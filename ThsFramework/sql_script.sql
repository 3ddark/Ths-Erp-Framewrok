--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE ths_erp2017; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE ths_erp2017 IS 'THS ERP Systems';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: audit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$DECLARE
	_username varchar;
	_ip varchar;
	_table_name varchar;
	_row_id integer;
	_access_type varchar;
	_time_of_change timestamp without time zone;
	_db_name varchar;
    BEGIN
	_username 		:= (upper(session_user)); 
	_ip 			:= (inet_client_addr());
	_table_name 		:= (upper(TG_TABLE_NAME)); 
	_time_of_change 	:= (now());
	_db_name 		:= (current_database());

	IF (TG_OP = 'INSERT') THEN
		_access_type 	:= (TG_OP);
		_row_id 	:= (NEW.id);
        END IF;

        IF (TG_OP = 'UPDATE') THEN
	    IF (OLD.validity = TRUE  AND  NEW.validity = FALSE) THEN
		_access_type 	:= quote_literal('VIRTUAL_DELETE');
		_row_id 	:= quote_literal(OLD.id);
	    ELSE
		_access_type 	:= (TG_OP);
		_row_id 	:= (OLD.id);
	    END IF;
	END IF;

	IF (TG_OP = 'DELETE') THEN
            _access_type	:= (TG_OP);
            _row_id 		:= (OLD.id);
        END IF;


	PERFORM dblink('host=localhost user=postgres password=123 dbname=ths_erp2017_log port=5432', 
	'INSERT INTO audit(username, ip, table_name, row_id, access_type, time_of_change, db_name) ' || 
	'VALUES(' || 
		(quote_literal(_username)) || ',' || 
		(quote_literal(_ip)) || ',' ||  
		(quote_literal(upper(_table_name))) || ',' || 
		(quote_literal(_row_id)) || ',' || 
		(quote_literal(_access_type)) || ',' || 
		(quote_literal(_time_of_change)) || ',' ||
		(quote_literal(_db_name)) || ');');
	    
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.audit() OWNER TO postgres;

--
-- Name: get_default_stok_tipi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_default_stok_tipi() RETURNS integer
    LANGUAGE sql
    AS $$SELECT id FROM stok_tipi WHERE is_default=true$$;


ALTER FUNCTION public.get_default_stok_tipi() OWNER TO postgres;

--
-- Name: get_lang_text(text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_lang_text(_default_value text, _table_name text, _column_name text, _row_id integer, _lang text) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$declare
	dmp text;
begin
	SELECT INTO dmp value FROM sys_table_lang_content 
	WHERE	1=1
		AND row_id = $4
		AND lang =$5
		AND column_name = $3
		AND table_name = $2
	LIMIT 1;

	IF (dmp is null) OR (dmp = '') THEN
		return _default_value;
	ELSE
		return dmp;
	END IF;

end
$_$;


ALTER FUNCTION public.get_lang_text(_default_value text, _table_name text, _column_name text, _row_id integer, _lang text) OWNER TO postgres;

--
-- Name: getdefaultparabirimi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getdefaultparabirimi() RETURNS character varying
    LANGUAGE sql
    AS $$SELECT kod FROM public.para_birimi WHERE is_default limit 1$$;


ALTER FUNCTION public.getdefaultparabirimi() OWNER TO postgres;

--
-- Name: login(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$declare 
	id integer;
	kullanici record;
begin
	select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1;
	IF NOT FOUND THEN
		return -1;
		--RAISE EXCEPTION 'kullanici % bulunamadi', $1;
	ELSE
		IF kullanici.is_active = false THEN
			return -2;
			--RAISE EXCEPTION 'kullanici % aktif değil', $1;
		ELSE
			select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1 and kullanicilar.surum = crypt($3, kullanicilar.surum);
			IF NOT FOUND THEN
				return -6;
			--geçersiz sürüm
			ELSE
			--IF kullanici.cevrim_ici = false THEN
				select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1 and kullanicilar.ip = text(inet_client_addr());
				IF NOT FOUND THEN
					return -3;
					--RAISE EXCEPTION 'ip % hatalı!', text(inet_client_addr());
				ELSE
					select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1 and kullanicilar.mac_address = $4;
					IF NOT FOUND THEN
						return -7;
						--geçersiz mac_adresi;
					ELSE				
					
						select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1 and kullanicilar.pwd = crypt($2, kullanicilar.pwd);
						IF NOT FOUND THEN
							--RAISE EXCEPTION 'şifre hatalı!';
							select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1;
							IF kullanici.login_deneme_sayisi = 3 THEN
									UPDATE kullanicilar SET is_active=false WHERE kullanicilar.kullanici_adi = $1;
									return -8;
							END IF;
							select into kullanici * from kullanicilar where kullanicilar.kullanici_adi = $1;
							UPDATE kullanicilar SET login_deneme_sayisi=(kullanici.login_deneme_sayisi +1) WHERE kullanicilar.kullanici_adi = $1;
							return -4;
						ELSE
							UPDATE kullanicilar SET cevrim_ici=true, login_deneme_sayisi = 0 WHERE kullanicilar.id = kullanici.id;	
							return kullanici.id;
						END IF;
					END IF;
				END IF;
			--ELSE
			--	return -5;
				--RAISE EXCEPTION 'kullanici % zaten çevrim içi!', $1;
			--END IF;
			END IF;
		END IF;

	END IF;
	--return 0;
end
$_$;


ALTER FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) OWNER TO postgres;

--
-- Name: shield(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.shield() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO audit (username, ip, table_name, row_id, access_type, time_of_change) 
            VALUES            (OLD.username,  OLD.ip, OLD.table_name, OLD.row_id, OLD.access_type, OLD.time_of_change);
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO audit (username, ip, table_name, row_id, access_type, time_of_change) 
            VALUES            (OLD.username, OLD.ip, OLD.table_name, OLD.row_id, OLD.access_type, OLD.time_of_change);
            RETURN NEW;
        END IF;
        RETURN NEW;
    END;$$;


ALTER FUNCTION public.shield() OWNER TO postgres;

--
-- Name: table_notify(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.table_notify() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$    BEGIN
        IF (TG_OP = 'INSERT') THEN
		PERFORM pg_notify(TG_TABLE_NAME, NEW.id::varchar);
        ELSIF (TG_OP = 'UPDATE') THEN
		PERFORM pg_notify(TG_TABLE_NAME, OLD.id::varchar);
        ELSIF (TG_OP = 'DELETE') THEN
		PERFORM pg_notify(TG_TABLE_NAME, '');
        END IF;
        RETURN NEW;
    END;$$;


ALTER FUNCTION public.table_notify() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alis_teklif; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alis_teklif (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    teklif_no integer NOT NULL,
    teklif_tarihi timestamp without time zone NOT NULL,
    cari_kod character varying(16),
    firma character varying(128),
    vergi_dairesi character varying(32),
    vergi_no character varying(16),
    aciklama character varying(128),
    referans character varying(32),
    teslim_tarihi timestamp without time zone,
    son_gecerlilik_tarihi timestamp without time zone,
    para_birimi character varying(3) NOT NULL,
    odeme_baslangic_donemi character varying(8),
    toplam_tutar double precision DEFAULT 0 NOT NULL,
    toplam_iskonto_tutar double precision DEFAULT 0 NOT NULL,
    toplam_kdv_tutar double precision DEFAULT 0 NOT NULL,
    genel_toplam double precision DEFAULT 0 NOT NULL,
    musteri_temsilcisi_id integer,
    ulke character varying(64),
    sehir character varying(32),
    adres character varying(80),
    posta_kodu character varying(7),
    yurtici_ihracat character varying(24),
    ortalama_opsiyon double precision,
    fatura_tipi character varying(16),
    tevkifat_kodu character varying(3),
    ihrac_kayit_kodu character varying(3),
    tevkifat_pay integer,
    tevkifat_payda integer,
    genel_iskonto_orani double precision DEFAULT 0 NOT NULL,
    genel_iskonto_tutar double precision DEFAULT 0 NOT NULL,
    is_e_fatura boolean DEFAULT false NOT NULL,
    siparislesti boolean NOT NULL
);


ALTER TABLE public.alis_teklif OWNER TO postgres;

--
-- Name: alis_teklif_detay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alis_teklif_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer
);


ALTER TABLE public.alis_teklif_detay OWNER TO postgres;

--
-- Name: alis_teklif_detay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alis_teklif_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alis_teklif_detay_id_seq OWNER TO postgres;

--
-- Name: alis_teklif_detay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alis_teklif_detay_id_seq OWNED BY public.alis_teklif_detay.id;


--
-- Name: alis_teklif_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alis_teklif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alis_teklif_id_seq OWNER TO postgres;

--
-- Name: alis_teklif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alis_teklif_id_seq OWNED BY public.alis_teklif.id;


--
-- Name: alis_tsif_kur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alis_tsif_kur (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    alis_teklif_id integer,
    alis_siparis_id integer,
    alis_irsaliye_id integer,
    alis_fatura_id integer,
    para_birimi character varying(3),
    deger double precision
);


ALTER TABLE public.alis_tsif_kur OWNER TO postgres;

--
-- Name: alis_tsif_kur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alis_tsif_kur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alis_tsif_kur_id_seq OWNER TO postgres;

--
-- Name: alis_tsif_kur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alis_tsif_kur_id_seq OWNED BY public.alis_tsif_kur.id;


--
-- Name: ambar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ambar (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    ambar character varying(32),
    is_varsayilan boolean DEFAULT false NOT NULL
);


ALTER TABLE public.ambar OWNER TO postgres;

--
-- Name: TABLE ambar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.ambar IS 'Stok hareketlerinin tutulduğu ambar bilgisi';


--
-- Name: ambar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ambar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ambar_id_seq OWNER TO postgres;

--
-- Name: ambar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ambar_id_seq OWNED BY public.ambar.id;


--
-- Name: ayar_efatura_iletisim_kanali; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_iletisim_kanali (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(2),
    aciklama character varying(512)
);


ALTER TABLE public.ayar_efatura_iletisim_kanali OWNER TO postgres;

--
-- Name: ayar_efatura_iletisim_kanali_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_iletisim_kanali_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_iletisim_kanali_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq OWNED BY public.ayar_efatura_iletisim_kanali.id;


--
-- Name: ayar_efatura_invoice_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_invoice_type (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32)
);


ALTER TABLE public.ayar_efatura_invoice_type OWNER TO postgres;

--
-- Name: TABLE ayar_efatura_invoice_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.ayar_efatura_invoice_type IS 'eFatura evrak tipi';


--
-- Name: ayar_efatura_invoice_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_invoice_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_invoice_type_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_invoice_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_invoice_type_id_seq OWNED BY public.ayar_efatura_invoice_type.id;


--
-- Name: ayar_efatura_istisna_kodu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_istisna_kodu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kodu character varying(4),
    adi character varying(512),
    tip character varying(16),
    is_tam_istisna boolean DEFAULT true NOT NULL
);


ALTER TABLE public.ayar_efatura_istisna_kodu OWNER TO postgres;

--
-- Name: ayar_efatura_istisna_kodu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_istisna_kodu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_istisna_kodu_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_istisna_kodu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_istisna_kodu_id_seq OWNED BY public.ayar_efatura_istisna_kodu.id;


--
-- Name: ayar_efatura_kimlik_semalari; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_kimlik_semalari (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(16),
    aciklama character varying(64)
);


ALTER TABLE public.ayar_efatura_kimlik_semalari OWNER TO postgres;

--
-- Name: ayar_efatura_kimlik_semalari_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_kimlik_semalari_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_kimlik_semalari_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq OWNED BY public.ayar_efatura_kimlik_semalari.id;


--
-- Name: ayar_efatura_response_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_response_code (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(8)
);


ALTER TABLE public.ayar_efatura_response_code OWNER TO postgres;

--
-- Name: ayar_efatura_response_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_response_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_response_code_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_response_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_response_code_id_seq OWNED BY public.ayar_efatura_response_code.id;


--
-- Name: ayar_efatura_senaryo_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_senaryo_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32) NOT NULL,
    aciklama character varying(64)
);


ALTER TABLE public.ayar_efatura_senaryo_tipi OWNER TO postgres;

--
-- Name: TABLE ayar_efatura_senaryo_tipi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.ayar_efatura_senaryo_tipi IS 'eFatura Senaryo tipleri';


--
-- Name: ayar_efatura_senaryo_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_senaryo_tipi_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_senaryo_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq OWNED BY public.ayar_efatura_senaryo_tipi.id;


--
-- Name: ayar_efatura_tevkifat_kodu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_tevkifat_kodu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kodu character varying(3),
    adi character varying(256),
    orani character varying(32),
    pay integer,
    payda integer
);


ALTER TABLE public.ayar_efatura_tevkifat_kodu OWNER TO postgres;

--
-- Name: ayar_efatura_tevkifat_kodu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_tevkifat_kodu_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_tevkifat_kodu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq OWNED BY public.ayar_efatura_tevkifat_kodu.id;


--
-- Name: ayar_efatura_vergi_kodu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_efatura_vergi_kodu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kodu character varying(4),
    adi character varying(128),
    kisaltma character varying(32),
    tevkifat boolean DEFAULT false NOT NULL
);


ALTER TABLE public.ayar_efatura_vergi_kodu OWNER TO postgres;

--
-- Name: ayar_efatura_vergi_kodu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_efatura_vergi_kodu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_efatura_vergi_kodu_id_seq OWNER TO postgres;

--
-- Name: ayar_efatura_vergi_kodu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_efatura_vergi_kodu_id_seq OWNED BY public.ayar_efatura_vergi_kodu.id;


--
-- Name: ayar_evrak_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_evrak_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(16)
);


ALTER TABLE public.ayar_evrak_tipi OWNER TO postgres;

--
-- Name: ayar_evrak_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_evrak_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_evrak_tipi_id_seq OWNER TO postgres;

--
-- Name: ayar_evrak_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_evrak_tipi_id_seq OWNED BY public.ayar_evrak_tipi.id;


--
-- Name: ayar_firma_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_firma_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32)
);


ALTER TABLE public.ayar_firma_tipi OWNER TO postgres;

--
-- Name: ayar_firma_tipi_detay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_firma_tipi_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(48),
    firma_tipi character varying(32)
);


ALTER TABLE public.ayar_firma_tipi_detay OWNER TO postgres;

--
-- Name: ayar_firma_tipi_detay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_firma_tipi_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_firma_tipi_detay_id_seq OWNER TO postgres;

--
-- Name: ayar_firma_tipi_detay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_firma_tipi_detay_id_seq OWNED BY public.ayar_firma_tipi_detay.id;


--
-- Name: ayar_firma_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_firma_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_firma_tipi_id_seq OWNER TO postgres;

--
-- Name: ayar_firma_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_firma_tipi_id_seq OWNED BY public.ayar_firma_tipi.id;


--
-- Name: ayar_genel_ayarlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_genel_ayarlar (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    donem integer,
    unvan character varying(256),
    vergi_no character varying(10),
    tc_no character varying(11),
    firma_tipi character varying(32),
    diger_ayarlar json
);


ALTER TABLE public.ayar_genel_ayarlar OWNER TO postgres;

--
-- Name: ayar_genel_ayarlar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_genel_ayarlar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_genel_ayarlar_id_seq OWNER TO postgres;

--
-- Name: ayar_genel_ayarlar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_genel_ayarlar_id_seq OWNED BY public.ayar_genel_ayarlar.id;


--
-- Name: ayar_hane_sayisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_hane_sayisi (
    id integer NOT NULL,
    validity boolean DEFAULT true,
    hesap_bakiye integer DEFAULT 2,
    alis_miktar integer DEFAULT 2,
    alis_fiyat integer DEFAULT 2,
    alis_tutar integer DEFAULT 2,
    satis_miktar integer DEFAULT 2,
    satis_fiyat integer DEFAULT 2,
    satis_tutar integer DEFAULT 2,
    stok_miktar integer DEFAULT 2,
    stok_fiyat integer DEFAULT 2
);


ALTER TABLE public.ayar_hane_sayisi OWNER TO postgres;

--
-- Name: ayar_hane_sayisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_hane_sayisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_hane_sayisi_id_seq OWNER TO postgres;

--
-- Name: ayar_hane_sayisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_hane_sayisi_id_seq OWNED BY public.ayar_hane_sayisi.id;


--
-- Name: ayar_sabit_degisken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_sabit_degisken (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(16) NOT NULL
);


ALTER TABLE public.ayar_sabit_degisken OWNER TO postgres;

--
-- Name: ayar_sabit_degisken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_sabit_degisken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_sabit_degisken_id_seq OWNER TO postgres;

--
-- Name: ayar_sabit_degisken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_sabit_degisken_id_seq OWNED BY public.ayar_sabit_degisken.id;


--
-- Name: ayar_stok_hareket_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_stok_hareket_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(8) NOT NULL
);


ALTER TABLE public.ayar_stok_hareket_tipi OWNER TO postgres;

--
-- Name: ayar_stok_hareket_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_stok_hareket_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_stok_hareket_tipi_id_seq OWNER TO postgres;

--
-- Name: ayar_stok_hareket_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_stok_hareket_tipi_id_seq OWNED BY public.ayar_stok_hareket_tipi.id;


--
-- Name: ayar_stok_hareketi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_stok_hareketi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    giris_ayari character varying(16),
    cikis_ayari character varying(16)
);


ALTER TABLE public.ayar_stok_hareketi OWNER TO postgres;

--
-- Name: ayar_stok_hareketi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_stok_hareketi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_stok_hareketi_id_seq OWNER TO postgres;

--
-- Name: ayar_stok_hareketi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_stok_hareketi_id_seq OWNED BY public.ayar_stok_hareketi.id;


--
-- Name: ayar_teslim_sekli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_teslim_sekli (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(16) NOT NULL,
    teslim_sekli character varying(64) NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.ayar_teslim_sekli OWNER TO postgres;

--
-- Name: ayar_teslim_sekli_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_teslim_sekli_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_teslim_sekli_id_seq OWNER TO postgres;

--
-- Name: ayar_teslim_sekli_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_teslim_sekli_id_seq OWNED BY public.ayar_teslim_sekli.id;


--
-- Name: banka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banka (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    adi character varying(64) NOT NULL,
    swift_kodu character varying(16),
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.banka OWNER TO postgres;

--
-- Name: banka_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banka_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banka_id_seq OWNER TO postgres;

--
-- Name: banka_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banka_id_seq OWNED BY public.banka.id;


--
-- Name: banka_subesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banka_subesi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    sube_kodu integer NOT NULL,
    sube_adi character varying(64) NOT NULL,
    sube_il character varying(16),
    banka_adi character varying(64) NOT NULL
);


ALTER TABLE public.banka_subesi OWNER TO postgres;

--
-- Name: banka_subesi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banka_subesi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banka_subesi_id_seq OWNER TO postgres;

--
-- Name: banka_subesi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banka_subesi_id_seq OWNED BY public.banka_subesi.id;


--
-- Name: bolge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bolge (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    bolge character varying(32) NOT NULL,
    bolge_turu character varying(24),
    hedef_ocak double precision,
    hedef_subat double precision,
    hedef_mart double precision,
    hedef_nisan double precision,
    hedef_mayis double precision,
    hedef_haziran double precision,
    hedef_temmuz double precision,
    hedef_agustos double precision,
    hedef_eylul double precision,
    hedef_ekim double precision,
    hedef_kasim double precision,
    hedef_aralik double precision,
    gecen_ocak double precision,
    gecen_subat double precision,
    gecen_mart double precision,
    gecen_nisan double precision,
    gecen_mayis double precision,
    gecen_haziran double precision,
    gecen_temmuz double precision,
    gecen_agustos double precision,
    gecen_eylul double precision,
    gecen_ekim double precision,
    gecen_kasim double precision,
    gecen_aralik double precision
);


ALTER TABLE public.bolge OWNER TO postgres;

--
-- Name: bolge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bolge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bolge_id_seq OWNER TO postgres;

--
-- Name: bolge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bolge_id_seq OWNED BY public.bolge.id;


--
-- Name: bolge_turu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bolge_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(32)
);


ALTER TABLE public.bolge_turu OWNER TO postgres;

--
-- Name: bolge_turu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bolge_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bolge_turu_id_seq OWNER TO postgres;

--
-- Name: bolge_turu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bolge_turu_id_seq OWNED BY public.bolge_turu.id;


--
-- Name: hesap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hesap (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    firma_tipi character varying(32),
    firma_tipi_detay character varying(64),
    hesap_kodu character varying(16) NOT NULL,
    hesap_ismi character varying(128) NOT NULL,
    mukellef_tipi character varying(8),
    hesap_grubu character varying(16),
    yetkili_adi character varying(32),
    yetkili_soyadi character varying(32),
    tel1 character varying(16),
    tel2 character varying(16),
    tel3 character varying(16),
    faks1 character varying(16),
    faks2 character varying(16),
    faks3 character varying(16),
    web_uri character varying(48),
    eposta character varying(80),
    muhasebe_tel character varying(16),
    muhasebe_eposta character varying(80),
    sokak character varying(40),
    cadde character varying(40),
    mahalle character varying(40),
    ilce character varying(32),
    sehir character varying(24),
    bolge character varying(32),
    bina character varying(40),
    kapi_no character varying(6),
    posta_kutusu character varying(8),
    posta_kodu character varying(7),
    ulke character varying(32),
    vergi_dairesi character varying(32),
    vergi_no character varying(16),
    nace_kodu character varying(16),
    iskonto double precision DEFAULT 0 NOT NULL,
    muhasebe_kodu character varying(16),
    ana_hesap_muhasebe_kodu character varying(16),
    plan_kodu character varying(3),
    ozel_bilgi character varying(400),
    para_birimi character varying(3) DEFAULT public.getdefaultparabirimi() NOT NULL,
    temsilci character varying(64),
    ortalama_vade character varying,
    is_efatura boolean DEFAULT false NOT NULL
);


ALTER TABLE public.hesap OWNER TO postgres;

--
-- Name: hesap_grubu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hesap_grubu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    grup character varying(16) NOT NULL
);


ALTER TABLE public.hesap_grubu OWNER TO postgres;

--
-- Name: hesap_grubu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hesap_grubu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hesap_grubu_id_seq OWNER TO postgres;

--
-- Name: hesap_grubu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hesap_grubu_id_seq OWNED BY public.hesap_grubu.id;


--
-- Name: hesap_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hesap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hesap_id_seq OWNER TO postgres;

--
-- Name: hesap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hesap_id_seq OWNED BY public.hesap.id;


--
-- Name: hesap_plani; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hesap_plani (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    plan_kodu character varying(3) NOT NULL,
    seviye_sayisi smallint NOT NULL
);


ALTER TABLE public.hesap_plani OWNER TO postgres;

--
-- Name: hesap_plani_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hesap_plani_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hesap_plani_id_seq OWNER TO postgres;

--
-- Name: hesap_plani_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hesap_plani_id_seq OWNED BY public.hesap_plani.id;


--
-- Name: muhasebe_hesap_plani; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muhasebe_hesap_plani (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    plan_kodu character varying(3) NOT NULL,
    seviye_sayisi smallint NOT NULL
);


ALTER TABLE public.muhasebe_hesap_plani OWNER TO postgres;

--
-- Name: muhasebe_hesap_plani_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.muhasebe_hesap_plani_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muhasebe_hesap_plani_id_seq OWNER TO postgres;

--
-- Name: muhasebe_hesap_plani_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.muhasebe_hesap_plani_id_seq OWNED BY public.muhasebe_hesap_plani.id;


--
-- Name: olcu_birimi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.olcu_birimi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    birim character varying(16) NOT NULL,
    float_tip boolean DEFAULT false NOT NULL,
    birim_kod character varying(3),
    birim_aciklama character varying(64)
);


ALTER TABLE public.olcu_birimi OWNER TO postgres;

--
-- Name: olcu_birimi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.olcu_birimi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.olcu_birimi_id_seq OWNER TO postgres;

--
-- Name: olcu_birimi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.olcu_birimi_id_seq OWNED BY public.olcu_birimi.id;


--
-- Name: para_birimi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.para_birimi (
    id integer NOT NULL,
    kod character varying(3) NOT NULL,
    sembol character varying(3) NOT NULL,
    aciklama character varying(128),
    is_varsayilan boolean DEFAULT false NOT NULL
);


ALTER TABLE public.para_birimi OWNER TO postgres;

--
-- Name: para_birimi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.para_birimi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.para_birimi_id_seq OWNER TO postgres;

--
-- Name: para_birimi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.para_birimi_id_seq OWNED BY public.para_birimi.id;


--
-- Name: personel_ayrilma_nedeni_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_ayrilma_nedeni_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32)
);


ALTER TABLE public.personel_ayrilma_nedeni_tipi OWNER TO postgres;

--
-- Name: personel_ayrilma_nedeni_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_ayrilma_nedeni_tipi_id_seq OWNER TO postgres;

--
-- Name: personel_ayrilma_nedeni_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq OWNED BY public.personel_ayrilma_nedeni_tipi.id;


--
-- Name: personel_bilgisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_bilgisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    ad character varying(32),
    soyad character varying(32),
    dogum_tarihi date,
    kan_grubu character varying(8),
    cinsiyet character varying(8),
    ev_telefonu character varying(16),
    cep_telefonu character varying(16),
    yakin_ad_soyad character varying(64),
    yakin_telefonu character varying(16),
    mail_adresi character varying(64),
    medeni_durumu character varying(8),
    cocuk_sayisi smallint,
    ayakkabi_no smallint,
    elbise_bedeni character varying(8),
    askerlik_durumu character varying(8),
    servis_id integer,
    brut_maas double precision,
    ozel_not character varying(256),
    is_active boolean DEFAULT true NOT NULL,
    is_ikramiye boolean DEFAULT false NOT NULL,
    ikramiye_sayisi integer,
    ikramiye_miktar double precision,
    genel_not character varying(256),
    tc_kimlik_no character varying(11),
    personel_tipi character varying(32),
    personel_gecmisi_id integer,
    birim_id integer,
    gorev_id integer
);


ALTER TABLE public.personel_bilgisi OWNER TO postgres;

--
-- Name: personel_bilgisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_bilgisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_bilgisi_id_seq OWNER TO postgres;

--
-- Name: personel_bilgisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_bilgisi_id_seq OWNED BY public.personel_bilgisi.id;


--
-- Name: personel_birim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_birim (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    bolum_id integer,
    birim character varying(32)
);


ALTER TABLE public.personel_birim OWNER TO postgres;

--
-- Name: TABLE personel_birim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.personel_birim IS 'Personelin şirket içindeki bölüm içindeki birimi(Departman içindeki alt kol)';


--
-- Name: personel_birim_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_birim_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_birim_id_seq OWNER TO postgres;

--
-- Name: personel_birim_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_birim_id_seq OWNED BY public.personel_birim.id;


--
-- Name: personel_bolum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_bolum (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    bolum character varying(32)
);


ALTER TABLE public.personel_bolum OWNER TO postgres;

--
-- Name: TABLE personel_bolum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.personel_bolum IS 'Personelin şirket içindeki çalıştığı bölüme ait bilgiler';


--
-- Name: personel_bolum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_bolum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_bolum_id_seq OWNER TO postgres;

--
-- Name: personel_bolum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_bolum_id_seq OWNED BY public.personel_bolum.id;


--
-- Name: personel_calisma_gecmisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_calisma_gecmisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    personel_id integer,
    personel_birim character varying(32),
    personel_gorev character varying(32),
    ise_giris_tarihi date NOT NULL,
    isten_cikis_tarihi date,
    ayrilma_nedeni_tipi character varying(32),
    ayrilma_nedeni_aciklama character varying(80)
);


ALTER TABLE public.personel_calisma_gecmisi OWNER TO postgres;

--
-- Name: personel_calisma_gecmisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_calisma_gecmisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_calisma_gecmisi_id_seq OWNER TO postgres;

--
-- Name: personel_calisma_gecmisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_calisma_gecmisi_id_seq OWNED BY public.personel_calisma_gecmisi.id;


--
-- Name: personel_gorev; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_gorev (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    gorev character varying(32)
);


ALTER TABLE public.personel_gorev OWNER TO postgres;

--
-- Name: TABLE personel_gorev; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.personel_gorev IS 'Personelin şirket içindeki görevi';


--
-- Name: personel_gorev_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_gorev_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_gorev_id_seq OWNER TO postgres;

--
-- Name: personel_gorev_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_gorev_id_seq OWNED BY public.personel_gorev.id;


--
-- Name: personel_tasima_servis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_tasima_servis (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    servis_no smallint,
    servis_adi character varying(32),
    rota character varying[]
);


ALTER TABLE public.personel_tasima_servis OWNER TO postgres;

--
-- Name: personel_tasima_servis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_tasima_servis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_tasima_servis_id_seq OWNER TO postgres;

--
-- Name: personel_tasima_servis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_tasima_servis_id_seq OWNED BY public.personel_tasima_servis.id;


--
-- Name: recete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recete (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    mamul_stok_kodu character varying(32) NOT NULL,
    ornek_uretim_miktari double precision NOT NULL,
    fire_orani double precision,
    aciklama character varying(128),
    recete_adi character varying(128) NOT NULL
);


ALTER TABLE public.recete OWNER TO postgres;

--
-- Name: recete_hammadde; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recete_hammadde (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer NOT NULL,
    stok_kodu character varying(32) NOT NULL,
    miktar double precision NOT NULL,
    fire_orani double precision,
    recete_id integer
);


ALTER TABLE public.recete_hammadde OWNER TO postgres;

--
-- Name: recete_hammadde_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recete_hammadde_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recete_hammadde_id_seq OWNER TO postgres;

--
-- Name: recete_hammadde_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recete_hammadde_id_seq OWNED BY public.recete_hammadde.id;


--
-- Name: recete_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recete_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recete_id_seq OWNER TO postgres;

--
-- Name: recete_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recete_id_seq OWNED BY public.recete.id;


--
-- Name: satis_fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_fatura (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL
);


ALTER TABLE public.satis_fatura OWNER TO postgres;

--
-- Name: satis_fatura_detay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_fatura_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer
);


ALTER TABLE public.satis_fatura_detay OWNER TO postgres;

--
-- Name: satis_fatura_detay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_fatura_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_fatura_detay_id_seq OWNER TO postgres;

--
-- Name: satis_fatura_detay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_fatura_detay_id_seq OWNED BY public.satis_fatura_detay.id;


--
-- Name: satis_fatura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_fatura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_fatura_id_seq OWNER TO postgres;

--
-- Name: satis_fatura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_fatura_id_seq OWNED BY public.satis_fatura.id;


--
-- Name: satis_irsaliye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_irsaliye (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL
);


ALTER TABLE public.satis_irsaliye OWNER TO postgres;

--
-- Name: satis_irsaliye_detay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_irsaliye_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer
);


ALTER TABLE public.satis_irsaliye_detay OWNER TO postgres;

--
-- Name: satis_irsaliye_detay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_irsaliye_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_irsaliye_detay_id_seq OWNER TO postgres;

--
-- Name: satis_irsaliye_detay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_irsaliye_detay_id_seq OWNED BY public.satis_irsaliye_detay.id;


--
-- Name: satis_irsaliye_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_irsaliye_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_irsaliye_id_seq OWNER TO postgres;

--
-- Name: satis_irsaliye_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_irsaliye_id_seq OWNED BY public.satis_irsaliye.id;


--
-- Name: satis_siparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_siparis (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL
);


ALTER TABLE public.satis_siparis OWNER TO postgres;

--
-- Name: satis_siparis_detay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_siparis_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer
);


ALTER TABLE public.satis_siparis_detay OWNER TO postgres;

--
-- Name: satis_siparis_detay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_siparis_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_siparis_detay_id_seq OWNER TO postgres;

--
-- Name: satis_siparis_detay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_siparis_detay_id_seq OWNED BY public.satis_siparis_detay.id;


--
-- Name: satis_siparis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_siparis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_siparis_id_seq OWNER TO postgres;

--
-- Name: satis_siparis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_siparis_id_seq OWNED BY public.satis_siparis.id;


--
-- Name: satis_teklif; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_teklif (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL
);


ALTER TABLE public.satis_teklif OWNER TO postgres;

--
-- Name: satis_teklif_detay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satis_teklif_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer
);


ALTER TABLE public.satis_teklif_detay OWNER TO postgres;

--
-- Name: satis_teklif_detay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_teklif_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_teklif_detay_id_seq OWNER TO postgres;

--
-- Name: satis_teklif_detay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_teklif_detay_id_seq OWNED BY public.satis_teklif_detay.id;


--
-- Name: satis_teklif_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satis_teklif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satis_teklif_id_seq OWNER TO postgres;

--
-- Name: satis_teklif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satis_teklif_id_seq OWNED BY public.satis_teklif.id;


--
-- Name: sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    sehir_adi character varying(32) NOT NULL,
    ulke_adi character varying(128) NOT NULL,
    plaka_kodu integer
);


ALTER TABLE public.sehir OWNER TO postgres;

--
-- Name: sehir_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sehir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sehir_id_seq OWNER TO postgres;

--
-- Name: sehir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sehir_id_seq OWNED BY public.sehir.id;


--
-- Name: stok_grubu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stok_grubu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    grup character varying(32)
);


ALTER TABLE public.stok_grubu OWNER TO postgres;

--
-- Name: stok_grubu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stok_grubu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stok_grubu_id_seq OWNER TO postgres;

--
-- Name: stok_grubu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stok_grubu_id_seq OWNED BY public.stok_grubu.id;


--
-- Name: stok_hareketi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stok_hareketi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    stok_kodu character varying(32) NOT NULL,
    miktar double precision NOT NULL,
    tutar double precision NOT NULL,
    giris_cikis_tip_id integer NOT NULL,
    alan_ambar character varying(32),
    veren_ambar character varying(32),
    tarih timestamp without time zone NOT NULL
);


ALTER TABLE public.stok_hareketi OWNER TO postgres;

--
-- Name: stok_hareketi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stok_hareketi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stok_hareketi_id_seq OWNER TO postgres;

--
-- Name: stok_hareketi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stok_hareketi_id_seq OWNED BY public.stok_hareketi.id;


--
-- Name: stok_karti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stok_karti (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    stok_kodu character varying(32),
    stok_adi character varying(128),
    stok_grubu character varying(32),
    alis_iskonto double precision,
    satis_iskonto double precision,
    yetkili_iskonto double precision,
    stok_tipi_id integer DEFAULT public.get_default_stok_tipi() NOT NULL
);


ALTER TABLE public.stok_karti OWNER TO postgres;

--
-- Name: stok_karti_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stok_karti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stok_karti_id_seq OWNER TO postgres;

--
-- Name: stok_karti_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stok_karti_id_seq OWNED BY public.stok_karti.id;


--
-- Name: stok_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stok_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(16) NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    is_stok boolean DEFAULT false NOT NULL
);


ALTER TABLE public.stok_tipi OWNER TO postgres;

--
-- Name: stok_tipi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stok_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stok_tipi_id_seq OWNER TO postgres;

--
-- Name: stok_tipi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stok_tipi_id_seq OWNED BY public.stok_tipi.id;


--
-- Name: sys_application_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_application_settings (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    logo bytea,
    unvan character varying(128) NOT NULL,
    tel1 character varying(24) NOT NULL,
    tel2 character varying(24),
    tel3 character varying(24),
    tel4 character varying(24),
    tel5 character varying(24),
    fax1 character varying(24),
    fax2 character varying(24),
    mersis_no character varying(16),
    web_sitesi character varying(48),
    eposta_adresi character varying(80),
    vergi_dairesi character varying(32),
    vergi_no character varying(16),
    form_color integer,
    donem integer DEFAULT 2014 NOT NULL,
    mukellef_tipi character varying(16),
    tam_adres character varying(160),
    ticaret_sicil_no character varying(24),
    ulke character varying(128),
    sehir character varying(24),
    ilce character varying(32),
    mahalle character varying(40),
    cadde character varying(40),
    sokak character varying(40),
    posta_kodu character varying(7),
    bina character varying(40),
    kapi_no character varying(6),
    eftr_appstr character varying(32),
    eftr_username character varying(16),
    eftr_password character varying(16),
    eftr_version character varying(8),
    efatura_fatura_kodu character varying(3) DEFAULT 'XXX'::character varying NOT NULL
);


ALTER TABLE public.sys_application_settings OWNER TO postgres;

--
-- Name: sys_application_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_application_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_application_settings_id_seq OWNER TO postgres;

--
-- Name: sys_application_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_application_settings_id_seq OWNED BY public.sys_application_settings.id;


--
-- Name: sys_application_settings_other; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_application_settings_other (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    is_edefter_aktif boolean DEFAULT false NOT NULL,
    uygunsuzluk_mail_sender character varying(32),
    uygunsuzluk_mail_sender_username character varying(32),
    uygunsuzluk_mail_sender_password character varying(16),
    uygunsuzluk_mail_sender_port integer,
    uygunsuzluk_mail_alici1 character varying(32),
    uygunsuzluk_mail_alici2 character varying(32),
    uygunsuzluk_mail_alici3 character varying(32),
    varsayilan_satis_cari_kod character varying(16),
    varsayilan_alis_cari_kod character varying(16),
    bolum_ambarda_uretim_yap boolean DEFAULT false NOT NULL,
    uretim_muhasebe_kaydi_olustursun boolean DEFAULT true NOT NULL,
    stok_satimda_negatife_dusebilir boolean DEFAULT false NOT NULL,
    mal_satis_sayilarini_goster boolean DEFAULT false NOT NULL,
    pcb_uretim boolean DEFAULT false NOT NULL,
    proforma_no_goster boolean DEFAULT false NOT NULL,
    satis_takip boolean DEFAULT false NOT NULL,
    hammadde_girise_gore_sirala boolean DEFAULT false NOT NULL,
    uretim_entegrasyon_hammadde_kullanim_hesabi_iscilikle boolean DEFAULT false NOT NULL,
    tahsilat_listesi_virmanli boolean DEFAULT false NOT NULL,
    ortalama_vade_0_ise_sevkiyata_izin_verme boolean DEFAULT false NOT NULL,
    sipariste_teslim_tarihi_yazdir boolean DEFAULT false NOT NULL,
    teklif_ayrintilarini_goster boolean DEFAULT false NOT NULL,
    fatura_irsaliye_no_0_ile_baslasin boolean DEFAULT false NOT NULL,
    excel_ekli_irsaliye_yazdirma boolean DEFAULT false NOT NULL,
    ambarlararasi_transfer_numara_otomatik_gelsin boolean DEFAULT false NOT NULL,
    ambarlararasi_transfer_onayli_calissin boolean DEFAULT false NOT NULL,
    alis_teklif_alis_sipariste_ham_alis_fiyatini_kullan boolean DEFAULT false NOT NULL,
    tahsilat_listesine_120_bulut_hesabini_dahil_etme boolean DEFAULT false NOT NULL,
    satis_listesi_varsayilan_filtre_mamul_hammadde boolean DEFAULT false NOT NULL,
    is_recete_maliyet_analizi_baska_db_kullanarak_yap boolean DEFAULT false NOT NULL,
    is_efatura_aktif boolean DEFAULT false NOT NULL,
    is_stok_transfer_fiyati_kullanici_degistirebilir boolean DEFAULT false NOT NULL,
    is_hesaplar_rapolarda_cikmasin boolean DEFAULT false NOT NULL,
    is_siparisi_baska_programa_otomatik_kayit_yap boolean DEFAULT false NOT NULL,
    is_active_uretim_takip boolean DEFAULT false NOT NULL,
    is_pano_programina_otomatik_kayit boolean DEFAULT false NOT NULL,
    is_nakit_akista_farkli_db_kullan boolean DEFAULT false NOT NULL,
    is_ihrac_fiyati_yerine_satis_fiyatini_kullan boolean DEFAULT false NOT NULL,
    is_statik_iskonto_orani_kullan boolean DEFAULT false,
    is_eirsaliye_aktif boolean DEFAULT false NOT NULL,
    is_stok_recete_adi_birlikte_guncellensin boolean DEFAULT false NOT NULL,
    is_kur_bilgisini_1_olarak_kullan boolean DEFAULT false NOT NULL,
    is_genel_kdv_orani_kullan boolean DEFAULT false NOT NULL,
    xslt_sablon_adi character varying(32),
    maliyet_analiz_host character varying(32),
    maliyet_analiz_db_name character varying(64),
    maliyet_analiz_user_name character varying(64),
    maliyet_analiz_password character varying(128),
    maliyet_analiz_port integer,
    genel_iskonto_gecerlilik_tarihi date,
    en_fazla_fatura_satir_sayisi integer DEFAULT 0 NOT NULL,
    en_fazla_e_fatura_satir_sayisi integer DEFAULT 0 NOT NULL,
    en_fazla_irsaliye_satir_sayisi integer DEFAULT 0 NOT NULL,
    en_fazla_e_irsaliye_satir_sayisi integer DEFAULT 0 NOT NULL,
    siparis_kopyalanacak_kaynak_cari_kod character varying(16),
    siparis_kopyalanacak_hedef_cari_kod character varying(16),
    ana_dil character varying(3) DEFAULT 'Türkçe TR'::character varying,
    maliyet_analizi_iskonto_orani double precision,
    genel_kdv_orani double precision DEFAULT 18 NOT NULL,
    path_teklif_hesaplama_conf character varying(255),
    path_proforma_file character varying(255),
    path_mal_stok_seviyesi_eord_rapor character varying(255),
    path_update character varying(255),
    path_stok_karti_resim character varying(255),
    path_proforma_pdf_kayit character varying(255)
);


ALTER TABLE public.sys_application_settings_other OWNER TO postgres;

--
-- Name: sys_application_settings_other_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_application_settings_other_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_application_settings_other_id_seq OWNER TO postgres;

--
-- Name: sys_application_settings_other_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_application_settings_other_id_seq OWNED BY public.sys_application_settings_other.id;


--
-- Name: sys_grid_col_color; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_grid_col_color (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    min_value double precision DEFAULT 0 NOT NULL,
    min_color integer DEFAULT 0 NOT NULL,
    max_value double precision DEFAULT 0 NOT NULL,
    max_color integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sys_grid_col_color OWNER TO postgres;

--
-- Name: sys_grid_col_color_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_grid_col_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_grid_col_color_id_seq OWNER TO postgres;

--
-- Name: sys_grid_col_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_grid_col_color_id_seq OWNED BY public.sys_grid_col_color.id;


--
-- Name: sys_grid_col_percent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_grid_col_percent (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying,
    column_name character varying,
    max_value double precision DEFAULT 0 NOT NULL,
    color_bar integer DEFAULT 0 NOT NULL,
    color_bar_back integer DEFAULT 0 NOT NULL,
    color_bar_text integer DEFAULT 0 NOT NULL,
    color_bar_text_active integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sys_grid_col_percent OWNER TO postgres;

--
-- Name: sys_grid_col_percent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_grid_col_percent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_grid_col_percent_id_seq OWNER TO postgres;

--
-- Name: sys_grid_col_percent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_grid_col_percent_id_seq OWNED BY public.sys_grid_col_percent.id;


--
-- Name: sys_grid_col_width; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_grid_col_width (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    column_width integer DEFAULT 0 NOT NULL,
    sequence_no integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.sys_grid_col_width OWNER TO postgres;

--
-- Name: sys_grid_col_width_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_grid_col_width_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_grid_col_width_id_seq OWNER TO postgres;

--
-- Name: sys_grid_col_width_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_grid_col_width_id_seq OWNED BY public.sys_grid_col_width.id;


--
-- Name: sys_grid_default_order_filter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_grid_default_order_filter (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    key character varying(32),
    value character varying,
    is_order boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sys_grid_default_order_filter OWNER TO postgres;

--
-- Name: sys_grid_default_order_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_grid_default_order_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_grid_default_order_filter_id_seq OWNER TO postgres;

--
-- Name: sys_grid_default_order_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_grid_default_order_filter_id_seq OWNED BY public.sys_grid_default_order_filter.id;


--
-- Name: sys_lang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_lang (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    language character varying(16)
);


ALTER TABLE public.sys_lang OWNER TO postgres;

--
-- Name: sys_lang_contents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_lang_contents (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    lang character varying(16) NOT NULL,
    code character varying(64) NOT NULL,
    value text,
    is_factory_setting boolean DEFAULT false NOT NULL,
    content_type character varying(32) NOT NULL,
    table_name character varying(64)
);


ALTER TABLE public.sys_lang_contents OWNER TO postgres;

--
-- Name: sys_lang_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_lang_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_lang_contents_id_seq OWNER TO postgres;

--
-- Name: sys_lang_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_lang_contents_id_seq OWNED BY public.sys_lang_contents.id;


--
-- Name: sys_lang_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_lang_id_seq OWNER TO postgres;

--
-- Name: sys_lang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_lang_id_seq OWNED BY public.sys_lang.id;


--
-- Name: sys_permission_source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission_source (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    source_code character varying(16),
    source_name character varying(64),
    source_group_id integer
);


ALTER TABLE public.sys_permission_source OWNER TO postgres;

--
-- Name: sys_permission_source_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission_source_group (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    source_group character varying(64)
);


ALTER TABLE public.sys_permission_source_group OWNER TO postgres;

--
-- Name: sys_permission_source_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_permission_source_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_permission_source_group_id_seq OWNER TO postgres;

--
-- Name: sys_permission_source_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_permission_source_group_id_seq OWNED BY public.sys_permission_source_group.id;


--
-- Name: sys_permission_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_permission_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_permission_source_id_seq OWNER TO postgres;

--
-- Name: sys_permission_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_permission_source_id_seq OWNED BY public.sys_permission_source.id;


--
-- Name: sys_quality_form_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_quality_form_number (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying NOT NULL,
    form_no character varying(16) NOT NULL
);


ALTER TABLE public.sys_quality_form_number OWNER TO postgres;

--
-- Name: sys_quality_form_number_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_quality_form_number_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_quality_form_number_id_seq OWNER TO postgres;

--
-- Name: sys_quality_form_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_quality_form_number_id_seq OWNED BY public.sys_quality_form_number.id;


--
-- Name: sys_table_lang_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_table_lang_content (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    lang character varying(16) NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    row_id integer NOT NULL,
    value text
);


ALTER TABLE public.sys_table_lang_content OWNER TO postgres;

--
-- Name: sys_table_lang_content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_table_lang_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_table_lang_content_id_seq OWNER TO postgres;

--
-- Name: sys_table_lang_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_table_lang_content_id_seq OWNED BY public.sys_table_lang_content.id;


--
-- Name: sys_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    user_name character varying(32) NOT NULL,
    user_password text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    is_active_user boolean DEFAULT false NOT NULL,
    is_online boolean DEFAULT false NOT NULL,
    app_version text,
    db_version text,
    ip_address character varying(32) DEFAULT '127.0.0.1'::character varying NOT NULL,
    mac_address character varying(32),
    is_super_user boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sys_user OWNER TO postgres;

--
-- Name: sys_user_access_right; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_access_right (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    source_code character varying(8) NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    is_add_record boolean DEFAULT false NOT NULL,
    is_update boolean DEFAULT false NOT NULL,
    is_delete boolean DEFAULT false NOT NULL,
    is_special boolean DEFAULT false NOT NULL,
    user_name character varying(32) NOT NULL
);


ALTER TABLE public.sys_user_access_right OWNER TO postgres;

--
-- Name: sys_user_access_right_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_access_right_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_user_access_right_id_seq OWNER TO postgres;

--
-- Name: sys_user_access_right_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_access_right_id_seq OWNED BY public.sys_user_access_right.id;


--
-- Name: sys_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_user_id_seq OWNER TO postgres;

--
-- Name: sys_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_id_seq OWNED BY public.sys_user.id;


--
-- Name: sys_view_tables; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sys_view_tables AS
 SELECT initcap(replace((tables.table_name)::text, '_'::text, ' '::text)) AS table_name,
    tables.table_type
   FROM information_schema.tables
  WHERE ((tables.table_schema)::text = 'public'::text)
  ORDER BY tables.table_type, tables.table_name;


ALTER TABLE public.sys_view_tables OWNER TO postgres;

--
-- Name: sys_view_columns; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sys_view_columns AS
 SELECT initcap(replace((columns.table_name)::text, '_'::text, ' '::text)) AS table_name,
    initcap(replace((columns.column_name)::text, '_'::text, ' '::text)) AS column_name,
    columns.is_nullable,
    (columns.data_type)::text AS data_type,
    (columns.character_maximum_length)::integer AS character_maximum_length,
    (columns.ordinal_position)::integer AS ordinal_position,
    (vt.table_type)::text AS table_type
   FROM (information_schema.columns
     JOIN public.sys_view_tables vt ON ((( SELECT lower(replace(vt.table_name, ' '::text, '_'::text)) AS lower) = (columns.table_name)::text)))
  ORDER BY vt.table_type, columns.table_name, columns.ordinal_position;


ALTER TABLE public.sys_view_columns OWNER TO postgres;

--
-- Name: sys_view_databases; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sys_view_databases AS
 SELECT pg_database.datname AS database_name,
    pg_shdescription.description AS aciklama
   FROM (pg_shdescription
     JOIN pg_database ON ((pg_shdescription.objoid = pg_database.oid)))
  WHERE ((1 = 1) AND (pg_shdescription.description = 'THS ERP Systems'::text));


ALTER TABLE public.sys_view_databases OWNER TO postgres;

--
-- Name: ulke; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ulke (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    ulke_kodu character varying(2) NOT NULL,
    ulke_adi character varying(128) NOT NULL,
    iso_year integer,
    iso_cctld_code character varying(3)
);


ALTER TABLE public.ulke OWNER TO postgres;

--
-- Name: ulke_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ulke_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ulke_id_seq OWNER TO postgres;

--
-- Name: ulke_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ulke_id_seq OWNED BY public.ulke.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_teklif ALTER COLUMN id SET DEFAULT nextval('public.alis_teklif_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_teklif_detay ALTER COLUMN id SET DEFAULT nextval('public.alis_teklif_detay_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur ALTER COLUMN id SET DEFAULT nextval('public.alis_tsif_kur_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambar ALTER COLUMN id SET DEFAULT nextval('public.ambar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_iletisim_kanali_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_invoice_type ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_invoice_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_istisna_kodu ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_istisna_kodu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_kimlik_semalari_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_response_code ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_response_code_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_senaryo_tipi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_tevkifat_kodu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_vergi_kodu ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_vergi_kodu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_evrak_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_evrak_tipi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_firma_tipi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi_detay ALTER COLUMN id SET DEFAULT nextval('public.ayar_firma_tipi_detay_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_genel_ayarlar ALTER COLUMN id SET DEFAULT nextval('public.ayar_genel_ayarlar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_hane_sayisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_hane_sayisi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_sabit_degisken ALTER COLUMN id SET DEFAULT nextval('public.ayar_sabit_degisken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareket_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_stok_hareket_tipi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareketi ALTER COLUMN id SET DEFAULT nextval('public.ayar_stok_hareketi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_teslim_sekli ALTER COLUMN id SET DEFAULT nextval('public.ayar_teslim_sekli_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka ALTER COLUMN id SET DEFAULT nextval('public.banka_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka_subesi ALTER COLUMN id SET DEFAULT nextval('public.banka_subesi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge ALTER COLUMN id SET DEFAULT nextval('public.bolge_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge_turu ALTER COLUMN id SET DEFAULT nextval('public.bolge_turu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap ALTER COLUMN id SET DEFAULT nextval('public.hesap_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap_grubu ALTER COLUMN id SET DEFAULT nextval('public.hesap_grubu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap_plani ALTER COLUMN id SET DEFAULT nextval('public.hesap_plani_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhasebe_hesap_plani ALTER COLUMN id SET DEFAULT nextval('public.muhasebe_hesap_plani_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.olcu_birimi ALTER COLUMN id SET DEFAULT nextval('public.olcu_birimi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.para_birimi ALTER COLUMN id SET DEFAULT nextval('public.para_birimi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi ALTER COLUMN id SET DEFAULT nextval('public.personel_ayrilma_nedeni_tipi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_bilgisi ALTER COLUMN id SET DEFAULT nextval('public.personel_bilgisi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_birim ALTER COLUMN id SET DEFAULT nextval('public.personel_birim_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_bolum ALTER COLUMN id SET DEFAULT nextval('public.personel_bolum_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_calisma_gecmisi ALTER COLUMN id SET DEFAULT nextval('public.personel_calisma_gecmisi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_gorev ALTER COLUMN id SET DEFAULT nextval('public.personel_gorev_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_tasima_servis ALTER COLUMN id SET DEFAULT nextval('public.personel_tasima_servis_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete ALTER COLUMN id SET DEFAULT nextval('public.recete_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_hammadde ALTER COLUMN id SET DEFAULT nextval('public.recete_hammadde_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_fatura ALTER COLUMN id SET DEFAULT nextval('public.satis_fatura_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_fatura_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_fatura_detay_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_irsaliye ALTER COLUMN id SET DEFAULT nextval('public.satis_irsaliye_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_irsaliye_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_irsaliye_detay_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_siparis ALTER COLUMN id SET DEFAULT nextval('public.satis_siparis_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_siparis_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_siparis_detay_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_teklif ALTER COLUMN id SET DEFAULT nextval('public.satis_teklif_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_teklif_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_teklif_detay_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir ALTER COLUMN id SET DEFAULT nextval('public.sehir_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_grubu ALTER COLUMN id SET DEFAULT nextval('public.stok_grubu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi ALTER COLUMN id SET DEFAULT nextval('public.stok_hareketi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_karti ALTER COLUMN id SET DEFAULT nextval('public.stok_karti_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_tipi ALTER COLUMN id SET DEFAULT nextval('public.stok_tipi_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_application_settings ALTER COLUMN id SET DEFAULT nextval('public.sys_application_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_application_settings_other ALTER COLUMN id SET DEFAULT nextval('public.sys_application_settings_other_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_color ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_col_color_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_percent ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_col_percent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_width ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_col_width_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_default_order_filter ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_default_order_filter_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang ALTER COLUMN id SET DEFAULT nextval('public.sys_lang_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang_contents ALTER COLUMN id SET DEFAULT nextval('public.sys_lang_contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source_group ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_source_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_quality_form_number ALTER COLUMN id SET DEFAULT nextval('public.sys_quality_form_number_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_table_lang_content ALTER COLUMN id SET DEFAULT nextval('public.sys_table_lang_content_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN id SET DEFAULT nextval('public.sys_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right ALTER COLUMN id SET DEFAULT nextval('public.sys_user_access_right_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulke ALTER COLUMN id SET DEFAULT nextval('public.ulke_id_seq'::regclass);


--
-- Data for Name: alis_teklif; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alis_teklif (id, validity, teklif_no, teklif_tarihi, cari_kod, firma, vergi_dairesi, vergi_no, aciklama, referans, teslim_tarihi, son_gecerlilik_tarihi, para_birimi, odeme_baslangic_donemi, toplam_tutar, toplam_iskonto_tutar, toplam_kdv_tutar, genel_toplam, musteri_temsilcisi_id, ulke, sehir, adres, posta_kodu, yurtici_ihracat, ortalama_opsiyon, fatura_tipi, tevkifat_kodu, ihrac_kayit_kodu, tevkifat_pay, tevkifat_payda, genel_iskonto_orani, genel_iskonto_tutar, is_e_fatura, siparislesti) FROM stdin;
\.


--
-- Data for Name: alis_teklif_detay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alis_teklif_detay (id, validity, header_id) FROM stdin;
\.


--
-- Name: alis_teklif_detay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alis_teklif_detay_id_seq', 1, false);


--
-- Name: alis_teklif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alis_teklif_id_seq', 6, true);


--
-- Data for Name: alis_tsif_kur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alis_tsif_kur (id, validity, alis_teklif_id, alis_siparis_id, alis_irsaliye_id, alis_fatura_id, para_birimi, deger) FROM stdin;
\.


--
-- Name: alis_tsif_kur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alis_tsif_kur_id_seq', 1, false);


--
-- Data for Name: ambar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ambar (id, validity, ambar, is_varsayilan) FROM stdin;
1	t	DEPO	t
2	t	FABRİKA	f
\.


--
-- Name: ambar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ambar_id_seq', 2, true);


--
-- Data for Name: ayar_efatura_iletisim_kanali; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_iletisim_kanali (id, validity, kod, aciklama) FROM stdin;
47	t	AA	Circuit switching
48	t	AB	SITA
49	t	AC	ARINC
50	t	AD	AT&T mailbox
51	t	AE	Peripheral device
52	t	AF	U.S. Defense Switched Network
53	t	AG	U.S. federal telecommunications system
55	t	AI	International calling country code
56	t	AJ	Alternate telephone
57	t	AK	Videotex number
59	t	AM	International telephone direct line
60	t	AN	O.F.T.P. (ODETTE File Transfer Protocol)
62	t	AP	Very High Frequency (VHF) radio telephone
63	t	AQ	X.400 address for mail text
64	t	AR	AS1 address
65	t	AS	AS2 address
66	t	AT	AS3 address
68	t	AV	Inmarsat call number
69	t	CA	Cable address
70	t	EI	EDI transmission
72	t	EX	Extension
73	t	FT	File transfer access method
74	t	FX	Telefax
75	t	GM	GEIS (General Electric Information Service) mailbox
76	t	IE	IBM information exchange
79	t	PB	Postbox number
80	t	PS	Packet switching
84	t	TL	Telex
85	t	TM	Telemail
87	t	TX	TWX
88	t	XF	X.400 address
89	t	XG	Pager
90	t	XH	International telephone switchboard
91	t	XI	National telephone direct line
92	t	XJ	National telephone switchboard
71	t	EM	EMAIL
81	t	SW	SWIFT
77	t	IM	INTERNAL MAIL
82	t	TE	TELEFON
83	t	TG	TELEGRAF
86	t	TT	TELETEXT
78	t	MA	POSTA SERVİS BELGESİ TESLİMATI
67	t	AU	FTP
58	t	AL	CEP TELEFONU
61	t	AO	URL WEB ADRESİ
54	t	AH	WWW WORLD WIDE WEB
\.


--
-- Name: ayar_efatura_iletisim_kanali_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_iletisim_kanali_id_seq', 92, true);


--
-- Data for Name: ayar_efatura_invoice_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_invoice_type (id, validity, tip) FROM stdin;
1	t	SATIS
2	t	IADE
3	t	TEVKIFAT
4	t	ISTISNA
5	t	OZELMATRAH
6	t	IHRACKAYITLI
\.


--
-- Name: ayar_efatura_invoice_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_invoice_type_id_seq', 6, true);


--
-- Data for Name: ayar_efatura_istisna_kodu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_istisna_kodu (id, validity, kodu, adi, tip, is_tam_istisna) FROM stdin;
1	t	201	17/1 Kültür ve Eğitim Amacı Taşıyan İşlemler	ISTISNA	f
2	t	202	17/2-a Sağlık, Çevre Ve Sosyal Yardım Amaçlı İşlemler	ISTISNA	f
3	t	204	17/2-c Yabancı Diplomatik Organ Ve Hayır Kurumlarının Yapacakları Bağışlarla İlgili Mal Ve Hizmet Alışları	ISTISNA	f
4	t	205	17/2-d Taşınmaz Kültür Varlıklarına İlişkin Teslimler ve Mimarlık Hizmetleri	ISTISNA	f
5	t	206	17/2-e Mesleki Kuruluşların İşlemleri	ISTISNA	f
6	t	207	17/3 Askeri Fabrika, Tersane ve Atölyelerin İşlemleri	ISTISNA	f
7	t	208	17/4-c Birleşme, Devir, Dönüşüm ve Bölünme İşlemleri	ISTISNA	f
8	t	209	17/4-e Banka ve Sigorta Muameleleri Vergisi Kapsamına Giren İşlemler	ISTISNA	f
9	t	211	17/4-h Zirai Amaçlı Su Teslimleri İle Köy Tüzel Kişiliklerince Yapılan İçme Suyu teslimleri	ISTISNA	f
10	t	212	17/4-ı Serbest Bölgelerde Verilen Hizmetler	ISTISNA	f
11	t	213	17/4-j Boru Hattı İle Yapılan Petrol Ve Gaz Taşımacılığı	ISTISNA	f
12	t	214	17/4-k Organize Sanayi Bölgelerindeki Arsa ve İşyeri Teslimleri İle Konut Yapı Kooperatiflerinin Üyelerine Konut Teslimleri	ISTISNA	f
13	t	215	17/4-l Varlık Yönetim Şirketlerinin İşlemleri	ISTISNA	f
14	t	216	17/4-m Tasarruf Mevduatı Sigorta Fonunun İşlemleri	ISTISNA	f
15	t	217	17/4-n Basın-Yayın ve Enformasyon Genel Müdürlüğüne Verilen Haber Hizmetleri	ISTISNA	f
16	t	218	17/4-o Gümrük Antrepoları, Geçici Depolama Yerleri, Gümrüklü Sahalar ve Vergisiz Satış Yapılan Mağazalarla İlgili Hizmetler	ISTISNA	f
17	t	219	17/4-p Hazine ve Arsa Ofisi Genel Müdürlüğünün işlemleri	ISTISNA	f
18	t	220	17/4-r İki Tam Yıl Süreyle Sahip Olunan Taşınmaz ve İştirak Hisseleri Satışları	ISTISNA	f
19	t	221	Geçici 15 Konut Yapı Kooperatifleri, Belediyeler ve Sosyal Güvenlik Kuruluşlarına Verilen İnşaat Taahhüt Hizmeti	ISTISNA	f
20	t	223	Geçici 20/1 Teknoloji Geliştirme Bölgelerinde Yapılan İşlemler	ISTISNA	f
21	t	225	Geçici 23 Milli Eğitim Bakanlığına Yapılan Bilgisayar Bağışları İle İlgili Teslimler	ISTISNA	f
22	t	226	17/2-b Özel Okulları, Üniversite ve Yüksekokullar Tarafından Verilen Bedelsiz Eğitim Ve Öğretim Hizmetleri	ISTISNA	f
23	t	227	17/2-b Kanunların Gösterdiği Gerek Üzerine Bedelsiz Olarak Yapılan Teslim ve Hizmetler	ISTISNA	f
24	t	228	17/2-b Kanunun (17/1) Maddesinde Sayılan Kurum ve Kuruluşlara Bedelsiz Olarak Yapılan Teslimler	ISTISNA	f
25	t	229	17/2-b Gıda Bankacılığı Faaliyetinde Bulunan Dernek ve Vakıflara Bağışlanan Gıda, Temizlik, Giyecek ve Yakacak Maddeleri	ISTISNA	f
26	t	230	17/4-g Külçe Altın, Külçe Gümüş Ve Kiymetli Taşlarin Teslimi	ISTISNA	f
27	t	231	17/4-g Metal Plastik, Lastik, Kauçuk, Kağit, Cam Hurda Ve Atıkların Teslimi	ISTISNA	f
28	t	232	17/4-g Döviz, Para, Damga Pulu, Değerli Kağıtlar, Hisse Senedi ve Tahvil Teslimleri	ISTISNA	f
29	t	234	17/4-ş Konut Finansmanı Amacıyla Teminat Gösterilen ve İpotek Konulan Konutların Teslimi	ISTISNA	f
30	t	235	16/1-c Transit ve Gümrük Antrepo Rejimleri İle Geçici Depolama ve Serbest Bölge Hükümlerinin Uygulandığiı Malların Teslimi	ISTISNA	f
31	t	236	19/2 Usulüne Göre Yürürlüğe Girmiş Uluslararası Anlaşmalar Kapsamındaki İstisnalar (İade Hakkı Tanınmayan)	ISTISNA	f
32	t	237	17/4-t 5300 Sayılı Kanuna Göre Düzenlenen Ürün Senetlerinin İhtisas/Ticaret Borsaları Aracılığıyla İlk Teslimlerinden Sonraki Teslim	ISTISNA	f
33	t	238	17/4-u Varlıkların Varlık Kiralama Şirketlerine Devri İle Bu Varlıkların Varlık Kiralama Şirketlerince Kiralanması ve Devralınan Kuruma Devri	ISTISNA	f
34	t	239	17/4-y Taşınmazların Finansal Kiralama Şirketlerine Devri, Finansal Kiralama Şirketi Tarafından Devredene Kiralanması ve Devri	ISTISNA	f
35	t	240	17/4-z Patentli Veya Faydalı Model Belgeli Buluşa İlişkin Gayri Maddi Hakların Kiralanması, Devri ve Satışı	ISTISNA	f
36	t	250	Diğerleri	ISTISNA	f
37	t	301	11/1-a Mal İhracatı	ISTISNA	t
38	t	302	11/1-a Hizmet İhracatı	ISTISNA	t
39	t	303	11/1-a Roaming Hizmetleri	ISTISNA	t
40	t	304	13/a Deniz Hava ve Demiryolu Taşıma Araçlarının Teslimi İle İnşa, Tadil, Bakım ve Onarımları	ISTISNA	t
41	t	305	13/b Deniz ve Hava Taşıma Araçları İçin Liman Ve Hava Meydanlarında Yapılan Hizmetler	ISTISNA	t
42	t	306	13/c Petrol Aramaları ve Petrol Boru Hatlarının İnşa ve Modernizasyonuna İlişkin Yapılan Teslim ve Hizmetler	ISTISNA	t
43	t	307	13/c Maden Arama, Altın, Gümüş, ve Platin Madenleri İçin İşletme, Zenginleştirme Ve Rafinaj Faaliyetlerine İlişkin Teslim Ve Hizmetler*KDVGUT-(II/8-4)]	ISTISNA	t
44	t	308	13/d Teşvikli Yatırım Mallarının Teslimi	ISTISNA	t
45	t	309	13/e Liman Ve Hava Meydanlarının İnşası, Yenilenmesi Ve Genişletilmesi	ISTISNA	t
46	t	310	13/f Ulusal Güvenlik Amaçlı Teslim ve Hizmetler	ISTISNA	t
47	t	311	14/1 Uluslararası Taşımacılık	ISTISNA	t
48	t	312	15/a Diplomatik Organ Ve Misyonlara Yapılan Teslim ve Hizmetler	ISTISNA	t
49	t	313	15/b Uluslararası Kuruluşlara Yapılan Teslim ve Hizmetler	ISTISNA	t
50	t	314	19/2 Usulüne Göre Yürürlüğe Girmiş Uluslar Arası Anlaşmalar Kapsamındaki İstisnalar	ISTISNA	t
51	t	315	14/3 İhraç Konusu Eşyayı Taşıyan Kamyon, Çekici ve Yarı Romorklara Yapılan Motorin Teslimleri	ISTISNA	t
52	t	316	11/1-a Serbest Bölgelerdeki Müşteriler İçin Yapılan Fason Hizmetler	ISTISNA	t
53	t	317	17/4-s Engellilerin Eğitimleri, Meslekleri ve Günlük Yaşamlarına İlişkin Araç-Gereç ve Bilgisayar Programları	ISTISNA	t
54	t	318	Geçici 29 3996 Sayılı Kanuna Göre Yap-İşlet-Devret Modeli Çerçevesinde Gerçekleştirilecek Projeler, 3359 Sayılı Kanuna Göre Kiralama Karşılığı Yaptırılan Sağlık Tesislerine İlişkin Projeler ve 652 Sayılı Kanun Hükmünde Kararnameye Göre Kiralama Karşılığı Yaptırılan Eğitim Öğretim Tesislerine İlişkin Projelere İlişkin Teslim ve Hizmetler	ISTISNA	t
55	t	319	13/g Başbakanlık Merkez Teşkilatına Yapılan Araç Teslimleri	ISTISNA	t
56	t	320	Geçici 16 (6111 sayılı K.) İSMEP Kapsamında İstanbul İl Özel İdaresi ne Bağlı Olarak Faaliyet Gösteren “İstanbul Proje Koordinasyon Birimi”ne Yapılacak Teslim ve Hizmetler	ISTISNA	t
66	t	101	İhracat İstisnası	ISTISNA	t
67	t	102	Diplomatik İstisna	ISTISNA	t
57	t	321	Geçici 26 Birleşmiş Milletler (BM) ile Kuzey Atlantik Antlaşması Teşkilatı (NATO) Temsilcilikleri ve Bu Teşkilatlara Bağlı Program, Fon ve Özel İhtisas Kuruluşları ile İktisadi İşbirliği ve Kalkınma Teşkilatına (OECD) Resmi Kullanımları İçin Yapılacak Mal Teslimi ve Hizmet İfaları, Bunların Sosyal ve Ekonomik Yardım Amacıyla Bedelsiz Olarak Yapacakları Mal Teslimi ve Hizmet İfaları İle İlgili Bunlara Yapılan Mal Teslimi ve Hizmet İfaları	ISTISNA	t
58	t	322	11/1-a Türkiye de İkamet Etmeyenlere Özel Fatura ile Yapılan Teslimler (Bavul Ticareti)	ISTISNA	t
59	t	323	13/ğ 5300 Sayılı Kanuna Göre Düzenlenen Ürün Senetlerinin İhtisas/Ticaret Borsaları Aracılığıyla İlk Teslimi	ISTISNA	t
60	t	324	13/h Türkiye Kızılay Derneğine Yapılan Teslim ve Hizmetler ile Türkiye Kızılay Derneğinin Teslim ve Hizmetleri	ISTISNA	t
61	t	325	13/ı Yem Teslimleri	ISTISNA	t
62	t	326	13/ı Gıda, Tarım ve Hayvancılık Bakanlığı Tarafından Tescil Edilmiş Gübrelerin Teslimi	ISTISNA	t
63	t	327	13/ı Gıda, Tarım ve Hayvancılık Bakanlığı Tarafından Tescil Edilmiş Gübrelerin İçeriğinde Bulunan Hammaddelerin Gübre Üreticilerine Teslimi	ISTISNA	t
64	t	350	Diğerleri	ISTISNA	t
65	t	351	KDV - İstisna Olmayan Diğer	SATIS	t
68	t	103	Askeri Amaçlı İstisna	ISTISNA	t
69	t	104	Petrol Arama Faaliyetlerinde Bulunanlara Yapılan Teslimler	ISTISNA	t
70	t	105	Uluslararası Anlaşmadan Doğan İstisna	ISTISNA	t
71	t	106	Diğer İstisnalar	ISTISNA	t
72	t	107	7/a Maddesi Kapsamında Yapılan Teslimler	ISTISNA	t
73	t	108	Geçici 5. Madde Kapsamında Yapılan Teslimler	ISTISNA	t
74	t	151	ÖTV - İstisna Olmayan Diğer	ISTISNA	t
75	t	701	3065 s. KDV Kanununun 11/1-c md. Kapsamındaki İhraç Kayıtlı Satış	IHRACKAYITLI	t
76	t	702	DİİB ve Geçici Kabul Rejimi Kapsamındaki Satışlar	IHRACKAYITLI	t
77	t	703	4760 s. ÖTV Kanununun 8/2 Md. Kapsamındaki İhraç Kayıtlı Satış	IHRACKAYITLI	t
78	t	801	Milli piyango, spor-toto ve benzeri Devletçe organize edilen organizasyonlar	OZELMATRAH	t
79	t	802	At yarışları ve diğer müşterek bahis ve talih oyunları	OZELMATRAH	t
80	t	803	Profesyonel sanatçıların yer aldığı gösteriler ve konserler ile profesyonel sporcuların katıldığı sportif faaliyetler, maçlar ve yarışlar ve yarışmalar	OZELMATRAH	t
81	t	804	Gümrük depolarında ve müzayede salonlarında yapılan satışlar	OZELMATRAH	t
82	t	805	Altından mamül veya altın ihtiva eden ziynet eşyaları ile sikke altınların teslim ve ithali	OZELMATRAH	t
83	t	806	Tütün mamülleri ve bazı alkollü içkiler	OZELMATRAH	t
84	t	807	Gazete, dergi ve benzeri periyodik yayınlar	OZELMATRAH	t
85	t	808	Külçe gümüş ve gümüşten mamül eşya teslimleri	OZELMATRAH	t
86	t	809	Belediyeler tarafından yapılan şehiriçi yolcu taşımacılığında kullanılan biletlerin ve kartların bayiler tarafından satışı	OZELMATRAH	t
87	t	810	Telefon kartı ve jeton satışları	OZELMATRAH	t
88	t	811	Türkiye Şoförler ve Otomobilciler Federasyonu tarafından araç plakaları ile sürücü kurslarında kullanılan bir kısım evrakın basımı	OZELMATRAH	t
\.


--
-- Name: ayar_efatura_istisna_kodu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_istisna_kodu_id_seq', 65, true);


--
-- Data for Name: ayar_efatura_kimlik_semalari; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_kimlik_semalari (id, validity, deger, aciklama) FROM stdin;
1	t	VKN	VERGİ KİMLİK NUMARASI
2	t	TCKN	TC KİMLİK NUMARASI
3	t	HIZMETNO	HİZMET NO
4	t	MUSTERINO	MÜŞTERİ NO
5	t	TESISATNO	TESİSAT NO
6	t	TELEFONNO	TELEFON NO
7	t	DISTRIBUTORNO	DİSTRİBÜTÖR NO
8	t	TICARETSICILNO	TİCARET SİCİL NO
9	t	TAPDKNO	TAPDK NO
10	t	BAYINO	BAYİ NO
11	t	ABONENO	ABONE NO
12	t	SAYACNO	SAYAÇ NO
13	t	URETICINO	ÜRETİCİ NO
14	t	CIFTCINO	ÇİFTÇİ NO
15	t	IMALATCINO	İMALATÇI NO
16	t	DOSYANO	DOSYA NO
17	t	HASTANO	HASTA NO
\.


--
-- Name: ayar_efatura_kimlik_semalari_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_kimlik_semalari_id_seq', 17, true);


--
-- Data for Name: ayar_efatura_response_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_response_code (id, validity, deger) FROM stdin;
1	t	KABUL
2	t	RED
3	t	IADE
\.


--
-- Name: ayar_efatura_response_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_response_code_id_seq', 3, true);


--
-- Data for Name: ayar_efatura_senaryo_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_senaryo_tipi (id, validity, tip, aciklama) FROM stdin;
1	t	TEMELIRSALIYE	TEMEL İRSALİYE SÜRECİNİ BELİRTİR
2	t	TEMELFATURA	TEMEL FATURA SÜRECİNİ BELİRTİR
3	t	TICARIFATURA	TİCARİ FATURA SÜRECİNİ BELİRTİR
4	t	IHRACAT	İHRACAT FATURASI SÜRECİNİ BELİRTİR
5	t	YOLCUBERABERFATURA	YOLCU BERABER EŞYA FATURA SÜRECİNİ BELİRTİR
\.


--
-- Name: ayar_efatura_senaryo_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_senaryo_tipi_id_seq', 5, true);


--
-- Data for Name: ayar_efatura_tevkifat_kodu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_tevkifat_kodu (id, validity, kodu, adi, orani, pay, payda) FROM stdin;
1	t	601	YAPIM İŞLERİ İLE BU İŞLERLE BİRLİKTE İFA EDİLEN MÜHENDİSLİK-MİMARLIK VE ETÜT-PROJE HİZMETLERİ *GT 117-Bölüm (3.2.1)+	2/10	2	10
2	t	602	ETÜT, PLAN-PROJE, DANIŞMANLIK, DENETİM VE BENZERİ HİZMETLER*GT 117-Bölüm (3.2.2)+	9/10	9	10
3	t	603	MAKİNE, TEÇHİZAT, DEMİRBAŞ VE TAŞITLARA AİT TADİL, BAKIM VE ONARIM HİZMETLERİ *GT 117-Bölüm (3.2.3)+	5/10	5	10
4	t	604	YEMEK SERVİS HİZMETİ *GT 117-Bölüm (3.2.4)+	5/10	5	10
5	t	605	ORGANİZASYON HİZMETİ *GT 117-Bölüm (3.2.4)+	5/10	5	10
6	t	606	İŞGÜCÜ TEMİN HİZMETLERİ *GT 117-Bölüm (3.2.5)+	9/10	9	10
7	t	607	ÖZEL GÜVENLİK HİZMETİ *GT 117-Bölüm (3.2.5)+	9/10	9	10
8	t	608	YAPI DENETİM HİZMETLERİ *GT 117-Bölüm (3.2.6)+	9/10	9	10
9	t	609	FASON OLARAK YAPTIRILAN TEKSTİL VE KONFEKSİYON İŞLERİ, ÇANTA VE AYAKKABI DİKİM İŞLERİ VE BU İŞLERE ARACILIK HİZMETLERİ *GT 117-Bölüm (3.2.7)+	5/10	5	10
10	t	610	TURİSTİK MAĞAZALARA VERİLEN MÜŞTERİ BULMA / GÖTÜRME HİZMETLERİ *GT 117-Bölüm (3.2.8)+	9/10	9	10
11	t	611	SPOR KULÜPLERİNİN YAYIN, REKLÂM VE İSİM HAKKI GELİRLERİNE KONU İŞLEMLERİ *GT 117-Bölüm (3.2.9)+	9/10	9	10
12	t	612	TEMİZLİK HİZMETİ *GT 117-Bölüm (3.2.10)+	7/10	7	10
13	t	613	ÇEVRE VE BAHÇE BAKIM HİZMETLERİ *GT 117-Bölüm (3.2.10)+	7/10	7	10
14	t	614	SERVİS TAŞIMACILIĞI HİZMETİ *GT 117-Bölüm (3.2.11)+	5/10	5	10
15	t	615	HER TÜRLÜ BASKI VE BASIM HİZMETLERİ *GT 117-Bölüm (3.2.12)+	5/10	5	10
16	t	616	5018 SAYILI KANUNA EKLİ CETVELLERDEKİ İDARE, KURUM VE KURUŞLARA YAPILAN DİĞER HİZMETLER *GT 117-Bölüm (3.2.13)+	5/10	5	10
17	t	617	HURDA METALDEN ELDE EDİLEN KÜLÇE TESLİMLERİ *GT 117-Bölüm (3.3.1)+	5/10	5	10
18	t	618	HURDA METALDEN ELDE EDİLENLER DIŞINDAKİ BAKIR, ÇİNKO VE ALÜMİNYUM KÜLÇE TESLİMLERİ *GT 117-Bölüm (3.3.1)+	5/10	5	10
19	t	619	BAKIR, ÇİNKO VE ALÜMİNYUM ÜRÜNLERİNİN TESLİMİ *GT 117-Bölüm (3.3.2)+	5/10	5	10
20	t	620	İSTİSNADAN VAZGEÇENLERİN HURDA VE ATIK TESLİMİ *GT 117-Bölüm (3.3.3)+	5/10	5	10
21	t	621	METAL, PLASTİK, LASTİK, KAUÇUK, KÂĞIT VE CAM HURDA VE ATIKLARDAN ELDE EDİLEN HAMMADDE TESLİMİ *GT 117-Bölüm (3.3.4)]	9/10	9	10
22	t	622	PAMUK, TİFTİK, YÜN VE YAPAĞI İLE HAM POST VE DERİ TESLİMLERİ *GT 117-Bölüm (3.3.5)+	9/10	9	10
23	t	623	AĞAÇ VE ORMAN ÜRÜNLERİ TESLİMİ *GT 117-Bölüm (3.3.6)+	5/10	5	10
25	t	650	DİĞERLERİ	5/10	5	10
26	t	650	DİĞERLERİ	7/10	7	10
27	t	650	DİĞERLERİ	9/10	9	10
24	t	650	DİĞERLERİ	2/10	2	10
\.


--
-- Name: ayar_efatura_tevkifat_kodu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_tevkifat_kodu_id_seq', 1, false);


--
-- Data for Name: ayar_efatura_vergi_kodu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_efatura_vergi_kodu (id, validity, kodu, adi, kisaltma, tevkifat) FROM stdin;
27	t	9077	MOTORLU TAŞIT ARAÇLARINA İLİŞKİN ÖZEL TÜKETİM VERGİSİ (TESCİLE TABİ OLANLAR)	ÖTV 2.LİSTE	f
26	t	9040	MERA FONU	MERA FONU	f
1	t	0003	GELİR VERGİSİ STOPAJI	GV STOPAJI	f
2	t	0011	KURUMLAR VERGİSİ STOPAJI	KV STOPAJI	f
3	t	0015	GERÇEK USULDE KATMA DEĞER VERGİSİ	KDV GERCEK	f
4	t	0021	BANKA MUAMELELERİ VERGİSİ	BMV	f
5	t	0061	KAYNAK KULLANIMI DESTEKLEME FONU KESİNTİSİ	KKDF KESİNTİ	f
6	t	0071	PETROL VE DOĞALGAZ ÜRÜNLERİNE İLİŞKİN ÖZEL TÜKETİM VERGİSİ	ÖTV 1.LİSTE	f
7	t	0073	KOLALI GAZOZ, ALKOLLÜ İÇEÇEKLER VE TÜTÜN MAMÜLLERİNE İLİŞKİN ÖZEL TÜKETİM VERGİSİ	ÖTV 3.LİSTE	f
8	t	0074	DAYANIKLI TÜKETİM VE DİĞER MALLARA İLİŞKİN ÖZEL TÜKETİM VERGİSİ	ÖTV 4.LİSTE	f
9	t	0075	ALKOLLÜ İÇEÇEKLERE İLİŞKİN ÖZEL TÜKETİM VERGİSİ	ÖTV 3A LİSTE	f
10	t	0076	TÜTÜN MAMÜLLERİNE İLİŞKİN ÖZEL TÜKETİM VERGİSİ	ÖTV 3B LİSTE	f
11	t	0077	KOLALI GAZOZLARA İLİŞKİN ÖZEL TÜKETİM VERGİSİ	ÖTV 3C LİSTE	f
12	t	1047	DAMGA VERGİSİ	DAMGA V	f
13	t	1048	5035 SAYILI KANUNA GÖRE DAMGA VERGİSİ	5035SKDAMGAV	f
14	t	4071	ELEKTRİK VE HAVAGAZI TÜKETİM VERGİSİ	ELK.HAVAGAZ.TÜK.VER.	f
15	t	4080	ÖZEL İLETİŞİM VERGİSİ	Ö.İLETİŞİM V	f
16	t	4081	5035 SAYILI KANUNA GÖRE ÖZEL İLETİŞİM VERGİSİ	5035ÖZİLETV.	f
17	t	4171	PETROL VE DOĞALGAZ ÜRÜNLERİNE İLİŞKİN ÖTV TEVKİFATI	PTR-DGZ ÖTV TEVKİFAT	f
18	t	8001	BORSA TESCİL ÜCRETİ	BORSA TES.ÜC.	f
19	t	8002	ENERJİ FONU	ENERJİ FONU	f
21	t	8005	ELEKTRİK TÜKETİM VERGİSİ	ELK.TÜK.VER.	f
20	t	8004	TRT PAYI	TRT PAYI	f
22	t	8006	TELSİZ KULLANIM ÜCRETİ	TK KULLANIM	f
23	t	8007	TELSİZ RUHSAT ÜCRETİ	TK RUHSAT	f
24	t	8008	ÇEVRE TEMİZLİK VERGİSİ	ÇEV. TEM .VER.	f
25	t	9021	4961 BANKA SİGORTA MUAMELELERİ VERGİSİ	4961BANKASMV	f
\.


--
-- Name: ayar_efatura_vergi_kodu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_efatura_vergi_kodu_id_seq', 27, true);


--
-- Data for Name: ayar_evrak_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_evrak_tipi (id, validity, deger) FROM stdin;
1	t	TEKLİF
2	t	SİPARİŞ
3	t	İRSALİYE
4	t	FATURA
\.


--
-- Name: ayar_evrak_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_evrak_tipi_id_seq', 4, true);


--
-- Data for Name: ayar_firma_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_firma_tipi (id, validity, tip) FROM stdin;
1	t	ŞAHIS
2	t	SERMAYE
\.


--
-- Data for Name: ayar_firma_tipi_detay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_firma_tipi_detay (id, validity, deger, firma_tipi) FROM stdin;
1	t	ADİ	ŞAHIS
2	t	KOLEKTİF	ŞAHIS
3	t	KOMANDİT	ŞAHIS
4	t	KOMANDİT	SERMAYE
5	t	LİMİTED	SERMAYE
6	t	ANONİM	SERMAYE
\.


--
-- Name: ayar_firma_tipi_detay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_firma_tipi_detay_id_seq', 6, true);


--
-- Name: ayar_firma_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_firma_tipi_id_seq', 2, true);


--
-- Data for Name: ayar_genel_ayarlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_genel_ayarlar (id, validity, donem, unvan, vergi_no, tc_no, firma_tipi, diger_ayarlar) FROM stdin;
1	t	2018	DENEME A.Ş.	1234567890	\N	ANONİM SERMAYE	{"vkn_tckn":"12345678901","unvan":"DENEME A.Ş.","adi":"ALİ","soyadi":"VELİ","bulvar":"aa","cadde": "","sokak": "","bina_adi":"","bina_no":"","kapi_no":"1","kasa_koy": "","mahalle":"SANAYİ","semt": "","ilce": "","sehir":"İSTANBUL","ulke":"tr","posta_kodu":34956,"telefon":"0216 123 45 89","faks":"0216 123 45 90","eposta":"abc@gmail.com","web_uri":"www.gmail.com","vergi_dairesi": "PENDİK","vergi_no": "1234567890","mersis_sicil_no": "","nace_kodu": "","iban": "","efatura_mukellef": true}
\.


--
-- Name: ayar_genel_ayarlar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_genel_ayarlar_id_seq', 1, true);


--
-- Data for Name: ayar_hane_sayisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_hane_sayisi (id, validity, hesap_bakiye, alis_miktar, alis_fiyat, alis_tutar, satis_miktar, satis_fiyat, satis_tutar, stok_miktar, stok_fiyat) FROM stdin;
1	t	2	6	6	2	2	3	2	4	4
\.


--
-- Name: ayar_hane_sayisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_hane_sayisi_id_seq', 1, true);


--
-- Data for Name: ayar_sabit_degisken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_sabit_degisken (id, validity, deger) FROM stdin;
1	t	SABİT
2	t	DEĞİŞKEN
\.


--
-- Name: ayar_sabit_degisken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_sabit_degisken_id_seq', 2, true);


--
-- Data for Name: ayar_stok_hareket_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_stok_hareket_tipi (id, validity, deger) FROM stdin;
1	t	GİRİŞ
2	t	ÇIKIŞ
\.


--
-- Name: ayar_stok_hareket_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_stok_hareket_tipi_id_seq', 2, true);


--
-- Data for Name: ayar_stok_hareketi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_stok_hareketi (id, validity, giris_ayari, cikis_ayari) FROM stdin;
1	t	İRSALİYE	İRSALİYE
\.


--
-- Name: ayar_stok_hareketi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_stok_hareketi_id_seq', 1, true);


--
-- Data for Name: ayar_teslim_sekli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_teslim_sekli (id, validity, kod, teslim_sekli, is_active) FROM stdin;
1	t	EX-WORKS	FABRİKA TESLİM	t
4	t	DAP	DAP HAVAYOLU	t
5	t	CIP	CIP KARAYOLU-HAVAYOLU	t
6	t	CFR	CFR DENİZYOLU	t
3	t	FCA	FCA KARAYOLU	t
7	t	FOB	FOB DENİZYOLU	t
2	t	CIF	CIF DENİZYOLU	t
\.


--
-- Name: ayar_teslim_sekli_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_teslim_sekli_id_seq', 7, true);


--
-- Data for Name: banka; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banka (id, validity, adi, swift_kodu, is_active) FROM stdin;
\.


--
-- Name: banka_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banka_id_seq', 1, false);


--
-- Data for Name: banka_subesi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banka_subesi (id, validity, sube_kodu, sube_adi, sube_il, banka_adi) FROM stdin;
\.


--
-- Name: banka_subesi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banka_subesi_id_seq', 1, false);


--
-- Data for Name: bolge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bolge (id, validity, bolge, bolge_turu, hedef_ocak, hedef_subat, hedef_mart, hedef_nisan, hedef_mayis, hedef_haziran, hedef_temmuz, hedef_agustos, hedef_eylul, hedef_ekim, hedef_kasim, hedef_aralik, gecen_ocak, gecen_subat, gecen_mart, gecen_nisan, gecen_mayis, gecen_haziran, gecen_temmuz, gecen_agustos, gecen_eylul, gecen_ekim, gecen_kasim, gecen_aralik) FROM stdin;
4	t	MARMARA	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	t	EGE	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	t	AKDENİZ	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	t	KARADENİZ	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	t	İÇ ANADOLU	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	t	DOĞU ANADOLU	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	t	KUZEY DOĞU ANADOLU	YURTİÇİ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: bolge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bolge_id_seq', 10, true);


--
-- Data for Name: bolge_turu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bolge_turu (id, validity, tur) FROM stdin;
1	t	YURTİÇİ
2	t	YURTDIŞI
\.


--
-- Name: bolge_turu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bolge_turu_id_seq', 2, true);


--
-- Data for Name: hesap; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hesap (id, validity, firma_tipi, firma_tipi_detay, hesap_kodu, hesap_ismi, mukellef_tipi, hesap_grubu, yetkili_adi, yetkili_soyadi, tel1, tel2, tel3, faks1, faks2, faks3, web_uri, eposta, muhasebe_tel, muhasebe_eposta, sokak, cadde, mahalle, ilce, sehir, bolge, bina, kapi_no, posta_kutusu, posta_kodu, ulke, vergi_dairesi, vergi_no, nace_kodu, iskonto, muhasebe_kodu, ana_hesap_muhasebe_kodu, plan_kodu, ozel_bilgi, para_birimi, temsilci, ortalama_vade, is_efatura) FROM stdin;
\.


--
-- Data for Name: hesap_grubu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hesap_grubu (id, validity, grup) FROM stdin;
\.


--
-- Name: hesap_grubu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hesap_grubu_id_seq', 1, false);


--
-- Name: hesap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hesap_id_seq', 1, false);


--
-- Data for Name: hesap_plani; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hesap_plani (id, validity, plan_kodu, seviye_sayisi) FROM stdin;
\.


--
-- Name: hesap_plani_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hesap_plani_id_seq', 1, false);


--
-- Data for Name: muhasebe_hesap_plani; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muhasebe_hesap_plani (id, validity, plan_kodu, seviye_sayisi) FROM stdin;
\.


--
-- Name: muhasebe_hesap_plani_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.muhasebe_hesap_plani_id_seq', 1, false);


--
-- Data for Name: olcu_birimi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.olcu_birimi (id, validity, birim, float_tip, birim_kod, birim_aciklama) FROM stdin;
\.


--
-- Name: olcu_birimi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.olcu_birimi_id_seq', 80, true);


--
-- Data for Name: para_birimi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.para_birimi (id, kod, sembol, aciklama, is_varsayilan) FROM stdin;
1	TL	₺	TÜRK LİRASI	t
\.


--
-- Name: para_birimi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.para_birimi_id_seq', 1, true);


--
-- Data for Name: personel_ayrilma_nedeni_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_ayrilma_nedeni_tipi (id, validity, tip) FROM stdin;
1	t	İSTİFA
2	t	DENEME SÜRESİ SONU
3	t	İŞVEREN TARAFINDAN İŞ SONU
4	t	ÇALIŞAN TARAFINDAN İŞ SONU
\.


--
-- Name: personel_ayrilma_nedeni_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_ayrilma_nedeni_tipi_id_seq', 4, true);


--
-- Data for Name: personel_bilgisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_bilgisi (id, validity, ad, soyad, dogum_tarihi, kan_grubu, cinsiyet, ev_telefonu, cep_telefonu, yakin_ad_soyad, yakin_telefonu, mail_adresi, medeni_durumu, cocuk_sayisi, ayakkabi_no, elbise_bedeni, askerlik_durumu, servis_id, brut_maas, ozel_not, is_active, is_ikramiye, ikramiye_sayisi, ikramiye_miktar, genel_not, tc_kimlik_no, personel_tipi, personel_gecmisi_id, birim_id, gorev_id) FROM stdin;
3	t	MUSTAFA	TİRYAKİ	1989-03-03	B RH -	BAY	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	2	1
1	t	FERHAT	YILDIRIM	1986-01-01	B RH +	BAY	0216 396 83 55	0555 625 87 96	AYŞE YILDIRIM	0554 868 22 44	ferhatyildirim1986@gmail.com	EVLİ	0	42	L	YAPTI	1	5000	ÖZEL NOT	t	t	4	2500	GENEL NOT	30850336806	MEMUR	\N	1	4
2	t	AYNUR	YILDIRIM	1988-02-02	A RH +	BAYAN	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	t	f	\N	\N	\N	\N	\N	\N	8	1
\.


--
-- Name: personel_bilgisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_bilgisi_id_seq', 3, true);


--
-- Data for Name: personel_birim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_birim (id, validity, bolum_id, birim) FROM stdin;
1	t	1	YAZILIM
2	t	1	DONANIM
3	t	2	TAHSİLAT
4	t	4	OPERASYON
5	t	4	ÜRÜN YÖNETİMİ
6	t	6	SATIN ALMA
7	t	6	SEVKİYAT
8	t	2	MUHASEBE
\.


--
-- Name: personel_birim_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_birim_id_seq', 8, true);


--
-- Data for Name: personel_bolum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_bolum (id, validity, bolum) FROM stdin;
1	t	BİLGİ İŞLEM
2	t	MUHASEBE
3	t	İMALAT
4	t	SATIŞ
5	t	AR-GE
6	t	DEPO
\.


--
-- Name: personel_bolum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_bolum_id_seq', 6, true);


--
-- Data for Name: personel_calisma_gecmisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_calisma_gecmisi (id, validity, personel_id, personel_birim, personel_gorev, ise_giris_tarihi, isten_cikis_tarihi, ayrilma_nedeni_tipi, ayrilma_nedeni_aciklama) FROM stdin;
\.


--
-- Name: personel_calisma_gecmisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_calisma_gecmisi_id_seq', 1, false);


--
-- Data for Name: personel_gorev; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_gorev (id, validity, gorev) FROM stdin;
1	t	ELEMAN
2	t	MÜDÜR
3	t	AMİR
4	t	ŞEF
5	t	ÇIRAK
6	t	KALFA
7	t	MÜHENDİS
8	t	SANTRAL
9	t	STAJYER
\.


--
-- Name: personel_gorev_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_gorev_id_seq', 9, true);


--
-- Data for Name: personel_tasima_servis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_tasima_servis (id, validity, servis_no, servis_adi, rota) FROM stdin;
1	t	1	PENDİK 1	{123,1425,445,99856}
\.


--
-- Name: personel_tasima_servis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_tasima_servis_id_seq', 1, true);


--
-- Data for Name: recete; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recete (id, validity, mamul_stok_kodu, ornek_uretim_miktari, fire_orani, aciklama, recete_adi) FROM stdin;
\.


--
-- Data for Name: recete_hammadde; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recete_hammadde (id, validity, header_id, stok_kodu, miktar, fire_orani, recete_id) FROM stdin;
\.


--
-- Name: recete_hammadde_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recete_hammadde_id_seq', 1, false);


--
-- Name: recete_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recete_id_seq', 1, false);


--
-- Data for Name: satis_fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_fatura (id, validity) FROM stdin;
\.


--
-- Data for Name: satis_fatura_detay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_fatura_detay (id, validity, header_id) FROM stdin;
\.


--
-- Name: satis_fatura_detay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_fatura_detay_id_seq', 1, false);


--
-- Name: satis_fatura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_fatura_id_seq', 1, false);


--
-- Data for Name: satis_irsaliye; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_irsaliye (id, validity) FROM stdin;
\.


--
-- Data for Name: satis_irsaliye_detay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_irsaliye_detay (id, validity, header_id) FROM stdin;
\.


--
-- Name: satis_irsaliye_detay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_irsaliye_detay_id_seq', 1, false);


--
-- Name: satis_irsaliye_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_irsaliye_id_seq', 1, false);


--
-- Data for Name: satis_siparis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_siparis (id, validity) FROM stdin;
\.


--
-- Data for Name: satis_siparis_detay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_siparis_detay (id, validity, header_id) FROM stdin;
\.


--
-- Name: satis_siparis_detay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_siparis_detay_id_seq', 1, false);


--
-- Name: satis_siparis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_siparis_id_seq', 1, false);


--
-- Data for Name: satis_teklif; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_teklif (id, validity) FROM stdin;
\.


--
-- Data for Name: satis_teklif_detay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satis_teklif_detay (id, validity, header_id) FROM stdin;
\.


--
-- Name: satis_teklif_detay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_teklif_detay_id_seq', 1, false);


--
-- Name: satis_teklif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satis_teklif_id_seq', 1, false);


--
-- Data for Name: sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sehir (id, validity, sehir_adi, ulke_adi, plaka_kodu) FROM stdin;
1	t	İSTANBUL	TÜRKİYE	34
4	t	ÇANKIRI	TÜRKİYE	18
3	t	İZMİR	TÜRKİYE	35
2	t	ANKARA	TÜRKİYE	6
\.


--
-- Name: sehir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sehir_id_seq', 4, true);


--
-- Data for Name: stok_grubu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stok_grubu (id, validity, grup) FROM stdin;
\.


--
-- Name: stok_grubu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stok_grubu_id_seq', 1, false);


--
-- Data for Name: stok_hareketi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stok_hareketi (id, validity, stok_kodu, miktar, tutar, giris_cikis_tip_id, alan_ambar, veren_ambar, tarih) FROM stdin;
2	t	1	1	2	2	\N	\N	2018-07-05 07:52:56.311554
3	t	2	2	4	1	\N	\N	2018-07-05 07:52:56.311554
4	t	3	3	6	2	\N	\N	2018-07-05 07:52:56.311554
5	t	4	4	8	1	\N	\N	2018-07-05 07:52:56.311554
6	t	5	5	10	2	\N	\N	2018-07-05 07:52:56.311554
7	t	6	6	12	1	\N	\N	2018-07-05 07:52:56.311554
8	t	7	7	14	2	\N	\N	2018-07-05 07:52:56.311554
9	t	8	8	16	1	\N	\N	2018-07-05 07:52:56.311554
10	t	9	9	18	2	\N	\N	2018-07-05 07:52:56.311554
11	t	10	10	20	1	\N	\N	2018-07-05 07:52:56.311554
12	t	11	11	22	2	\N	\N	2018-07-05 07:52:56.311554
13	t	12	12	24	1	\N	\N	2018-07-05 07:52:56.311554
14	t	13	13	26	2	\N	\N	2018-07-05 07:52:56.311554
15	t	14	14	28	1	\N	\N	2018-07-05 07:52:56.311554
16	t	15	15	30	2	\N	\N	2018-07-05 07:52:56.311554
17	t	16	16	32	1	\N	\N	2018-07-05 07:52:56.311554
18	t	17	17	34	2	\N	\N	2018-07-05 07:52:56.311554
19	t	18	18	36	1	\N	\N	2018-07-05 07:52:56.311554
20	t	19	19	38	2	\N	\N	2018-07-05 07:52:56.311554
21	t	20	20	40	1	\N	\N	2018-07-05 07:52:56.311554
22	t	21	21	42	2	\N	\N	2018-07-05 07:52:56.311554
23	t	22	22	44	1	\N	\N	2018-07-05 07:52:56.311554
24	t	23	23	46	2	\N	\N	2018-07-05 07:52:56.311554
25	t	24	24	48	1	\N	\N	2018-07-05 07:52:56.311554
26	t	25	25	50	2	\N	\N	2018-07-05 07:52:56.311554
27	t	26	26	52	1	\N	\N	2018-07-05 07:52:56.311554
28	t	27	27	54	2	\N	\N	2018-07-05 07:52:56.311554
29	t	28	28	56	1	\N	\N	2018-07-05 07:52:56.311554
30	t	29	29	58	2	\N	\N	2018-07-05 07:52:56.311554
31	t	30	30	60	1	\N	\N	2018-07-05 07:52:56.311554
32	t	31	31	62	2	\N	\N	2018-07-05 07:52:56.311554
33	t	32	32	64	1	\N	\N	2018-07-05 07:52:56.311554
34	t	33	33	66	2	\N	\N	2018-07-05 07:52:56.311554
35	t	34	34	68	1	\N	\N	2018-07-05 07:52:56.311554
36	t	35	35	70	2	\N	\N	2018-07-05 07:52:56.311554
37	t	36	36	72	1	\N	\N	2018-07-05 07:52:56.311554
38	t	37	37	74	2	\N	\N	2018-07-05 07:52:56.311554
39	t	38	38	76	1	\N	\N	2018-07-05 07:52:56.311554
40	t	39	39	78	2	\N	\N	2018-07-05 07:52:56.311554
41	t	40	40	80	1	\N	\N	2018-07-05 07:52:56.311554
42	t	41	41	82	2	\N	\N	2018-07-05 07:52:56.311554
43	t	42	42	84	1	\N	\N	2018-07-05 07:52:56.311554
44	t	43	43	86	2	\N	\N	2018-07-05 07:52:56.311554
45	t	44	44	88	1	\N	\N	2018-07-05 07:52:56.311554
46	t	45	45	90	2	\N	\N	2018-07-05 07:52:56.311554
47	t	46	46	92	1	\N	\N	2018-07-05 07:52:56.311554
48	t	47	47	94	2	\N	\N	2018-07-05 07:52:56.311554
49	t	48	48	96	1	\N	\N	2018-07-05 07:52:56.311554
50	t	49	49	98	2	\N	\N	2018-07-05 07:52:56.311554
51	t	50	50	100	1	\N	\N	2018-07-05 07:52:56.311554
52	t	51	51	102	2	\N	\N	2018-07-05 07:52:56.311554
53	t	52	52	104	1	\N	\N	2018-07-05 07:52:56.311554
54	t	53	53	106	2	\N	\N	2018-07-05 07:52:56.311554
55	t	54	54	108	1	\N	\N	2018-07-05 07:52:56.311554
56	t	55	55	110	2	\N	\N	2018-07-05 07:52:56.311554
57	t	56	56	112	1	\N	\N	2018-07-05 07:52:56.311554
58	t	57	57	114	2	\N	\N	2018-07-05 07:52:56.311554
59	t	58	58	116	1	\N	\N	2018-07-05 07:52:56.311554
60	t	59	59	118	2	\N	\N	2018-07-05 07:52:56.311554
61	t	60	60	120	1	\N	\N	2018-07-05 07:52:56.311554
62	t	61	61	122	2	\N	\N	2018-07-05 07:52:56.311554
63	t	62	62	124	1	\N	\N	2018-07-05 07:52:56.311554
64	t	63	63	126	2	\N	\N	2018-07-05 07:52:56.311554
65	t	64	64	128	1	\N	\N	2018-07-05 07:52:56.311554
66	t	65	65	130	2	\N	\N	2018-07-05 07:52:56.311554
67	t	66	66	132	1	\N	\N	2018-07-05 07:52:56.311554
68	t	67	67	134	2	\N	\N	2018-07-05 07:52:56.311554
69	t	68	68	136	1	\N	\N	2018-07-05 07:52:56.311554
70	t	69	69	138	2	\N	\N	2018-07-05 07:52:56.311554
71	t	70	70	140	1	\N	\N	2018-07-05 07:52:56.311554
72	t	71	71	142	2	\N	\N	2018-07-05 07:52:56.311554
73	t	72	72	144	1	\N	\N	2018-07-05 07:52:56.311554
74	t	73	73	146	2	\N	\N	2018-07-05 07:52:56.311554
75	t	74	74	148	1	\N	\N	2018-07-05 07:52:56.311554
76	t	75	75	150	2	\N	\N	2018-07-05 07:52:56.311554
77	t	76	76	152	1	\N	\N	2018-07-05 07:52:56.311554
78	t	77	77	154	2	\N	\N	2018-07-05 07:52:56.311554
79	t	78	78	156	1	\N	\N	2018-07-05 07:52:56.311554
80	t	79	79	158	2	\N	\N	2018-07-05 07:52:56.311554
81	t	80	80	160	1	\N	\N	2018-07-05 07:52:56.311554
82	t	81	81	162	2	\N	\N	2018-07-05 07:52:56.311554
83	t	82	82	164	1	\N	\N	2018-07-05 07:52:56.311554
84	t	83	83	166	2	\N	\N	2018-07-05 07:52:56.311554
85	t	84	84	168	1	\N	\N	2018-07-05 07:52:56.311554
86	t	85	85	170	2	\N	\N	2018-07-05 07:52:56.311554
87	t	86	86	172	1	\N	\N	2018-07-05 07:52:56.311554
88	t	87	87	174	2	\N	\N	2018-07-05 07:52:56.311554
89	t	88	88	176	1	\N	\N	2018-07-05 07:52:56.311554
90	t	89	89	178	2	\N	\N	2018-07-05 07:52:56.311554
91	t	90	90	180	1	\N	\N	2018-07-05 07:52:56.311554
92	t	91	91	182	2	\N	\N	2018-07-05 07:52:56.311554
93	t	92	92	184	1	\N	\N	2018-07-05 07:52:56.311554
94	t	93	93	186	2	\N	\N	2018-07-05 07:52:56.311554
95	t	94	94	188	1	\N	\N	2018-07-05 07:52:56.311554
96	t	95	95	190	2	\N	\N	2018-07-05 07:52:56.311554
97	t	96	96	192	1	\N	\N	2018-07-05 07:52:56.311554
98	t	97	97	194	2	\N	\N	2018-07-05 07:52:56.311554
99	t	98	98	196	1	\N	\N	2018-07-05 07:52:56.311554
100	t	99	99	198	2	\N	\N	2018-07-05 07:52:56.311554
101	t	100	100	200	1	\N	\N	2018-07-05 07:52:56.311554
102	t	101	101	202	2	\N	\N	2018-07-05 07:52:56.311554
103	t	102	102	204	1	\N	\N	2018-07-05 07:52:56.311554
104	t	103	103	206	2	\N	\N	2018-07-05 07:52:56.311554
105	t	104	104	208	1	\N	\N	2018-07-05 07:52:56.311554
106	t	105	105	210	2	\N	\N	2018-07-05 07:52:56.311554
107	t	106	106	212	1	\N	\N	2018-07-05 07:52:56.311554
108	t	107	107	214	2	\N	\N	2018-07-05 07:52:56.311554
109	t	108	108	216	1	\N	\N	2018-07-05 07:52:56.311554
110	t	109	109	218	2	\N	\N	2018-07-05 07:52:56.311554
111	t	110	110	220	1	\N	\N	2018-07-05 07:52:56.311554
112	t	111	111	222	2	\N	\N	2018-07-05 07:52:56.311554
113	t	112	112	224	1	\N	\N	2018-07-05 07:52:56.311554
114	t	113	113	226	2	\N	\N	2018-07-05 07:52:56.311554
115	t	114	114	228	1	\N	\N	2018-07-05 07:52:56.311554
116	t	115	115	230	2	\N	\N	2018-07-05 07:52:56.311554
117	t	116	116	232	1	\N	\N	2018-07-05 07:52:56.311554
118	t	117	117	234	2	\N	\N	2018-07-05 07:52:56.311554
119	t	118	118	236	1	\N	\N	2018-07-05 07:52:56.311554
120	t	119	119	238	2	\N	\N	2018-07-05 07:52:56.311554
121	t	120	120	240	1	\N	\N	2018-07-05 07:52:56.311554
122	t	121	121	242	2	\N	\N	2018-07-05 07:52:56.311554
123	t	122	122	244	1	\N	\N	2018-07-05 07:52:56.311554
124	t	123	123	246	2	\N	\N	2018-07-05 07:52:56.311554
125	t	124	124	248	1	\N	\N	2018-07-05 07:52:56.311554
126	t	125	125	250	2	\N	\N	2018-07-05 07:52:56.311554
127	t	126	126	252	1	\N	\N	2018-07-05 07:52:56.311554
128	t	127	127	254	2	\N	\N	2018-07-05 07:52:56.311554
129	t	128	128	256	1	\N	\N	2018-07-05 07:52:56.311554
130	t	129	129	258	2	\N	\N	2018-07-05 07:52:56.311554
131	t	130	130	260	1	\N	\N	2018-07-05 07:52:56.311554
132	t	131	131	262	2	\N	\N	2018-07-05 07:52:56.311554
133	t	132	132	264	1	\N	\N	2018-07-05 07:52:56.311554
134	t	133	133	266	2	\N	\N	2018-07-05 07:52:56.311554
135	t	134	134	268	1	\N	\N	2018-07-05 07:52:56.311554
136	t	135	135	270	2	\N	\N	2018-07-05 07:52:56.311554
137	t	136	136	272	1	\N	\N	2018-07-05 07:52:56.311554
138	t	137	137	274	2	\N	\N	2018-07-05 07:52:56.311554
139	t	138	138	276	1	\N	\N	2018-07-05 07:52:56.311554
140	t	139	139	278	2	\N	\N	2018-07-05 07:52:56.311554
141	t	140	140	280	1	\N	\N	2018-07-05 07:52:56.311554
142	t	141	141	282	2	\N	\N	2018-07-05 07:52:56.311554
143	t	142	142	284	1	\N	\N	2018-07-05 07:52:56.311554
144	t	143	143	286	2	\N	\N	2018-07-05 07:52:56.311554
145	t	144	144	288	1	\N	\N	2018-07-05 07:52:56.311554
146	t	145	145	290	2	\N	\N	2018-07-05 07:52:56.311554
147	t	146	146	292	1	\N	\N	2018-07-05 07:52:56.311554
148	t	147	147	294	2	\N	\N	2018-07-05 07:52:56.311554
149	t	148	148	296	1	\N	\N	2018-07-05 07:52:56.311554
150	t	149	149	298	2	\N	\N	2018-07-05 07:52:56.311554
151	t	150	150	300	1	\N	\N	2018-07-05 07:52:56.311554
152	t	151	151	302	2	\N	\N	2018-07-05 07:52:56.311554
153	t	152	152	304	1	\N	\N	2018-07-05 07:52:56.311554
154	t	153	153	306	2	\N	\N	2018-07-05 07:52:56.311554
155	t	154	154	308	1	\N	\N	2018-07-05 07:52:56.311554
156	t	155	155	310	2	\N	\N	2018-07-05 07:52:56.311554
157	t	156	156	312	1	\N	\N	2018-07-05 07:52:56.311554
158	t	157	157	314	2	\N	\N	2018-07-05 07:52:56.311554
159	t	158	158	316	1	\N	\N	2018-07-05 07:52:56.311554
160	t	159	159	318	2	\N	\N	2018-07-05 07:52:56.311554
161	t	160	160	320	1	\N	\N	2018-07-05 07:52:56.311554
162	t	161	161	322	2	\N	\N	2018-07-05 07:52:56.311554
163	t	162	162	324	1	\N	\N	2018-07-05 07:52:56.311554
164	t	163	163	326	2	\N	\N	2018-07-05 07:52:56.311554
165	t	164	164	328	1	\N	\N	2018-07-05 07:52:56.311554
166	t	165	165	330	2	\N	\N	2018-07-05 07:52:56.311554
167	t	166	166	332	1	\N	\N	2018-07-05 07:52:56.311554
168	t	167	167	334	2	\N	\N	2018-07-05 07:52:56.311554
169	t	168	168	336	1	\N	\N	2018-07-05 07:52:56.311554
170	t	169	169	338	2	\N	\N	2018-07-05 07:52:56.311554
171	t	170	170	340	1	\N	\N	2018-07-05 07:52:56.311554
172	t	171	171	342	2	\N	\N	2018-07-05 07:52:56.311554
173	t	172	172	344	1	\N	\N	2018-07-05 07:52:56.311554
174	t	173	173	346	2	\N	\N	2018-07-05 07:52:56.311554
175	t	174	174	348	1	\N	\N	2018-07-05 07:52:56.311554
176	t	175	175	350	2	\N	\N	2018-07-05 07:52:56.311554
177	t	176	176	352	1	\N	\N	2018-07-05 07:52:56.311554
178	t	177	177	354	2	\N	\N	2018-07-05 07:52:56.311554
179	t	178	178	356	1	\N	\N	2018-07-05 07:52:56.311554
180	t	179	179	358	2	\N	\N	2018-07-05 07:52:56.311554
181	t	180	180	360	1	\N	\N	2018-07-05 07:52:56.311554
182	t	181	181	362	2	\N	\N	2018-07-05 07:52:56.311554
183	t	182	182	364	1	\N	\N	2018-07-05 07:52:56.311554
184	t	183	183	366	2	\N	\N	2018-07-05 07:52:56.311554
185	t	184	184	368	1	\N	\N	2018-07-05 07:52:56.311554
186	t	185	185	370	2	\N	\N	2018-07-05 07:52:56.311554
187	t	186	186	372	1	\N	\N	2018-07-05 07:52:56.311554
188	t	187	187	374	2	\N	\N	2018-07-05 07:52:56.311554
189	t	188	188	376	1	\N	\N	2018-07-05 07:52:56.311554
190	t	189	189	378	2	\N	\N	2018-07-05 07:52:56.311554
191	t	190	190	380	1	\N	\N	2018-07-05 07:52:56.311554
192	t	191	191	382	2	\N	\N	2018-07-05 07:52:56.311554
193	t	192	192	384	1	\N	\N	2018-07-05 07:52:56.311554
194	t	193	193	386	2	\N	\N	2018-07-05 07:52:56.311554
195	t	194	194	388	1	\N	\N	2018-07-05 07:52:56.311554
196	t	195	195	390	2	\N	\N	2018-07-05 07:52:56.311554
197	t	196	196	392	1	\N	\N	2018-07-05 07:52:56.311554
198	t	197	197	394	2	\N	\N	2018-07-05 07:52:56.311554
199	t	198	198	396	1	\N	\N	2018-07-05 07:52:56.311554
200	t	199	199	398	2	\N	\N	2018-07-05 07:52:56.311554
201	t	200	200	400	1	\N	\N	2018-07-05 07:52:56.311554
202	t	201	201	402	2	\N	\N	2018-07-05 07:52:56.311554
203	t	202	202	404	1	\N	\N	2018-07-05 07:52:56.311554
204	t	203	203	406	2	\N	\N	2018-07-05 07:52:56.311554
205	t	204	204	408	1	\N	\N	2018-07-05 07:52:56.311554
206	t	205	205	410	2	\N	\N	2018-07-05 07:52:56.311554
207	t	206	206	412	1	\N	\N	2018-07-05 07:52:56.311554
208	t	207	207	414	2	\N	\N	2018-07-05 07:52:56.311554
209	t	208	208	416	1	\N	\N	2018-07-05 07:52:56.311554
210	t	209	209	418	2	\N	\N	2018-07-05 07:52:56.311554
211	t	210	210	420	1	\N	\N	2018-07-05 07:52:56.311554
212	t	211	211	422	2	\N	\N	2018-07-05 07:52:56.311554
213	t	212	212	424	1	\N	\N	2018-07-05 07:52:56.311554
214	t	213	213	426	2	\N	\N	2018-07-05 07:52:56.311554
215	t	214	214	428	1	\N	\N	2018-07-05 07:52:56.311554
216	t	215	215	430	2	\N	\N	2018-07-05 07:52:56.311554
217	t	216	216	432	1	\N	\N	2018-07-05 07:52:56.311554
218	t	217	217	434	2	\N	\N	2018-07-05 07:52:56.311554
219	t	218	218	436	1	\N	\N	2018-07-05 07:52:56.311554
220	t	219	219	438	2	\N	\N	2018-07-05 07:52:56.311554
221	t	220	220	440	1	\N	\N	2018-07-05 07:52:56.311554
222	t	221	221	442	2	\N	\N	2018-07-05 07:52:56.311554
223	t	222	222	444	1	\N	\N	2018-07-05 07:52:56.311554
224	t	223	223	446	2	\N	\N	2018-07-05 07:52:56.311554
225	t	224	224	448	1	\N	\N	2018-07-05 07:52:56.311554
226	t	225	225	450	2	\N	\N	2018-07-05 07:52:56.311554
227	t	226	226	452	1	\N	\N	2018-07-05 07:52:56.311554
228	t	227	227	454	2	\N	\N	2018-07-05 07:52:56.311554
229	t	228	228	456	1	\N	\N	2018-07-05 07:52:56.311554
230	t	229	229	458	2	\N	\N	2018-07-05 07:52:56.311554
231	t	230	230	460	1	\N	\N	2018-07-05 07:52:56.311554
232	t	231	231	462	2	\N	\N	2018-07-05 07:52:56.311554
233	t	232	232	464	1	\N	\N	2018-07-05 07:52:56.311554
234	t	233	233	466	2	\N	\N	2018-07-05 07:52:56.311554
235	t	234	234	468	1	\N	\N	2018-07-05 07:52:56.311554
236	t	235	235	470	2	\N	\N	2018-07-05 07:52:56.311554
237	t	236	236	472	1	\N	\N	2018-07-05 07:52:56.311554
238	t	237	237	474	2	\N	\N	2018-07-05 07:52:56.311554
239	t	238	238	476	1	\N	\N	2018-07-05 07:52:56.311554
240	t	239	239	478	2	\N	\N	2018-07-05 07:52:56.311554
241	t	240	240	480	1	\N	\N	2018-07-05 07:52:56.311554
242	t	241	241	482	2	\N	\N	2018-07-05 07:52:56.311554
243	t	242	242	484	1	\N	\N	2018-07-05 07:52:56.311554
244	t	243	243	486	2	\N	\N	2018-07-05 07:52:56.311554
245	t	244	244	488	1	\N	\N	2018-07-05 07:52:56.311554
246	t	245	245	490	2	\N	\N	2018-07-05 07:52:56.311554
247	t	246	246	492	1	\N	\N	2018-07-05 07:52:56.311554
248	t	247	247	494	2	\N	\N	2018-07-05 07:52:56.311554
249	t	248	248	496	1	\N	\N	2018-07-05 07:52:56.311554
250	t	249	249	498	2	\N	\N	2018-07-05 07:52:56.311554
251	t	250	250	500	1	\N	\N	2018-07-05 07:52:56.311554
252	t	251	251	502	2	\N	\N	2018-07-05 07:52:56.311554
253	t	252	252	504	1	\N	\N	2018-07-05 07:52:56.311554
254	t	253	253	506	2	\N	\N	2018-07-05 07:52:56.311554
255	t	254	254	508	1	\N	\N	2018-07-05 07:52:56.311554
256	t	255	255	510	2	\N	\N	2018-07-05 07:52:56.311554
257	t	256	256	512	1	\N	\N	2018-07-05 07:52:56.311554
258	t	257	257	514	2	\N	\N	2018-07-05 07:52:56.311554
259	t	258	258	516	1	\N	\N	2018-07-05 07:52:56.311554
260	t	259	259	518	2	\N	\N	2018-07-05 07:52:56.311554
261	t	260	260	520	1	\N	\N	2018-07-05 07:52:56.311554
262	t	261	261	522	2	\N	\N	2018-07-05 07:52:56.311554
263	t	262	262	524	1	\N	\N	2018-07-05 07:52:56.311554
264	t	263	263	526	2	\N	\N	2018-07-05 07:52:56.311554
265	t	264	264	528	1	\N	\N	2018-07-05 07:52:56.311554
266	t	265	265	530	2	\N	\N	2018-07-05 07:52:56.311554
267	t	266	266	532	1	\N	\N	2018-07-05 07:52:56.311554
268	t	267	267	534	2	\N	\N	2018-07-05 07:52:56.311554
269	t	268	268	536	1	\N	\N	2018-07-05 07:52:56.311554
270	t	269	269	538	2	\N	\N	2018-07-05 07:52:56.311554
271	t	270	270	540	1	\N	\N	2018-07-05 07:52:56.311554
272	t	271	271	542	2	\N	\N	2018-07-05 07:52:56.311554
273	t	272	272	544	1	\N	\N	2018-07-05 07:52:56.311554
274	t	273	273	546	2	\N	\N	2018-07-05 07:52:56.311554
275	t	274	274	548	1	\N	\N	2018-07-05 07:52:56.311554
276	t	275	275	550	2	\N	\N	2018-07-05 07:52:56.311554
277	t	276	276	552	1	\N	\N	2018-07-05 07:52:56.311554
278	t	277	277	554	2	\N	\N	2018-07-05 07:52:56.311554
279	t	278	278	556	1	\N	\N	2018-07-05 07:52:56.311554
280	t	279	279	558	2	\N	\N	2018-07-05 07:52:56.311554
281	t	280	280	560	1	\N	\N	2018-07-05 07:52:56.311554
282	t	281	281	562	2	\N	\N	2018-07-05 07:52:56.311554
283	t	282	282	564	1	\N	\N	2018-07-05 07:52:56.311554
284	t	283	283	566	2	\N	\N	2018-07-05 07:52:56.311554
285	t	284	284	568	1	\N	\N	2018-07-05 07:52:56.311554
286	t	285	285	570	2	\N	\N	2018-07-05 07:52:56.311554
287	t	286	286	572	1	\N	\N	2018-07-05 07:52:56.311554
288	t	287	287	574	2	\N	\N	2018-07-05 07:52:56.311554
289	t	288	288	576	1	\N	\N	2018-07-05 07:52:56.311554
290	t	289	289	578	2	\N	\N	2018-07-05 07:52:56.311554
291	t	290	290	580	1	\N	\N	2018-07-05 07:52:56.311554
292	t	291	291	582	2	\N	\N	2018-07-05 07:52:56.311554
293	t	292	292	584	1	\N	\N	2018-07-05 07:52:56.311554
294	t	293	293	586	2	\N	\N	2018-07-05 07:52:56.311554
295	t	294	294	588	1	\N	\N	2018-07-05 07:52:56.311554
296	t	295	295	590	2	\N	\N	2018-07-05 07:52:56.311554
297	t	296	296	592	1	\N	\N	2018-07-05 07:52:56.311554
298	t	297	297	594	2	\N	\N	2018-07-05 07:52:56.311554
299	t	298	298	596	1	\N	\N	2018-07-05 07:52:56.311554
300	t	299	299	598	2	\N	\N	2018-07-05 07:52:56.311554
301	t	300	300	600	1	\N	\N	2018-07-05 07:52:56.311554
302	t	301	301	602	2	\N	\N	2018-07-05 07:52:56.311554
303	t	302	302	604	1	\N	\N	2018-07-05 07:52:56.311554
304	t	303	303	606	2	\N	\N	2018-07-05 07:52:56.311554
305	t	304	304	608	1	\N	\N	2018-07-05 07:52:56.311554
306	t	305	305	610	2	\N	\N	2018-07-05 07:52:56.311554
307	t	306	306	612	1	\N	\N	2018-07-05 07:52:56.311554
308	t	307	307	614	2	\N	\N	2018-07-05 07:52:56.311554
309	t	308	308	616	1	\N	\N	2018-07-05 07:52:56.311554
310	t	309	309	618	2	\N	\N	2018-07-05 07:52:56.311554
311	t	310	310	620	1	\N	\N	2018-07-05 07:52:56.311554
312	t	311	311	622	2	\N	\N	2018-07-05 07:52:56.311554
313	t	312	312	624	1	\N	\N	2018-07-05 07:52:56.311554
314	t	313	313	626	2	\N	\N	2018-07-05 07:52:56.311554
315	t	314	314	628	1	\N	\N	2018-07-05 07:52:56.311554
316	t	315	315	630	2	\N	\N	2018-07-05 07:52:56.311554
317	t	316	316	632	1	\N	\N	2018-07-05 07:52:56.311554
318	t	317	317	634	2	\N	\N	2018-07-05 07:52:56.311554
319	t	318	318	636	1	\N	\N	2018-07-05 07:52:56.311554
320	t	319	319	638	2	\N	\N	2018-07-05 07:52:56.311554
321	t	320	320	640	1	\N	\N	2018-07-05 07:52:56.311554
322	t	321	321	642	2	\N	\N	2018-07-05 07:52:56.311554
323	t	322	322	644	1	\N	\N	2018-07-05 07:52:56.311554
324	t	323	323	646	2	\N	\N	2018-07-05 07:52:56.311554
325	t	324	324	648	1	\N	\N	2018-07-05 07:52:56.311554
326	t	325	325	650	2	\N	\N	2018-07-05 07:52:56.311554
327	t	326	326	652	1	\N	\N	2018-07-05 07:52:56.311554
328	t	327	327	654	2	\N	\N	2018-07-05 07:52:56.311554
329	t	328	328	656	1	\N	\N	2018-07-05 07:52:56.311554
330	t	329	329	658	2	\N	\N	2018-07-05 07:52:56.311554
331	t	330	330	660	1	\N	\N	2018-07-05 07:52:56.311554
332	t	331	331	662	2	\N	\N	2018-07-05 07:52:56.311554
333	t	332	332	664	1	\N	\N	2018-07-05 07:52:56.311554
334	t	333	333	666	2	\N	\N	2018-07-05 07:52:56.311554
335	t	334	334	668	1	\N	\N	2018-07-05 07:52:56.311554
336	t	335	335	670	2	\N	\N	2018-07-05 07:52:56.311554
337	t	336	336	672	1	\N	\N	2018-07-05 07:52:56.311554
338	t	337	337	674	2	\N	\N	2018-07-05 07:52:56.311554
339	t	338	338	676	1	\N	\N	2018-07-05 07:52:56.311554
340	t	339	339	678	2	\N	\N	2018-07-05 07:52:56.311554
341	t	340	340	680	1	\N	\N	2018-07-05 07:52:56.311554
342	t	341	341	682	2	\N	\N	2018-07-05 07:52:56.311554
343	t	342	342	684	1	\N	\N	2018-07-05 07:52:56.311554
344	t	343	343	686	2	\N	\N	2018-07-05 07:52:56.311554
345	t	344	344	688	1	\N	\N	2018-07-05 07:52:56.311554
346	t	345	345	690	2	\N	\N	2018-07-05 07:52:56.311554
347	t	346	346	692	1	\N	\N	2018-07-05 07:52:56.311554
348	t	347	347	694	2	\N	\N	2018-07-05 07:52:56.311554
349	t	348	348	696	1	\N	\N	2018-07-05 07:52:56.311554
350	t	349	349	698	2	\N	\N	2018-07-05 07:52:56.311554
351	t	350	350	700	1	\N	\N	2018-07-05 07:52:56.311554
352	t	351	351	702	2	\N	\N	2018-07-05 07:52:56.311554
353	t	352	352	704	1	\N	\N	2018-07-05 07:52:56.311554
354	t	353	353	706	2	\N	\N	2018-07-05 07:52:56.311554
355	t	354	354	708	1	\N	\N	2018-07-05 07:52:56.311554
356	t	355	355	710	2	\N	\N	2018-07-05 07:52:56.311554
357	t	356	356	712	1	\N	\N	2018-07-05 07:52:56.311554
358	t	357	357	714	2	\N	\N	2018-07-05 07:52:56.311554
359	t	358	358	716	1	\N	\N	2018-07-05 07:52:56.311554
360	t	359	359	718	2	\N	\N	2018-07-05 07:52:56.311554
361	t	360	360	720	1	\N	\N	2018-07-05 07:52:56.311554
362	t	361	361	722	2	\N	\N	2018-07-05 07:52:56.311554
363	t	362	362	724	1	\N	\N	2018-07-05 07:52:56.311554
364	t	363	363	726	2	\N	\N	2018-07-05 07:52:56.311554
365	t	364	364	728	1	\N	\N	2018-07-05 07:52:56.311554
366	t	365	365	730	2	\N	\N	2018-07-05 07:52:56.311554
367	t	366	366	732	1	\N	\N	2018-07-05 07:52:56.311554
368	t	367	367	734	2	\N	\N	2018-07-05 07:52:56.311554
369	t	368	368	736	1	\N	\N	2018-07-05 07:52:56.311554
370	t	369	369	738	2	\N	\N	2018-07-05 07:52:56.311554
371	t	370	370	740	1	\N	\N	2018-07-05 07:52:56.311554
372	t	371	371	742	2	\N	\N	2018-07-05 07:52:56.311554
373	t	372	372	744	1	\N	\N	2018-07-05 07:52:56.311554
374	t	373	373	746	2	\N	\N	2018-07-05 07:52:56.311554
375	t	374	374	748	1	\N	\N	2018-07-05 07:52:56.311554
376	t	375	375	750	2	\N	\N	2018-07-05 07:52:56.311554
377	t	376	376	752	1	\N	\N	2018-07-05 07:52:56.311554
378	t	377	377	754	2	\N	\N	2018-07-05 07:52:56.311554
379	t	378	378	756	1	\N	\N	2018-07-05 07:52:56.311554
380	t	379	379	758	2	\N	\N	2018-07-05 07:52:56.311554
381	t	380	380	760	1	\N	\N	2018-07-05 07:52:56.311554
382	t	381	381	762	2	\N	\N	2018-07-05 07:52:56.311554
383	t	382	382	764	1	\N	\N	2018-07-05 07:52:56.311554
384	t	383	383	766	2	\N	\N	2018-07-05 07:52:56.311554
385	t	384	384	768	1	\N	\N	2018-07-05 07:52:56.311554
386	t	385	385	770	2	\N	\N	2018-07-05 07:52:56.311554
387	t	386	386	772	1	\N	\N	2018-07-05 07:52:56.311554
388	t	387	387	774	2	\N	\N	2018-07-05 07:52:56.311554
389	t	388	388	776	1	\N	\N	2018-07-05 07:52:56.311554
390	t	389	389	778	2	\N	\N	2018-07-05 07:52:56.311554
391	t	390	390	780	1	\N	\N	2018-07-05 07:52:56.311554
392	t	391	391	782	2	\N	\N	2018-07-05 07:52:56.311554
393	t	392	392	784	1	\N	\N	2018-07-05 07:52:56.311554
394	t	393	393	786	2	\N	\N	2018-07-05 07:52:56.311554
395	t	394	394	788	1	\N	\N	2018-07-05 07:52:56.311554
396	t	395	395	790	2	\N	\N	2018-07-05 07:52:56.311554
397	t	396	396	792	1	\N	\N	2018-07-05 07:52:56.311554
398	t	397	397	794	2	\N	\N	2018-07-05 07:52:56.311554
399	t	398	398	796	1	\N	\N	2018-07-05 07:52:56.311554
400	t	399	399	798	2	\N	\N	2018-07-05 07:52:56.311554
401	t	400	400	800	1	\N	\N	2018-07-05 07:52:56.311554
402	t	401	401	802	2	\N	\N	2018-07-05 07:52:56.311554
403	t	402	402	804	1	\N	\N	2018-07-05 07:52:56.311554
404	t	403	403	806	2	\N	\N	2018-07-05 07:52:56.311554
405	t	404	404	808	1	\N	\N	2018-07-05 07:52:56.311554
406	t	405	405	810	2	\N	\N	2018-07-05 07:52:56.311554
407	t	406	406	812	1	\N	\N	2018-07-05 07:52:56.311554
408	t	407	407	814	2	\N	\N	2018-07-05 07:52:56.311554
409	t	408	408	816	1	\N	\N	2018-07-05 07:52:56.311554
410	t	409	409	818	2	\N	\N	2018-07-05 07:52:56.311554
411	t	410	410	820	1	\N	\N	2018-07-05 07:52:56.311554
412	t	411	411	822	2	\N	\N	2018-07-05 07:52:56.311554
413	t	412	412	824	1	\N	\N	2018-07-05 07:52:56.311554
414	t	413	413	826	2	\N	\N	2018-07-05 07:52:56.311554
415	t	414	414	828	1	\N	\N	2018-07-05 07:52:56.311554
416	t	415	415	830	2	\N	\N	2018-07-05 07:52:56.311554
417	t	416	416	832	1	\N	\N	2018-07-05 07:52:56.311554
418	t	417	417	834	2	\N	\N	2018-07-05 07:52:56.311554
419	t	418	418	836	1	\N	\N	2018-07-05 07:52:56.311554
420	t	419	419	838	2	\N	\N	2018-07-05 07:52:56.311554
421	t	420	420	840	1	\N	\N	2018-07-05 07:52:56.311554
422	t	421	421	842	2	\N	\N	2018-07-05 07:52:56.311554
423	t	422	422	844	1	\N	\N	2018-07-05 07:52:56.311554
424	t	423	423	846	2	\N	\N	2018-07-05 07:52:56.311554
425	t	424	424	848	1	\N	\N	2018-07-05 07:52:56.311554
426	t	425	425	850	2	\N	\N	2018-07-05 07:52:56.311554
427	t	426	426	852	1	\N	\N	2018-07-05 07:52:56.311554
428	t	427	427	854	2	\N	\N	2018-07-05 07:52:56.311554
429	t	428	428	856	1	\N	\N	2018-07-05 07:52:56.311554
430	t	429	429	858	2	\N	\N	2018-07-05 07:52:56.311554
431	t	430	430	860	1	\N	\N	2018-07-05 07:52:56.311554
432	t	431	431	862	2	\N	\N	2018-07-05 07:52:56.311554
433	t	432	432	864	1	\N	\N	2018-07-05 07:52:56.311554
434	t	433	433	866	2	\N	\N	2018-07-05 07:52:56.311554
435	t	434	434	868	1	\N	\N	2018-07-05 07:52:56.311554
436	t	435	435	870	2	\N	\N	2018-07-05 07:52:56.311554
437	t	436	436	872	1	\N	\N	2018-07-05 07:52:56.311554
438	t	437	437	874	2	\N	\N	2018-07-05 07:52:56.311554
439	t	438	438	876	1	\N	\N	2018-07-05 07:52:56.311554
440	t	439	439	878	2	\N	\N	2018-07-05 07:52:56.311554
441	t	440	440	880	1	\N	\N	2018-07-05 07:52:56.311554
442	t	441	441	882	2	\N	\N	2018-07-05 07:52:56.311554
443	t	442	442	884	1	\N	\N	2018-07-05 07:52:56.311554
444	t	443	443	886	2	\N	\N	2018-07-05 07:52:56.311554
445	t	444	444	888	1	\N	\N	2018-07-05 07:52:56.311554
446	t	445	445	890	2	\N	\N	2018-07-05 07:52:56.311554
447	t	446	446	892	1	\N	\N	2018-07-05 07:52:56.311554
448	t	447	447	894	2	\N	\N	2018-07-05 07:52:56.311554
449	t	448	448	896	1	\N	\N	2018-07-05 07:52:56.311554
450	t	449	449	898	2	\N	\N	2018-07-05 07:52:56.311554
451	t	450	450	900	1	\N	\N	2018-07-05 07:52:56.311554
452	t	451	451	902	2	\N	\N	2018-07-05 07:52:56.311554
453	t	452	452	904	1	\N	\N	2018-07-05 07:52:56.311554
454	t	453	453	906	2	\N	\N	2018-07-05 07:52:56.311554
455	t	454	454	908	1	\N	\N	2018-07-05 07:52:56.311554
456	t	455	455	910	2	\N	\N	2018-07-05 07:52:56.311554
457	t	456	456	912	1	\N	\N	2018-07-05 07:52:56.311554
458	t	457	457	914	2	\N	\N	2018-07-05 07:52:56.311554
459	t	458	458	916	1	\N	\N	2018-07-05 07:52:56.311554
460	t	459	459	918	2	\N	\N	2018-07-05 07:52:56.311554
461	t	460	460	920	1	\N	\N	2018-07-05 07:52:56.311554
462	t	461	461	922	2	\N	\N	2018-07-05 07:52:56.311554
463	t	462	462	924	1	\N	\N	2018-07-05 07:52:56.311554
464	t	463	463	926	2	\N	\N	2018-07-05 07:52:56.311554
465	t	464	464	928	1	\N	\N	2018-07-05 07:52:56.311554
466	t	465	465	930	2	\N	\N	2018-07-05 07:52:56.311554
467	t	466	466	932	1	\N	\N	2018-07-05 07:52:56.311554
468	t	467	467	934	2	\N	\N	2018-07-05 07:52:56.311554
469	t	468	468	936	1	\N	\N	2018-07-05 07:52:56.311554
470	t	469	469	938	2	\N	\N	2018-07-05 07:52:56.311554
471	t	470	470	940	1	\N	\N	2018-07-05 07:52:56.311554
472	t	471	471	942	2	\N	\N	2018-07-05 07:52:56.311554
473	t	472	472	944	1	\N	\N	2018-07-05 07:52:56.311554
474	t	473	473	946	2	\N	\N	2018-07-05 07:52:56.311554
475	t	474	474	948	1	\N	\N	2018-07-05 07:52:56.311554
476	t	475	475	950	2	\N	\N	2018-07-05 07:52:56.311554
477	t	476	476	952	1	\N	\N	2018-07-05 07:52:56.311554
478	t	477	477	954	2	\N	\N	2018-07-05 07:52:56.311554
479	t	478	478	956	1	\N	\N	2018-07-05 07:52:56.311554
480	t	479	479	958	2	\N	\N	2018-07-05 07:52:56.311554
481	t	480	480	960	1	\N	\N	2018-07-05 07:52:56.311554
482	t	481	481	962	2	\N	\N	2018-07-05 07:52:56.311554
483	t	482	482	964	1	\N	\N	2018-07-05 07:52:56.311554
484	t	483	483	966	2	\N	\N	2018-07-05 07:52:56.311554
485	t	484	484	968	1	\N	\N	2018-07-05 07:52:56.311554
486	t	485	485	970	2	\N	\N	2018-07-05 07:52:56.311554
487	t	486	486	972	1	\N	\N	2018-07-05 07:52:56.311554
488	t	487	487	974	2	\N	\N	2018-07-05 07:52:56.311554
489	t	488	488	976	1	\N	\N	2018-07-05 07:52:56.311554
490	t	489	489	978	2	\N	\N	2018-07-05 07:52:56.311554
491	t	490	490	980	1	\N	\N	2018-07-05 07:52:56.311554
492	t	491	491	982	2	\N	\N	2018-07-05 07:52:56.311554
493	t	492	492	984	1	\N	\N	2018-07-05 07:52:56.311554
494	t	493	493	986	2	\N	\N	2018-07-05 07:52:56.311554
495	t	494	494	988	1	\N	\N	2018-07-05 07:52:56.311554
496	t	495	495	990	2	\N	\N	2018-07-05 07:52:56.311554
497	t	496	496	992	1	\N	\N	2018-07-05 07:52:56.311554
498	t	497	497	994	2	\N	\N	2018-07-05 07:52:56.311554
499	t	498	498	996	1	\N	\N	2018-07-05 07:52:56.311554
500	t	499	499	998	2	\N	\N	2018-07-05 07:52:56.311554
501	t	500	500	1000	1	\N	\N	2018-07-05 07:52:56.311554
502	t	501	501	1002	2	\N	\N	2018-07-05 07:52:56.311554
503	t	502	502	1004	1	\N	\N	2018-07-05 07:52:56.311554
504	t	503	503	1006	2	\N	\N	2018-07-05 07:52:56.311554
505	t	504	504	1008	1	\N	\N	2018-07-05 07:52:56.311554
506	t	505	505	1010	2	\N	\N	2018-07-05 07:52:56.311554
507	t	506	506	1012	1	\N	\N	2018-07-05 07:52:56.311554
508	t	507	507	1014	2	\N	\N	2018-07-05 07:52:56.311554
509	t	508	508	1016	1	\N	\N	2018-07-05 07:52:56.311554
510	t	509	509	1018	2	\N	\N	2018-07-05 07:52:56.311554
511	t	510	510	1020	1	\N	\N	2018-07-05 07:52:56.311554
512	t	511	511	1022	2	\N	\N	2018-07-05 07:52:56.311554
513	t	512	512	1024	1	\N	\N	2018-07-05 07:52:56.311554
514	t	513	513	1026	2	\N	\N	2018-07-05 07:52:56.311554
515	t	514	514	1028	1	\N	\N	2018-07-05 07:52:56.311554
516	t	515	515	1030	2	\N	\N	2018-07-05 07:52:56.311554
517	t	516	516	1032	1	\N	\N	2018-07-05 07:52:56.311554
518	t	517	517	1034	2	\N	\N	2018-07-05 07:52:56.311554
519	t	518	518	1036	1	\N	\N	2018-07-05 07:52:56.311554
520	t	519	519	1038	2	\N	\N	2018-07-05 07:52:56.311554
521	t	520	520	1040	1	\N	\N	2018-07-05 07:52:56.311554
522	t	521	521	1042	2	\N	\N	2018-07-05 07:52:56.311554
523	t	522	522	1044	1	\N	\N	2018-07-05 07:52:56.311554
524	t	523	523	1046	2	\N	\N	2018-07-05 07:52:56.311554
525	t	524	524	1048	1	\N	\N	2018-07-05 07:52:56.311554
526	t	525	525	1050	2	\N	\N	2018-07-05 07:52:56.311554
527	t	526	526	1052	1	\N	\N	2018-07-05 07:52:56.311554
528	t	527	527	1054	2	\N	\N	2018-07-05 07:52:56.311554
529	t	528	528	1056	1	\N	\N	2018-07-05 07:52:56.311554
530	t	529	529	1058	2	\N	\N	2018-07-05 07:52:56.311554
531	t	530	530	1060	1	\N	\N	2018-07-05 07:52:56.311554
532	t	531	531	1062	2	\N	\N	2018-07-05 07:52:56.311554
533	t	532	532	1064	1	\N	\N	2018-07-05 07:52:56.311554
534	t	533	533	1066	2	\N	\N	2018-07-05 07:52:56.311554
535	t	534	534	1068	1	\N	\N	2018-07-05 07:52:56.311554
536	t	535	535	1070	2	\N	\N	2018-07-05 07:52:56.311554
537	t	536	536	1072	1	\N	\N	2018-07-05 07:52:56.311554
538	t	537	537	1074	2	\N	\N	2018-07-05 07:52:56.311554
539	t	538	538	1076	1	\N	\N	2018-07-05 07:52:56.311554
540	t	539	539	1078	2	\N	\N	2018-07-05 07:52:56.311554
541	t	540	540	1080	1	\N	\N	2018-07-05 07:52:56.311554
542	t	541	541	1082	2	\N	\N	2018-07-05 07:52:56.311554
543	t	542	542	1084	1	\N	\N	2018-07-05 07:52:56.311554
544	t	543	543	1086	2	\N	\N	2018-07-05 07:52:56.311554
545	t	544	544	1088	1	\N	\N	2018-07-05 07:52:56.311554
546	t	545	545	1090	2	\N	\N	2018-07-05 07:52:56.311554
547	t	546	546	1092	1	\N	\N	2018-07-05 07:52:56.311554
548	t	547	547	1094	2	\N	\N	2018-07-05 07:52:56.311554
549	t	548	548	1096	1	\N	\N	2018-07-05 07:52:56.311554
550	t	549	549	1098	2	\N	\N	2018-07-05 07:52:56.311554
551	t	550	550	1100	1	\N	\N	2018-07-05 07:52:56.311554
552	t	551	551	1102	2	\N	\N	2018-07-05 07:52:56.311554
553	t	552	552	1104	1	\N	\N	2018-07-05 07:52:56.311554
554	t	553	553	1106	2	\N	\N	2018-07-05 07:52:56.311554
555	t	554	554	1108	1	\N	\N	2018-07-05 07:52:56.311554
556	t	555	555	1110	2	\N	\N	2018-07-05 07:52:56.311554
557	t	556	556	1112	1	\N	\N	2018-07-05 07:52:56.311554
558	t	557	557	1114	2	\N	\N	2018-07-05 07:52:56.311554
559	t	558	558	1116	1	\N	\N	2018-07-05 07:52:56.311554
560	t	559	559	1118	2	\N	\N	2018-07-05 07:52:56.311554
561	t	560	560	1120	1	\N	\N	2018-07-05 07:52:56.311554
562	t	561	561	1122	2	\N	\N	2018-07-05 07:52:56.311554
563	t	562	562	1124	1	\N	\N	2018-07-05 07:52:56.311554
564	t	563	563	1126	2	\N	\N	2018-07-05 07:52:56.311554
565	t	564	564	1128	1	\N	\N	2018-07-05 07:52:56.311554
566	t	565	565	1130	2	\N	\N	2018-07-05 07:52:56.311554
567	t	566	566	1132	1	\N	\N	2018-07-05 07:52:56.311554
568	t	567	567	1134	2	\N	\N	2018-07-05 07:52:56.311554
569	t	568	568	1136	1	\N	\N	2018-07-05 07:52:56.311554
570	t	569	569	1138	2	\N	\N	2018-07-05 07:52:56.311554
571	t	570	570	1140	1	\N	\N	2018-07-05 07:52:56.311554
572	t	571	571	1142	2	\N	\N	2018-07-05 07:52:56.311554
573	t	572	572	1144	1	\N	\N	2018-07-05 07:52:56.311554
574	t	573	573	1146	2	\N	\N	2018-07-05 07:52:56.311554
575	t	574	574	1148	1	\N	\N	2018-07-05 07:52:56.311554
576	t	575	575	1150	2	\N	\N	2018-07-05 07:52:56.311554
577	t	576	576	1152	1	\N	\N	2018-07-05 07:52:56.311554
578	t	577	577	1154	2	\N	\N	2018-07-05 07:52:56.311554
579	t	578	578	1156	1	\N	\N	2018-07-05 07:52:56.311554
580	t	579	579	1158	2	\N	\N	2018-07-05 07:52:56.311554
581	t	580	580	1160	1	\N	\N	2018-07-05 07:52:56.311554
582	t	581	581	1162	2	\N	\N	2018-07-05 07:52:56.311554
583	t	582	582	1164	1	\N	\N	2018-07-05 07:52:56.311554
584	t	583	583	1166	2	\N	\N	2018-07-05 07:52:56.311554
585	t	584	584	1168	1	\N	\N	2018-07-05 07:52:56.311554
586	t	585	585	1170	2	\N	\N	2018-07-05 07:52:56.311554
587	t	586	586	1172	1	\N	\N	2018-07-05 07:52:56.311554
588	t	587	587	1174	2	\N	\N	2018-07-05 07:52:56.311554
589	t	588	588	1176	1	\N	\N	2018-07-05 07:52:56.311554
590	t	589	589	1178	2	\N	\N	2018-07-05 07:52:56.311554
591	t	590	590	1180	1	\N	\N	2018-07-05 07:52:56.311554
592	t	591	591	1182	2	\N	\N	2018-07-05 07:52:56.311554
593	t	592	592	1184	1	\N	\N	2018-07-05 07:52:56.311554
594	t	593	593	1186	2	\N	\N	2018-07-05 07:52:56.311554
595	t	594	594	1188	1	\N	\N	2018-07-05 07:52:56.311554
596	t	595	595	1190	2	\N	\N	2018-07-05 07:52:56.311554
597	t	596	596	1192	1	\N	\N	2018-07-05 07:52:56.311554
598	t	597	597	1194	2	\N	\N	2018-07-05 07:52:56.311554
599	t	598	598	1196	1	\N	\N	2018-07-05 07:52:56.311554
600	t	599	599	1198	2	\N	\N	2018-07-05 07:52:56.311554
601	t	600	600	1200	1	\N	\N	2018-07-05 07:52:56.311554
602	t	601	601	1202	2	\N	\N	2018-07-05 07:52:56.311554
603	t	602	602	1204	1	\N	\N	2018-07-05 07:52:56.311554
604	t	603	603	1206	2	\N	\N	2018-07-05 07:52:56.311554
605	t	604	604	1208	1	\N	\N	2018-07-05 07:52:56.311554
606	t	605	605	1210	2	\N	\N	2018-07-05 07:52:56.311554
607	t	606	606	1212	1	\N	\N	2018-07-05 07:52:56.311554
608	t	607	607	1214	2	\N	\N	2018-07-05 07:52:56.311554
609	t	608	608	1216	1	\N	\N	2018-07-05 07:52:56.311554
610	t	609	609	1218	2	\N	\N	2018-07-05 07:52:56.311554
611	t	610	610	1220	1	\N	\N	2018-07-05 07:52:56.311554
612	t	611	611	1222	2	\N	\N	2018-07-05 07:52:56.311554
613	t	612	612	1224	1	\N	\N	2018-07-05 07:52:56.311554
614	t	613	613	1226	2	\N	\N	2018-07-05 07:52:56.311554
615	t	614	614	1228	1	\N	\N	2018-07-05 07:52:56.311554
616	t	615	615	1230	2	\N	\N	2018-07-05 07:52:56.311554
617	t	616	616	1232	1	\N	\N	2018-07-05 07:52:56.311554
618	t	617	617	1234	2	\N	\N	2018-07-05 07:52:56.311554
619	t	618	618	1236	1	\N	\N	2018-07-05 07:52:56.311554
620	t	619	619	1238	2	\N	\N	2018-07-05 07:52:56.311554
621	t	620	620	1240	1	\N	\N	2018-07-05 07:52:56.311554
622	t	621	621	1242	2	\N	\N	2018-07-05 07:52:56.311554
623	t	622	622	1244	1	\N	\N	2018-07-05 07:52:56.311554
624	t	623	623	1246	2	\N	\N	2018-07-05 07:52:56.311554
625	t	624	624	1248	1	\N	\N	2018-07-05 07:52:56.311554
626	t	625	625	1250	2	\N	\N	2018-07-05 07:52:56.311554
627	t	626	626	1252	1	\N	\N	2018-07-05 07:52:56.311554
628	t	627	627	1254	2	\N	\N	2018-07-05 07:52:56.311554
629	t	628	628	1256	1	\N	\N	2018-07-05 07:52:56.311554
630	t	629	629	1258	2	\N	\N	2018-07-05 07:52:56.311554
631	t	630	630	1260	1	\N	\N	2018-07-05 07:52:56.311554
632	t	631	631	1262	2	\N	\N	2018-07-05 07:52:56.311554
633	t	632	632	1264	1	\N	\N	2018-07-05 07:52:56.311554
634	t	633	633	1266	2	\N	\N	2018-07-05 07:52:56.311554
635	t	634	634	1268	1	\N	\N	2018-07-05 07:52:56.311554
636	t	635	635	1270	2	\N	\N	2018-07-05 07:52:56.311554
637	t	636	636	1272	1	\N	\N	2018-07-05 07:52:56.311554
638	t	637	637	1274	2	\N	\N	2018-07-05 07:52:56.311554
639	t	638	638	1276	1	\N	\N	2018-07-05 07:52:56.311554
640	t	639	639	1278	2	\N	\N	2018-07-05 07:52:56.311554
641	t	640	640	1280	1	\N	\N	2018-07-05 07:52:56.311554
642	t	641	641	1282	2	\N	\N	2018-07-05 07:52:56.311554
643	t	642	642	1284	1	\N	\N	2018-07-05 07:52:56.311554
644	t	643	643	1286	2	\N	\N	2018-07-05 07:52:56.311554
645	t	644	644	1288	1	\N	\N	2018-07-05 07:52:56.311554
646	t	645	645	1290	2	\N	\N	2018-07-05 07:52:56.311554
647	t	646	646	1292	1	\N	\N	2018-07-05 07:52:56.311554
648	t	647	647	1294	2	\N	\N	2018-07-05 07:52:56.311554
649	t	648	648	1296	1	\N	\N	2018-07-05 07:52:56.311554
650	t	649	649	1298	2	\N	\N	2018-07-05 07:52:56.311554
651	t	650	650	1300	1	\N	\N	2018-07-05 07:52:56.311554
652	t	651	651	1302	2	\N	\N	2018-07-05 07:52:56.311554
653	t	652	652	1304	1	\N	\N	2018-07-05 07:52:56.311554
654	t	653	653	1306	2	\N	\N	2018-07-05 07:52:56.311554
655	t	654	654	1308	1	\N	\N	2018-07-05 07:52:56.311554
656	t	655	655	1310	2	\N	\N	2018-07-05 07:52:56.311554
657	t	656	656	1312	1	\N	\N	2018-07-05 07:52:56.311554
658	t	657	657	1314	2	\N	\N	2018-07-05 07:52:56.311554
659	t	658	658	1316	1	\N	\N	2018-07-05 07:52:56.311554
660	t	659	659	1318	2	\N	\N	2018-07-05 07:52:56.311554
661	t	660	660	1320	1	\N	\N	2018-07-05 07:52:56.311554
662	t	661	661	1322	2	\N	\N	2018-07-05 07:52:56.311554
663	t	662	662	1324	1	\N	\N	2018-07-05 07:52:56.311554
664	t	663	663	1326	2	\N	\N	2018-07-05 07:52:56.311554
665	t	664	664	1328	1	\N	\N	2018-07-05 07:52:56.311554
666	t	665	665	1330	2	\N	\N	2018-07-05 07:52:56.311554
667	t	666	666	1332	1	\N	\N	2018-07-05 07:52:56.311554
668	t	667	667	1334	2	\N	\N	2018-07-05 07:52:56.311554
669	t	668	668	1336	1	\N	\N	2018-07-05 07:52:56.311554
670	t	669	669	1338	2	\N	\N	2018-07-05 07:52:56.311554
671	t	670	670	1340	1	\N	\N	2018-07-05 07:52:56.311554
672	t	671	671	1342	2	\N	\N	2018-07-05 07:52:56.311554
673	t	672	672	1344	1	\N	\N	2018-07-05 07:52:56.311554
674	t	673	673	1346	2	\N	\N	2018-07-05 07:52:56.311554
675	t	674	674	1348	1	\N	\N	2018-07-05 07:52:56.311554
676	t	675	675	1350	2	\N	\N	2018-07-05 07:52:56.311554
677	t	676	676	1352	1	\N	\N	2018-07-05 07:52:56.311554
678	t	677	677	1354	2	\N	\N	2018-07-05 07:52:56.311554
679	t	678	678	1356	1	\N	\N	2018-07-05 07:52:56.311554
680	t	679	679	1358	2	\N	\N	2018-07-05 07:52:56.311554
681	t	680	680	1360	1	\N	\N	2018-07-05 07:52:56.311554
682	t	681	681	1362	2	\N	\N	2018-07-05 07:52:56.311554
683	t	682	682	1364	1	\N	\N	2018-07-05 07:52:56.311554
684	t	683	683	1366	2	\N	\N	2018-07-05 07:52:56.311554
685	t	684	684	1368	1	\N	\N	2018-07-05 07:52:56.311554
686	t	685	685	1370	2	\N	\N	2018-07-05 07:52:56.311554
687	t	686	686	1372	1	\N	\N	2018-07-05 07:52:56.311554
688	t	687	687	1374	2	\N	\N	2018-07-05 07:52:56.311554
689	t	688	688	1376	1	\N	\N	2018-07-05 07:52:56.311554
690	t	689	689	1378	2	\N	\N	2018-07-05 07:52:56.311554
691	t	690	690	1380	1	\N	\N	2018-07-05 07:52:56.311554
692	t	691	691	1382	2	\N	\N	2018-07-05 07:52:56.311554
693	t	692	692	1384	1	\N	\N	2018-07-05 07:52:56.311554
694	t	693	693	1386	2	\N	\N	2018-07-05 07:52:56.311554
695	t	694	694	1388	1	\N	\N	2018-07-05 07:52:56.311554
696	t	695	695	1390	2	\N	\N	2018-07-05 07:52:56.311554
697	t	696	696	1392	1	\N	\N	2018-07-05 07:52:56.311554
698	t	697	697	1394	2	\N	\N	2018-07-05 07:52:56.311554
699	t	698	698	1396	1	\N	\N	2018-07-05 07:52:56.311554
700	t	699	699	1398	2	\N	\N	2018-07-05 07:52:56.311554
701	t	700	700	1400	1	\N	\N	2018-07-05 07:52:56.311554
702	t	701	701	1402	2	\N	\N	2018-07-05 07:52:56.311554
703	t	702	702	1404	1	\N	\N	2018-07-05 07:52:56.311554
704	t	703	703	1406	2	\N	\N	2018-07-05 07:52:56.311554
705	t	704	704	1408	1	\N	\N	2018-07-05 07:52:56.311554
706	t	705	705	1410	2	\N	\N	2018-07-05 07:52:56.311554
707	t	706	706	1412	1	\N	\N	2018-07-05 07:52:56.311554
708	t	707	707	1414	2	\N	\N	2018-07-05 07:52:56.311554
709	t	708	708	1416	1	\N	\N	2018-07-05 07:52:56.311554
710	t	709	709	1418	2	\N	\N	2018-07-05 07:52:56.311554
711	t	710	710	1420	1	\N	\N	2018-07-05 07:52:56.311554
712	t	711	711	1422	2	\N	\N	2018-07-05 07:52:56.311554
713	t	712	712	1424	1	\N	\N	2018-07-05 07:52:56.311554
714	t	713	713	1426	2	\N	\N	2018-07-05 07:52:56.311554
715	t	714	714	1428	1	\N	\N	2018-07-05 07:52:56.311554
716	t	715	715	1430	2	\N	\N	2018-07-05 07:52:56.311554
717	t	716	716	1432	1	\N	\N	2018-07-05 07:52:56.311554
718	t	717	717	1434	2	\N	\N	2018-07-05 07:52:56.311554
719	t	718	718	1436	1	\N	\N	2018-07-05 07:52:56.311554
720	t	719	719	1438	2	\N	\N	2018-07-05 07:52:56.311554
721	t	720	720	1440	1	\N	\N	2018-07-05 07:52:56.311554
722	t	721	721	1442	2	\N	\N	2018-07-05 07:52:56.311554
723	t	722	722	1444	1	\N	\N	2018-07-05 07:52:56.311554
724	t	723	723	1446	2	\N	\N	2018-07-05 07:52:56.311554
725	t	724	724	1448	1	\N	\N	2018-07-05 07:52:56.311554
726	t	725	725	1450	2	\N	\N	2018-07-05 07:52:56.311554
727	t	726	726	1452	1	\N	\N	2018-07-05 07:52:56.311554
728	t	727	727	1454	2	\N	\N	2018-07-05 07:52:56.311554
729	t	728	728	1456	1	\N	\N	2018-07-05 07:52:56.311554
730	t	729	729	1458	2	\N	\N	2018-07-05 07:52:56.311554
731	t	730	730	1460	1	\N	\N	2018-07-05 07:52:56.311554
732	t	731	731	1462	2	\N	\N	2018-07-05 07:52:56.311554
733	t	732	732	1464	1	\N	\N	2018-07-05 07:52:56.311554
734	t	733	733	1466	2	\N	\N	2018-07-05 07:52:56.311554
735	t	734	734	1468	1	\N	\N	2018-07-05 07:52:56.311554
736	t	735	735	1470	2	\N	\N	2018-07-05 07:52:56.311554
737	t	736	736	1472	1	\N	\N	2018-07-05 07:52:56.311554
738	t	737	737	1474	2	\N	\N	2018-07-05 07:52:56.311554
739	t	738	738	1476	1	\N	\N	2018-07-05 07:52:56.311554
740	t	739	739	1478	2	\N	\N	2018-07-05 07:52:56.311554
741	t	740	740	1480	1	\N	\N	2018-07-05 07:52:56.311554
742	t	741	741	1482	2	\N	\N	2018-07-05 07:52:56.311554
743	t	742	742	1484	1	\N	\N	2018-07-05 07:52:56.311554
744	t	743	743	1486	2	\N	\N	2018-07-05 07:52:56.311554
745	t	744	744	1488	1	\N	\N	2018-07-05 07:52:56.311554
746	t	745	745	1490	2	\N	\N	2018-07-05 07:52:56.311554
747	t	746	746	1492	1	\N	\N	2018-07-05 07:52:56.311554
748	t	747	747	1494	2	\N	\N	2018-07-05 07:52:56.311554
749	t	748	748	1496	1	\N	\N	2018-07-05 07:52:56.311554
750	t	749	749	1498	2	\N	\N	2018-07-05 07:52:56.311554
751	t	750	750	1500	1	\N	\N	2018-07-05 07:52:56.311554
752	t	751	751	1502	2	\N	\N	2018-07-05 07:52:56.311554
753	t	752	752	1504	1	\N	\N	2018-07-05 07:52:56.311554
754	t	753	753	1506	2	\N	\N	2018-07-05 07:52:56.311554
755	t	754	754	1508	1	\N	\N	2018-07-05 07:52:56.311554
756	t	755	755	1510	2	\N	\N	2018-07-05 07:52:56.311554
757	t	756	756	1512	1	\N	\N	2018-07-05 07:52:56.311554
758	t	757	757	1514	2	\N	\N	2018-07-05 07:52:56.311554
759	t	758	758	1516	1	\N	\N	2018-07-05 07:52:56.311554
760	t	759	759	1518	2	\N	\N	2018-07-05 07:52:56.311554
761	t	760	760	1520	1	\N	\N	2018-07-05 07:52:56.311554
762	t	761	761	1522	2	\N	\N	2018-07-05 07:52:56.311554
763	t	762	762	1524	1	\N	\N	2018-07-05 07:52:56.311554
764	t	763	763	1526	2	\N	\N	2018-07-05 07:52:56.311554
765	t	764	764	1528	1	\N	\N	2018-07-05 07:52:56.311554
766	t	765	765	1530	2	\N	\N	2018-07-05 07:52:56.311554
767	t	766	766	1532	1	\N	\N	2018-07-05 07:52:56.311554
768	t	767	767	1534	2	\N	\N	2018-07-05 07:52:56.311554
769	t	768	768	1536	1	\N	\N	2018-07-05 07:52:56.311554
770	t	769	769	1538	2	\N	\N	2018-07-05 07:52:56.311554
771	t	770	770	1540	1	\N	\N	2018-07-05 07:52:56.311554
772	t	771	771	1542	2	\N	\N	2018-07-05 07:52:56.311554
773	t	772	772	1544	1	\N	\N	2018-07-05 07:52:56.311554
774	t	773	773	1546	2	\N	\N	2018-07-05 07:52:56.311554
775	t	774	774	1548	1	\N	\N	2018-07-05 07:52:56.311554
776	t	775	775	1550	2	\N	\N	2018-07-05 07:52:56.311554
777	t	776	776	1552	1	\N	\N	2018-07-05 07:52:56.311554
778	t	777	777	1554	2	\N	\N	2018-07-05 07:52:56.311554
779	t	778	778	1556	1	\N	\N	2018-07-05 07:52:56.311554
780	t	779	779	1558	2	\N	\N	2018-07-05 07:52:56.311554
781	t	780	780	1560	1	\N	\N	2018-07-05 07:52:56.311554
782	t	781	781	1562	2	\N	\N	2018-07-05 07:52:56.311554
783	t	782	782	1564	1	\N	\N	2018-07-05 07:52:56.311554
784	t	783	783	1566	2	\N	\N	2018-07-05 07:52:56.311554
785	t	784	784	1568	1	\N	\N	2018-07-05 07:52:56.311554
786	t	785	785	1570	2	\N	\N	2018-07-05 07:52:56.311554
787	t	786	786	1572	1	\N	\N	2018-07-05 07:52:56.311554
788	t	787	787	1574	2	\N	\N	2018-07-05 07:52:56.311554
789	t	788	788	1576	1	\N	\N	2018-07-05 07:52:56.311554
790	t	789	789	1578	2	\N	\N	2018-07-05 07:52:56.311554
791	t	790	790	1580	1	\N	\N	2018-07-05 07:52:56.311554
792	t	791	791	1582	2	\N	\N	2018-07-05 07:52:56.311554
793	t	792	792	1584	1	\N	\N	2018-07-05 07:52:56.311554
794	t	793	793	1586	2	\N	\N	2018-07-05 07:52:56.311554
795	t	794	794	1588	1	\N	\N	2018-07-05 07:52:56.311554
796	t	795	795	1590	2	\N	\N	2018-07-05 07:52:56.311554
797	t	796	796	1592	1	\N	\N	2018-07-05 07:52:56.311554
798	t	797	797	1594	2	\N	\N	2018-07-05 07:52:56.311554
799	t	798	798	1596	1	\N	\N	2018-07-05 07:52:56.311554
800	t	799	799	1598	2	\N	\N	2018-07-05 07:52:56.311554
801	t	800	800	1600	1	\N	\N	2018-07-05 07:52:56.311554
802	t	801	801	1602	2	\N	\N	2018-07-05 07:52:56.311554
803	t	802	802	1604	1	\N	\N	2018-07-05 07:52:56.311554
804	t	803	803	1606	2	\N	\N	2018-07-05 07:52:56.311554
805	t	804	804	1608	1	\N	\N	2018-07-05 07:52:56.311554
806	t	805	805	1610	2	\N	\N	2018-07-05 07:52:56.311554
807	t	806	806	1612	1	\N	\N	2018-07-05 07:52:56.311554
808	t	807	807	1614	2	\N	\N	2018-07-05 07:52:56.311554
809	t	808	808	1616	1	\N	\N	2018-07-05 07:52:56.311554
810	t	809	809	1618	2	\N	\N	2018-07-05 07:52:56.311554
811	t	810	810	1620	1	\N	\N	2018-07-05 07:52:56.311554
812	t	811	811	1622	2	\N	\N	2018-07-05 07:52:56.311554
813	t	812	812	1624	1	\N	\N	2018-07-05 07:52:56.311554
814	t	813	813	1626	2	\N	\N	2018-07-05 07:52:56.311554
815	t	814	814	1628	1	\N	\N	2018-07-05 07:52:56.311554
816	t	815	815	1630	2	\N	\N	2018-07-05 07:52:56.311554
817	t	816	816	1632	1	\N	\N	2018-07-05 07:52:56.311554
818	t	817	817	1634	2	\N	\N	2018-07-05 07:52:56.311554
819	t	818	818	1636	1	\N	\N	2018-07-05 07:52:56.311554
820	t	819	819	1638	2	\N	\N	2018-07-05 07:52:56.311554
821	t	820	820	1640	1	\N	\N	2018-07-05 07:52:56.311554
822	t	821	821	1642	2	\N	\N	2018-07-05 07:52:56.311554
823	t	822	822	1644	1	\N	\N	2018-07-05 07:52:56.311554
824	t	823	823	1646	2	\N	\N	2018-07-05 07:52:56.311554
825	t	824	824	1648	1	\N	\N	2018-07-05 07:52:56.311554
826	t	825	825	1650	2	\N	\N	2018-07-05 07:52:56.311554
827	t	826	826	1652	1	\N	\N	2018-07-05 07:52:56.311554
828	t	827	827	1654	2	\N	\N	2018-07-05 07:52:56.311554
829	t	828	828	1656	1	\N	\N	2018-07-05 07:52:56.311554
830	t	829	829	1658	2	\N	\N	2018-07-05 07:52:56.311554
831	t	830	830	1660	1	\N	\N	2018-07-05 07:52:56.311554
832	t	831	831	1662	2	\N	\N	2018-07-05 07:52:56.311554
833	t	832	832	1664	1	\N	\N	2018-07-05 07:52:56.311554
834	t	833	833	1666	2	\N	\N	2018-07-05 07:52:56.311554
835	t	834	834	1668	1	\N	\N	2018-07-05 07:52:56.311554
836	t	835	835	1670	2	\N	\N	2018-07-05 07:52:56.311554
837	t	836	836	1672	1	\N	\N	2018-07-05 07:52:56.311554
838	t	837	837	1674	2	\N	\N	2018-07-05 07:52:56.311554
839	t	838	838	1676	1	\N	\N	2018-07-05 07:52:56.311554
840	t	839	839	1678	2	\N	\N	2018-07-05 07:52:56.311554
841	t	840	840	1680	1	\N	\N	2018-07-05 07:52:56.311554
842	t	841	841	1682	2	\N	\N	2018-07-05 07:52:56.311554
843	t	842	842	1684	1	\N	\N	2018-07-05 07:52:56.311554
844	t	843	843	1686	2	\N	\N	2018-07-05 07:52:56.311554
845	t	844	844	1688	1	\N	\N	2018-07-05 07:52:56.311554
846	t	845	845	1690	2	\N	\N	2018-07-05 07:52:56.311554
847	t	846	846	1692	1	\N	\N	2018-07-05 07:52:56.311554
848	t	847	847	1694	2	\N	\N	2018-07-05 07:52:56.311554
849	t	848	848	1696	1	\N	\N	2018-07-05 07:52:56.311554
850	t	849	849	1698	2	\N	\N	2018-07-05 07:52:56.311554
851	t	850	850	1700	1	\N	\N	2018-07-05 07:52:56.311554
852	t	851	851	1702	2	\N	\N	2018-07-05 07:52:56.311554
853	t	852	852	1704	1	\N	\N	2018-07-05 07:52:56.311554
854	t	853	853	1706	2	\N	\N	2018-07-05 07:52:56.311554
855	t	854	854	1708	1	\N	\N	2018-07-05 07:52:56.311554
856	t	855	855	1710	2	\N	\N	2018-07-05 07:52:56.311554
857	t	856	856	1712	1	\N	\N	2018-07-05 07:52:56.311554
858	t	857	857	1714	2	\N	\N	2018-07-05 07:52:56.311554
859	t	858	858	1716	1	\N	\N	2018-07-05 07:52:56.311554
860	t	859	859	1718	2	\N	\N	2018-07-05 07:52:56.311554
861	t	860	860	1720	1	\N	\N	2018-07-05 07:52:56.311554
862	t	861	861	1722	2	\N	\N	2018-07-05 07:52:56.311554
863	t	862	862	1724	1	\N	\N	2018-07-05 07:52:56.311554
864	t	863	863	1726	2	\N	\N	2018-07-05 07:52:56.311554
865	t	864	864	1728	1	\N	\N	2018-07-05 07:52:56.311554
866	t	865	865	1730	2	\N	\N	2018-07-05 07:52:56.311554
867	t	866	866	1732	1	\N	\N	2018-07-05 07:52:56.311554
868	t	867	867	1734	2	\N	\N	2018-07-05 07:52:56.311554
869	t	868	868	1736	1	\N	\N	2018-07-05 07:52:56.311554
870	t	869	869	1738	2	\N	\N	2018-07-05 07:52:56.311554
871	t	870	870	1740	1	\N	\N	2018-07-05 07:52:56.311554
872	t	871	871	1742	2	\N	\N	2018-07-05 07:52:56.311554
873	t	872	872	1744	1	\N	\N	2018-07-05 07:52:56.311554
874	t	873	873	1746	2	\N	\N	2018-07-05 07:52:56.311554
875	t	874	874	1748	1	\N	\N	2018-07-05 07:52:56.311554
876	t	875	875	1750	2	\N	\N	2018-07-05 07:52:56.311554
877	t	876	876	1752	1	\N	\N	2018-07-05 07:52:56.311554
878	t	877	877	1754	2	\N	\N	2018-07-05 07:52:56.311554
879	t	878	878	1756	1	\N	\N	2018-07-05 07:52:56.311554
880	t	879	879	1758	2	\N	\N	2018-07-05 07:52:56.311554
881	t	880	880	1760	1	\N	\N	2018-07-05 07:52:56.311554
882	t	881	881	1762	2	\N	\N	2018-07-05 07:52:56.311554
883	t	882	882	1764	1	\N	\N	2018-07-05 07:52:56.311554
884	t	883	883	1766	2	\N	\N	2018-07-05 07:52:56.311554
885	t	884	884	1768	1	\N	\N	2018-07-05 07:52:56.311554
886	t	885	885	1770	2	\N	\N	2018-07-05 07:52:56.311554
887	t	886	886	1772	1	\N	\N	2018-07-05 07:52:56.311554
888	t	887	887	1774	2	\N	\N	2018-07-05 07:52:56.311554
889	t	888	888	1776	1	\N	\N	2018-07-05 07:52:56.311554
890	t	889	889	1778	2	\N	\N	2018-07-05 07:52:56.311554
891	t	890	890	1780	1	\N	\N	2018-07-05 07:52:56.311554
892	t	891	891	1782	2	\N	\N	2018-07-05 07:52:56.311554
893	t	892	892	1784	1	\N	\N	2018-07-05 07:52:56.311554
894	t	893	893	1786	2	\N	\N	2018-07-05 07:52:56.311554
895	t	894	894	1788	1	\N	\N	2018-07-05 07:52:56.311554
896	t	895	895	1790	2	\N	\N	2018-07-05 07:52:56.311554
897	t	896	896	1792	1	\N	\N	2018-07-05 07:52:56.311554
898	t	897	897	1794	2	\N	\N	2018-07-05 07:52:56.311554
899	t	898	898	1796	1	\N	\N	2018-07-05 07:52:56.311554
900	t	899	899	1798	2	\N	\N	2018-07-05 07:52:56.311554
901	t	900	900	1800	1	\N	\N	2018-07-05 07:52:56.311554
902	t	901	901	1802	2	\N	\N	2018-07-05 07:52:56.311554
903	t	902	902	1804	1	\N	\N	2018-07-05 07:52:56.311554
904	t	903	903	1806	2	\N	\N	2018-07-05 07:52:56.311554
905	t	904	904	1808	1	\N	\N	2018-07-05 07:52:56.311554
906	t	905	905	1810	2	\N	\N	2018-07-05 07:52:56.311554
907	t	906	906	1812	1	\N	\N	2018-07-05 07:52:56.311554
908	t	907	907	1814	2	\N	\N	2018-07-05 07:52:56.311554
909	t	908	908	1816	1	\N	\N	2018-07-05 07:52:56.311554
910	t	909	909	1818	2	\N	\N	2018-07-05 07:52:56.311554
911	t	910	910	1820	1	\N	\N	2018-07-05 07:52:56.311554
912	t	911	911	1822	2	\N	\N	2018-07-05 07:52:56.311554
913	t	912	912	1824	1	\N	\N	2018-07-05 07:52:56.311554
914	t	913	913	1826	2	\N	\N	2018-07-05 07:52:56.311554
915	t	914	914	1828	1	\N	\N	2018-07-05 07:52:56.311554
916	t	915	915	1830	2	\N	\N	2018-07-05 07:52:56.311554
917	t	916	916	1832	1	\N	\N	2018-07-05 07:52:56.311554
918	t	917	917	1834	2	\N	\N	2018-07-05 07:52:56.311554
919	t	918	918	1836	1	\N	\N	2018-07-05 07:52:56.311554
920	t	919	919	1838	2	\N	\N	2018-07-05 07:52:56.311554
921	t	920	920	1840	1	\N	\N	2018-07-05 07:52:56.311554
922	t	921	921	1842	2	\N	\N	2018-07-05 07:52:56.311554
923	t	922	922	1844	1	\N	\N	2018-07-05 07:52:56.311554
924	t	923	923	1846	2	\N	\N	2018-07-05 07:52:56.311554
925	t	924	924	1848	1	\N	\N	2018-07-05 07:52:56.311554
926	t	925	925	1850	2	\N	\N	2018-07-05 07:52:56.311554
927	t	926	926	1852	1	\N	\N	2018-07-05 07:52:56.311554
928	t	927	927	1854	2	\N	\N	2018-07-05 07:52:56.311554
929	t	928	928	1856	1	\N	\N	2018-07-05 07:52:56.311554
930	t	929	929	1858	2	\N	\N	2018-07-05 07:52:56.311554
931	t	930	930	1860	1	\N	\N	2018-07-05 07:52:56.311554
932	t	931	931	1862	2	\N	\N	2018-07-05 07:52:56.311554
933	t	932	932	1864	1	\N	\N	2018-07-05 07:52:56.311554
934	t	933	933	1866	2	\N	\N	2018-07-05 07:52:56.311554
935	t	934	934	1868	1	\N	\N	2018-07-05 07:52:56.311554
936	t	935	935	1870	2	\N	\N	2018-07-05 07:52:56.311554
937	t	936	936	1872	1	\N	\N	2018-07-05 07:52:56.311554
938	t	937	937	1874	2	\N	\N	2018-07-05 07:52:56.311554
939	t	938	938	1876	1	\N	\N	2018-07-05 07:52:56.311554
940	t	939	939	1878	2	\N	\N	2018-07-05 07:52:56.311554
941	t	940	940	1880	1	\N	\N	2018-07-05 07:52:56.311554
942	t	941	941	1882	2	\N	\N	2018-07-05 07:52:56.311554
943	t	942	942	1884	1	\N	\N	2018-07-05 07:52:56.311554
944	t	943	943	1886	2	\N	\N	2018-07-05 07:52:56.311554
945	t	944	944	1888	1	\N	\N	2018-07-05 07:52:56.311554
946	t	945	945	1890	2	\N	\N	2018-07-05 07:52:56.311554
947	t	946	946	1892	1	\N	\N	2018-07-05 07:52:56.311554
948	t	947	947	1894	2	\N	\N	2018-07-05 07:52:56.311554
949	t	948	948	1896	1	\N	\N	2018-07-05 07:52:56.311554
950	t	949	949	1898	2	\N	\N	2018-07-05 07:52:56.311554
951	t	950	950	1900	1	\N	\N	2018-07-05 07:52:56.311554
952	t	951	951	1902	2	\N	\N	2018-07-05 07:52:56.311554
953	t	952	952	1904	1	\N	\N	2018-07-05 07:52:56.311554
954	t	953	953	1906	2	\N	\N	2018-07-05 07:52:56.311554
955	t	954	954	1908	1	\N	\N	2018-07-05 07:52:56.311554
956	t	955	955	1910	2	\N	\N	2018-07-05 07:52:56.311554
957	t	956	956	1912	1	\N	\N	2018-07-05 07:52:56.311554
958	t	957	957	1914	2	\N	\N	2018-07-05 07:52:56.311554
959	t	958	958	1916	1	\N	\N	2018-07-05 07:52:56.311554
960	t	959	959	1918	2	\N	\N	2018-07-05 07:52:56.311554
961	t	960	960	1920	1	\N	\N	2018-07-05 07:52:56.311554
962	t	961	961	1922	2	\N	\N	2018-07-05 07:52:56.311554
963	t	962	962	1924	1	\N	\N	2018-07-05 07:52:56.311554
964	t	963	963	1926	2	\N	\N	2018-07-05 07:52:56.311554
965	t	964	964	1928	1	\N	\N	2018-07-05 07:52:56.311554
966	t	965	965	1930	2	\N	\N	2018-07-05 07:52:56.311554
967	t	966	966	1932	1	\N	\N	2018-07-05 07:52:56.311554
968	t	967	967	1934	2	\N	\N	2018-07-05 07:52:56.311554
969	t	968	968	1936	1	\N	\N	2018-07-05 07:52:56.311554
970	t	969	969	1938	2	\N	\N	2018-07-05 07:52:56.311554
971	t	970	970	1940	1	\N	\N	2018-07-05 07:52:56.311554
972	t	971	971	1942	2	\N	\N	2018-07-05 07:52:56.311554
973	t	972	972	1944	1	\N	\N	2018-07-05 07:52:56.311554
974	t	973	973	1946	2	\N	\N	2018-07-05 07:52:56.311554
975	t	974	974	1948	1	\N	\N	2018-07-05 07:52:56.311554
976	t	975	975	1950	2	\N	\N	2018-07-05 07:52:56.311554
977	t	976	976	1952	1	\N	\N	2018-07-05 07:52:56.311554
978	t	977	977	1954	2	\N	\N	2018-07-05 07:52:56.311554
979	t	978	978	1956	1	\N	\N	2018-07-05 07:52:56.311554
980	t	979	979	1958	2	\N	\N	2018-07-05 07:52:56.311554
981	t	980	980	1960	1	\N	\N	2018-07-05 07:52:56.311554
982	t	981	981	1962	2	\N	\N	2018-07-05 07:52:56.311554
983	t	982	982	1964	1	\N	\N	2018-07-05 07:52:56.311554
984	t	983	983	1966	2	\N	\N	2018-07-05 07:52:56.311554
985	t	984	984	1968	1	\N	\N	2018-07-05 07:52:56.311554
986	t	985	985	1970	2	\N	\N	2018-07-05 07:52:56.311554
987	t	986	986	1972	1	\N	\N	2018-07-05 07:52:56.311554
988	t	987	987	1974	2	\N	\N	2018-07-05 07:52:56.311554
989	t	988	988	1976	1	\N	\N	2018-07-05 07:52:56.311554
990	t	989	989	1978	2	\N	\N	2018-07-05 07:52:56.311554
991	t	990	990	1980	1	\N	\N	2018-07-05 07:52:56.311554
992	t	991	991	1982	2	\N	\N	2018-07-05 07:52:56.311554
993	t	992	992	1984	1	\N	\N	2018-07-05 07:52:56.311554
994	t	993	993	1986	2	\N	\N	2018-07-05 07:52:56.311554
995	t	994	994	1988	1	\N	\N	2018-07-05 07:52:56.311554
996	t	995	995	1990	2	\N	\N	2018-07-05 07:52:56.311554
997	t	996	996	1992	1	\N	\N	2018-07-05 07:52:56.311554
998	t	997	997	1994	2	\N	\N	2018-07-05 07:52:56.311554
999	t	998	998	1996	1	\N	\N	2018-07-05 07:52:56.311554
1000	t	999	999	1998	2	\N	\N	2018-07-05 07:52:56.311554
1001	t	1000	1000	2000	1	\N	\N	2018-07-05 07:52:56.311554
1002	t	1001	1001	2002	2	\N	\N	2018-07-05 07:52:56.311554
1003	t	1002	1002	2004	1	\N	\N	2018-07-05 07:52:56.311554
1004	t	1003	1003	2006	2	\N	\N	2018-07-05 07:52:56.311554
1005	t	1004	1004	2008	1	\N	\N	2018-07-05 07:52:56.311554
1006	t	1005	1005	2010	2	\N	\N	2018-07-05 07:52:56.311554
1007	t	1006	1006	2012	1	\N	\N	2018-07-05 07:52:56.311554
1008	t	1007	1007	2014	2	\N	\N	2018-07-05 07:52:56.311554
1009	t	1008	1008	2016	1	\N	\N	2018-07-05 07:52:56.311554
1010	t	1009	1009	2018	2	\N	\N	2018-07-05 07:52:56.311554
1011	t	1010	1010	2020	1	\N	\N	2018-07-05 07:52:56.311554
1012	t	1011	1011	2022	2	\N	\N	2018-07-05 07:52:56.311554
1013	t	1012	1012	2024	1	\N	\N	2018-07-05 07:52:56.311554
1014	t	1013	1013	2026	2	\N	\N	2018-07-05 07:52:56.311554
1015	t	1014	1014	2028	1	\N	\N	2018-07-05 07:52:56.311554
1016	t	1015	1015	2030	2	\N	\N	2018-07-05 07:52:56.311554
1017	t	1016	1016	2032	1	\N	\N	2018-07-05 07:52:56.311554
1018	t	1017	1017	2034	2	\N	\N	2018-07-05 07:52:56.311554
1019	t	1018	1018	2036	1	\N	\N	2018-07-05 07:52:56.311554
1020	t	1019	1019	2038	2	\N	\N	2018-07-05 07:52:56.311554
1021	t	1020	1020	2040	1	\N	\N	2018-07-05 07:52:56.311554
1022	t	1021	1021	2042	2	\N	\N	2018-07-05 07:52:56.311554
1023	t	1022	1022	2044	1	\N	\N	2018-07-05 07:52:56.311554
1024	t	1023	1023	2046	2	\N	\N	2018-07-05 07:52:56.311554
1025	t	1024	1024	2048	1	\N	\N	2018-07-05 07:52:56.311554
1026	t	1025	1025	2050	2	\N	\N	2018-07-05 07:52:56.311554
1027	t	1026	1026	2052	1	\N	\N	2018-07-05 07:52:56.311554
1028	t	1027	1027	2054	2	\N	\N	2018-07-05 07:52:56.311554
1029	t	1028	1028	2056	1	\N	\N	2018-07-05 07:52:56.311554
1030	t	1029	1029	2058	2	\N	\N	2018-07-05 07:52:56.311554
1031	t	1030	1030	2060	1	\N	\N	2018-07-05 07:52:56.311554
1032	t	1031	1031	2062	2	\N	\N	2018-07-05 07:52:56.311554
1033	t	1032	1032	2064	1	\N	\N	2018-07-05 07:52:56.311554
1034	t	1033	1033	2066	2	\N	\N	2018-07-05 07:52:56.311554
1035	t	1034	1034	2068	1	\N	\N	2018-07-05 07:52:56.311554
1036	t	1035	1035	2070	2	\N	\N	2018-07-05 07:52:56.311554
1037	t	1036	1036	2072	1	\N	\N	2018-07-05 07:52:56.311554
1038	t	1037	1037	2074	2	\N	\N	2018-07-05 07:52:56.311554
1039	t	1038	1038	2076	1	\N	\N	2018-07-05 07:52:56.311554
1040	t	1039	1039	2078	2	\N	\N	2018-07-05 07:52:56.311554
1041	t	1040	1040	2080	1	\N	\N	2018-07-05 07:52:56.311554
1042	t	1041	1041	2082	2	\N	\N	2018-07-05 07:52:56.311554
1043	t	1042	1042	2084	1	\N	\N	2018-07-05 07:52:56.311554
1044	t	1043	1043	2086	2	\N	\N	2018-07-05 07:52:56.311554
1045	t	1044	1044	2088	1	\N	\N	2018-07-05 07:52:56.311554
1046	t	1045	1045	2090	2	\N	\N	2018-07-05 07:52:56.311554
1047	t	1046	1046	2092	1	\N	\N	2018-07-05 07:52:56.311554
1048	t	1047	1047	2094	2	\N	\N	2018-07-05 07:52:56.311554
1049	t	1048	1048	2096	1	\N	\N	2018-07-05 07:52:56.311554
1050	t	1049	1049	2098	2	\N	\N	2018-07-05 07:52:56.311554
1051	t	1050	1050	2100	1	\N	\N	2018-07-05 07:52:56.311554
1052	t	1051	1051	2102	2	\N	\N	2018-07-05 07:52:56.311554
1053	t	1052	1052	2104	1	\N	\N	2018-07-05 07:52:56.311554
1054	t	1053	1053	2106	2	\N	\N	2018-07-05 07:52:56.311554
1055	t	1054	1054	2108	1	\N	\N	2018-07-05 07:52:56.311554
1056	t	1055	1055	2110	2	\N	\N	2018-07-05 07:52:56.311554
1057	t	1056	1056	2112	1	\N	\N	2018-07-05 07:52:56.311554
1058	t	1057	1057	2114	2	\N	\N	2018-07-05 07:52:56.311554
1059	t	1058	1058	2116	1	\N	\N	2018-07-05 07:52:56.311554
1060	t	1059	1059	2118	2	\N	\N	2018-07-05 07:52:56.311554
1061	t	1060	1060	2120	1	\N	\N	2018-07-05 07:52:56.311554
1062	t	1061	1061	2122	2	\N	\N	2018-07-05 07:52:56.311554
1063	t	1062	1062	2124	1	\N	\N	2018-07-05 07:52:56.311554
1064	t	1063	1063	2126	2	\N	\N	2018-07-05 07:52:56.311554
1065	t	1064	1064	2128	1	\N	\N	2018-07-05 07:52:56.311554
1066	t	1065	1065	2130	2	\N	\N	2018-07-05 07:52:56.311554
1067	t	1066	1066	2132	1	\N	\N	2018-07-05 07:52:56.311554
1068	t	1067	1067	2134	2	\N	\N	2018-07-05 07:52:56.311554
1069	t	1068	1068	2136	1	\N	\N	2018-07-05 07:52:56.311554
1070	t	1069	1069	2138	2	\N	\N	2018-07-05 07:52:56.311554
1071	t	1070	1070	2140	1	\N	\N	2018-07-05 07:52:56.311554
1072	t	1071	1071	2142	2	\N	\N	2018-07-05 07:52:56.311554
1073	t	1072	1072	2144	1	\N	\N	2018-07-05 07:52:56.311554
1074	t	1073	1073	2146	2	\N	\N	2018-07-05 07:52:56.311554
1075	t	1074	1074	2148	1	\N	\N	2018-07-05 07:52:56.311554
1076	t	1075	1075	2150	2	\N	\N	2018-07-05 07:52:56.311554
1077	t	1076	1076	2152	1	\N	\N	2018-07-05 07:52:56.311554
1078	t	1077	1077	2154	2	\N	\N	2018-07-05 07:52:56.311554
1079	t	1078	1078	2156	1	\N	\N	2018-07-05 07:52:56.311554
1080	t	1079	1079	2158	2	\N	\N	2018-07-05 07:52:56.311554
1081	t	1080	1080	2160	1	\N	\N	2018-07-05 07:52:56.311554
1082	t	1081	1081	2162	2	\N	\N	2018-07-05 07:52:56.311554
1083	t	1082	1082	2164	1	\N	\N	2018-07-05 07:52:56.311554
1084	t	1083	1083	2166	2	\N	\N	2018-07-05 07:52:56.311554
1085	t	1084	1084	2168	1	\N	\N	2018-07-05 07:52:56.311554
1086	t	1085	1085	2170	2	\N	\N	2018-07-05 07:52:56.311554
1087	t	1086	1086	2172	1	\N	\N	2018-07-05 07:52:56.311554
1088	t	1087	1087	2174	2	\N	\N	2018-07-05 07:52:56.311554
1089	t	1088	1088	2176	1	\N	\N	2018-07-05 07:52:56.311554
1090	t	1089	1089	2178	2	\N	\N	2018-07-05 07:52:56.311554
1091	t	1090	1090	2180	1	\N	\N	2018-07-05 07:52:56.311554
1092	t	1091	1091	2182	2	\N	\N	2018-07-05 07:52:56.311554
1093	t	1092	1092	2184	1	\N	\N	2018-07-05 07:52:56.311554
1094	t	1093	1093	2186	2	\N	\N	2018-07-05 07:52:56.311554
1095	t	1094	1094	2188	1	\N	\N	2018-07-05 07:52:56.311554
1096	t	1095	1095	2190	2	\N	\N	2018-07-05 07:52:56.311554
1097	t	1096	1096	2192	1	\N	\N	2018-07-05 07:52:56.311554
1098	t	1097	1097	2194	2	\N	\N	2018-07-05 07:52:56.311554
1099	t	1098	1098	2196	1	\N	\N	2018-07-05 07:52:56.311554
1100	t	1099	1099	2198	2	\N	\N	2018-07-05 07:52:56.311554
1101	t	1100	1100	2200	1	\N	\N	2018-07-05 07:52:56.311554
1102	t	1101	1101	2202	2	\N	\N	2018-07-05 07:52:56.311554
1103	t	1102	1102	2204	1	\N	\N	2018-07-05 07:52:56.311554
1104	t	1103	1103	2206	2	\N	\N	2018-07-05 07:52:56.311554
1105	t	1104	1104	2208	1	\N	\N	2018-07-05 07:52:56.311554
1106	t	1105	1105	2210	2	\N	\N	2018-07-05 07:52:56.311554
1107	t	1106	1106	2212	1	\N	\N	2018-07-05 07:52:56.311554
1108	t	1107	1107	2214	2	\N	\N	2018-07-05 07:52:56.311554
1109	t	1108	1108	2216	1	\N	\N	2018-07-05 07:52:56.311554
1110	t	1109	1109	2218	2	\N	\N	2018-07-05 07:52:56.311554
1111	t	1110	1110	2220	1	\N	\N	2018-07-05 07:52:56.311554
1112	t	1111	1111	2222	2	\N	\N	2018-07-05 07:52:56.311554
1113	t	1112	1112	2224	1	\N	\N	2018-07-05 07:52:56.311554
1114	t	1113	1113	2226	2	\N	\N	2018-07-05 07:52:56.311554
1115	t	1114	1114	2228	1	\N	\N	2018-07-05 07:52:56.311554
1116	t	1115	1115	2230	2	\N	\N	2018-07-05 07:52:56.311554
1117	t	1116	1116	2232	1	\N	\N	2018-07-05 07:52:56.311554
1118	t	1117	1117	2234	2	\N	\N	2018-07-05 07:52:56.311554
1119	t	1118	1118	2236	1	\N	\N	2018-07-05 07:52:56.311554
1120	t	1119	1119	2238	2	\N	\N	2018-07-05 07:52:56.311554
1121	t	1120	1120	2240	1	\N	\N	2018-07-05 07:52:56.311554
1122	t	1121	1121	2242	2	\N	\N	2018-07-05 07:52:56.311554
1123	t	1122	1122	2244	1	\N	\N	2018-07-05 07:52:56.311554
1124	t	1123	1123	2246	2	\N	\N	2018-07-05 07:52:56.311554
1125	t	1124	1124	2248	1	\N	\N	2018-07-05 07:52:56.311554
1126	t	1125	1125	2250	2	\N	\N	2018-07-05 07:52:56.311554
1127	t	1126	1126	2252	1	\N	\N	2018-07-05 07:52:56.311554
1128	t	1127	1127	2254	2	\N	\N	2018-07-05 07:52:56.311554
1129	t	1128	1128	2256	1	\N	\N	2018-07-05 07:52:56.311554
1130	t	1129	1129	2258	2	\N	\N	2018-07-05 07:52:56.311554
1131	t	1130	1130	2260	1	\N	\N	2018-07-05 07:52:56.311554
1132	t	1131	1131	2262	2	\N	\N	2018-07-05 07:52:56.311554
1133	t	1132	1132	2264	1	\N	\N	2018-07-05 07:52:56.311554
1134	t	1133	1133	2266	2	\N	\N	2018-07-05 07:52:56.311554
1135	t	1134	1134	2268	1	\N	\N	2018-07-05 07:52:56.311554
1136	t	1135	1135	2270	2	\N	\N	2018-07-05 07:52:56.311554
1137	t	1136	1136	2272	1	\N	\N	2018-07-05 07:52:56.311554
1138	t	1137	1137	2274	2	\N	\N	2018-07-05 07:52:56.311554
1139	t	1138	1138	2276	1	\N	\N	2018-07-05 07:52:56.311554
1140	t	1139	1139	2278	2	\N	\N	2018-07-05 07:52:56.311554
1141	t	1140	1140	2280	1	\N	\N	2018-07-05 07:52:56.311554
1142	t	1141	1141	2282	2	\N	\N	2018-07-05 07:52:56.311554
1143	t	1142	1142	2284	1	\N	\N	2018-07-05 07:52:56.311554
1144	t	1143	1143	2286	2	\N	\N	2018-07-05 07:52:56.311554
1145	t	1144	1144	2288	1	\N	\N	2018-07-05 07:52:56.311554
1146	t	1145	1145	2290	2	\N	\N	2018-07-05 07:52:56.311554
1147	t	1146	1146	2292	1	\N	\N	2018-07-05 07:52:56.311554
1148	t	1147	1147	2294	2	\N	\N	2018-07-05 07:52:56.311554
1149	t	1148	1148	2296	1	\N	\N	2018-07-05 07:52:56.311554
1150	t	1149	1149	2298	2	\N	\N	2018-07-05 07:52:56.311554
1151	t	1150	1150	2300	1	\N	\N	2018-07-05 07:52:56.311554
1152	t	1151	1151	2302	2	\N	\N	2018-07-05 07:52:56.311554
1153	t	1152	1152	2304	1	\N	\N	2018-07-05 07:52:56.311554
1154	t	1153	1153	2306	2	\N	\N	2018-07-05 07:52:56.311554
1155	t	1154	1154	2308	1	\N	\N	2018-07-05 07:52:56.311554
1156	t	1155	1155	2310	2	\N	\N	2018-07-05 07:52:56.311554
1157	t	1156	1156	2312	1	\N	\N	2018-07-05 07:52:56.311554
1158	t	1157	1157	2314	2	\N	\N	2018-07-05 07:52:56.311554
1159	t	1158	1158	2316	1	\N	\N	2018-07-05 07:52:56.311554
1160	t	1159	1159	2318	2	\N	\N	2018-07-05 07:52:56.311554
1161	t	1160	1160	2320	1	\N	\N	2018-07-05 07:52:56.311554
1162	t	1161	1161	2322	2	\N	\N	2018-07-05 07:52:56.311554
1163	t	1162	1162	2324	1	\N	\N	2018-07-05 07:52:56.311554
1164	t	1163	1163	2326	2	\N	\N	2018-07-05 07:52:56.311554
1165	t	1164	1164	2328	1	\N	\N	2018-07-05 07:52:56.311554
1166	t	1165	1165	2330	2	\N	\N	2018-07-05 07:52:56.311554
1167	t	1166	1166	2332	1	\N	\N	2018-07-05 07:52:56.311554
1168	t	1167	1167	2334	2	\N	\N	2018-07-05 07:52:56.311554
1169	t	1168	1168	2336	1	\N	\N	2018-07-05 07:52:56.311554
1170	t	1169	1169	2338	2	\N	\N	2018-07-05 07:52:56.311554
1171	t	1170	1170	2340	1	\N	\N	2018-07-05 07:52:56.311554
1172	t	1171	1171	2342	2	\N	\N	2018-07-05 07:52:56.311554
1173	t	1172	1172	2344	1	\N	\N	2018-07-05 07:52:56.311554
1174	t	1173	1173	2346	2	\N	\N	2018-07-05 07:52:56.311554
1175	t	1174	1174	2348	1	\N	\N	2018-07-05 07:52:56.311554
1176	t	1175	1175	2350	2	\N	\N	2018-07-05 07:52:56.311554
1177	t	1176	1176	2352	1	\N	\N	2018-07-05 07:52:56.311554
1178	t	1177	1177	2354	2	\N	\N	2018-07-05 07:52:56.311554
1179	t	1178	1178	2356	1	\N	\N	2018-07-05 07:52:56.311554
1180	t	1179	1179	2358	2	\N	\N	2018-07-05 07:52:56.311554
1181	t	1180	1180	2360	1	\N	\N	2018-07-05 07:52:56.311554
1182	t	1181	1181	2362	2	\N	\N	2018-07-05 07:52:56.311554
1183	t	1182	1182	2364	1	\N	\N	2018-07-05 07:52:56.311554
1184	t	1183	1183	2366	2	\N	\N	2018-07-05 07:52:56.311554
1185	t	1184	1184	2368	1	\N	\N	2018-07-05 07:52:56.311554
1186	t	1185	1185	2370	2	\N	\N	2018-07-05 07:52:56.311554
1187	t	1186	1186	2372	1	\N	\N	2018-07-05 07:52:56.311554
1188	t	1187	1187	2374	2	\N	\N	2018-07-05 07:52:56.311554
1189	t	1188	1188	2376	1	\N	\N	2018-07-05 07:52:56.311554
1190	t	1189	1189	2378	2	\N	\N	2018-07-05 07:52:56.311554
1191	t	1190	1190	2380	1	\N	\N	2018-07-05 07:52:56.311554
1192	t	1191	1191	2382	2	\N	\N	2018-07-05 07:52:56.311554
1193	t	1192	1192	2384	1	\N	\N	2018-07-05 07:52:56.311554
1194	t	1193	1193	2386	2	\N	\N	2018-07-05 07:52:56.311554
1195	t	1194	1194	2388	1	\N	\N	2018-07-05 07:52:56.311554
1196	t	1195	1195	2390	2	\N	\N	2018-07-05 07:52:56.311554
1197	t	1196	1196	2392	1	\N	\N	2018-07-05 07:52:56.311554
1198	t	1197	1197	2394	2	\N	\N	2018-07-05 07:52:56.311554
1199	t	1198	1198	2396	1	\N	\N	2018-07-05 07:52:56.311554
1200	t	1199	1199	2398	2	\N	\N	2018-07-05 07:52:56.311554
1201	t	1200	1200	2400	1	\N	\N	2018-07-05 07:52:56.311554
1202	t	1201	1201	2402	2	\N	\N	2018-07-05 07:52:56.311554
1203	t	1202	1202	2404	1	\N	\N	2018-07-05 07:52:56.311554
1204	t	1203	1203	2406	2	\N	\N	2018-07-05 07:52:56.311554
1205	t	1204	1204	2408	1	\N	\N	2018-07-05 07:52:56.311554
1206	t	1205	1205	2410	2	\N	\N	2018-07-05 07:52:56.311554
1207	t	1206	1206	2412	1	\N	\N	2018-07-05 07:52:56.311554
1208	t	1207	1207	2414	2	\N	\N	2018-07-05 07:52:56.311554
1209	t	1208	1208	2416	1	\N	\N	2018-07-05 07:52:56.311554
1210	t	1209	1209	2418	2	\N	\N	2018-07-05 07:52:56.311554
1211	t	1210	1210	2420	1	\N	\N	2018-07-05 07:52:56.311554
1212	t	1211	1211	2422	2	\N	\N	2018-07-05 07:52:56.311554
1213	t	1212	1212	2424	1	\N	\N	2018-07-05 07:52:56.311554
1214	t	1213	1213	2426	2	\N	\N	2018-07-05 07:52:56.311554
1215	t	1214	1214	2428	1	\N	\N	2018-07-05 07:52:56.311554
1216	t	1215	1215	2430	2	\N	\N	2018-07-05 07:52:56.311554
1217	t	1216	1216	2432	1	\N	\N	2018-07-05 07:52:56.311554
1218	t	1217	1217	2434	2	\N	\N	2018-07-05 07:52:56.311554
1219	t	1218	1218	2436	1	\N	\N	2018-07-05 07:52:56.311554
1220	t	1219	1219	2438	2	\N	\N	2018-07-05 07:52:56.311554
1221	t	1220	1220	2440	1	\N	\N	2018-07-05 07:52:56.311554
1222	t	1221	1221	2442	2	\N	\N	2018-07-05 07:52:56.311554
1223	t	1222	1222	2444	1	\N	\N	2018-07-05 07:52:56.311554
1224	t	1223	1223	2446	2	\N	\N	2018-07-05 07:52:56.311554
1225	t	1224	1224	2448	1	\N	\N	2018-07-05 07:52:56.311554
1226	t	1225	1225	2450	2	\N	\N	2018-07-05 07:52:56.311554
1227	t	1226	1226	2452	1	\N	\N	2018-07-05 07:52:56.311554
1228	t	1227	1227	2454	2	\N	\N	2018-07-05 07:52:56.311554
1229	t	1228	1228	2456	1	\N	\N	2018-07-05 07:52:56.311554
1230	t	1229	1229	2458	2	\N	\N	2018-07-05 07:52:56.311554
1231	t	1230	1230	2460	1	\N	\N	2018-07-05 07:52:56.311554
1232	t	1231	1231	2462	2	\N	\N	2018-07-05 07:52:56.311554
1233	t	1232	1232	2464	1	\N	\N	2018-07-05 07:52:56.311554
1234	t	1233	1233	2466	2	\N	\N	2018-07-05 07:52:56.311554
1235	t	1234	1234	2468	1	\N	\N	2018-07-05 07:52:56.311554
1236	t	1235	1235	2470	2	\N	\N	2018-07-05 07:52:56.311554
1237	t	1236	1236	2472	1	\N	\N	2018-07-05 07:52:56.311554
1238	t	1237	1237	2474	2	\N	\N	2018-07-05 07:52:56.311554
1239	t	1238	1238	2476	1	\N	\N	2018-07-05 07:52:56.311554
1240	t	1239	1239	2478	2	\N	\N	2018-07-05 07:52:56.311554
1241	t	1240	1240	2480	1	\N	\N	2018-07-05 07:52:56.311554
1242	t	1241	1241	2482	2	\N	\N	2018-07-05 07:52:56.311554
1243	t	1242	1242	2484	1	\N	\N	2018-07-05 07:52:56.311554
1244	t	1243	1243	2486	2	\N	\N	2018-07-05 07:52:56.311554
1245	t	1244	1244	2488	1	\N	\N	2018-07-05 07:52:56.311554
1246	t	1245	1245	2490	2	\N	\N	2018-07-05 07:52:56.311554
1247	t	1246	1246	2492	1	\N	\N	2018-07-05 07:52:56.311554
1248	t	1247	1247	2494	2	\N	\N	2018-07-05 07:52:56.311554
1249	t	1248	1248	2496	1	\N	\N	2018-07-05 07:52:56.311554
1250	t	1249	1249	2498	2	\N	\N	2018-07-05 07:52:56.311554
1251	t	1250	1250	2500	1	\N	\N	2018-07-05 07:52:56.311554
1252	t	1251	1251	2502	2	\N	\N	2018-07-05 07:52:56.311554
1253	t	1252	1252	2504	1	\N	\N	2018-07-05 07:52:56.311554
1254	t	1253	1253	2506	2	\N	\N	2018-07-05 07:52:56.311554
1255	t	1254	1254	2508	1	\N	\N	2018-07-05 07:52:56.311554
1256	t	1255	1255	2510	2	\N	\N	2018-07-05 07:52:56.311554
1257	t	1256	1256	2512	1	\N	\N	2018-07-05 07:52:56.311554
1258	t	1257	1257	2514	2	\N	\N	2018-07-05 07:52:56.311554
1259	t	1258	1258	2516	1	\N	\N	2018-07-05 07:52:56.311554
1260	t	1259	1259	2518	2	\N	\N	2018-07-05 07:52:56.311554
1261	t	1260	1260	2520	1	\N	\N	2018-07-05 07:52:56.311554
1262	t	1261	1261	2522	2	\N	\N	2018-07-05 07:52:56.311554
1263	t	1262	1262	2524	1	\N	\N	2018-07-05 07:52:56.311554
1264	t	1263	1263	2526	2	\N	\N	2018-07-05 07:52:56.311554
1265	t	1264	1264	2528	1	\N	\N	2018-07-05 07:52:56.311554
1266	t	1265	1265	2530	2	\N	\N	2018-07-05 07:52:56.311554
1267	t	1266	1266	2532	1	\N	\N	2018-07-05 07:52:56.311554
1268	t	1267	1267	2534	2	\N	\N	2018-07-05 07:52:56.311554
1269	t	1268	1268	2536	1	\N	\N	2018-07-05 07:52:56.311554
1270	t	1269	1269	2538	2	\N	\N	2018-07-05 07:52:56.311554
1271	t	1270	1270	2540	1	\N	\N	2018-07-05 07:52:56.311554
1272	t	1271	1271	2542	2	\N	\N	2018-07-05 07:52:56.311554
1273	t	1272	1272	2544	1	\N	\N	2018-07-05 07:52:56.311554
1274	t	1273	1273	2546	2	\N	\N	2018-07-05 07:52:56.311554
1275	t	1274	1274	2548	1	\N	\N	2018-07-05 07:52:56.311554
1276	t	1275	1275	2550	2	\N	\N	2018-07-05 07:52:56.311554
1277	t	1276	1276	2552	1	\N	\N	2018-07-05 07:52:56.311554
1278	t	1277	1277	2554	2	\N	\N	2018-07-05 07:52:56.311554
1279	t	1278	1278	2556	1	\N	\N	2018-07-05 07:52:56.311554
1280	t	1279	1279	2558	2	\N	\N	2018-07-05 07:52:56.311554
1281	t	1280	1280	2560	1	\N	\N	2018-07-05 07:52:56.311554
1282	t	1281	1281	2562	2	\N	\N	2018-07-05 07:52:56.311554
1283	t	1282	1282	2564	1	\N	\N	2018-07-05 07:52:56.311554
1284	t	1283	1283	2566	2	\N	\N	2018-07-05 07:52:56.311554
1285	t	1284	1284	2568	1	\N	\N	2018-07-05 07:52:56.311554
1286	t	1285	1285	2570	2	\N	\N	2018-07-05 07:52:56.311554
1287	t	1286	1286	2572	1	\N	\N	2018-07-05 07:52:56.311554
1288	t	1287	1287	2574	2	\N	\N	2018-07-05 07:52:56.311554
1289	t	1288	1288	2576	1	\N	\N	2018-07-05 07:52:56.311554
1290	t	1289	1289	2578	2	\N	\N	2018-07-05 07:52:56.311554
1291	t	1290	1290	2580	1	\N	\N	2018-07-05 07:52:56.311554
1292	t	1291	1291	2582	2	\N	\N	2018-07-05 07:52:56.311554
1293	t	1292	1292	2584	1	\N	\N	2018-07-05 07:52:56.311554
1294	t	1293	1293	2586	2	\N	\N	2018-07-05 07:52:56.311554
1295	t	1294	1294	2588	1	\N	\N	2018-07-05 07:52:56.311554
1296	t	1295	1295	2590	2	\N	\N	2018-07-05 07:52:56.311554
1297	t	1296	1296	2592	1	\N	\N	2018-07-05 07:52:56.311554
1298	t	1297	1297	2594	2	\N	\N	2018-07-05 07:52:56.311554
1299	t	1298	1298	2596	1	\N	\N	2018-07-05 07:52:56.311554
1300	t	1299	1299	2598	2	\N	\N	2018-07-05 07:52:56.311554
1301	t	1300	1300	2600	1	\N	\N	2018-07-05 07:52:56.311554
1302	t	1301	1301	2602	2	\N	\N	2018-07-05 07:52:56.311554
1303	t	1302	1302	2604	1	\N	\N	2018-07-05 07:52:56.311554
1304	t	1303	1303	2606	2	\N	\N	2018-07-05 07:52:56.311554
1305	t	1304	1304	2608	1	\N	\N	2018-07-05 07:52:56.311554
1306	t	1305	1305	2610	2	\N	\N	2018-07-05 07:52:56.311554
1307	t	1306	1306	2612	1	\N	\N	2018-07-05 07:52:56.311554
1308	t	1307	1307	2614	2	\N	\N	2018-07-05 07:52:56.311554
1309	t	1308	1308	2616	1	\N	\N	2018-07-05 07:52:56.311554
1310	t	1309	1309	2618	2	\N	\N	2018-07-05 07:52:56.311554
1311	t	1310	1310	2620	1	\N	\N	2018-07-05 07:52:56.311554
1312	t	1311	1311	2622	2	\N	\N	2018-07-05 07:52:56.311554
1313	t	1312	1312	2624	1	\N	\N	2018-07-05 07:52:56.311554
1314	t	1313	1313	2626	2	\N	\N	2018-07-05 07:52:56.311554
1315	t	1314	1314	2628	1	\N	\N	2018-07-05 07:52:56.311554
1316	t	1315	1315	2630	2	\N	\N	2018-07-05 07:52:56.311554
1317	t	1316	1316	2632	1	\N	\N	2018-07-05 07:52:56.311554
1318	t	1317	1317	2634	2	\N	\N	2018-07-05 07:52:56.311554
1319	t	1318	1318	2636	1	\N	\N	2018-07-05 07:52:56.311554
1320	t	1319	1319	2638	2	\N	\N	2018-07-05 07:52:56.311554
1321	t	1320	1320	2640	1	\N	\N	2018-07-05 07:52:56.311554
1322	t	1321	1321	2642	2	\N	\N	2018-07-05 07:52:56.311554
1323	t	1322	1322	2644	1	\N	\N	2018-07-05 07:52:56.311554
1324	t	1323	1323	2646	2	\N	\N	2018-07-05 07:52:56.311554
1325	t	1324	1324	2648	1	\N	\N	2018-07-05 07:52:56.311554
1326	t	1325	1325	2650	2	\N	\N	2018-07-05 07:52:56.311554
1327	t	1326	1326	2652	1	\N	\N	2018-07-05 07:52:56.311554
1328	t	1327	1327	2654	2	\N	\N	2018-07-05 07:52:56.311554
1329	t	1328	1328	2656	1	\N	\N	2018-07-05 07:52:56.311554
1330	t	1329	1329	2658	2	\N	\N	2018-07-05 07:52:56.311554
1331	t	1330	1330	2660	1	\N	\N	2018-07-05 07:52:56.311554
1332	t	1331	1331	2662	2	\N	\N	2018-07-05 07:52:56.311554
1333	t	1332	1332	2664	1	\N	\N	2018-07-05 07:52:56.311554
1334	t	1333	1333	2666	2	\N	\N	2018-07-05 07:52:56.311554
1335	t	1334	1334	2668	1	\N	\N	2018-07-05 07:52:56.311554
1336	t	1335	1335	2670	2	\N	\N	2018-07-05 07:52:56.311554
1337	t	1336	1336	2672	1	\N	\N	2018-07-05 07:52:56.311554
1338	t	1337	1337	2674	2	\N	\N	2018-07-05 07:52:56.311554
1339	t	1338	1338	2676	1	\N	\N	2018-07-05 07:52:56.311554
1340	t	1339	1339	2678	2	\N	\N	2018-07-05 07:52:56.311554
1341	t	1340	1340	2680	1	\N	\N	2018-07-05 07:52:56.311554
1342	t	1341	1341	2682	2	\N	\N	2018-07-05 07:52:56.311554
1343	t	1342	1342	2684	1	\N	\N	2018-07-05 07:52:56.311554
1344	t	1343	1343	2686	2	\N	\N	2018-07-05 07:52:56.311554
1345	t	1344	1344	2688	1	\N	\N	2018-07-05 07:52:56.311554
1346	t	1345	1345	2690	2	\N	\N	2018-07-05 07:52:56.311554
1347	t	1346	1346	2692	1	\N	\N	2018-07-05 07:52:56.311554
1348	t	1347	1347	2694	2	\N	\N	2018-07-05 07:52:56.311554
1349	t	1348	1348	2696	1	\N	\N	2018-07-05 07:52:56.311554
1350	t	1349	1349	2698	2	\N	\N	2018-07-05 07:52:56.311554
1351	t	1350	1350	2700	1	\N	\N	2018-07-05 07:52:56.311554
1352	t	1351	1351	2702	2	\N	\N	2018-07-05 07:52:56.311554
1353	t	1352	1352	2704	1	\N	\N	2018-07-05 07:52:56.311554
1354	t	1353	1353	2706	2	\N	\N	2018-07-05 07:52:56.311554
1355	t	1354	1354	2708	1	\N	\N	2018-07-05 07:52:56.311554
1356	t	1355	1355	2710	2	\N	\N	2018-07-05 07:52:56.311554
1357	t	1356	1356	2712	1	\N	\N	2018-07-05 07:52:56.311554
1358	t	1357	1357	2714	2	\N	\N	2018-07-05 07:52:56.311554
1359	t	1358	1358	2716	1	\N	\N	2018-07-05 07:52:56.311554
1360	t	1359	1359	2718	2	\N	\N	2018-07-05 07:52:56.311554
1361	t	1360	1360	2720	1	\N	\N	2018-07-05 07:52:56.311554
1362	t	1361	1361	2722	2	\N	\N	2018-07-05 07:52:56.311554
1363	t	1362	1362	2724	1	\N	\N	2018-07-05 07:52:56.311554
1364	t	1363	1363	2726	2	\N	\N	2018-07-05 07:52:56.311554
1365	t	1364	1364	2728	1	\N	\N	2018-07-05 07:52:56.311554
1366	t	1365	1365	2730	2	\N	\N	2018-07-05 07:52:56.311554
1367	t	1366	1366	2732	1	\N	\N	2018-07-05 07:52:56.311554
1368	t	1367	1367	2734	2	\N	\N	2018-07-05 07:52:56.311554
1369	t	1368	1368	2736	1	\N	\N	2018-07-05 07:52:56.311554
1370	t	1369	1369	2738	2	\N	\N	2018-07-05 07:52:56.311554
1371	t	1370	1370	2740	1	\N	\N	2018-07-05 07:52:56.311554
1372	t	1371	1371	2742	2	\N	\N	2018-07-05 07:52:56.311554
1373	t	1372	1372	2744	1	\N	\N	2018-07-05 07:52:56.311554
1374	t	1373	1373	2746	2	\N	\N	2018-07-05 07:52:56.311554
1375	t	1374	1374	2748	1	\N	\N	2018-07-05 07:52:56.311554
1376	t	1375	1375	2750	2	\N	\N	2018-07-05 07:52:56.311554
1377	t	1376	1376	2752	1	\N	\N	2018-07-05 07:52:56.311554
1378	t	1377	1377	2754	2	\N	\N	2018-07-05 07:52:56.311554
1379	t	1378	1378	2756	1	\N	\N	2018-07-05 07:52:56.311554
1380	t	1379	1379	2758	2	\N	\N	2018-07-05 07:52:56.311554
1381	t	1380	1380	2760	1	\N	\N	2018-07-05 07:52:56.311554
1382	t	1381	1381	2762	2	\N	\N	2018-07-05 07:52:56.311554
1383	t	1382	1382	2764	1	\N	\N	2018-07-05 07:52:56.311554
1384	t	1383	1383	2766	2	\N	\N	2018-07-05 07:52:56.311554
1385	t	1384	1384	2768	1	\N	\N	2018-07-05 07:52:56.311554
1386	t	1385	1385	2770	2	\N	\N	2018-07-05 07:52:56.311554
1387	t	1386	1386	2772	1	\N	\N	2018-07-05 07:52:56.311554
1388	t	1387	1387	2774	2	\N	\N	2018-07-05 07:52:56.311554
1389	t	1388	1388	2776	1	\N	\N	2018-07-05 07:52:56.311554
1390	t	1389	1389	2778	2	\N	\N	2018-07-05 07:52:56.311554
1391	t	1390	1390	2780	1	\N	\N	2018-07-05 07:52:56.311554
1392	t	1391	1391	2782	2	\N	\N	2018-07-05 07:52:56.311554
1393	t	1392	1392	2784	1	\N	\N	2018-07-05 07:52:56.311554
1394	t	1393	1393	2786	2	\N	\N	2018-07-05 07:52:56.311554
1395	t	1394	1394	2788	1	\N	\N	2018-07-05 07:52:56.311554
1396	t	1395	1395	2790	2	\N	\N	2018-07-05 07:52:56.311554
1397	t	1396	1396	2792	1	\N	\N	2018-07-05 07:52:56.311554
1398	t	1397	1397	2794	2	\N	\N	2018-07-05 07:52:56.311554
1399	t	1398	1398	2796	1	\N	\N	2018-07-05 07:52:56.311554
1400	t	1399	1399	2798	2	\N	\N	2018-07-05 07:52:56.311554
1401	t	1400	1400	2800	1	\N	\N	2018-07-05 07:52:56.311554
1402	t	1401	1401	2802	2	\N	\N	2018-07-05 07:52:56.311554
1403	t	1402	1402	2804	1	\N	\N	2018-07-05 07:52:56.311554
1404	t	1403	1403	2806	2	\N	\N	2018-07-05 07:52:56.311554
1405	t	1404	1404	2808	1	\N	\N	2018-07-05 07:52:56.311554
1406	t	1405	1405	2810	2	\N	\N	2018-07-05 07:52:56.311554
1407	t	1406	1406	2812	1	\N	\N	2018-07-05 07:52:56.311554
1408	t	1407	1407	2814	2	\N	\N	2018-07-05 07:52:56.311554
1409	t	1408	1408	2816	1	\N	\N	2018-07-05 07:52:56.311554
1410	t	1409	1409	2818	2	\N	\N	2018-07-05 07:52:56.311554
1411	t	1410	1410	2820	1	\N	\N	2018-07-05 07:52:56.311554
1412	t	1411	1411	2822	2	\N	\N	2018-07-05 07:52:56.311554
1413	t	1412	1412	2824	1	\N	\N	2018-07-05 07:52:56.311554
1414	t	1413	1413	2826	2	\N	\N	2018-07-05 07:52:56.311554
1415	t	1414	1414	2828	1	\N	\N	2018-07-05 07:52:56.311554
1416	t	1415	1415	2830	2	\N	\N	2018-07-05 07:52:56.311554
1417	t	1416	1416	2832	1	\N	\N	2018-07-05 07:52:56.311554
1418	t	1417	1417	2834	2	\N	\N	2018-07-05 07:52:56.311554
1419	t	1418	1418	2836	1	\N	\N	2018-07-05 07:52:56.311554
1420	t	1419	1419	2838	2	\N	\N	2018-07-05 07:52:56.311554
1421	t	1420	1420	2840	1	\N	\N	2018-07-05 07:52:56.311554
1422	t	1421	1421	2842	2	\N	\N	2018-07-05 07:52:56.311554
1423	t	1422	1422	2844	1	\N	\N	2018-07-05 07:52:56.311554
1424	t	1423	1423	2846	2	\N	\N	2018-07-05 07:52:56.311554
1425	t	1424	1424	2848	1	\N	\N	2018-07-05 07:52:56.311554
1426	t	1425	1425	2850	2	\N	\N	2018-07-05 07:52:56.311554
1427	t	1426	1426	2852	1	\N	\N	2018-07-05 07:52:56.311554
1428	t	1427	1427	2854	2	\N	\N	2018-07-05 07:52:56.311554
1429	t	1428	1428	2856	1	\N	\N	2018-07-05 07:52:56.311554
1430	t	1429	1429	2858	2	\N	\N	2018-07-05 07:52:56.311554
1431	t	1430	1430	2860	1	\N	\N	2018-07-05 07:52:56.311554
1432	t	1431	1431	2862	2	\N	\N	2018-07-05 07:52:56.311554
1433	t	1432	1432	2864	1	\N	\N	2018-07-05 07:52:56.311554
1434	t	1433	1433	2866	2	\N	\N	2018-07-05 07:52:56.311554
1435	t	1434	1434	2868	1	\N	\N	2018-07-05 07:52:56.311554
1436	t	1435	1435	2870	2	\N	\N	2018-07-05 07:52:56.311554
1437	t	1436	1436	2872	1	\N	\N	2018-07-05 07:52:56.311554
1438	t	1437	1437	2874	2	\N	\N	2018-07-05 07:52:56.311554
1439	t	1438	1438	2876	1	\N	\N	2018-07-05 07:52:56.311554
1440	t	1439	1439	2878	2	\N	\N	2018-07-05 07:52:56.311554
1441	t	1440	1440	2880	1	\N	\N	2018-07-05 07:52:56.311554
1442	t	1441	1441	2882	2	\N	\N	2018-07-05 07:52:56.311554
1443	t	1442	1442	2884	1	\N	\N	2018-07-05 07:52:56.311554
1444	t	1443	1443	2886	2	\N	\N	2018-07-05 07:52:56.311554
1445	t	1444	1444	2888	1	\N	\N	2018-07-05 07:52:56.311554
1446	t	1445	1445	2890	2	\N	\N	2018-07-05 07:52:56.311554
1447	t	1446	1446	2892	1	\N	\N	2018-07-05 07:52:56.311554
1448	t	1447	1447	2894	2	\N	\N	2018-07-05 07:52:56.311554
1449	t	1448	1448	2896	1	\N	\N	2018-07-05 07:52:56.311554
1450	t	1449	1449	2898	2	\N	\N	2018-07-05 07:52:56.311554
1451	t	1450	1450	2900	1	\N	\N	2018-07-05 07:52:56.311554
1452	t	1451	1451	2902	2	\N	\N	2018-07-05 07:52:56.311554
1453	t	1452	1452	2904	1	\N	\N	2018-07-05 07:52:56.311554
1454	t	1453	1453	2906	2	\N	\N	2018-07-05 07:52:56.311554
1455	t	1454	1454	2908	1	\N	\N	2018-07-05 07:52:56.311554
1456	t	1455	1455	2910	2	\N	\N	2018-07-05 07:52:56.311554
1457	t	1456	1456	2912	1	\N	\N	2018-07-05 07:52:56.311554
1458	t	1457	1457	2914	2	\N	\N	2018-07-05 07:52:56.311554
1459	t	1458	1458	2916	1	\N	\N	2018-07-05 07:52:56.311554
1460	t	1459	1459	2918	2	\N	\N	2018-07-05 07:52:56.311554
1461	t	1460	1460	2920	1	\N	\N	2018-07-05 07:52:56.311554
1462	t	1461	1461	2922	2	\N	\N	2018-07-05 07:52:56.311554
1463	t	1462	1462	2924	1	\N	\N	2018-07-05 07:52:56.311554
1464	t	1463	1463	2926	2	\N	\N	2018-07-05 07:52:56.311554
1465	t	1464	1464	2928	1	\N	\N	2018-07-05 07:52:56.311554
1466	t	1465	1465	2930	2	\N	\N	2018-07-05 07:52:56.311554
1467	t	1466	1466	2932	1	\N	\N	2018-07-05 07:52:56.311554
1468	t	1467	1467	2934	2	\N	\N	2018-07-05 07:52:56.311554
1469	t	1468	1468	2936	1	\N	\N	2018-07-05 07:52:56.311554
1470	t	1469	1469	2938	2	\N	\N	2018-07-05 07:52:56.311554
1471	t	1470	1470	2940	1	\N	\N	2018-07-05 07:52:56.311554
1472	t	1471	1471	2942	2	\N	\N	2018-07-05 07:52:56.311554
1473	t	1472	1472	2944	1	\N	\N	2018-07-05 07:52:56.311554
1474	t	1473	1473	2946	2	\N	\N	2018-07-05 07:52:56.311554
1475	t	1474	1474	2948	1	\N	\N	2018-07-05 07:52:56.311554
1476	t	1475	1475	2950	2	\N	\N	2018-07-05 07:52:56.311554
1477	t	1476	1476	2952	1	\N	\N	2018-07-05 07:52:56.311554
1478	t	1477	1477	2954	2	\N	\N	2018-07-05 07:52:56.311554
1479	t	1478	1478	2956	1	\N	\N	2018-07-05 07:52:56.311554
1480	t	1479	1479	2958	2	\N	\N	2018-07-05 07:52:56.311554
1481	t	1480	1480	2960	1	\N	\N	2018-07-05 07:52:56.311554
1482	t	1481	1481	2962	2	\N	\N	2018-07-05 07:52:56.311554
1483	t	1482	1482	2964	1	\N	\N	2018-07-05 07:52:56.311554
1484	t	1483	1483	2966	2	\N	\N	2018-07-05 07:52:56.311554
1485	t	1484	1484	2968	1	\N	\N	2018-07-05 07:52:56.311554
1486	t	1485	1485	2970	2	\N	\N	2018-07-05 07:52:56.311554
1487	t	1486	1486	2972	1	\N	\N	2018-07-05 07:52:56.311554
1488	t	1487	1487	2974	2	\N	\N	2018-07-05 07:52:56.311554
1489	t	1488	1488	2976	1	\N	\N	2018-07-05 07:52:56.311554
1490	t	1489	1489	2978	2	\N	\N	2018-07-05 07:52:56.311554
1491	t	1490	1490	2980	1	\N	\N	2018-07-05 07:52:56.311554
1492	t	1491	1491	2982	2	\N	\N	2018-07-05 07:52:56.311554
1493	t	1492	1492	2984	1	\N	\N	2018-07-05 07:52:56.311554
1494	t	1493	1493	2986	2	\N	\N	2018-07-05 07:52:56.311554
1495	t	1494	1494	2988	1	\N	\N	2018-07-05 07:52:56.311554
1496	t	1495	1495	2990	2	\N	\N	2018-07-05 07:52:56.311554
1497	t	1496	1496	2992	1	\N	\N	2018-07-05 07:52:56.311554
1498	t	1497	1497	2994	2	\N	\N	2018-07-05 07:52:56.311554
1499	t	1498	1498	2996	1	\N	\N	2018-07-05 07:52:56.311554
1500	t	1499	1499	2998	2	\N	\N	2018-07-05 07:52:56.311554
1501	t	1500	1500	3000	1	\N	\N	2018-07-05 07:52:56.311554
1502	t	1501	1501	3002	2	\N	\N	2018-07-05 07:52:56.311554
1503	t	1502	1502	3004	1	\N	\N	2018-07-05 07:52:56.311554
1504	t	1503	1503	3006	2	\N	\N	2018-07-05 07:52:56.311554
1505	t	1504	1504	3008	1	\N	\N	2018-07-05 07:52:56.311554
1506	t	1505	1505	3010	2	\N	\N	2018-07-05 07:52:56.311554
1507	t	1506	1506	3012	1	\N	\N	2018-07-05 07:52:56.311554
1508	t	1507	1507	3014	2	\N	\N	2018-07-05 07:52:56.311554
1509	t	1508	1508	3016	1	\N	\N	2018-07-05 07:52:56.311554
1510	t	1509	1509	3018	2	\N	\N	2018-07-05 07:52:56.311554
1511	t	1510	1510	3020	1	\N	\N	2018-07-05 07:52:56.311554
1512	t	1511	1511	3022	2	\N	\N	2018-07-05 07:52:56.311554
1513	t	1512	1512	3024	1	\N	\N	2018-07-05 07:52:56.311554
1514	t	1513	1513	3026	2	\N	\N	2018-07-05 07:52:56.311554
1515	t	1514	1514	3028	1	\N	\N	2018-07-05 07:52:56.311554
1516	t	1515	1515	3030	2	\N	\N	2018-07-05 07:52:56.311554
1517	t	1516	1516	3032	1	\N	\N	2018-07-05 07:52:56.311554
1518	t	1517	1517	3034	2	\N	\N	2018-07-05 07:52:56.311554
1519	t	1518	1518	3036	1	\N	\N	2018-07-05 07:52:56.311554
1520	t	1519	1519	3038	2	\N	\N	2018-07-05 07:52:56.311554
1521	t	1520	1520	3040	1	\N	\N	2018-07-05 07:52:56.311554
1522	t	1521	1521	3042	2	\N	\N	2018-07-05 07:52:56.311554
1523	t	1522	1522	3044	1	\N	\N	2018-07-05 07:52:56.311554
1524	t	1523	1523	3046	2	\N	\N	2018-07-05 07:52:56.311554
1525	t	1524	1524	3048	1	\N	\N	2018-07-05 07:52:56.311554
1526	t	1525	1525	3050	2	\N	\N	2018-07-05 07:52:56.311554
1527	t	1526	1526	3052	1	\N	\N	2018-07-05 07:52:56.311554
1528	t	1527	1527	3054	2	\N	\N	2018-07-05 07:52:56.311554
1529	t	1528	1528	3056	1	\N	\N	2018-07-05 07:52:56.311554
1530	t	1529	1529	3058	2	\N	\N	2018-07-05 07:52:56.311554
1531	t	1530	1530	3060	1	\N	\N	2018-07-05 07:52:56.311554
1532	t	1531	1531	3062	2	\N	\N	2018-07-05 07:52:56.311554
1533	t	1532	1532	3064	1	\N	\N	2018-07-05 07:52:56.311554
1534	t	1533	1533	3066	2	\N	\N	2018-07-05 07:52:56.311554
1535	t	1534	1534	3068	1	\N	\N	2018-07-05 07:52:56.311554
1536	t	1535	1535	3070	2	\N	\N	2018-07-05 07:52:56.311554
1537	t	1536	1536	3072	1	\N	\N	2018-07-05 07:52:56.311554
1538	t	1537	1537	3074	2	\N	\N	2018-07-05 07:52:56.311554
1539	t	1538	1538	3076	1	\N	\N	2018-07-05 07:52:56.311554
1540	t	1539	1539	3078	2	\N	\N	2018-07-05 07:52:56.311554
1541	t	1540	1540	3080	1	\N	\N	2018-07-05 07:52:56.311554
1542	t	1541	1541	3082	2	\N	\N	2018-07-05 07:52:56.311554
1543	t	1542	1542	3084	1	\N	\N	2018-07-05 07:52:56.311554
1544	t	1543	1543	3086	2	\N	\N	2018-07-05 07:52:56.311554
1545	t	1544	1544	3088	1	\N	\N	2018-07-05 07:52:56.311554
1546	t	1545	1545	3090	2	\N	\N	2018-07-05 07:52:56.311554
1547	t	1546	1546	3092	1	\N	\N	2018-07-05 07:52:56.311554
1548	t	1547	1547	3094	2	\N	\N	2018-07-05 07:52:56.311554
1549	t	1548	1548	3096	1	\N	\N	2018-07-05 07:52:56.311554
1550	t	1549	1549	3098	2	\N	\N	2018-07-05 07:52:56.311554
1551	t	1550	1550	3100	1	\N	\N	2018-07-05 07:52:56.311554
1552	t	1551	1551	3102	2	\N	\N	2018-07-05 07:52:56.311554
1553	t	1552	1552	3104	1	\N	\N	2018-07-05 07:52:56.311554
1554	t	1553	1553	3106	2	\N	\N	2018-07-05 07:52:56.311554
1555	t	1554	1554	3108	1	\N	\N	2018-07-05 07:52:56.311554
1556	t	1555	1555	3110	2	\N	\N	2018-07-05 07:52:56.311554
1557	t	1556	1556	3112	1	\N	\N	2018-07-05 07:52:56.311554
1558	t	1557	1557	3114	2	\N	\N	2018-07-05 07:52:56.311554
1559	t	1558	1558	3116	1	\N	\N	2018-07-05 07:52:56.311554
1560	t	1559	1559	3118	2	\N	\N	2018-07-05 07:52:56.311554
1561	t	1560	1560	3120	1	\N	\N	2018-07-05 07:52:56.311554
1562	t	1561	1561	3122	2	\N	\N	2018-07-05 07:52:56.311554
1563	t	1562	1562	3124	1	\N	\N	2018-07-05 07:52:56.311554
1564	t	1563	1563	3126	2	\N	\N	2018-07-05 07:52:56.311554
1565	t	1564	1564	3128	1	\N	\N	2018-07-05 07:52:56.311554
1566	t	1565	1565	3130	2	\N	\N	2018-07-05 07:52:56.311554
1567	t	1566	1566	3132	1	\N	\N	2018-07-05 07:52:56.311554
1568	t	1567	1567	3134	2	\N	\N	2018-07-05 07:52:56.311554
1569	t	1568	1568	3136	1	\N	\N	2018-07-05 07:52:56.311554
1570	t	1569	1569	3138	2	\N	\N	2018-07-05 07:52:56.311554
1571	t	1570	1570	3140	1	\N	\N	2018-07-05 07:52:56.311554
1572	t	1571	1571	3142	2	\N	\N	2018-07-05 07:52:56.311554
1573	t	1572	1572	3144	1	\N	\N	2018-07-05 07:52:56.311554
1574	t	1573	1573	3146	2	\N	\N	2018-07-05 07:52:56.311554
1575	t	1574	1574	3148	1	\N	\N	2018-07-05 07:52:56.311554
1576	t	1575	1575	3150	2	\N	\N	2018-07-05 07:52:56.311554
1577	t	1576	1576	3152	1	\N	\N	2018-07-05 07:52:56.311554
1578	t	1577	1577	3154	2	\N	\N	2018-07-05 07:52:56.311554
1579	t	1578	1578	3156	1	\N	\N	2018-07-05 07:52:56.311554
1580	t	1579	1579	3158	2	\N	\N	2018-07-05 07:52:56.311554
1581	t	1580	1580	3160	1	\N	\N	2018-07-05 07:52:56.311554
1582	t	1581	1581	3162	2	\N	\N	2018-07-05 07:52:56.311554
1583	t	1582	1582	3164	1	\N	\N	2018-07-05 07:52:56.311554
1584	t	1583	1583	3166	2	\N	\N	2018-07-05 07:52:56.311554
1585	t	1584	1584	3168	1	\N	\N	2018-07-05 07:52:56.311554
1586	t	1585	1585	3170	2	\N	\N	2018-07-05 07:52:56.311554
1587	t	1586	1586	3172	1	\N	\N	2018-07-05 07:52:56.311554
1588	t	1587	1587	3174	2	\N	\N	2018-07-05 07:52:56.311554
1589	t	1588	1588	3176	1	\N	\N	2018-07-05 07:52:56.311554
1590	t	1589	1589	3178	2	\N	\N	2018-07-05 07:52:56.311554
1591	t	1590	1590	3180	1	\N	\N	2018-07-05 07:52:56.311554
1592	t	1591	1591	3182	2	\N	\N	2018-07-05 07:52:56.311554
1593	t	1592	1592	3184	1	\N	\N	2018-07-05 07:52:56.311554
1594	t	1593	1593	3186	2	\N	\N	2018-07-05 07:52:56.311554
1595	t	1594	1594	3188	1	\N	\N	2018-07-05 07:52:56.311554
1596	t	1595	1595	3190	2	\N	\N	2018-07-05 07:52:56.311554
1597	t	1596	1596	3192	1	\N	\N	2018-07-05 07:52:56.311554
1598	t	1597	1597	3194	2	\N	\N	2018-07-05 07:52:56.311554
1599	t	1598	1598	3196	1	\N	\N	2018-07-05 07:52:56.311554
1600	t	1599	1599	3198	2	\N	\N	2018-07-05 07:52:56.311554
1601	t	1600	1600	3200	1	\N	\N	2018-07-05 07:52:56.311554
1602	t	1601	1601	3202	2	\N	\N	2018-07-05 07:52:56.311554
1603	t	1602	1602	3204	1	\N	\N	2018-07-05 07:52:56.311554
1604	t	1603	1603	3206	2	\N	\N	2018-07-05 07:52:56.311554
1605	t	1604	1604	3208	1	\N	\N	2018-07-05 07:52:56.311554
1606	t	1605	1605	3210	2	\N	\N	2018-07-05 07:52:56.311554
1607	t	1606	1606	3212	1	\N	\N	2018-07-05 07:52:56.311554
1608	t	1607	1607	3214	2	\N	\N	2018-07-05 07:52:56.311554
1609	t	1608	1608	3216	1	\N	\N	2018-07-05 07:52:56.311554
1610	t	1609	1609	3218	2	\N	\N	2018-07-05 07:52:56.311554
1611	t	1610	1610	3220	1	\N	\N	2018-07-05 07:52:56.311554
1612	t	1611	1611	3222	2	\N	\N	2018-07-05 07:52:56.311554
1613	t	1612	1612	3224	1	\N	\N	2018-07-05 07:52:56.311554
1614	t	1613	1613	3226	2	\N	\N	2018-07-05 07:52:56.311554
1615	t	1614	1614	3228	1	\N	\N	2018-07-05 07:52:56.311554
1616	t	1615	1615	3230	2	\N	\N	2018-07-05 07:52:56.311554
1617	t	1616	1616	3232	1	\N	\N	2018-07-05 07:52:56.311554
1618	t	1617	1617	3234	2	\N	\N	2018-07-05 07:52:56.311554
1619	t	1618	1618	3236	1	\N	\N	2018-07-05 07:52:56.311554
1620	t	1619	1619	3238	2	\N	\N	2018-07-05 07:52:56.311554
1621	t	1620	1620	3240	1	\N	\N	2018-07-05 07:52:56.311554
1622	t	1621	1621	3242	2	\N	\N	2018-07-05 07:52:56.311554
1623	t	1622	1622	3244	1	\N	\N	2018-07-05 07:52:56.311554
1624	t	1623	1623	3246	2	\N	\N	2018-07-05 07:52:56.311554
1625	t	1624	1624	3248	1	\N	\N	2018-07-05 07:52:56.311554
1626	t	1625	1625	3250	2	\N	\N	2018-07-05 07:52:56.311554
1627	t	1626	1626	3252	1	\N	\N	2018-07-05 07:52:56.311554
1628	t	1627	1627	3254	2	\N	\N	2018-07-05 07:52:56.311554
1629	t	1628	1628	3256	1	\N	\N	2018-07-05 07:52:56.311554
1630	t	1629	1629	3258	2	\N	\N	2018-07-05 07:52:56.311554
1631	t	1630	1630	3260	1	\N	\N	2018-07-05 07:52:56.311554
1632	t	1631	1631	3262	2	\N	\N	2018-07-05 07:52:56.311554
1633	t	1632	1632	3264	1	\N	\N	2018-07-05 07:52:56.311554
1634	t	1633	1633	3266	2	\N	\N	2018-07-05 07:52:56.311554
1635	t	1634	1634	3268	1	\N	\N	2018-07-05 07:52:56.311554
1636	t	1635	1635	3270	2	\N	\N	2018-07-05 07:52:56.311554
1637	t	1636	1636	3272	1	\N	\N	2018-07-05 07:52:56.311554
1638	t	1637	1637	3274	2	\N	\N	2018-07-05 07:52:56.311554
1639	t	1638	1638	3276	1	\N	\N	2018-07-05 07:52:56.311554
1640	t	1639	1639	3278	2	\N	\N	2018-07-05 07:52:56.311554
1641	t	1640	1640	3280	1	\N	\N	2018-07-05 07:52:56.311554
1642	t	1641	1641	3282	2	\N	\N	2018-07-05 07:52:56.311554
1643	t	1642	1642	3284	1	\N	\N	2018-07-05 07:52:56.311554
1644	t	1643	1643	3286	2	\N	\N	2018-07-05 07:52:56.311554
1645	t	1644	1644	3288	1	\N	\N	2018-07-05 07:52:56.311554
1646	t	1645	1645	3290	2	\N	\N	2018-07-05 07:52:56.311554
1647	t	1646	1646	3292	1	\N	\N	2018-07-05 07:52:56.311554
1648	t	1647	1647	3294	2	\N	\N	2018-07-05 07:52:56.311554
1649	t	1648	1648	3296	1	\N	\N	2018-07-05 07:52:56.311554
1650	t	1649	1649	3298	2	\N	\N	2018-07-05 07:52:56.311554
1651	t	1650	1650	3300	1	\N	\N	2018-07-05 07:52:56.311554
1652	t	1651	1651	3302	2	\N	\N	2018-07-05 07:52:56.311554
1653	t	1652	1652	3304	1	\N	\N	2018-07-05 07:52:56.311554
1654	t	1653	1653	3306	2	\N	\N	2018-07-05 07:52:56.311554
1655	t	1654	1654	3308	1	\N	\N	2018-07-05 07:52:56.311554
1656	t	1655	1655	3310	2	\N	\N	2018-07-05 07:52:56.311554
1657	t	1656	1656	3312	1	\N	\N	2018-07-05 07:52:56.311554
1658	t	1657	1657	3314	2	\N	\N	2018-07-05 07:52:56.311554
1659	t	1658	1658	3316	1	\N	\N	2018-07-05 07:52:56.311554
1660	t	1659	1659	3318	2	\N	\N	2018-07-05 07:52:56.311554
1661	t	1660	1660	3320	1	\N	\N	2018-07-05 07:52:56.311554
1662	t	1661	1661	3322	2	\N	\N	2018-07-05 07:52:56.311554
1663	t	1662	1662	3324	1	\N	\N	2018-07-05 07:52:56.311554
1664	t	1663	1663	3326	2	\N	\N	2018-07-05 07:52:56.311554
1665	t	1664	1664	3328	1	\N	\N	2018-07-05 07:52:56.311554
1666	t	1665	1665	3330	2	\N	\N	2018-07-05 07:52:56.311554
1667	t	1666	1666	3332	1	\N	\N	2018-07-05 07:52:56.311554
1668	t	1667	1667	3334	2	\N	\N	2018-07-05 07:52:56.311554
1669	t	1668	1668	3336	1	\N	\N	2018-07-05 07:52:56.311554
1670	t	1669	1669	3338	2	\N	\N	2018-07-05 07:52:56.311554
1671	t	1670	1670	3340	1	\N	\N	2018-07-05 07:52:56.311554
1672	t	1671	1671	3342	2	\N	\N	2018-07-05 07:52:56.311554
1673	t	1672	1672	3344	1	\N	\N	2018-07-05 07:52:56.311554
1674	t	1673	1673	3346	2	\N	\N	2018-07-05 07:52:56.311554
1675	t	1674	1674	3348	1	\N	\N	2018-07-05 07:52:56.311554
1676	t	1675	1675	3350	2	\N	\N	2018-07-05 07:52:56.311554
1677	t	1676	1676	3352	1	\N	\N	2018-07-05 07:52:56.311554
1678	t	1677	1677	3354	2	\N	\N	2018-07-05 07:52:56.311554
1679	t	1678	1678	3356	1	\N	\N	2018-07-05 07:52:56.311554
1680	t	1679	1679	3358	2	\N	\N	2018-07-05 07:52:56.311554
1681	t	1680	1680	3360	1	\N	\N	2018-07-05 07:52:56.311554
1682	t	1681	1681	3362	2	\N	\N	2018-07-05 07:52:56.311554
1683	t	1682	1682	3364	1	\N	\N	2018-07-05 07:52:56.311554
1684	t	1683	1683	3366	2	\N	\N	2018-07-05 07:52:56.311554
1685	t	1684	1684	3368	1	\N	\N	2018-07-05 07:52:56.311554
1686	t	1685	1685	3370	2	\N	\N	2018-07-05 07:52:56.311554
1687	t	1686	1686	3372	1	\N	\N	2018-07-05 07:52:56.311554
1688	t	1687	1687	3374	2	\N	\N	2018-07-05 07:52:56.311554
1689	t	1688	1688	3376	1	\N	\N	2018-07-05 07:52:56.311554
1690	t	1689	1689	3378	2	\N	\N	2018-07-05 07:52:56.311554
1691	t	1690	1690	3380	1	\N	\N	2018-07-05 07:52:56.311554
1692	t	1691	1691	3382	2	\N	\N	2018-07-05 07:52:56.311554
1693	t	1692	1692	3384	1	\N	\N	2018-07-05 07:52:56.311554
1694	t	1693	1693	3386	2	\N	\N	2018-07-05 07:52:56.311554
1695	t	1694	1694	3388	1	\N	\N	2018-07-05 07:52:56.311554
1696	t	1695	1695	3390	2	\N	\N	2018-07-05 07:52:56.311554
1697	t	1696	1696	3392	1	\N	\N	2018-07-05 07:52:56.311554
1698	t	1697	1697	3394	2	\N	\N	2018-07-05 07:52:56.311554
1699	t	1698	1698	3396	1	\N	\N	2018-07-05 07:52:56.311554
1700	t	1699	1699	3398	2	\N	\N	2018-07-05 07:52:56.311554
1701	t	1700	1700	3400	1	\N	\N	2018-07-05 07:52:56.311554
1702	t	1701	1701	3402	2	\N	\N	2018-07-05 07:52:56.311554
1703	t	1702	1702	3404	1	\N	\N	2018-07-05 07:52:56.311554
1704	t	1703	1703	3406	2	\N	\N	2018-07-05 07:52:56.311554
1705	t	1704	1704	3408	1	\N	\N	2018-07-05 07:52:56.311554
1706	t	1705	1705	3410	2	\N	\N	2018-07-05 07:52:56.311554
1707	t	1706	1706	3412	1	\N	\N	2018-07-05 07:52:56.311554
1708	t	1707	1707	3414	2	\N	\N	2018-07-05 07:52:56.311554
1709	t	1708	1708	3416	1	\N	\N	2018-07-05 07:52:56.311554
1710	t	1709	1709	3418	2	\N	\N	2018-07-05 07:52:56.311554
1711	t	1710	1710	3420	1	\N	\N	2018-07-05 07:52:56.311554
1712	t	1711	1711	3422	2	\N	\N	2018-07-05 07:52:56.311554
1713	t	1712	1712	3424	1	\N	\N	2018-07-05 07:52:56.311554
1714	t	1713	1713	3426	2	\N	\N	2018-07-05 07:52:56.311554
1715	t	1714	1714	3428	1	\N	\N	2018-07-05 07:52:56.311554
1716	t	1715	1715	3430	2	\N	\N	2018-07-05 07:52:56.311554
1717	t	1716	1716	3432	1	\N	\N	2018-07-05 07:52:56.311554
1718	t	1717	1717	3434	2	\N	\N	2018-07-05 07:52:56.311554
1719	t	1718	1718	3436	1	\N	\N	2018-07-05 07:52:56.311554
1720	t	1719	1719	3438	2	\N	\N	2018-07-05 07:52:56.311554
1721	t	1720	1720	3440	1	\N	\N	2018-07-05 07:52:56.311554
1722	t	1721	1721	3442	2	\N	\N	2018-07-05 07:52:56.311554
1723	t	1722	1722	3444	1	\N	\N	2018-07-05 07:52:56.311554
1724	t	1723	1723	3446	2	\N	\N	2018-07-05 07:52:56.311554
1725	t	1724	1724	3448	1	\N	\N	2018-07-05 07:52:56.311554
1726	t	1725	1725	3450	2	\N	\N	2018-07-05 07:52:56.311554
1727	t	1726	1726	3452	1	\N	\N	2018-07-05 07:52:56.311554
1728	t	1727	1727	3454	2	\N	\N	2018-07-05 07:52:56.311554
1729	t	1728	1728	3456	1	\N	\N	2018-07-05 07:52:56.311554
1730	t	1729	1729	3458	2	\N	\N	2018-07-05 07:52:56.311554
1731	t	1730	1730	3460	1	\N	\N	2018-07-05 07:52:56.311554
1732	t	1731	1731	3462	2	\N	\N	2018-07-05 07:52:56.311554
1733	t	1732	1732	3464	1	\N	\N	2018-07-05 07:52:56.311554
1734	t	1733	1733	3466	2	\N	\N	2018-07-05 07:52:56.311554
1735	t	1734	1734	3468	1	\N	\N	2018-07-05 07:52:56.311554
1736	t	1735	1735	3470	2	\N	\N	2018-07-05 07:52:56.311554
1737	t	1736	1736	3472	1	\N	\N	2018-07-05 07:52:56.311554
1738	t	1737	1737	3474	2	\N	\N	2018-07-05 07:52:56.311554
1739	t	1738	1738	3476	1	\N	\N	2018-07-05 07:52:56.311554
1740	t	1739	1739	3478	2	\N	\N	2018-07-05 07:52:56.311554
1741	t	1740	1740	3480	1	\N	\N	2018-07-05 07:52:56.311554
1742	t	1741	1741	3482	2	\N	\N	2018-07-05 07:52:56.311554
1743	t	1742	1742	3484	1	\N	\N	2018-07-05 07:52:56.311554
1744	t	1743	1743	3486	2	\N	\N	2018-07-05 07:52:56.311554
1745	t	1744	1744	3488	1	\N	\N	2018-07-05 07:52:56.311554
1746	t	1745	1745	3490	2	\N	\N	2018-07-05 07:52:56.311554
1747	t	1746	1746	3492	1	\N	\N	2018-07-05 07:52:56.311554
1748	t	1747	1747	3494	2	\N	\N	2018-07-05 07:52:56.311554
1749	t	1748	1748	3496	1	\N	\N	2018-07-05 07:52:56.311554
1750	t	1749	1749	3498	2	\N	\N	2018-07-05 07:52:56.311554
1751	t	1750	1750	3500	1	\N	\N	2018-07-05 07:52:56.311554
1752	t	1751	1751	3502	2	\N	\N	2018-07-05 07:52:56.311554
1753	t	1752	1752	3504	1	\N	\N	2018-07-05 07:52:56.311554
1754	t	1753	1753	3506	2	\N	\N	2018-07-05 07:52:56.311554
1755	t	1754	1754	3508	1	\N	\N	2018-07-05 07:52:56.311554
1756	t	1755	1755	3510	2	\N	\N	2018-07-05 07:52:56.311554
1757	t	1756	1756	3512	1	\N	\N	2018-07-05 07:52:56.311554
1758	t	1757	1757	3514	2	\N	\N	2018-07-05 07:52:56.311554
1759	t	1758	1758	3516	1	\N	\N	2018-07-05 07:52:56.311554
1760	t	1759	1759	3518	2	\N	\N	2018-07-05 07:52:56.311554
1761	t	1760	1760	3520	1	\N	\N	2018-07-05 07:52:56.311554
1762	t	1761	1761	3522	2	\N	\N	2018-07-05 07:52:56.311554
1763	t	1762	1762	3524	1	\N	\N	2018-07-05 07:52:56.311554
1764	t	1763	1763	3526	2	\N	\N	2018-07-05 07:52:56.311554
1765	t	1764	1764	3528	1	\N	\N	2018-07-05 07:52:56.311554
1766	t	1765	1765	3530	2	\N	\N	2018-07-05 07:52:56.311554
1767	t	1766	1766	3532	1	\N	\N	2018-07-05 07:52:56.311554
1768	t	1767	1767	3534	2	\N	\N	2018-07-05 07:52:56.311554
1769	t	1768	1768	3536	1	\N	\N	2018-07-05 07:52:56.311554
1770	t	1769	1769	3538	2	\N	\N	2018-07-05 07:52:56.311554
1771	t	1770	1770	3540	1	\N	\N	2018-07-05 07:52:56.311554
1772	t	1771	1771	3542	2	\N	\N	2018-07-05 07:52:56.311554
1773	t	1772	1772	3544	1	\N	\N	2018-07-05 07:52:56.311554
1774	t	1773	1773	3546	2	\N	\N	2018-07-05 07:52:56.311554
1775	t	1774	1774	3548	1	\N	\N	2018-07-05 07:52:56.311554
1776	t	1775	1775	3550	2	\N	\N	2018-07-05 07:52:56.311554
1777	t	1776	1776	3552	1	\N	\N	2018-07-05 07:52:56.311554
1778	t	1777	1777	3554	2	\N	\N	2018-07-05 07:52:56.311554
1779	t	1778	1778	3556	1	\N	\N	2018-07-05 07:52:56.311554
1780	t	1779	1779	3558	2	\N	\N	2018-07-05 07:52:56.311554
1781	t	1780	1780	3560	1	\N	\N	2018-07-05 07:52:56.311554
1782	t	1781	1781	3562	2	\N	\N	2018-07-05 07:52:56.311554
1783	t	1782	1782	3564	1	\N	\N	2018-07-05 07:52:56.311554
1784	t	1783	1783	3566	2	\N	\N	2018-07-05 07:52:56.311554
1785	t	1784	1784	3568	1	\N	\N	2018-07-05 07:52:56.311554
1786	t	1785	1785	3570	2	\N	\N	2018-07-05 07:52:56.311554
1787	t	1786	1786	3572	1	\N	\N	2018-07-05 07:52:56.311554
1788	t	1787	1787	3574	2	\N	\N	2018-07-05 07:52:56.311554
1789	t	1788	1788	3576	1	\N	\N	2018-07-05 07:52:56.311554
1790	t	1789	1789	3578	2	\N	\N	2018-07-05 07:52:56.311554
1791	t	1790	1790	3580	1	\N	\N	2018-07-05 07:52:56.311554
1792	t	1791	1791	3582	2	\N	\N	2018-07-05 07:52:56.311554
1793	t	1792	1792	3584	1	\N	\N	2018-07-05 07:52:56.311554
1794	t	1793	1793	3586	2	\N	\N	2018-07-05 07:52:56.311554
1795	t	1794	1794	3588	1	\N	\N	2018-07-05 07:52:56.311554
1796	t	1795	1795	3590	2	\N	\N	2018-07-05 07:52:56.311554
1797	t	1796	1796	3592	1	\N	\N	2018-07-05 07:52:56.311554
1798	t	1797	1797	3594	2	\N	\N	2018-07-05 07:52:56.311554
1799	t	1798	1798	3596	1	\N	\N	2018-07-05 07:52:56.311554
1800	t	1799	1799	3598	2	\N	\N	2018-07-05 07:52:56.311554
1801	t	1800	1800	3600	1	\N	\N	2018-07-05 07:52:56.311554
1802	t	1801	1801	3602	2	\N	\N	2018-07-05 07:52:56.311554
1803	t	1802	1802	3604	1	\N	\N	2018-07-05 07:52:56.311554
1804	t	1803	1803	3606	2	\N	\N	2018-07-05 07:52:56.311554
1805	t	1804	1804	3608	1	\N	\N	2018-07-05 07:52:56.311554
1806	t	1805	1805	3610	2	\N	\N	2018-07-05 07:52:56.311554
1807	t	1806	1806	3612	1	\N	\N	2018-07-05 07:52:56.311554
1808	t	1807	1807	3614	2	\N	\N	2018-07-05 07:52:56.311554
1809	t	1808	1808	3616	1	\N	\N	2018-07-05 07:52:56.311554
1810	t	1809	1809	3618	2	\N	\N	2018-07-05 07:52:56.311554
1811	t	1810	1810	3620	1	\N	\N	2018-07-05 07:52:56.311554
1812	t	1811	1811	3622	2	\N	\N	2018-07-05 07:52:56.311554
1813	t	1812	1812	3624	1	\N	\N	2018-07-05 07:52:56.311554
1814	t	1813	1813	3626	2	\N	\N	2018-07-05 07:52:56.311554
1815	t	1814	1814	3628	1	\N	\N	2018-07-05 07:52:56.311554
1816	t	1815	1815	3630	2	\N	\N	2018-07-05 07:52:56.311554
1817	t	1816	1816	3632	1	\N	\N	2018-07-05 07:52:56.311554
1818	t	1817	1817	3634	2	\N	\N	2018-07-05 07:52:56.311554
1819	t	1818	1818	3636	1	\N	\N	2018-07-05 07:52:56.311554
1820	t	1819	1819	3638	2	\N	\N	2018-07-05 07:52:56.311554
1821	t	1820	1820	3640	1	\N	\N	2018-07-05 07:52:56.311554
1822	t	1821	1821	3642	2	\N	\N	2018-07-05 07:52:56.311554
1823	t	1822	1822	3644	1	\N	\N	2018-07-05 07:52:56.311554
1824	t	1823	1823	3646	2	\N	\N	2018-07-05 07:52:56.311554
1825	t	1824	1824	3648	1	\N	\N	2018-07-05 07:52:56.311554
1826	t	1825	1825	3650	2	\N	\N	2018-07-05 07:52:56.311554
1827	t	1826	1826	3652	1	\N	\N	2018-07-05 07:52:56.311554
1828	t	1827	1827	3654	2	\N	\N	2018-07-05 07:52:56.311554
1829	t	1828	1828	3656	1	\N	\N	2018-07-05 07:52:56.311554
1830	t	1829	1829	3658	2	\N	\N	2018-07-05 07:52:56.311554
1831	t	1830	1830	3660	1	\N	\N	2018-07-05 07:52:56.311554
1832	t	1831	1831	3662	2	\N	\N	2018-07-05 07:52:56.311554
1833	t	1832	1832	3664	1	\N	\N	2018-07-05 07:52:56.311554
1834	t	1833	1833	3666	2	\N	\N	2018-07-05 07:52:56.311554
1835	t	1834	1834	3668	1	\N	\N	2018-07-05 07:52:56.311554
1836	t	1835	1835	3670	2	\N	\N	2018-07-05 07:52:56.311554
1837	t	1836	1836	3672	1	\N	\N	2018-07-05 07:52:56.311554
1838	t	1837	1837	3674	2	\N	\N	2018-07-05 07:52:56.311554
1839	t	1838	1838	3676	1	\N	\N	2018-07-05 07:52:56.311554
1840	t	1839	1839	3678	2	\N	\N	2018-07-05 07:52:56.311554
1841	t	1840	1840	3680	1	\N	\N	2018-07-05 07:52:56.311554
1842	t	1841	1841	3682	2	\N	\N	2018-07-05 07:52:56.311554
1843	t	1842	1842	3684	1	\N	\N	2018-07-05 07:52:56.311554
1844	t	1843	1843	3686	2	\N	\N	2018-07-05 07:52:56.311554
1845	t	1844	1844	3688	1	\N	\N	2018-07-05 07:52:56.311554
1846	t	1845	1845	3690	2	\N	\N	2018-07-05 07:52:56.311554
1847	t	1846	1846	3692	1	\N	\N	2018-07-05 07:52:56.311554
1848	t	1847	1847	3694	2	\N	\N	2018-07-05 07:52:56.311554
1849	t	1848	1848	3696	1	\N	\N	2018-07-05 07:52:56.311554
1850	t	1849	1849	3698	2	\N	\N	2018-07-05 07:52:56.311554
1851	t	1850	1850	3700	1	\N	\N	2018-07-05 07:52:56.311554
1852	t	1851	1851	3702	2	\N	\N	2018-07-05 07:52:56.311554
1853	t	1852	1852	3704	1	\N	\N	2018-07-05 07:52:56.311554
1854	t	1853	1853	3706	2	\N	\N	2018-07-05 07:52:56.311554
1855	t	1854	1854	3708	1	\N	\N	2018-07-05 07:52:56.311554
1856	t	1855	1855	3710	2	\N	\N	2018-07-05 07:52:56.311554
1857	t	1856	1856	3712	1	\N	\N	2018-07-05 07:52:56.311554
1858	t	1857	1857	3714	2	\N	\N	2018-07-05 07:52:56.311554
1859	t	1858	1858	3716	1	\N	\N	2018-07-05 07:52:56.311554
1860	t	1859	1859	3718	2	\N	\N	2018-07-05 07:52:56.311554
1861	t	1860	1860	3720	1	\N	\N	2018-07-05 07:52:56.311554
1862	t	1861	1861	3722	2	\N	\N	2018-07-05 07:52:56.311554
1863	t	1862	1862	3724	1	\N	\N	2018-07-05 07:52:56.311554
1864	t	1863	1863	3726	2	\N	\N	2018-07-05 07:52:56.311554
1865	t	1864	1864	3728	1	\N	\N	2018-07-05 07:52:56.311554
1866	t	1865	1865	3730	2	\N	\N	2018-07-05 07:52:56.311554
1867	t	1866	1866	3732	1	\N	\N	2018-07-05 07:52:56.311554
1868	t	1867	1867	3734	2	\N	\N	2018-07-05 07:52:56.311554
1869	t	1868	1868	3736	1	\N	\N	2018-07-05 07:52:56.311554
1870	t	1869	1869	3738	2	\N	\N	2018-07-05 07:52:56.311554
1871	t	1870	1870	3740	1	\N	\N	2018-07-05 07:52:56.311554
1872	t	1871	1871	3742	2	\N	\N	2018-07-05 07:52:56.311554
1873	t	1872	1872	3744	1	\N	\N	2018-07-05 07:52:56.311554
1874	t	1873	1873	3746	2	\N	\N	2018-07-05 07:52:56.311554
1875	t	1874	1874	3748	1	\N	\N	2018-07-05 07:52:56.311554
1876	t	1875	1875	3750	2	\N	\N	2018-07-05 07:52:56.311554
1877	t	1876	1876	3752	1	\N	\N	2018-07-05 07:52:56.311554
1878	t	1877	1877	3754	2	\N	\N	2018-07-05 07:52:56.311554
1879	t	1878	1878	3756	1	\N	\N	2018-07-05 07:52:56.311554
1880	t	1879	1879	3758	2	\N	\N	2018-07-05 07:52:56.311554
1881	t	1880	1880	3760	1	\N	\N	2018-07-05 07:52:56.311554
1882	t	1881	1881	3762	2	\N	\N	2018-07-05 07:52:56.311554
1883	t	1882	1882	3764	1	\N	\N	2018-07-05 07:52:56.311554
1884	t	1883	1883	3766	2	\N	\N	2018-07-05 07:52:56.311554
1885	t	1884	1884	3768	1	\N	\N	2018-07-05 07:52:56.311554
1886	t	1885	1885	3770	2	\N	\N	2018-07-05 07:52:56.311554
1887	t	1886	1886	3772	1	\N	\N	2018-07-05 07:52:56.311554
1888	t	1887	1887	3774	2	\N	\N	2018-07-05 07:52:56.311554
1889	t	1888	1888	3776	1	\N	\N	2018-07-05 07:52:56.311554
1890	t	1889	1889	3778	2	\N	\N	2018-07-05 07:52:56.311554
1891	t	1890	1890	3780	1	\N	\N	2018-07-05 07:52:56.311554
1892	t	1891	1891	3782	2	\N	\N	2018-07-05 07:52:56.311554
1893	t	1892	1892	3784	1	\N	\N	2018-07-05 07:52:56.311554
1894	t	1893	1893	3786	2	\N	\N	2018-07-05 07:52:56.311554
1895	t	1894	1894	3788	1	\N	\N	2018-07-05 07:52:56.311554
1896	t	1895	1895	3790	2	\N	\N	2018-07-05 07:52:56.311554
1897	t	1896	1896	3792	1	\N	\N	2018-07-05 07:52:56.311554
1898	t	1897	1897	3794	2	\N	\N	2018-07-05 07:52:56.311554
1899	t	1898	1898	3796	1	\N	\N	2018-07-05 07:52:56.311554
1900	t	1899	1899	3798	2	\N	\N	2018-07-05 07:52:56.311554
1901	t	1900	1900	3800	1	\N	\N	2018-07-05 07:52:56.311554
1902	t	1901	1901	3802	2	\N	\N	2018-07-05 07:52:56.311554
1903	t	1902	1902	3804	1	\N	\N	2018-07-05 07:52:56.311554
1904	t	1903	1903	3806	2	\N	\N	2018-07-05 07:52:56.311554
1905	t	1904	1904	3808	1	\N	\N	2018-07-05 07:52:56.311554
1906	t	1905	1905	3810	2	\N	\N	2018-07-05 07:52:56.311554
1907	t	1906	1906	3812	1	\N	\N	2018-07-05 07:52:56.311554
1908	t	1907	1907	3814	2	\N	\N	2018-07-05 07:52:56.311554
1909	t	1908	1908	3816	1	\N	\N	2018-07-05 07:52:56.311554
1910	t	1909	1909	3818	2	\N	\N	2018-07-05 07:52:56.311554
1911	t	1910	1910	3820	1	\N	\N	2018-07-05 07:52:56.311554
1912	t	1911	1911	3822	2	\N	\N	2018-07-05 07:52:56.311554
1913	t	1912	1912	3824	1	\N	\N	2018-07-05 07:52:56.311554
1914	t	1913	1913	3826	2	\N	\N	2018-07-05 07:52:56.311554
1915	t	1914	1914	3828	1	\N	\N	2018-07-05 07:52:56.311554
1916	t	1915	1915	3830	2	\N	\N	2018-07-05 07:52:56.311554
1917	t	1916	1916	3832	1	\N	\N	2018-07-05 07:52:56.311554
1918	t	1917	1917	3834	2	\N	\N	2018-07-05 07:52:56.311554
1919	t	1918	1918	3836	1	\N	\N	2018-07-05 07:52:56.311554
1920	t	1919	1919	3838	2	\N	\N	2018-07-05 07:52:56.311554
1921	t	1920	1920	3840	1	\N	\N	2018-07-05 07:52:56.311554
1922	t	1921	1921	3842	2	\N	\N	2018-07-05 07:52:56.311554
1923	t	1922	1922	3844	1	\N	\N	2018-07-05 07:52:56.311554
1924	t	1923	1923	3846	2	\N	\N	2018-07-05 07:52:56.311554
1925	t	1924	1924	3848	1	\N	\N	2018-07-05 07:52:56.311554
1926	t	1925	1925	3850	2	\N	\N	2018-07-05 07:52:56.311554
1927	t	1926	1926	3852	1	\N	\N	2018-07-05 07:52:56.311554
1928	t	1927	1927	3854	2	\N	\N	2018-07-05 07:52:56.311554
1929	t	1928	1928	3856	1	\N	\N	2018-07-05 07:52:56.311554
1930	t	1929	1929	3858	2	\N	\N	2018-07-05 07:52:56.311554
1931	t	1930	1930	3860	1	\N	\N	2018-07-05 07:52:56.311554
1932	t	1931	1931	3862	2	\N	\N	2018-07-05 07:52:56.311554
1933	t	1932	1932	3864	1	\N	\N	2018-07-05 07:52:56.311554
1934	t	1933	1933	3866	2	\N	\N	2018-07-05 07:52:56.311554
1935	t	1934	1934	3868	1	\N	\N	2018-07-05 07:52:56.311554
1936	t	1935	1935	3870	2	\N	\N	2018-07-05 07:52:56.311554
1937	t	1936	1936	3872	1	\N	\N	2018-07-05 07:52:56.311554
1938	t	1937	1937	3874	2	\N	\N	2018-07-05 07:52:56.311554
1939	t	1938	1938	3876	1	\N	\N	2018-07-05 07:52:56.311554
1940	t	1939	1939	3878	2	\N	\N	2018-07-05 07:52:56.311554
1941	t	1940	1940	3880	1	\N	\N	2018-07-05 07:52:56.311554
1942	t	1941	1941	3882	2	\N	\N	2018-07-05 07:52:56.311554
1943	t	1942	1942	3884	1	\N	\N	2018-07-05 07:52:56.311554
1944	t	1943	1943	3886	2	\N	\N	2018-07-05 07:52:56.311554
1945	t	1944	1944	3888	1	\N	\N	2018-07-05 07:52:56.311554
1946	t	1945	1945	3890	2	\N	\N	2018-07-05 07:52:56.311554
1947	t	1946	1946	3892	1	\N	\N	2018-07-05 07:52:56.311554
1948	t	1947	1947	3894	2	\N	\N	2018-07-05 07:52:56.311554
1949	t	1948	1948	3896	1	\N	\N	2018-07-05 07:52:56.311554
1950	t	1949	1949	3898	2	\N	\N	2018-07-05 07:52:56.311554
1951	t	1950	1950	3900	1	\N	\N	2018-07-05 07:52:56.311554
1952	t	1951	1951	3902	2	\N	\N	2018-07-05 07:52:56.311554
1953	t	1952	1952	3904	1	\N	\N	2018-07-05 07:52:56.311554
1954	t	1953	1953	3906	2	\N	\N	2018-07-05 07:52:56.311554
1955	t	1954	1954	3908	1	\N	\N	2018-07-05 07:52:56.311554
1956	t	1955	1955	3910	2	\N	\N	2018-07-05 07:52:56.311554
1957	t	1956	1956	3912	1	\N	\N	2018-07-05 07:52:56.311554
1958	t	1957	1957	3914	2	\N	\N	2018-07-05 07:52:56.311554
1959	t	1958	1958	3916	1	\N	\N	2018-07-05 07:52:56.311554
1960	t	1959	1959	3918	2	\N	\N	2018-07-05 07:52:56.311554
1961	t	1960	1960	3920	1	\N	\N	2018-07-05 07:52:56.311554
1962	t	1961	1961	3922	2	\N	\N	2018-07-05 07:52:56.311554
1963	t	1962	1962	3924	1	\N	\N	2018-07-05 07:52:56.311554
1964	t	1963	1963	3926	2	\N	\N	2018-07-05 07:52:56.311554
1965	t	1964	1964	3928	1	\N	\N	2018-07-05 07:52:56.311554
1966	t	1965	1965	3930	2	\N	\N	2018-07-05 07:52:56.311554
1967	t	1966	1966	3932	1	\N	\N	2018-07-05 07:52:56.311554
1968	t	1967	1967	3934	2	\N	\N	2018-07-05 07:52:56.311554
1969	t	1968	1968	3936	1	\N	\N	2018-07-05 07:52:56.311554
1970	t	1969	1969	3938	2	\N	\N	2018-07-05 07:52:56.311554
1971	t	1970	1970	3940	1	\N	\N	2018-07-05 07:52:56.311554
1972	t	1971	1971	3942	2	\N	\N	2018-07-05 07:52:56.311554
1973	t	1972	1972	3944	1	\N	\N	2018-07-05 07:52:56.311554
1974	t	1973	1973	3946	2	\N	\N	2018-07-05 07:52:56.311554
1975	t	1974	1974	3948	1	\N	\N	2018-07-05 07:52:56.311554
1976	t	1975	1975	3950	2	\N	\N	2018-07-05 07:52:56.311554
1977	t	1976	1976	3952	1	\N	\N	2018-07-05 07:52:56.311554
1978	t	1977	1977	3954	2	\N	\N	2018-07-05 07:52:56.311554
1979	t	1978	1978	3956	1	\N	\N	2018-07-05 07:52:56.311554
1980	t	1979	1979	3958	2	\N	\N	2018-07-05 07:52:56.311554
1981	t	1980	1980	3960	1	\N	\N	2018-07-05 07:52:56.311554
1982	t	1981	1981	3962	2	\N	\N	2018-07-05 07:52:56.311554
1983	t	1982	1982	3964	1	\N	\N	2018-07-05 07:52:56.311554
1984	t	1983	1983	3966	2	\N	\N	2018-07-05 07:52:56.311554
1985	t	1984	1984	3968	1	\N	\N	2018-07-05 07:52:56.311554
1986	t	1985	1985	3970	2	\N	\N	2018-07-05 07:52:56.311554
1987	t	1986	1986	3972	1	\N	\N	2018-07-05 07:52:56.311554
1988	t	1987	1987	3974	2	\N	\N	2018-07-05 07:52:56.311554
1989	t	1988	1988	3976	1	\N	\N	2018-07-05 07:52:56.311554
1990	t	1989	1989	3978	2	\N	\N	2018-07-05 07:52:56.311554
1991	t	1990	1990	3980	1	\N	\N	2018-07-05 07:52:56.311554
1992	t	1991	1991	3982	2	\N	\N	2018-07-05 07:52:56.311554
1993	t	1992	1992	3984	1	\N	\N	2018-07-05 07:52:56.311554
1994	t	1993	1993	3986	2	\N	\N	2018-07-05 07:52:56.311554
1995	t	1994	1994	3988	1	\N	\N	2018-07-05 07:52:56.311554
1996	t	1995	1995	3990	2	\N	\N	2018-07-05 07:52:56.311554
1997	t	1996	1996	3992	1	\N	\N	2018-07-05 07:52:56.311554
1998	t	1997	1997	3994	2	\N	\N	2018-07-05 07:52:56.311554
1999	t	1998	1998	3996	1	\N	\N	2018-07-05 07:52:56.311554
2000	t	1999	1999	3998	2	\N	\N	2018-07-05 07:52:56.311554
2001	t	2000	2000	4000	1	\N	\N	2018-07-05 07:52:56.311554
2002	t	2001	2001	4002	2	\N	\N	2018-07-05 07:52:56.311554
2003	t	2002	2002	4004	1	\N	\N	2018-07-05 07:52:56.311554
2004	t	2003	2003	4006	2	\N	\N	2018-07-05 07:52:56.311554
2005	t	2004	2004	4008	1	\N	\N	2018-07-05 07:52:56.311554
2006	t	2005	2005	4010	2	\N	\N	2018-07-05 07:52:56.311554
2007	t	2006	2006	4012	1	\N	\N	2018-07-05 07:52:56.311554
2008	t	2007	2007	4014	2	\N	\N	2018-07-05 07:52:56.311554
2009	t	2008	2008	4016	1	\N	\N	2018-07-05 07:52:56.311554
2010	t	2009	2009	4018	2	\N	\N	2018-07-05 07:52:56.311554
2011	t	2010	2010	4020	1	\N	\N	2018-07-05 07:52:56.311554
2012	t	2011	2011	4022	2	\N	\N	2018-07-05 07:52:56.311554
2013	t	2012	2012	4024	1	\N	\N	2018-07-05 07:52:56.311554
2014	t	2013	2013	4026	2	\N	\N	2018-07-05 07:52:56.311554
2015	t	2014	2014	4028	1	\N	\N	2018-07-05 07:52:56.311554
2016	t	2015	2015	4030	2	\N	\N	2018-07-05 07:52:56.311554
2017	t	2016	2016	4032	1	\N	\N	2018-07-05 07:52:56.311554
2018	t	2017	2017	4034	2	\N	\N	2018-07-05 07:52:56.311554
2019	t	2018	2018	4036	1	\N	\N	2018-07-05 07:52:56.311554
2020	t	2019	2019	4038	2	\N	\N	2018-07-05 07:52:56.311554
2021	t	2020	2020	4040	1	\N	\N	2018-07-05 07:52:56.311554
2022	t	2021	2021	4042	2	\N	\N	2018-07-05 07:52:56.311554
2023	t	2022	2022	4044	1	\N	\N	2018-07-05 07:52:56.311554
2024	t	2023	2023	4046	2	\N	\N	2018-07-05 07:52:56.311554
2025	t	2024	2024	4048	1	\N	\N	2018-07-05 07:52:56.311554
2026	t	2025	2025	4050	2	\N	\N	2018-07-05 07:52:56.311554
2027	t	2026	2026	4052	1	\N	\N	2018-07-05 07:52:56.311554
2028	t	2027	2027	4054	2	\N	\N	2018-07-05 07:52:56.311554
2029	t	2028	2028	4056	1	\N	\N	2018-07-05 07:52:56.311554
2030	t	2029	2029	4058	2	\N	\N	2018-07-05 07:52:56.311554
2031	t	2030	2030	4060	1	\N	\N	2018-07-05 07:52:56.311554
2032	t	2031	2031	4062	2	\N	\N	2018-07-05 07:52:56.311554
2033	t	2032	2032	4064	1	\N	\N	2018-07-05 07:52:56.311554
2034	t	2033	2033	4066	2	\N	\N	2018-07-05 07:52:56.311554
2035	t	2034	2034	4068	1	\N	\N	2018-07-05 07:52:56.311554
2036	t	2035	2035	4070	2	\N	\N	2018-07-05 07:52:56.311554
2037	t	2036	2036	4072	1	\N	\N	2018-07-05 07:52:56.311554
2038	t	2037	2037	4074	2	\N	\N	2018-07-05 07:52:56.311554
2039	t	2038	2038	4076	1	\N	\N	2018-07-05 07:52:56.311554
2040	t	2039	2039	4078	2	\N	\N	2018-07-05 07:52:56.311554
2041	t	2040	2040	4080	1	\N	\N	2018-07-05 07:52:56.311554
2042	t	2041	2041	4082	2	\N	\N	2018-07-05 07:52:56.311554
2043	t	2042	2042	4084	1	\N	\N	2018-07-05 07:52:56.311554
2044	t	2043	2043	4086	2	\N	\N	2018-07-05 07:52:56.311554
2045	t	2044	2044	4088	1	\N	\N	2018-07-05 07:52:56.311554
2046	t	2045	2045	4090	2	\N	\N	2018-07-05 07:52:56.311554
2047	t	2046	2046	4092	1	\N	\N	2018-07-05 07:52:56.311554
2048	t	2047	2047	4094	2	\N	\N	2018-07-05 07:52:56.311554
2049	t	2048	2048	4096	1	\N	\N	2018-07-05 07:52:56.311554
2050	t	2049	2049	4098	2	\N	\N	2018-07-05 07:52:56.311554
2051	t	2050	2050	4100	1	\N	\N	2018-07-05 07:52:56.311554
2052	t	2051	2051	4102	2	\N	\N	2018-07-05 07:52:56.311554
2053	t	2052	2052	4104	1	\N	\N	2018-07-05 07:52:56.311554
2054	t	2053	2053	4106	2	\N	\N	2018-07-05 07:52:56.311554
2055	t	2054	2054	4108	1	\N	\N	2018-07-05 07:52:56.311554
2056	t	2055	2055	4110	2	\N	\N	2018-07-05 07:52:56.311554
2057	t	2056	2056	4112	1	\N	\N	2018-07-05 07:52:56.311554
2058	t	2057	2057	4114	2	\N	\N	2018-07-05 07:52:56.311554
2059	t	2058	2058	4116	1	\N	\N	2018-07-05 07:52:56.311554
2060	t	2059	2059	4118	2	\N	\N	2018-07-05 07:52:56.311554
2061	t	2060	2060	4120	1	\N	\N	2018-07-05 07:52:56.311554
2062	t	2061	2061	4122	2	\N	\N	2018-07-05 07:52:56.311554
2063	t	2062	2062	4124	1	\N	\N	2018-07-05 07:52:56.311554
2064	t	2063	2063	4126	2	\N	\N	2018-07-05 07:52:56.311554
2065	t	2064	2064	4128	1	\N	\N	2018-07-05 07:52:56.311554
2066	t	2065	2065	4130	2	\N	\N	2018-07-05 07:52:56.311554
2067	t	2066	2066	4132	1	\N	\N	2018-07-05 07:52:56.311554
2068	t	2067	2067	4134	2	\N	\N	2018-07-05 07:52:56.311554
2069	t	2068	2068	4136	1	\N	\N	2018-07-05 07:52:56.311554
2070	t	2069	2069	4138	2	\N	\N	2018-07-05 07:52:56.311554
2071	t	2070	2070	4140	1	\N	\N	2018-07-05 07:52:56.311554
2072	t	2071	2071	4142	2	\N	\N	2018-07-05 07:52:56.311554
2073	t	2072	2072	4144	1	\N	\N	2018-07-05 07:52:56.311554
2074	t	2073	2073	4146	2	\N	\N	2018-07-05 07:52:56.311554
2075	t	2074	2074	4148	1	\N	\N	2018-07-05 07:52:56.311554
2076	t	2075	2075	4150	2	\N	\N	2018-07-05 07:52:56.311554
2077	t	2076	2076	4152	1	\N	\N	2018-07-05 07:52:56.311554
2078	t	2077	2077	4154	2	\N	\N	2018-07-05 07:52:56.311554
2079	t	2078	2078	4156	1	\N	\N	2018-07-05 07:52:56.311554
2080	t	2079	2079	4158	2	\N	\N	2018-07-05 07:52:56.311554
2081	t	2080	2080	4160	1	\N	\N	2018-07-05 07:52:56.311554
2082	t	2081	2081	4162	2	\N	\N	2018-07-05 07:52:56.311554
2083	t	2082	2082	4164	1	\N	\N	2018-07-05 07:52:56.311554
2084	t	2083	2083	4166	2	\N	\N	2018-07-05 07:52:56.311554
2085	t	2084	2084	4168	1	\N	\N	2018-07-05 07:52:56.311554
2086	t	2085	2085	4170	2	\N	\N	2018-07-05 07:52:56.311554
2087	t	2086	2086	4172	1	\N	\N	2018-07-05 07:52:56.311554
2088	t	2087	2087	4174	2	\N	\N	2018-07-05 07:52:56.311554
2089	t	2088	2088	4176	1	\N	\N	2018-07-05 07:52:56.311554
2090	t	2089	2089	4178	2	\N	\N	2018-07-05 07:52:56.311554
2091	t	2090	2090	4180	1	\N	\N	2018-07-05 07:52:56.311554
2092	t	2091	2091	4182	2	\N	\N	2018-07-05 07:52:56.311554
2093	t	2092	2092	4184	1	\N	\N	2018-07-05 07:52:56.311554
2094	t	2093	2093	4186	2	\N	\N	2018-07-05 07:52:56.311554
2095	t	2094	2094	4188	1	\N	\N	2018-07-05 07:52:56.311554
2096	t	2095	2095	4190	2	\N	\N	2018-07-05 07:52:56.311554
2097	t	2096	2096	4192	1	\N	\N	2018-07-05 07:52:56.311554
2098	t	2097	2097	4194	2	\N	\N	2018-07-05 07:52:56.311554
2099	t	2098	2098	4196	1	\N	\N	2018-07-05 07:52:56.311554
2100	t	2099	2099	4198	2	\N	\N	2018-07-05 07:52:56.311554
2101	t	2100	2100	4200	1	\N	\N	2018-07-05 07:52:56.311554
2102	t	2101	2101	4202	2	\N	\N	2018-07-05 07:52:56.311554
2103	t	2102	2102	4204	1	\N	\N	2018-07-05 07:52:56.311554
2104	t	2103	2103	4206	2	\N	\N	2018-07-05 07:52:56.311554
2105	t	2104	2104	4208	1	\N	\N	2018-07-05 07:52:56.311554
2106	t	2105	2105	4210	2	\N	\N	2018-07-05 07:52:56.311554
2107	t	2106	2106	4212	1	\N	\N	2018-07-05 07:52:56.311554
2108	t	2107	2107	4214	2	\N	\N	2018-07-05 07:52:56.311554
2109	t	2108	2108	4216	1	\N	\N	2018-07-05 07:52:56.311554
2110	t	2109	2109	4218	2	\N	\N	2018-07-05 07:52:56.311554
2111	t	2110	2110	4220	1	\N	\N	2018-07-05 07:52:56.311554
2112	t	2111	2111	4222	2	\N	\N	2018-07-05 07:52:56.311554
2113	t	2112	2112	4224	1	\N	\N	2018-07-05 07:52:56.311554
2114	t	2113	2113	4226	2	\N	\N	2018-07-05 07:52:56.311554
2115	t	2114	2114	4228	1	\N	\N	2018-07-05 07:52:56.311554
2116	t	2115	2115	4230	2	\N	\N	2018-07-05 07:52:56.311554
2117	t	2116	2116	4232	1	\N	\N	2018-07-05 07:52:56.311554
2118	t	2117	2117	4234	2	\N	\N	2018-07-05 07:52:56.311554
2119	t	2118	2118	4236	1	\N	\N	2018-07-05 07:52:56.311554
2120	t	2119	2119	4238	2	\N	\N	2018-07-05 07:52:56.311554
2121	t	2120	2120	4240	1	\N	\N	2018-07-05 07:52:56.311554
2122	t	2121	2121	4242	2	\N	\N	2018-07-05 07:52:56.311554
2123	t	2122	2122	4244	1	\N	\N	2018-07-05 07:52:56.311554
2124	t	2123	2123	4246	2	\N	\N	2018-07-05 07:52:56.311554
2125	t	2124	2124	4248	1	\N	\N	2018-07-05 07:52:56.311554
2126	t	2125	2125	4250	2	\N	\N	2018-07-05 07:52:56.311554
2127	t	2126	2126	4252	1	\N	\N	2018-07-05 07:52:56.311554
2128	t	2127	2127	4254	2	\N	\N	2018-07-05 07:52:56.311554
2129	t	2128	2128	4256	1	\N	\N	2018-07-05 07:52:56.311554
2130	t	2129	2129	4258	2	\N	\N	2018-07-05 07:52:56.311554
2131	t	2130	2130	4260	1	\N	\N	2018-07-05 07:52:56.311554
2132	t	2131	2131	4262	2	\N	\N	2018-07-05 07:52:56.311554
2133	t	2132	2132	4264	1	\N	\N	2018-07-05 07:52:56.311554
2134	t	2133	2133	4266	2	\N	\N	2018-07-05 07:52:56.311554
2135	t	2134	2134	4268	1	\N	\N	2018-07-05 07:52:56.311554
2136	t	2135	2135	4270	2	\N	\N	2018-07-05 07:52:56.311554
2137	t	2136	2136	4272	1	\N	\N	2018-07-05 07:52:56.311554
2138	t	2137	2137	4274	2	\N	\N	2018-07-05 07:52:56.311554
2139	t	2138	2138	4276	1	\N	\N	2018-07-05 07:52:56.311554
2140	t	2139	2139	4278	2	\N	\N	2018-07-05 07:52:56.311554
2141	t	2140	2140	4280	1	\N	\N	2018-07-05 07:52:56.311554
2142	t	2141	2141	4282	2	\N	\N	2018-07-05 07:52:56.311554
2143	t	2142	2142	4284	1	\N	\N	2018-07-05 07:52:56.311554
2144	t	2143	2143	4286	2	\N	\N	2018-07-05 07:52:56.311554
2145	t	2144	2144	4288	1	\N	\N	2018-07-05 07:52:56.311554
2146	t	2145	2145	4290	2	\N	\N	2018-07-05 07:52:56.311554
2147	t	2146	2146	4292	1	\N	\N	2018-07-05 07:52:56.311554
2148	t	2147	2147	4294	2	\N	\N	2018-07-05 07:52:56.311554
2149	t	2148	2148	4296	1	\N	\N	2018-07-05 07:52:56.311554
2150	t	2149	2149	4298	2	\N	\N	2018-07-05 07:52:56.311554
2151	t	2150	2150	4300	1	\N	\N	2018-07-05 07:52:56.311554
2152	t	2151	2151	4302	2	\N	\N	2018-07-05 07:52:56.311554
2153	t	2152	2152	4304	1	\N	\N	2018-07-05 07:52:56.311554
2154	t	2153	2153	4306	2	\N	\N	2018-07-05 07:52:56.311554
2155	t	2154	2154	4308	1	\N	\N	2018-07-05 07:52:56.311554
2156	t	2155	2155	4310	2	\N	\N	2018-07-05 07:52:56.311554
2157	t	2156	2156	4312	1	\N	\N	2018-07-05 07:52:56.311554
2158	t	2157	2157	4314	2	\N	\N	2018-07-05 07:52:56.311554
2159	t	2158	2158	4316	1	\N	\N	2018-07-05 07:52:56.311554
2160	t	2159	2159	4318	2	\N	\N	2018-07-05 07:52:56.311554
2161	t	2160	2160	4320	1	\N	\N	2018-07-05 07:52:56.311554
2162	t	2161	2161	4322	2	\N	\N	2018-07-05 07:52:56.311554
2163	t	2162	2162	4324	1	\N	\N	2018-07-05 07:52:56.311554
2164	t	2163	2163	4326	2	\N	\N	2018-07-05 07:52:56.311554
2165	t	2164	2164	4328	1	\N	\N	2018-07-05 07:52:56.311554
2166	t	2165	2165	4330	2	\N	\N	2018-07-05 07:52:56.311554
2167	t	2166	2166	4332	1	\N	\N	2018-07-05 07:52:56.311554
2168	t	2167	2167	4334	2	\N	\N	2018-07-05 07:52:56.311554
2169	t	2168	2168	4336	1	\N	\N	2018-07-05 07:52:56.311554
2170	t	2169	2169	4338	2	\N	\N	2018-07-05 07:52:56.311554
2171	t	2170	2170	4340	1	\N	\N	2018-07-05 07:52:56.311554
2172	t	2171	2171	4342	2	\N	\N	2018-07-05 07:52:56.311554
2173	t	2172	2172	4344	1	\N	\N	2018-07-05 07:52:56.311554
2174	t	2173	2173	4346	2	\N	\N	2018-07-05 07:52:56.311554
2175	t	2174	2174	4348	1	\N	\N	2018-07-05 07:52:56.311554
2176	t	2175	2175	4350	2	\N	\N	2018-07-05 07:52:56.311554
2177	t	2176	2176	4352	1	\N	\N	2018-07-05 07:52:56.311554
2178	t	2177	2177	4354	2	\N	\N	2018-07-05 07:52:56.311554
2179	t	2178	2178	4356	1	\N	\N	2018-07-05 07:52:56.311554
2180	t	2179	2179	4358	2	\N	\N	2018-07-05 07:52:56.311554
2181	t	2180	2180	4360	1	\N	\N	2018-07-05 07:52:56.311554
2182	t	2181	2181	4362	2	\N	\N	2018-07-05 07:52:56.311554
2183	t	2182	2182	4364	1	\N	\N	2018-07-05 07:52:56.311554
2184	t	2183	2183	4366	2	\N	\N	2018-07-05 07:52:56.311554
2185	t	2184	2184	4368	1	\N	\N	2018-07-05 07:52:56.311554
2186	t	2185	2185	4370	2	\N	\N	2018-07-05 07:52:56.311554
2187	t	2186	2186	4372	1	\N	\N	2018-07-05 07:52:56.311554
2188	t	2187	2187	4374	2	\N	\N	2018-07-05 07:52:56.311554
2189	t	2188	2188	4376	1	\N	\N	2018-07-05 07:52:56.311554
2190	t	2189	2189	4378	2	\N	\N	2018-07-05 07:52:56.311554
2191	t	2190	2190	4380	1	\N	\N	2018-07-05 07:52:56.311554
2192	t	2191	2191	4382	2	\N	\N	2018-07-05 07:52:56.311554
2193	t	2192	2192	4384	1	\N	\N	2018-07-05 07:52:56.311554
2194	t	2193	2193	4386	2	\N	\N	2018-07-05 07:52:56.311554
2195	t	2194	2194	4388	1	\N	\N	2018-07-05 07:52:56.311554
2196	t	2195	2195	4390	2	\N	\N	2018-07-05 07:52:56.311554
2197	t	2196	2196	4392	1	\N	\N	2018-07-05 07:52:56.311554
2198	t	2197	2197	4394	2	\N	\N	2018-07-05 07:52:56.311554
2199	t	2198	2198	4396	1	\N	\N	2018-07-05 07:52:56.311554
2200	t	2199	2199	4398	2	\N	\N	2018-07-05 07:52:56.311554
2201	t	2200	2200	4400	1	\N	\N	2018-07-05 07:52:56.311554
2202	t	2201	2201	4402	2	\N	\N	2018-07-05 07:52:56.311554
2203	t	2202	2202	4404	1	\N	\N	2018-07-05 07:52:56.311554
2204	t	2203	2203	4406	2	\N	\N	2018-07-05 07:52:56.311554
2205	t	2204	2204	4408	1	\N	\N	2018-07-05 07:52:56.311554
2206	t	2205	2205	4410	2	\N	\N	2018-07-05 07:52:56.311554
2207	t	2206	2206	4412	1	\N	\N	2018-07-05 07:52:56.311554
2208	t	2207	2207	4414	2	\N	\N	2018-07-05 07:52:56.311554
2209	t	2208	2208	4416	1	\N	\N	2018-07-05 07:52:56.311554
2210	t	2209	2209	4418	2	\N	\N	2018-07-05 07:52:56.311554
2211	t	2210	2210	4420	1	\N	\N	2018-07-05 07:52:56.311554
2212	t	2211	2211	4422	2	\N	\N	2018-07-05 07:52:56.311554
2213	t	2212	2212	4424	1	\N	\N	2018-07-05 07:52:56.311554
2214	t	2213	2213	4426	2	\N	\N	2018-07-05 07:52:56.311554
2215	t	2214	2214	4428	1	\N	\N	2018-07-05 07:52:56.311554
2216	t	2215	2215	4430	2	\N	\N	2018-07-05 07:52:56.311554
2217	t	2216	2216	4432	1	\N	\N	2018-07-05 07:52:56.311554
2218	t	2217	2217	4434	2	\N	\N	2018-07-05 07:52:56.311554
2219	t	2218	2218	4436	1	\N	\N	2018-07-05 07:52:56.311554
2220	t	2219	2219	4438	2	\N	\N	2018-07-05 07:52:56.311554
2221	t	2220	2220	4440	1	\N	\N	2018-07-05 07:52:56.311554
2222	t	2221	2221	4442	2	\N	\N	2018-07-05 07:52:56.311554
2223	t	2222	2222	4444	1	\N	\N	2018-07-05 07:52:56.311554
2224	t	2223	2223	4446	2	\N	\N	2018-07-05 07:52:56.311554
2225	t	2224	2224	4448	1	\N	\N	2018-07-05 07:52:56.311554
2226	t	2225	2225	4450	2	\N	\N	2018-07-05 07:52:56.311554
2227	t	2226	2226	4452	1	\N	\N	2018-07-05 07:52:56.311554
2228	t	2227	2227	4454	2	\N	\N	2018-07-05 07:52:56.311554
2229	t	2228	2228	4456	1	\N	\N	2018-07-05 07:52:56.311554
2230	t	2229	2229	4458	2	\N	\N	2018-07-05 07:52:56.311554
2231	t	2230	2230	4460	1	\N	\N	2018-07-05 07:52:56.311554
2232	t	2231	2231	4462	2	\N	\N	2018-07-05 07:52:56.311554
2233	t	2232	2232	4464	1	\N	\N	2018-07-05 07:52:56.311554
2234	t	2233	2233	4466	2	\N	\N	2018-07-05 07:52:56.311554
2235	t	2234	2234	4468	1	\N	\N	2018-07-05 07:52:56.311554
2236	t	2235	2235	4470	2	\N	\N	2018-07-05 07:52:56.311554
2237	t	2236	2236	4472	1	\N	\N	2018-07-05 07:52:56.311554
2238	t	2237	2237	4474	2	\N	\N	2018-07-05 07:52:56.311554
2239	t	2238	2238	4476	1	\N	\N	2018-07-05 07:52:56.311554
2240	t	2239	2239	4478	2	\N	\N	2018-07-05 07:52:56.311554
2241	t	2240	2240	4480	1	\N	\N	2018-07-05 07:52:56.311554
2242	t	2241	2241	4482	2	\N	\N	2018-07-05 07:52:56.311554
2243	t	2242	2242	4484	1	\N	\N	2018-07-05 07:52:56.311554
2244	t	2243	2243	4486	2	\N	\N	2018-07-05 07:52:56.311554
2245	t	2244	2244	4488	1	\N	\N	2018-07-05 07:52:56.311554
2246	t	2245	2245	4490	2	\N	\N	2018-07-05 07:52:56.311554
2247	t	2246	2246	4492	1	\N	\N	2018-07-05 07:52:56.311554
2248	t	2247	2247	4494	2	\N	\N	2018-07-05 07:52:56.311554
2249	t	2248	2248	4496	1	\N	\N	2018-07-05 07:52:56.311554
2250	t	2249	2249	4498	2	\N	\N	2018-07-05 07:52:56.311554
2251	t	2250	2250	4500	1	\N	\N	2018-07-05 07:52:56.311554
2252	t	2251	2251	4502	2	\N	\N	2018-07-05 07:52:56.311554
2253	t	2252	2252	4504	1	\N	\N	2018-07-05 07:52:56.311554
2254	t	2253	2253	4506	2	\N	\N	2018-07-05 07:52:56.311554
2255	t	2254	2254	4508	1	\N	\N	2018-07-05 07:52:56.311554
2256	t	2255	2255	4510	2	\N	\N	2018-07-05 07:52:56.311554
2257	t	2256	2256	4512	1	\N	\N	2018-07-05 07:52:56.311554
2258	t	2257	2257	4514	2	\N	\N	2018-07-05 07:52:56.311554
2259	t	2258	2258	4516	1	\N	\N	2018-07-05 07:52:56.311554
2260	t	2259	2259	4518	2	\N	\N	2018-07-05 07:52:56.311554
2261	t	2260	2260	4520	1	\N	\N	2018-07-05 07:52:56.311554
2262	t	2261	2261	4522	2	\N	\N	2018-07-05 07:52:56.311554
2263	t	2262	2262	4524	1	\N	\N	2018-07-05 07:52:56.311554
2264	t	2263	2263	4526	2	\N	\N	2018-07-05 07:52:56.311554
2265	t	2264	2264	4528	1	\N	\N	2018-07-05 07:52:56.311554
2266	t	2265	2265	4530	2	\N	\N	2018-07-05 07:52:56.311554
2267	t	2266	2266	4532	1	\N	\N	2018-07-05 07:52:56.311554
2268	t	2267	2267	4534	2	\N	\N	2018-07-05 07:52:56.311554
2269	t	2268	2268	4536	1	\N	\N	2018-07-05 07:52:56.311554
2270	t	2269	2269	4538	2	\N	\N	2018-07-05 07:52:56.311554
2271	t	2270	2270	4540	1	\N	\N	2018-07-05 07:52:56.311554
2272	t	2271	2271	4542	2	\N	\N	2018-07-05 07:52:56.311554
2273	t	2272	2272	4544	1	\N	\N	2018-07-05 07:52:56.311554
2274	t	2273	2273	4546	2	\N	\N	2018-07-05 07:52:56.311554
2275	t	2274	2274	4548	1	\N	\N	2018-07-05 07:52:56.311554
2276	t	2275	2275	4550	2	\N	\N	2018-07-05 07:52:56.311554
2277	t	2276	2276	4552	1	\N	\N	2018-07-05 07:52:56.311554
2278	t	2277	2277	4554	2	\N	\N	2018-07-05 07:52:56.311554
2279	t	2278	2278	4556	1	\N	\N	2018-07-05 07:52:56.311554
2280	t	2279	2279	4558	2	\N	\N	2018-07-05 07:52:56.311554
2281	t	2280	2280	4560	1	\N	\N	2018-07-05 07:52:56.311554
2282	t	2281	2281	4562	2	\N	\N	2018-07-05 07:52:56.311554
2283	t	2282	2282	4564	1	\N	\N	2018-07-05 07:52:56.311554
2284	t	2283	2283	4566	2	\N	\N	2018-07-05 07:52:56.311554
2285	t	2284	2284	4568	1	\N	\N	2018-07-05 07:52:56.311554
2286	t	2285	2285	4570	2	\N	\N	2018-07-05 07:52:56.311554
2287	t	2286	2286	4572	1	\N	\N	2018-07-05 07:52:56.311554
2288	t	2287	2287	4574	2	\N	\N	2018-07-05 07:52:56.311554
2289	t	2288	2288	4576	1	\N	\N	2018-07-05 07:52:56.311554
2290	t	2289	2289	4578	2	\N	\N	2018-07-05 07:52:56.311554
2291	t	2290	2290	4580	1	\N	\N	2018-07-05 07:52:56.311554
2292	t	2291	2291	4582	2	\N	\N	2018-07-05 07:52:56.311554
2293	t	2292	2292	4584	1	\N	\N	2018-07-05 07:52:56.311554
2294	t	2293	2293	4586	2	\N	\N	2018-07-05 07:52:56.311554
2295	t	2294	2294	4588	1	\N	\N	2018-07-05 07:52:56.311554
2296	t	2295	2295	4590	2	\N	\N	2018-07-05 07:52:56.311554
2297	t	2296	2296	4592	1	\N	\N	2018-07-05 07:52:56.311554
2298	t	2297	2297	4594	2	\N	\N	2018-07-05 07:52:56.311554
2299	t	2298	2298	4596	1	\N	\N	2018-07-05 07:52:56.311554
2300	t	2299	2299	4598	2	\N	\N	2018-07-05 07:52:56.311554
2301	t	2300	2300	4600	1	\N	\N	2018-07-05 07:52:56.311554
2302	t	2301	2301	4602	2	\N	\N	2018-07-05 07:52:56.311554
2303	t	2302	2302	4604	1	\N	\N	2018-07-05 07:52:56.311554
2304	t	2303	2303	4606	2	\N	\N	2018-07-05 07:52:56.311554
2305	t	2304	2304	4608	1	\N	\N	2018-07-05 07:52:56.311554
2306	t	2305	2305	4610	2	\N	\N	2018-07-05 07:52:56.311554
2307	t	2306	2306	4612	1	\N	\N	2018-07-05 07:52:56.311554
2308	t	2307	2307	4614	2	\N	\N	2018-07-05 07:52:56.311554
2309	t	2308	2308	4616	1	\N	\N	2018-07-05 07:52:56.311554
2310	t	2309	2309	4618	2	\N	\N	2018-07-05 07:52:56.311554
2311	t	2310	2310	4620	1	\N	\N	2018-07-05 07:52:56.311554
2312	t	2311	2311	4622	2	\N	\N	2018-07-05 07:52:56.311554
2313	t	2312	2312	4624	1	\N	\N	2018-07-05 07:52:56.311554
2314	t	2313	2313	4626	2	\N	\N	2018-07-05 07:52:56.311554
2315	t	2314	2314	4628	1	\N	\N	2018-07-05 07:52:56.311554
2316	t	2315	2315	4630	2	\N	\N	2018-07-05 07:52:56.311554
2317	t	2316	2316	4632	1	\N	\N	2018-07-05 07:52:56.311554
2318	t	2317	2317	4634	2	\N	\N	2018-07-05 07:52:56.311554
2319	t	2318	2318	4636	1	\N	\N	2018-07-05 07:52:56.311554
2320	t	2319	2319	4638	2	\N	\N	2018-07-05 07:52:56.311554
2321	t	2320	2320	4640	1	\N	\N	2018-07-05 07:52:56.311554
2322	t	2321	2321	4642	2	\N	\N	2018-07-05 07:52:56.311554
2323	t	2322	2322	4644	1	\N	\N	2018-07-05 07:52:56.311554
2324	t	2323	2323	4646	2	\N	\N	2018-07-05 07:52:56.311554
2325	t	2324	2324	4648	1	\N	\N	2018-07-05 07:52:56.311554
2326	t	2325	2325	4650	2	\N	\N	2018-07-05 07:52:56.311554
2327	t	2326	2326	4652	1	\N	\N	2018-07-05 07:52:56.311554
2328	t	2327	2327	4654	2	\N	\N	2018-07-05 07:52:56.311554
2329	t	2328	2328	4656	1	\N	\N	2018-07-05 07:52:56.311554
2330	t	2329	2329	4658	2	\N	\N	2018-07-05 07:52:56.311554
2331	t	2330	2330	4660	1	\N	\N	2018-07-05 07:52:56.311554
2332	t	2331	2331	4662	2	\N	\N	2018-07-05 07:52:56.311554
2333	t	2332	2332	4664	1	\N	\N	2018-07-05 07:52:56.311554
2334	t	2333	2333	4666	2	\N	\N	2018-07-05 07:52:56.311554
2335	t	2334	2334	4668	1	\N	\N	2018-07-05 07:52:56.311554
2336	t	2335	2335	4670	2	\N	\N	2018-07-05 07:52:56.311554
2337	t	2336	2336	4672	1	\N	\N	2018-07-05 07:52:56.311554
2338	t	2337	2337	4674	2	\N	\N	2018-07-05 07:52:56.311554
2339	t	2338	2338	4676	1	\N	\N	2018-07-05 07:52:56.311554
2340	t	2339	2339	4678	2	\N	\N	2018-07-05 07:52:56.311554
2341	t	2340	2340	4680	1	\N	\N	2018-07-05 07:52:56.311554
2342	t	2341	2341	4682	2	\N	\N	2018-07-05 07:52:56.311554
2343	t	2342	2342	4684	1	\N	\N	2018-07-05 07:52:56.311554
2344	t	2343	2343	4686	2	\N	\N	2018-07-05 07:52:56.311554
2345	t	2344	2344	4688	1	\N	\N	2018-07-05 07:52:56.311554
2346	t	2345	2345	4690	2	\N	\N	2018-07-05 07:52:56.311554
2347	t	2346	2346	4692	1	\N	\N	2018-07-05 07:52:56.311554
2348	t	2347	2347	4694	2	\N	\N	2018-07-05 07:52:56.311554
2349	t	2348	2348	4696	1	\N	\N	2018-07-05 07:52:56.311554
2350	t	2349	2349	4698	2	\N	\N	2018-07-05 07:52:56.311554
2351	t	2350	2350	4700	1	\N	\N	2018-07-05 07:52:56.311554
2352	t	2351	2351	4702	2	\N	\N	2018-07-05 07:52:56.311554
2353	t	2352	2352	4704	1	\N	\N	2018-07-05 07:52:56.311554
2354	t	2353	2353	4706	2	\N	\N	2018-07-05 07:52:56.311554
2355	t	2354	2354	4708	1	\N	\N	2018-07-05 07:52:56.311554
2356	t	2355	2355	4710	2	\N	\N	2018-07-05 07:52:56.311554
2357	t	2356	2356	4712	1	\N	\N	2018-07-05 07:52:56.311554
2358	t	2357	2357	4714	2	\N	\N	2018-07-05 07:52:56.311554
2359	t	2358	2358	4716	1	\N	\N	2018-07-05 07:52:56.311554
2360	t	2359	2359	4718	2	\N	\N	2018-07-05 07:52:56.311554
2361	t	2360	2360	4720	1	\N	\N	2018-07-05 07:52:56.311554
2362	t	2361	2361	4722	2	\N	\N	2018-07-05 07:52:56.311554
2363	t	2362	2362	4724	1	\N	\N	2018-07-05 07:52:56.311554
2364	t	2363	2363	4726	2	\N	\N	2018-07-05 07:52:56.311554
2365	t	2364	2364	4728	1	\N	\N	2018-07-05 07:52:56.311554
2366	t	2365	2365	4730	2	\N	\N	2018-07-05 07:52:56.311554
2367	t	2366	2366	4732	1	\N	\N	2018-07-05 07:52:56.311554
2368	t	2367	2367	4734	2	\N	\N	2018-07-05 07:52:56.311554
2369	t	2368	2368	4736	1	\N	\N	2018-07-05 07:52:56.311554
2370	t	2369	2369	4738	2	\N	\N	2018-07-05 07:52:56.311554
2371	t	2370	2370	4740	1	\N	\N	2018-07-05 07:52:56.311554
2372	t	2371	2371	4742	2	\N	\N	2018-07-05 07:52:56.311554
2373	t	2372	2372	4744	1	\N	\N	2018-07-05 07:52:56.311554
2374	t	2373	2373	4746	2	\N	\N	2018-07-05 07:52:56.311554
2375	t	2374	2374	4748	1	\N	\N	2018-07-05 07:52:56.311554
2376	t	2375	2375	4750	2	\N	\N	2018-07-05 07:52:56.311554
2377	t	2376	2376	4752	1	\N	\N	2018-07-05 07:52:56.311554
2378	t	2377	2377	4754	2	\N	\N	2018-07-05 07:52:56.311554
2379	t	2378	2378	4756	1	\N	\N	2018-07-05 07:52:56.311554
2380	t	2379	2379	4758	2	\N	\N	2018-07-05 07:52:56.311554
2381	t	2380	2380	4760	1	\N	\N	2018-07-05 07:52:56.311554
2382	t	2381	2381	4762	2	\N	\N	2018-07-05 07:52:56.311554
2383	t	2382	2382	4764	1	\N	\N	2018-07-05 07:52:56.311554
2384	t	2383	2383	4766	2	\N	\N	2018-07-05 07:52:56.311554
2385	t	2384	2384	4768	1	\N	\N	2018-07-05 07:52:56.311554
2386	t	2385	2385	4770	2	\N	\N	2018-07-05 07:52:56.311554
2387	t	2386	2386	4772	1	\N	\N	2018-07-05 07:52:56.311554
2388	t	2387	2387	4774	2	\N	\N	2018-07-05 07:52:56.311554
2389	t	2388	2388	4776	1	\N	\N	2018-07-05 07:52:56.311554
2390	t	2389	2389	4778	2	\N	\N	2018-07-05 07:52:56.311554
2391	t	2390	2390	4780	1	\N	\N	2018-07-05 07:52:56.311554
2392	t	2391	2391	4782	2	\N	\N	2018-07-05 07:52:56.311554
2393	t	2392	2392	4784	1	\N	\N	2018-07-05 07:52:56.311554
2394	t	2393	2393	4786	2	\N	\N	2018-07-05 07:52:56.311554
2395	t	2394	2394	4788	1	\N	\N	2018-07-05 07:52:56.311554
2396	t	2395	2395	4790	2	\N	\N	2018-07-05 07:52:56.311554
2397	t	2396	2396	4792	1	\N	\N	2018-07-05 07:52:56.311554
2398	t	2397	2397	4794	2	\N	\N	2018-07-05 07:52:56.311554
2399	t	2398	2398	4796	1	\N	\N	2018-07-05 07:52:56.311554
2400	t	2399	2399	4798	2	\N	\N	2018-07-05 07:52:56.311554
2401	t	2400	2400	4800	1	\N	\N	2018-07-05 07:52:56.311554
2402	t	2401	2401	4802	2	\N	\N	2018-07-05 07:52:56.311554
2403	t	2402	2402	4804	1	\N	\N	2018-07-05 07:52:56.311554
2404	t	2403	2403	4806	2	\N	\N	2018-07-05 07:52:56.311554
2405	t	2404	2404	4808	1	\N	\N	2018-07-05 07:52:56.311554
2406	t	2405	2405	4810	2	\N	\N	2018-07-05 07:52:56.311554
2407	t	2406	2406	4812	1	\N	\N	2018-07-05 07:52:56.311554
2408	t	2407	2407	4814	2	\N	\N	2018-07-05 07:52:56.311554
2409	t	2408	2408	4816	1	\N	\N	2018-07-05 07:52:56.311554
2410	t	2409	2409	4818	2	\N	\N	2018-07-05 07:52:56.311554
2411	t	2410	2410	4820	1	\N	\N	2018-07-05 07:52:56.311554
2412	t	2411	2411	4822	2	\N	\N	2018-07-05 07:52:56.311554
2413	t	2412	2412	4824	1	\N	\N	2018-07-05 07:52:56.311554
2414	t	2413	2413	4826	2	\N	\N	2018-07-05 07:52:56.311554
2415	t	2414	2414	4828	1	\N	\N	2018-07-05 07:52:56.311554
2416	t	2415	2415	4830	2	\N	\N	2018-07-05 07:52:56.311554
2417	t	2416	2416	4832	1	\N	\N	2018-07-05 07:52:56.311554
2418	t	2417	2417	4834	2	\N	\N	2018-07-05 07:52:56.311554
2419	t	2418	2418	4836	1	\N	\N	2018-07-05 07:52:56.311554
2420	t	2419	2419	4838	2	\N	\N	2018-07-05 07:52:56.311554
2421	t	2420	2420	4840	1	\N	\N	2018-07-05 07:52:56.311554
2422	t	2421	2421	4842	2	\N	\N	2018-07-05 07:52:56.311554
2423	t	2422	2422	4844	1	\N	\N	2018-07-05 07:52:56.311554
2424	t	2423	2423	4846	2	\N	\N	2018-07-05 07:52:56.311554
2425	t	2424	2424	4848	1	\N	\N	2018-07-05 07:52:56.311554
2426	t	2425	2425	4850	2	\N	\N	2018-07-05 07:52:56.311554
2427	t	2426	2426	4852	1	\N	\N	2018-07-05 07:52:56.311554
2428	t	2427	2427	4854	2	\N	\N	2018-07-05 07:52:56.311554
2429	t	2428	2428	4856	1	\N	\N	2018-07-05 07:52:56.311554
2430	t	2429	2429	4858	2	\N	\N	2018-07-05 07:52:56.311554
2431	t	2430	2430	4860	1	\N	\N	2018-07-05 07:52:56.311554
2432	t	2431	2431	4862	2	\N	\N	2018-07-05 07:52:56.311554
2433	t	2432	2432	4864	1	\N	\N	2018-07-05 07:52:56.311554
2434	t	2433	2433	4866	2	\N	\N	2018-07-05 07:52:56.311554
2435	t	2434	2434	4868	1	\N	\N	2018-07-05 07:52:56.311554
2436	t	2435	2435	4870	2	\N	\N	2018-07-05 07:52:56.311554
2437	t	2436	2436	4872	1	\N	\N	2018-07-05 07:52:56.311554
2438	t	2437	2437	4874	2	\N	\N	2018-07-05 07:52:56.311554
2439	t	2438	2438	4876	1	\N	\N	2018-07-05 07:52:56.311554
2440	t	2439	2439	4878	2	\N	\N	2018-07-05 07:52:56.311554
2441	t	2440	2440	4880	1	\N	\N	2018-07-05 07:52:56.311554
2442	t	2441	2441	4882	2	\N	\N	2018-07-05 07:52:56.311554
2443	t	2442	2442	4884	1	\N	\N	2018-07-05 07:52:56.311554
2444	t	2443	2443	4886	2	\N	\N	2018-07-05 07:52:56.311554
2445	t	2444	2444	4888	1	\N	\N	2018-07-05 07:52:56.311554
2446	t	2445	2445	4890	2	\N	\N	2018-07-05 07:52:56.311554
2447	t	2446	2446	4892	1	\N	\N	2018-07-05 07:52:56.311554
2448	t	2447	2447	4894	2	\N	\N	2018-07-05 07:52:56.311554
2449	t	2448	2448	4896	1	\N	\N	2018-07-05 07:52:56.311554
2450	t	2449	2449	4898	2	\N	\N	2018-07-05 07:52:56.311554
2451	t	2450	2450	4900	1	\N	\N	2018-07-05 07:52:56.311554
2452	t	2451	2451	4902	2	\N	\N	2018-07-05 07:52:56.311554
2453	t	2452	2452	4904	1	\N	\N	2018-07-05 07:52:56.311554
2454	t	2453	2453	4906	2	\N	\N	2018-07-05 07:52:56.311554
2455	t	2454	2454	4908	1	\N	\N	2018-07-05 07:52:56.311554
2456	t	2455	2455	4910	2	\N	\N	2018-07-05 07:52:56.311554
2457	t	2456	2456	4912	1	\N	\N	2018-07-05 07:52:56.311554
2458	t	2457	2457	4914	2	\N	\N	2018-07-05 07:52:56.311554
2459	t	2458	2458	4916	1	\N	\N	2018-07-05 07:52:56.311554
2460	t	2459	2459	4918	2	\N	\N	2018-07-05 07:52:56.311554
2461	t	2460	2460	4920	1	\N	\N	2018-07-05 07:52:56.311554
2462	t	2461	2461	4922	2	\N	\N	2018-07-05 07:52:56.311554
2463	t	2462	2462	4924	1	\N	\N	2018-07-05 07:52:56.311554
2464	t	2463	2463	4926	2	\N	\N	2018-07-05 07:52:56.311554
2465	t	2464	2464	4928	1	\N	\N	2018-07-05 07:52:56.311554
2466	t	2465	2465	4930	2	\N	\N	2018-07-05 07:52:56.311554
2467	t	2466	2466	4932	1	\N	\N	2018-07-05 07:52:56.311554
2468	t	2467	2467	4934	2	\N	\N	2018-07-05 07:52:56.311554
2469	t	2468	2468	4936	1	\N	\N	2018-07-05 07:52:56.311554
2470	t	2469	2469	4938	2	\N	\N	2018-07-05 07:52:56.311554
2471	t	2470	2470	4940	1	\N	\N	2018-07-05 07:52:56.311554
2472	t	2471	2471	4942	2	\N	\N	2018-07-05 07:52:56.311554
2473	t	2472	2472	4944	1	\N	\N	2018-07-05 07:52:56.311554
2474	t	2473	2473	4946	2	\N	\N	2018-07-05 07:52:56.311554
2475	t	2474	2474	4948	1	\N	\N	2018-07-05 07:52:56.311554
2476	t	2475	2475	4950	2	\N	\N	2018-07-05 07:52:56.311554
2477	t	2476	2476	4952	1	\N	\N	2018-07-05 07:52:56.311554
2478	t	2477	2477	4954	2	\N	\N	2018-07-05 07:52:56.311554
2479	t	2478	2478	4956	1	\N	\N	2018-07-05 07:52:56.311554
2480	t	2479	2479	4958	2	\N	\N	2018-07-05 07:52:56.311554
2481	t	2480	2480	4960	1	\N	\N	2018-07-05 07:52:56.311554
2482	t	2481	2481	4962	2	\N	\N	2018-07-05 07:52:56.311554
2483	t	2482	2482	4964	1	\N	\N	2018-07-05 07:52:56.311554
2484	t	2483	2483	4966	2	\N	\N	2018-07-05 07:52:56.311554
2485	t	2484	2484	4968	1	\N	\N	2018-07-05 07:52:56.311554
2486	t	2485	2485	4970	2	\N	\N	2018-07-05 07:52:56.311554
2487	t	2486	2486	4972	1	\N	\N	2018-07-05 07:52:56.311554
2488	t	2487	2487	4974	2	\N	\N	2018-07-05 07:52:56.311554
2489	t	2488	2488	4976	1	\N	\N	2018-07-05 07:52:56.311554
2490	t	2489	2489	4978	2	\N	\N	2018-07-05 07:52:56.311554
2491	t	2490	2490	4980	1	\N	\N	2018-07-05 07:52:56.311554
2492	t	2491	2491	4982	2	\N	\N	2018-07-05 07:52:56.311554
2493	t	2492	2492	4984	1	\N	\N	2018-07-05 07:52:56.311554
2494	t	2493	2493	4986	2	\N	\N	2018-07-05 07:52:56.311554
2495	t	2494	2494	4988	1	\N	\N	2018-07-05 07:52:56.311554
2496	t	2495	2495	4990	2	\N	\N	2018-07-05 07:52:56.311554
2497	t	2496	2496	4992	1	\N	\N	2018-07-05 07:52:56.311554
2498	t	2497	2497	4994	2	\N	\N	2018-07-05 07:52:56.311554
2499	t	2498	2498	4996	1	\N	\N	2018-07-05 07:52:56.311554
2500	t	2499	2499	4998	2	\N	\N	2018-07-05 07:52:56.311554
2501	t	2500	2500	5000	1	\N	\N	2018-07-05 07:52:56.311554
2502	t	2501	2501	5002	2	\N	\N	2018-07-05 07:52:56.311554
2503	t	2502	2502	5004	1	\N	\N	2018-07-05 07:52:56.311554
2504	t	2503	2503	5006	2	\N	\N	2018-07-05 07:52:56.311554
2505	t	2504	2504	5008	1	\N	\N	2018-07-05 07:52:56.311554
2506	t	2505	2505	5010	2	\N	\N	2018-07-05 07:52:56.311554
2507	t	2506	2506	5012	1	\N	\N	2018-07-05 07:52:56.311554
2508	t	2507	2507	5014	2	\N	\N	2018-07-05 07:52:56.311554
2509	t	2508	2508	5016	1	\N	\N	2018-07-05 07:52:56.311554
2510	t	2509	2509	5018	2	\N	\N	2018-07-05 07:52:56.311554
2511	t	2510	2510	5020	1	\N	\N	2018-07-05 07:52:56.311554
2512	t	2511	2511	5022	2	\N	\N	2018-07-05 07:52:56.311554
2513	t	2512	2512	5024	1	\N	\N	2018-07-05 07:52:56.311554
2514	t	2513	2513	5026	2	\N	\N	2018-07-05 07:52:56.311554
2515	t	2514	2514	5028	1	\N	\N	2018-07-05 07:52:56.311554
2516	t	2515	2515	5030	2	\N	\N	2018-07-05 07:52:56.311554
2517	t	2516	2516	5032	1	\N	\N	2018-07-05 07:52:56.311554
2518	t	2517	2517	5034	2	\N	\N	2018-07-05 07:52:56.311554
2519	t	2518	2518	5036	1	\N	\N	2018-07-05 07:52:56.311554
2520	t	2519	2519	5038	2	\N	\N	2018-07-05 07:52:56.311554
2521	t	2520	2520	5040	1	\N	\N	2018-07-05 07:52:56.311554
2522	t	2521	2521	5042	2	\N	\N	2018-07-05 07:52:56.311554
2523	t	2522	2522	5044	1	\N	\N	2018-07-05 07:52:56.311554
2524	t	2523	2523	5046	2	\N	\N	2018-07-05 07:52:56.311554
2525	t	2524	2524	5048	1	\N	\N	2018-07-05 07:52:56.311554
2526	t	2525	2525	5050	2	\N	\N	2018-07-05 07:52:56.311554
2527	t	2526	2526	5052	1	\N	\N	2018-07-05 07:52:56.311554
2528	t	2527	2527	5054	2	\N	\N	2018-07-05 07:52:56.311554
2529	t	2528	2528	5056	1	\N	\N	2018-07-05 07:52:56.311554
2530	t	2529	2529	5058	2	\N	\N	2018-07-05 07:52:56.311554
2531	t	2530	2530	5060	1	\N	\N	2018-07-05 07:52:56.311554
2532	t	2531	2531	5062	2	\N	\N	2018-07-05 07:52:56.311554
2533	t	2532	2532	5064	1	\N	\N	2018-07-05 07:52:56.311554
2534	t	2533	2533	5066	2	\N	\N	2018-07-05 07:52:56.311554
2535	t	2534	2534	5068	1	\N	\N	2018-07-05 07:52:56.311554
2536	t	2535	2535	5070	2	\N	\N	2018-07-05 07:52:56.311554
2537	t	2536	2536	5072	1	\N	\N	2018-07-05 07:52:56.311554
2538	t	2537	2537	5074	2	\N	\N	2018-07-05 07:52:56.311554
2539	t	2538	2538	5076	1	\N	\N	2018-07-05 07:52:56.311554
2540	t	2539	2539	5078	2	\N	\N	2018-07-05 07:52:56.311554
2541	t	2540	2540	5080	1	\N	\N	2018-07-05 07:52:56.311554
2542	t	2541	2541	5082	2	\N	\N	2018-07-05 07:52:56.311554
2543	t	2542	2542	5084	1	\N	\N	2018-07-05 07:52:56.311554
2544	t	2543	2543	5086	2	\N	\N	2018-07-05 07:52:56.311554
2545	t	2544	2544	5088	1	\N	\N	2018-07-05 07:52:56.311554
2546	t	2545	2545	5090	2	\N	\N	2018-07-05 07:52:56.311554
2547	t	2546	2546	5092	1	\N	\N	2018-07-05 07:52:56.311554
2548	t	2547	2547	5094	2	\N	\N	2018-07-05 07:52:56.311554
2549	t	2548	2548	5096	1	\N	\N	2018-07-05 07:52:56.311554
2550	t	2549	2549	5098	2	\N	\N	2018-07-05 07:52:56.311554
2551	t	2550	2550	5100	1	\N	\N	2018-07-05 07:52:56.311554
2552	t	2551	2551	5102	2	\N	\N	2018-07-05 07:52:56.311554
2553	t	2552	2552	5104	1	\N	\N	2018-07-05 07:52:56.311554
2554	t	2553	2553	5106	2	\N	\N	2018-07-05 07:52:56.311554
2555	t	2554	2554	5108	1	\N	\N	2018-07-05 07:52:56.311554
2556	t	2555	2555	5110	2	\N	\N	2018-07-05 07:52:56.311554
2557	t	2556	2556	5112	1	\N	\N	2018-07-05 07:52:56.311554
2558	t	2557	2557	5114	2	\N	\N	2018-07-05 07:52:56.311554
2559	t	2558	2558	5116	1	\N	\N	2018-07-05 07:52:56.311554
2560	t	2559	2559	5118	2	\N	\N	2018-07-05 07:52:56.311554
2561	t	2560	2560	5120	1	\N	\N	2018-07-05 07:52:56.311554
2562	t	2561	2561	5122	2	\N	\N	2018-07-05 07:52:56.311554
2563	t	2562	2562	5124	1	\N	\N	2018-07-05 07:52:56.311554
2564	t	2563	2563	5126	2	\N	\N	2018-07-05 07:52:56.311554
2565	t	2564	2564	5128	1	\N	\N	2018-07-05 07:52:56.311554
2566	t	2565	2565	5130	2	\N	\N	2018-07-05 07:52:56.311554
2567	t	2566	2566	5132	1	\N	\N	2018-07-05 07:52:56.311554
2568	t	2567	2567	5134	2	\N	\N	2018-07-05 07:52:56.311554
2569	t	2568	2568	5136	1	\N	\N	2018-07-05 07:52:56.311554
2570	t	2569	2569	5138	2	\N	\N	2018-07-05 07:52:56.311554
2571	t	2570	2570	5140	1	\N	\N	2018-07-05 07:52:56.311554
2572	t	2571	2571	5142	2	\N	\N	2018-07-05 07:52:56.311554
2573	t	2572	2572	5144	1	\N	\N	2018-07-05 07:52:56.311554
2574	t	2573	2573	5146	2	\N	\N	2018-07-05 07:52:56.311554
2575	t	2574	2574	5148	1	\N	\N	2018-07-05 07:52:56.311554
2576	t	2575	2575	5150	2	\N	\N	2018-07-05 07:52:56.311554
2577	t	2576	2576	5152	1	\N	\N	2018-07-05 07:52:56.311554
2578	t	2577	2577	5154	2	\N	\N	2018-07-05 07:52:56.311554
2579	t	2578	2578	5156	1	\N	\N	2018-07-05 07:52:56.311554
2580	t	2579	2579	5158	2	\N	\N	2018-07-05 07:52:56.311554
2581	t	2580	2580	5160	1	\N	\N	2018-07-05 07:52:56.311554
2582	t	2581	2581	5162	2	\N	\N	2018-07-05 07:52:56.311554
2583	t	2582	2582	5164	1	\N	\N	2018-07-05 07:52:56.311554
2584	t	2583	2583	5166	2	\N	\N	2018-07-05 07:52:56.311554
2585	t	2584	2584	5168	1	\N	\N	2018-07-05 07:52:56.311554
2586	t	2585	2585	5170	2	\N	\N	2018-07-05 07:52:56.311554
2587	t	2586	2586	5172	1	\N	\N	2018-07-05 07:52:56.311554
2588	t	2587	2587	5174	2	\N	\N	2018-07-05 07:52:56.311554
2589	t	2588	2588	5176	1	\N	\N	2018-07-05 07:52:56.311554
2590	t	2589	2589	5178	2	\N	\N	2018-07-05 07:52:56.311554
2591	t	2590	2590	5180	1	\N	\N	2018-07-05 07:52:56.311554
2592	t	2591	2591	5182	2	\N	\N	2018-07-05 07:52:56.311554
2593	t	2592	2592	5184	1	\N	\N	2018-07-05 07:52:56.311554
2594	t	2593	2593	5186	2	\N	\N	2018-07-05 07:52:56.311554
2595	t	2594	2594	5188	1	\N	\N	2018-07-05 07:52:56.311554
2596	t	2595	2595	5190	2	\N	\N	2018-07-05 07:52:56.311554
2597	t	2596	2596	5192	1	\N	\N	2018-07-05 07:52:56.311554
2598	t	2597	2597	5194	2	\N	\N	2018-07-05 07:52:56.311554
2599	t	2598	2598	5196	1	\N	\N	2018-07-05 07:52:56.311554
2600	t	2599	2599	5198	2	\N	\N	2018-07-05 07:52:56.311554
2601	t	2600	2600	5200	1	\N	\N	2018-07-05 07:52:56.311554
2602	t	2601	2601	5202	2	\N	\N	2018-07-05 07:52:56.311554
2603	t	2602	2602	5204	1	\N	\N	2018-07-05 07:52:56.311554
2604	t	2603	2603	5206	2	\N	\N	2018-07-05 07:52:56.311554
2605	t	2604	2604	5208	1	\N	\N	2018-07-05 07:52:56.311554
2606	t	2605	2605	5210	2	\N	\N	2018-07-05 07:52:56.311554
2607	t	2606	2606	5212	1	\N	\N	2018-07-05 07:52:56.311554
2608	t	2607	2607	5214	2	\N	\N	2018-07-05 07:52:56.311554
2609	t	2608	2608	5216	1	\N	\N	2018-07-05 07:52:56.311554
2610	t	2609	2609	5218	2	\N	\N	2018-07-05 07:52:56.311554
2611	t	2610	2610	5220	1	\N	\N	2018-07-05 07:52:56.311554
2612	t	2611	2611	5222	2	\N	\N	2018-07-05 07:52:56.311554
2613	t	2612	2612	5224	1	\N	\N	2018-07-05 07:52:56.311554
2614	t	2613	2613	5226	2	\N	\N	2018-07-05 07:52:56.311554
2615	t	2614	2614	5228	1	\N	\N	2018-07-05 07:52:56.311554
2616	t	2615	2615	5230	2	\N	\N	2018-07-05 07:52:56.311554
2617	t	2616	2616	5232	1	\N	\N	2018-07-05 07:52:56.311554
2618	t	2617	2617	5234	2	\N	\N	2018-07-05 07:52:56.311554
2619	t	2618	2618	5236	1	\N	\N	2018-07-05 07:52:56.311554
2620	t	2619	2619	5238	2	\N	\N	2018-07-05 07:52:56.311554
2621	t	2620	2620	5240	1	\N	\N	2018-07-05 07:52:56.311554
2622	t	2621	2621	5242	2	\N	\N	2018-07-05 07:52:56.311554
2623	t	2622	2622	5244	1	\N	\N	2018-07-05 07:52:56.311554
2624	t	2623	2623	5246	2	\N	\N	2018-07-05 07:52:56.311554
2625	t	2624	2624	5248	1	\N	\N	2018-07-05 07:52:56.311554
2626	t	2625	2625	5250	2	\N	\N	2018-07-05 07:52:56.311554
2627	t	2626	2626	5252	1	\N	\N	2018-07-05 07:52:56.311554
2628	t	2627	2627	5254	2	\N	\N	2018-07-05 07:52:56.311554
2629	t	2628	2628	5256	1	\N	\N	2018-07-05 07:52:56.311554
2630	t	2629	2629	5258	2	\N	\N	2018-07-05 07:52:56.311554
2631	t	2630	2630	5260	1	\N	\N	2018-07-05 07:52:56.311554
2632	t	2631	2631	5262	2	\N	\N	2018-07-05 07:52:56.311554
2633	t	2632	2632	5264	1	\N	\N	2018-07-05 07:52:56.311554
2634	t	2633	2633	5266	2	\N	\N	2018-07-05 07:52:56.311554
2635	t	2634	2634	5268	1	\N	\N	2018-07-05 07:52:56.311554
2636	t	2635	2635	5270	2	\N	\N	2018-07-05 07:52:56.311554
2637	t	2636	2636	5272	1	\N	\N	2018-07-05 07:52:56.311554
2638	t	2637	2637	5274	2	\N	\N	2018-07-05 07:52:56.311554
2639	t	2638	2638	5276	1	\N	\N	2018-07-05 07:52:56.311554
2640	t	2639	2639	5278	2	\N	\N	2018-07-05 07:52:56.311554
2641	t	2640	2640	5280	1	\N	\N	2018-07-05 07:52:56.311554
2642	t	2641	2641	5282	2	\N	\N	2018-07-05 07:52:56.311554
2643	t	2642	2642	5284	1	\N	\N	2018-07-05 07:52:56.311554
2644	t	2643	2643	5286	2	\N	\N	2018-07-05 07:52:56.311554
2645	t	2644	2644	5288	1	\N	\N	2018-07-05 07:52:56.311554
2646	t	2645	2645	5290	2	\N	\N	2018-07-05 07:52:56.311554
2647	t	2646	2646	5292	1	\N	\N	2018-07-05 07:52:56.311554
2648	t	2647	2647	5294	2	\N	\N	2018-07-05 07:52:56.311554
2649	t	2648	2648	5296	1	\N	\N	2018-07-05 07:52:56.311554
2650	t	2649	2649	5298	2	\N	\N	2018-07-05 07:52:56.311554
2651	t	2650	2650	5300	1	\N	\N	2018-07-05 07:52:56.311554
2652	t	2651	2651	5302	2	\N	\N	2018-07-05 07:52:56.311554
2653	t	2652	2652	5304	1	\N	\N	2018-07-05 07:52:56.311554
2654	t	2653	2653	5306	2	\N	\N	2018-07-05 07:52:56.311554
2655	t	2654	2654	5308	1	\N	\N	2018-07-05 07:52:56.311554
2656	t	2655	2655	5310	2	\N	\N	2018-07-05 07:52:56.311554
2657	t	2656	2656	5312	1	\N	\N	2018-07-05 07:52:56.311554
2658	t	2657	2657	5314	2	\N	\N	2018-07-05 07:52:56.311554
2659	t	2658	2658	5316	1	\N	\N	2018-07-05 07:52:56.311554
2660	t	2659	2659	5318	2	\N	\N	2018-07-05 07:52:56.311554
2661	t	2660	2660	5320	1	\N	\N	2018-07-05 07:52:56.311554
2662	t	2661	2661	5322	2	\N	\N	2018-07-05 07:52:56.311554
2663	t	2662	2662	5324	1	\N	\N	2018-07-05 07:52:56.311554
2664	t	2663	2663	5326	2	\N	\N	2018-07-05 07:52:56.311554
2665	t	2664	2664	5328	1	\N	\N	2018-07-05 07:52:56.311554
2666	t	2665	2665	5330	2	\N	\N	2018-07-05 07:52:56.311554
2667	t	2666	2666	5332	1	\N	\N	2018-07-05 07:52:56.311554
2668	t	2667	2667	5334	2	\N	\N	2018-07-05 07:52:56.311554
2669	t	2668	2668	5336	1	\N	\N	2018-07-05 07:52:56.311554
2670	t	2669	2669	5338	2	\N	\N	2018-07-05 07:52:56.311554
2671	t	2670	2670	5340	1	\N	\N	2018-07-05 07:52:56.311554
2672	t	2671	2671	5342	2	\N	\N	2018-07-05 07:52:56.311554
2673	t	2672	2672	5344	1	\N	\N	2018-07-05 07:52:56.311554
2674	t	2673	2673	5346	2	\N	\N	2018-07-05 07:52:56.311554
2675	t	2674	2674	5348	1	\N	\N	2018-07-05 07:52:56.311554
2676	t	2675	2675	5350	2	\N	\N	2018-07-05 07:52:56.311554
2677	t	2676	2676	5352	1	\N	\N	2018-07-05 07:52:56.311554
2678	t	2677	2677	5354	2	\N	\N	2018-07-05 07:52:56.311554
2679	t	2678	2678	5356	1	\N	\N	2018-07-05 07:52:56.311554
2680	t	2679	2679	5358	2	\N	\N	2018-07-05 07:52:56.311554
2681	t	2680	2680	5360	1	\N	\N	2018-07-05 07:52:56.311554
2682	t	2681	2681	5362	2	\N	\N	2018-07-05 07:52:56.311554
2683	t	2682	2682	5364	1	\N	\N	2018-07-05 07:52:56.311554
2684	t	2683	2683	5366	2	\N	\N	2018-07-05 07:52:56.311554
2685	t	2684	2684	5368	1	\N	\N	2018-07-05 07:52:56.311554
2686	t	2685	2685	5370	2	\N	\N	2018-07-05 07:52:56.311554
2687	t	2686	2686	5372	1	\N	\N	2018-07-05 07:52:56.311554
2688	t	2687	2687	5374	2	\N	\N	2018-07-05 07:52:56.311554
2689	t	2688	2688	5376	1	\N	\N	2018-07-05 07:52:56.311554
2690	t	2689	2689	5378	2	\N	\N	2018-07-05 07:52:56.311554
2691	t	2690	2690	5380	1	\N	\N	2018-07-05 07:52:56.311554
2692	t	2691	2691	5382	2	\N	\N	2018-07-05 07:52:56.311554
2693	t	2692	2692	5384	1	\N	\N	2018-07-05 07:52:56.311554
2694	t	2693	2693	5386	2	\N	\N	2018-07-05 07:52:56.311554
2695	t	2694	2694	5388	1	\N	\N	2018-07-05 07:52:56.311554
2696	t	2695	2695	5390	2	\N	\N	2018-07-05 07:52:56.311554
2697	t	2696	2696	5392	1	\N	\N	2018-07-05 07:52:56.311554
2698	t	2697	2697	5394	2	\N	\N	2018-07-05 07:52:56.311554
2699	t	2698	2698	5396	1	\N	\N	2018-07-05 07:52:56.311554
2700	t	2699	2699	5398	2	\N	\N	2018-07-05 07:52:56.311554
2701	t	2700	2700	5400	1	\N	\N	2018-07-05 07:52:56.311554
2702	t	2701	2701	5402	2	\N	\N	2018-07-05 07:52:56.311554
2703	t	2702	2702	5404	1	\N	\N	2018-07-05 07:52:56.311554
2704	t	2703	2703	5406	2	\N	\N	2018-07-05 07:52:56.311554
2705	t	2704	2704	5408	1	\N	\N	2018-07-05 07:52:56.311554
2706	t	2705	2705	5410	2	\N	\N	2018-07-05 07:52:56.311554
2707	t	2706	2706	5412	1	\N	\N	2018-07-05 07:52:56.311554
2708	t	2707	2707	5414	2	\N	\N	2018-07-05 07:52:56.311554
2709	t	2708	2708	5416	1	\N	\N	2018-07-05 07:52:56.311554
2710	t	2709	2709	5418	2	\N	\N	2018-07-05 07:52:56.311554
2711	t	2710	2710	5420	1	\N	\N	2018-07-05 07:52:56.311554
2712	t	2711	2711	5422	2	\N	\N	2018-07-05 07:52:56.311554
2713	t	2712	2712	5424	1	\N	\N	2018-07-05 07:52:56.311554
2714	t	2713	2713	5426	2	\N	\N	2018-07-05 07:52:56.311554
2715	t	2714	2714	5428	1	\N	\N	2018-07-05 07:52:56.311554
2716	t	2715	2715	5430	2	\N	\N	2018-07-05 07:52:56.311554
2717	t	2716	2716	5432	1	\N	\N	2018-07-05 07:52:56.311554
2718	t	2717	2717	5434	2	\N	\N	2018-07-05 07:52:56.311554
2719	t	2718	2718	5436	1	\N	\N	2018-07-05 07:52:56.311554
2720	t	2719	2719	5438	2	\N	\N	2018-07-05 07:52:56.311554
2721	t	2720	2720	5440	1	\N	\N	2018-07-05 07:52:56.311554
2722	t	2721	2721	5442	2	\N	\N	2018-07-05 07:52:56.311554
2723	t	2722	2722	5444	1	\N	\N	2018-07-05 07:52:56.311554
2724	t	2723	2723	5446	2	\N	\N	2018-07-05 07:52:56.311554
2725	t	2724	2724	5448	1	\N	\N	2018-07-05 07:52:56.311554
2726	t	2725	2725	5450	2	\N	\N	2018-07-05 07:52:56.311554
2727	t	2726	2726	5452	1	\N	\N	2018-07-05 07:52:56.311554
2728	t	2727	2727	5454	2	\N	\N	2018-07-05 07:52:56.311554
2729	t	2728	2728	5456	1	\N	\N	2018-07-05 07:52:56.311554
2730	t	2729	2729	5458	2	\N	\N	2018-07-05 07:52:56.311554
2731	t	2730	2730	5460	1	\N	\N	2018-07-05 07:52:56.311554
2732	t	2731	2731	5462	2	\N	\N	2018-07-05 07:52:56.311554
2733	t	2732	2732	5464	1	\N	\N	2018-07-05 07:52:56.311554
2734	t	2733	2733	5466	2	\N	\N	2018-07-05 07:52:56.311554
2735	t	2734	2734	5468	1	\N	\N	2018-07-05 07:52:56.311554
2736	t	2735	2735	5470	2	\N	\N	2018-07-05 07:52:56.311554
2737	t	2736	2736	5472	1	\N	\N	2018-07-05 07:52:56.311554
2738	t	2737	2737	5474	2	\N	\N	2018-07-05 07:52:56.311554
2739	t	2738	2738	5476	1	\N	\N	2018-07-05 07:52:56.311554
2740	t	2739	2739	5478	2	\N	\N	2018-07-05 07:52:56.311554
2741	t	2740	2740	5480	1	\N	\N	2018-07-05 07:52:56.311554
2742	t	2741	2741	5482	2	\N	\N	2018-07-05 07:52:56.311554
2743	t	2742	2742	5484	1	\N	\N	2018-07-05 07:52:56.311554
2744	t	2743	2743	5486	2	\N	\N	2018-07-05 07:52:56.311554
2745	t	2744	2744	5488	1	\N	\N	2018-07-05 07:52:56.311554
2746	t	2745	2745	5490	2	\N	\N	2018-07-05 07:52:56.311554
2747	t	2746	2746	5492	1	\N	\N	2018-07-05 07:52:56.311554
2748	t	2747	2747	5494	2	\N	\N	2018-07-05 07:52:56.311554
2749	t	2748	2748	5496	1	\N	\N	2018-07-05 07:52:56.311554
2750	t	2749	2749	5498	2	\N	\N	2018-07-05 07:52:56.311554
2751	t	2750	2750	5500	1	\N	\N	2018-07-05 07:52:56.311554
2752	t	2751	2751	5502	2	\N	\N	2018-07-05 07:52:56.311554
2753	t	2752	2752	5504	1	\N	\N	2018-07-05 07:52:56.311554
2754	t	2753	2753	5506	2	\N	\N	2018-07-05 07:52:56.311554
2755	t	2754	2754	5508	1	\N	\N	2018-07-05 07:52:56.311554
2756	t	2755	2755	5510	2	\N	\N	2018-07-05 07:52:56.311554
2757	t	2756	2756	5512	1	\N	\N	2018-07-05 07:52:56.311554
2758	t	2757	2757	5514	2	\N	\N	2018-07-05 07:52:56.311554
2759	t	2758	2758	5516	1	\N	\N	2018-07-05 07:52:56.311554
2760	t	2759	2759	5518	2	\N	\N	2018-07-05 07:52:56.311554
2761	t	2760	2760	5520	1	\N	\N	2018-07-05 07:52:56.311554
2762	t	2761	2761	5522	2	\N	\N	2018-07-05 07:52:56.311554
2763	t	2762	2762	5524	1	\N	\N	2018-07-05 07:52:56.311554
2764	t	2763	2763	5526	2	\N	\N	2018-07-05 07:52:56.311554
2765	t	2764	2764	5528	1	\N	\N	2018-07-05 07:52:56.311554
2766	t	2765	2765	5530	2	\N	\N	2018-07-05 07:52:56.311554
2767	t	2766	2766	5532	1	\N	\N	2018-07-05 07:52:56.311554
2768	t	2767	2767	5534	2	\N	\N	2018-07-05 07:52:56.311554
2769	t	2768	2768	5536	1	\N	\N	2018-07-05 07:52:56.311554
2770	t	2769	2769	5538	2	\N	\N	2018-07-05 07:52:56.311554
2771	t	2770	2770	5540	1	\N	\N	2018-07-05 07:52:56.311554
2772	t	2771	2771	5542	2	\N	\N	2018-07-05 07:52:56.311554
2773	t	2772	2772	5544	1	\N	\N	2018-07-05 07:52:56.311554
2774	t	2773	2773	5546	2	\N	\N	2018-07-05 07:52:56.311554
2775	t	2774	2774	5548	1	\N	\N	2018-07-05 07:52:56.311554
2776	t	2775	2775	5550	2	\N	\N	2018-07-05 07:52:56.311554
2777	t	2776	2776	5552	1	\N	\N	2018-07-05 07:52:56.311554
2778	t	2777	2777	5554	2	\N	\N	2018-07-05 07:52:56.311554
2779	t	2778	2778	5556	1	\N	\N	2018-07-05 07:52:56.311554
2780	t	2779	2779	5558	2	\N	\N	2018-07-05 07:52:56.311554
2781	t	2780	2780	5560	1	\N	\N	2018-07-05 07:52:56.311554
2782	t	2781	2781	5562	2	\N	\N	2018-07-05 07:52:56.311554
2783	t	2782	2782	5564	1	\N	\N	2018-07-05 07:52:56.311554
2784	t	2783	2783	5566	2	\N	\N	2018-07-05 07:52:56.311554
2785	t	2784	2784	5568	1	\N	\N	2018-07-05 07:52:56.311554
2786	t	2785	2785	5570	2	\N	\N	2018-07-05 07:52:56.311554
2787	t	2786	2786	5572	1	\N	\N	2018-07-05 07:52:56.311554
2788	t	2787	2787	5574	2	\N	\N	2018-07-05 07:52:56.311554
2789	t	2788	2788	5576	1	\N	\N	2018-07-05 07:52:56.311554
2790	t	2789	2789	5578	2	\N	\N	2018-07-05 07:52:56.311554
2791	t	2790	2790	5580	1	\N	\N	2018-07-05 07:52:56.311554
2792	t	2791	2791	5582	2	\N	\N	2018-07-05 07:52:56.311554
2793	t	2792	2792	5584	1	\N	\N	2018-07-05 07:52:56.311554
2794	t	2793	2793	5586	2	\N	\N	2018-07-05 07:52:56.311554
2795	t	2794	2794	5588	1	\N	\N	2018-07-05 07:52:56.311554
2796	t	2795	2795	5590	2	\N	\N	2018-07-05 07:52:56.311554
2797	t	2796	2796	5592	1	\N	\N	2018-07-05 07:52:56.311554
2798	t	2797	2797	5594	2	\N	\N	2018-07-05 07:52:56.311554
2799	t	2798	2798	5596	1	\N	\N	2018-07-05 07:52:56.311554
2800	t	2799	2799	5598	2	\N	\N	2018-07-05 07:52:56.311554
2801	t	2800	2800	5600	1	\N	\N	2018-07-05 07:52:56.311554
2802	t	2801	2801	5602	2	\N	\N	2018-07-05 07:52:56.311554
2803	t	2802	2802	5604	1	\N	\N	2018-07-05 07:52:56.311554
2804	t	2803	2803	5606	2	\N	\N	2018-07-05 07:52:56.311554
2805	t	2804	2804	5608	1	\N	\N	2018-07-05 07:52:56.311554
2806	t	2805	2805	5610	2	\N	\N	2018-07-05 07:52:56.311554
2807	t	2806	2806	5612	1	\N	\N	2018-07-05 07:52:56.311554
2808	t	2807	2807	5614	2	\N	\N	2018-07-05 07:52:56.311554
2809	t	2808	2808	5616	1	\N	\N	2018-07-05 07:52:56.311554
2810	t	2809	2809	5618	2	\N	\N	2018-07-05 07:52:56.311554
2811	t	2810	2810	5620	1	\N	\N	2018-07-05 07:52:56.311554
2812	t	2811	2811	5622	2	\N	\N	2018-07-05 07:52:56.311554
2813	t	2812	2812	5624	1	\N	\N	2018-07-05 07:52:56.311554
2814	t	2813	2813	5626	2	\N	\N	2018-07-05 07:52:56.311554
2815	t	2814	2814	5628	1	\N	\N	2018-07-05 07:52:56.311554
2816	t	2815	2815	5630	2	\N	\N	2018-07-05 07:52:56.311554
2817	t	2816	2816	5632	1	\N	\N	2018-07-05 07:52:56.311554
2818	t	2817	2817	5634	2	\N	\N	2018-07-05 07:52:56.311554
2819	t	2818	2818	5636	1	\N	\N	2018-07-05 07:52:56.311554
2820	t	2819	2819	5638	2	\N	\N	2018-07-05 07:52:56.311554
2821	t	2820	2820	5640	1	\N	\N	2018-07-05 07:52:56.311554
2822	t	2821	2821	5642	2	\N	\N	2018-07-05 07:52:56.311554
2823	t	2822	2822	5644	1	\N	\N	2018-07-05 07:52:56.311554
2824	t	2823	2823	5646	2	\N	\N	2018-07-05 07:52:56.311554
2825	t	2824	2824	5648	1	\N	\N	2018-07-05 07:52:56.311554
2826	t	2825	2825	5650	2	\N	\N	2018-07-05 07:52:56.311554
2827	t	2826	2826	5652	1	\N	\N	2018-07-05 07:52:56.311554
2828	t	2827	2827	5654	2	\N	\N	2018-07-05 07:52:56.311554
2829	t	2828	2828	5656	1	\N	\N	2018-07-05 07:52:56.311554
2830	t	2829	2829	5658	2	\N	\N	2018-07-05 07:52:56.311554
2831	t	2830	2830	5660	1	\N	\N	2018-07-05 07:52:56.311554
2832	t	2831	2831	5662	2	\N	\N	2018-07-05 07:52:56.311554
2833	t	2832	2832	5664	1	\N	\N	2018-07-05 07:52:56.311554
2834	t	2833	2833	5666	2	\N	\N	2018-07-05 07:52:56.311554
2835	t	2834	2834	5668	1	\N	\N	2018-07-05 07:52:56.311554
2836	t	2835	2835	5670	2	\N	\N	2018-07-05 07:52:56.311554
2837	t	2836	2836	5672	1	\N	\N	2018-07-05 07:52:56.311554
2838	t	2837	2837	5674	2	\N	\N	2018-07-05 07:52:56.311554
2839	t	2838	2838	5676	1	\N	\N	2018-07-05 07:52:56.311554
2840	t	2839	2839	5678	2	\N	\N	2018-07-05 07:52:56.311554
2841	t	2840	2840	5680	1	\N	\N	2018-07-05 07:52:56.311554
2842	t	2841	2841	5682	2	\N	\N	2018-07-05 07:52:56.311554
2843	t	2842	2842	5684	1	\N	\N	2018-07-05 07:52:56.311554
2844	t	2843	2843	5686	2	\N	\N	2018-07-05 07:52:56.311554
2845	t	2844	2844	5688	1	\N	\N	2018-07-05 07:52:56.311554
2846	t	2845	2845	5690	2	\N	\N	2018-07-05 07:52:56.311554
2847	t	2846	2846	5692	1	\N	\N	2018-07-05 07:52:56.311554
2848	t	2847	2847	5694	2	\N	\N	2018-07-05 07:52:56.311554
2849	t	2848	2848	5696	1	\N	\N	2018-07-05 07:52:56.311554
2850	t	2849	2849	5698	2	\N	\N	2018-07-05 07:52:56.311554
2851	t	2850	2850	5700	1	\N	\N	2018-07-05 07:52:56.311554
2852	t	2851	2851	5702	2	\N	\N	2018-07-05 07:52:56.311554
2853	t	2852	2852	5704	1	\N	\N	2018-07-05 07:52:56.311554
2854	t	2853	2853	5706	2	\N	\N	2018-07-05 07:52:56.311554
2855	t	2854	2854	5708	1	\N	\N	2018-07-05 07:52:56.311554
2856	t	2855	2855	5710	2	\N	\N	2018-07-05 07:52:56.311554
2857	t	2856	2856	5712	1	\N	\N	2018-07-05 07:52:56.311554
2858	t	2857	2857	5714	2	\N	\N	2018-07-05 07:52:56.311554
2859	t	2858	2858	5716	1	\N	\N	2018-07-05 07:52:56.311554
2860	t	2859	2859	5718	2	\N	\N	2018-07-05 07:52:56.311554
2861	t	2860	2860	5720	1	\N	\N	2018-07-05 07:52:56.311554
2862	t	2861	2861	5722	2	\N	\N	2018-07-05 07:52:56.311554
2863	t	2862	2862	5724	1	\N	\N	2018-07-05 07:52:56.311554
2864	t	2863	2863	5726	2	\N	\N	2018-07-05 07:52:56.311554
2865	t	2864	2864	5728	1	\N	\N	2018-07-05 07:52:56.311554
2866	t	2865	2865	5730	2	\N	\N	2018-07-05 07:52:56.311554
2867	t	2866	2866	5732	1	\N	\N	2018-07-05 07:52:56.311554
2868	t	2867	2867	5734	2	\N	\N	2018-07-05 07:52:56.311554
2869	t	2868	2868	5736	1	\N	\N	2018-07-05 07:52:56.311554
2870	t	2869	2869	5738	2	\N	\N	2018-07-05 07:52:56.311554
2871	t	2870	2870	5740	1	\N	\N	2018-07-05 07:52:56.311554
2872	t	2871	2871	5742	2	\N	\N	2018-07-05 07:52:56.311554
2873	t	2872	2872	5744	1	\N	\N	2018-07-05 07:52:56.311554
2874	t	2873	2873	5746	2	\N	\N	2018-07-05 07:52:56.311554
2875	t	2874	2874	5748	1	\N	\N	2018-07-05 07:52:56.311554
2876	t	2875	2875	5750	2	\N	\N	2018-07-05 07:52:56.311554
2877	t	2876	2876	5752	1	\N	\N	2018-07-05 07:52:56.311554
2878	t	2877	2877	5754	2	\N	\N	2018-07-05 07:52:56.311554
2879	t	2878	2878	5756	1	\N	\N	2018-07-05 07:52:56.311554
2880	t	2879	2879	5758	2	\N	\N	2018-07-05 07:52:56.311554
2881	t	2880	2880	5760	1	\N	\N	2018-07-05 07:52:56.311554
2882	t	2881	2881	5762	2	\N	\N	2018-07-05 07:52:56.311554
2883	t	2882	2882	5764	1	\N	\N	2018-07-05 07:52:56.311554
2884	t	2883	2883	5766	2	\N	\N	2018-07-05 07:52:56.311554
2885	t	2884	2884	5768	1	\N	\N	2018-07-05 07:52:56.311554
2886	t	2885	2885	5770	2	\N	\N	2018-07-05 07:52:56.311554
2887	t	2886	2886	5772	1	\N	\N	2018-07-05 07:52:56.311554
2888	t	2887	2887	5774	2	\N	\N	2018-07-05 07:52:56.311554
2889	t	2888	2888	5776	1	\N	\N	2018-07-05 07:52:56.311554
2890	t	2889	2889	5778	2	\N	\N	2018-07-05 07:52:56.311554
2891	t	2890	2890	5780	1	\N	\N	2018-07-05 07:52:56.311554
2892	t	2891	2891	5782	2	\N	\N	2018-07-05 07:52:56.311554
2893	t	2892	2892	5784	1	\N	\N	2018-07-05 07:52:56.311554
2894	t	2893	2893	5786	2	\N	\N	2018-07-05 07:52:56.311554
2895	t	2894	2894	5788	1	\N	\N	2018-07-05 07:52:56.311554
2896	t	2895	2895	5790	2	\N	\N	2018-07-05 07:52:56.311554
2897	t	2896	2896	5792	1	\N	\N	2018-07-05 07:52:56.311554
2898	t	2897	2897	5794	2	\N	\N	2018-07-05 07:52:56.311554
2899	t	2898	2898	5796	1	\N	\N	2018-07-05 07:52:56.311554
2900	t	2899	2899	5798	2	\N	\N	2018-07-05 07:52:56.311554
2901	t	2900	2900	5800	1	\N	\N	2018-07-05 07:52:56.311554
2902	t	2901	2901	5802	2	\N	\N	2018-07-05 07:52:56.311554
2903	t	2902	2902	5804	1	\N	\N	2018-07-05 07:52:56.311554
2904	t	2903	2903	5806	2	\N	\N	2018-07-05 07:52:56.311554
2905	t	2904	2904	5808	1	\N	\N	2018-07-05 07:52:56.311554
2906	t	2905	2905	5810	2	\N	\N	2018-07-05 07:52:56.311554
2907	t	2906	2906	5812	1	\N	\N	2018-07-05 07:52:56.311554
2908	t	2907	2907	5814	2	\N	\N	2018-07-05 07:52:56.311554
2909	t	2908	2908	5816	1	\N	\N	2018-07-05 07:52:56.311554
2910	t	2909	2909	5818	2	\N	\N	2018-07-05 07:52:56.311554
2911	t	2910	2910	5820	1	\N	\N	2018-07-05 07:52:56.311554
2912	t	2911	2911	5822	2	\N	\N	2018-07-05 07:52:56.311554
2913	t	2912	2912	5824	1	\N	\N	2018-07-05 07:52:56.311554
2914	t	2913	2913	5826	2	\N	\N	2018-07-05 07:52:56.311554
2915	t	2914	2914	5828	1	\N	\N	2018-07-05 07:52:56.311554
2916	t	2915	2915	5830	2	\N	\N	2018-07-05 07:52:56.311554
2917	t	2916	2916	5832	1	\N	\N	2018-07-05 07:52:56.311554
2918	t	2917	2917	5834	2	\N	\N	2018-07-05 07:52:56.311554
2919	t	2918	2918	5836	1	\N	\N	2018-07-05 07:52:56.311554
2920	t	2919	2919	5838	2	\N	\N	2018-07-05 07:52:56.311554
2921	t	2920	2920	5840	1	\N	\N	2018-07-05 07:52:56.311554
2922	t	2921	2921	5842	2	\N	\N	2018-07-05 07:52:56.311554
2923	t	2922	2922	5844	1	\N	\N	2018-07-05 07:52:56.311554
2924	t	2923	2923	5846	2	\N	\N	2018-07-05 07:52:56.311554
2925	t	2924	2924	5848	1	\N	\N	2018-07-05 07:52:56.311554
2926	t	2925	2925	5850	2	\N	\N	2018-07-05 07:52:56.311554
2927	t	2926	2926	5852	1	\N	\N	2018-07-05 07:52:56.311554
2928	t	2927	2927	5854	2	\N	\N	2018-07-05 07:52:56.311554
2929	t	2928	2928	5856	1	\N	\N	2018-07-05 07:52:56.311554
2930	t	2929	2929	5858	2	\N	\N	2018-07-05 07:52:56.311554
2931	t	2930	2930	5860	1	\N	\N	2018-07-05 07:52:56.311554
2932	t	2931	2931	5862	2	\N	\N	2018-07-05 07:52:56.311554
2933	t	2932	2932	5864	1	\N	\N	2018-07-05 07:52:56.311554
2934	t	2933	2933	5866	2	\N	\N	2018-07-05 07:52:56.311554
2935	t	2934	2934	5868	1	\N	\N	2018-07-05 07:52:56.311554
2936	t	2935	2935	5870	2	\N	\N	2018-07-05 07:52:56.311554
2937	t	2936	2936	5872	1	\N	\N	2018-07-05 07:52:56.311554
2938	t	2937	2937	5874	2	\N	\N	2018-07-05 07:52:56.311554
2939	t	2938	2938	5876	1	\N	\N	2018-07-05 07:52:56.311554
2940	t	2939	2939	5878	2	\N	\N	2018-07-05 07:52:56.311554
2941	t	2940	2940	5880	1	\N	\N	2018-07-05 07:52:56.311554
2942	t	2941	2941	5882	2	\N	\N	2018-07-05 07:52:56.311554
2943	t	2942	2942	5884	1	\N	\N	2018-07-05 07:52:56.311554
2944	t	2943	2943	5886	2	\N	\N	2018-07-05 07:52:56.311554
2945	t	2944	2944	5888	1	\N	\N	2018-07-05 07:52:56.311554
2946	t	2945	2945	5890	2	\N	\N	2018-07-05 07:52:56.311554
2947	t	2946	2946	5892	1	\N	\N	2018-07-05 07:52:56.311554
2948	t	2947	2947	5894	2	\N	\N	2018-07-05 07:52:56.311554
2949	t	2948	2948	5896	1	\N	\N	2018-07-05 07:52:56.311554
2950	t	2949	2949	5898	2	\N	\N	2018-07-05 07:52:56.311554
2951	t	2950	2950	5900	1	\N	\N	2018-07-05 07:52:56.311554
2952	t	2951	2951	5902	2	\N	\N	2018-07-05 07:52:56.311554
2953	t	2952	2952	5904	1	\N	\N	2018-07-05 07:52:56.311554
2954	t	2953	2953	5906	2	\N	\N	2018-07-05 07:52:56.311554
2955	t	2954	2954	5908	1	\N	\N	2018-07-05 07:52:56.311554
2956	t	2955	2955	5910	2	\N	\N	2018-07-05 07:52:56.311554
2957	t	2956	2956	5912	1	\N	\N	2018-07-05 07:52:56.311554
2958	t	2957	2957	5914	2	\N	\N	2018-07-05 07:52:56.311554
2959	t	2958	2958	5916	1	\N	\N	2018-07-05 07:52:56.311554
2960	t	2959	2959	5918	2	\N	\N	2018-07-05 07:52:56.311554
2961	t	2960	2960	5920	1	\N	\N	2018-07-05 07:52:56.311554
2962	t	2961	2961	5922	2	\N	\N	2018-07-05 07:52:56.311554
2963	t	2962	2962	5924	1	\N	\N	2018-07-05 07:52:56.311554
2964	t	2963	2963	5926	2	\N	\N	2018-07-05 07:52:56.311554
2965	t	2964	2964	5928	1	\N	\N	2018-07-05 07:52:56.311554
2966	t	2965	2965	5930	2	\N	\N	2018-07-05 07:52:56.311554
2967	t	2966	2966	5932	1	\N	\N	2018-07-05 07:52:56.311554
2968	t	2967	2967	5934	2	\N	\N	2018-07-05 07:52:56.311554
2969	t	2968	2968	5936	1	\N	\N	2018-07-05 07:52:56.311554
2970	t	2969	2969	5938	2	\N	\N	2018-07-05 07:52:56.311554
2971	t	2970	2970	5940	1	\N	\N	2018-07-05 07:52:56.311554
2972	t	2971	2971	5942	2	\N	\N	2018-07-05 07:52:56.311554
2973	t	2972	2972	5944	1	\N	\N	2018-07-05 07:52:56.311554
2974	t	2973	2973	5946	2	\N	\N	2018-07-05 07:52:56.311554
2975	t	2974	2974	5948	1	\N	\N	2018-07-05 07:52:56.311554
2976	t	2975	2975	5950	2	\N	\N	2018-07-05 07:52:56.311554
2977	t	2976	2976	5952	1	\N	\N	2018-07-05 07:52:56.311554
2978	t	2977	2977	5954	2	\N	\N	2018-07-05 07:52:56.311554
2979	t	2978	2978	5956	1	\N	\N	2018-07-05 07:52:56.311554
2980	t	2979	2979	5958	2	\N	\N	2018-07-05 07:52:56.311554
2981	t	2980	2980	5960	1	\N	\N	2018-07-05 07:52:56.311554
2982	t	2981	2981	5962	2	\N	\N	2018-07-05 07:52:56.311554
2983	t	2982	2982	5964	1	\N	\N	2018-07-05 07:52:56.311554
2984	t	2983	2983	5966	2	\N	\N	2018-07-05 07:52:56.311554
2985	t	2984	2984	5968	1	\N	\N	2018-07-05 07:52:56.311554
2986	t	2985	2985	5970	2	\N	\N	2018-07-05 07:52:56.311554
2987	t	2986	2986	5972	1	\N	\N	2018-07-05 07:52:56.311554
2988	t	2987	2987	5974	2	\N	\N	2018-07-05 07:52:56.311554
2989	t	2988	2988	5976	1	\N	\N	2018-07-05 07:52:56.311554
2990	t	2989	2989	5978	2	\N	\N	2018-07-05 07:52:56.311554
2991	t	2990	2990	5980	1	\N	\N	2018-07-05 07:52:56.311554
2992	t	2991	2991	5982	2	\N	\N	2018-07-05 07:52:56.311554
2993	t	2992	2992	5984	1	\N	\N	2018-07-05 07:52:56.311554
2994	t	2993	2993	5986	2	\N	\N	2018-07-05 07:52:56.311554
2995	t	2994	2994	5988	1	\N	\N	2018-07-05 07:52:56.311554
2996	t	2995	2995	5990	2	\N	\N	2018-07-05 07:52:56.311554
2997	t	2996	2996	5992	1	\N	\N	2018-07-05 07:52:56.311554
2998	t	2997	2997	5994	2	\N	\N	2018-07-05 07:52:56.311554
2999	t	2998	2998	5996	1	\N	\N	2018-07-05 07:52:56.311554
3000	t	2999	2999	5998	2	\N	\N	2018-07-05 07:52:56.311554
3001	t	3000	3000	6000	1	\N	\N	2018-07-05 07:52:56.311554
3002	t	3001	3001	6002	2	\N	\N	2018-07-05 07:52:56.311554
3003	t	3002	3002	6004	1	\N	\N	2018-07-05 07:52:56.311554
3004	t	3003	3003	6006	2	\N	\N	2018-07-05 07:52:56.311554
3005	t	3004	3004	6008	1	\N	\N	2018-07-05 07:52:56.311554
3006	t	3005	3005	6010	2	\N	\N	2018-07-05 07:52:56.311554
3007	t	3006	3006	6012	1	\N	\N	2018-07-05 07:52:56.311554
3008	t	3007	3007	6014	2	\N	\N	2018-07-05 07:52:56.311554
3009	t	3008	3008	6016	1	\N	\N	2018-07-05 07:52:56.311554
3010	t	3009	3009	6018	2	\N	\N	2018-07-05 07:52:56.311554
3011	t	3010	3010	6020	1	\N	\N	2018-07-05 07:52:56.311554
3012	t	3011	3011	6022	2	\N	\N	2018-07-05 07:52:56.311554
3013	t	3012	3012	6024	1	\N	\N	2018-07-05 07:52:56.311554
3014	t	3013	3013	6026	2	\N	\N	2018-07-05 07:52:56.311554
3015	t	3014	3014	6028	1	\N	\N	2018-07-05 07:52:56.311554
3016	t	3015	3015	6030	2	\N	\N	2018-07-05 07:52:56.311554
3017	t	3016	3016	6032	1	\N	\N	2018-07-05 07:52:56.311554
3018	t	3017	3017	6034	2	\N	\N	2018-07-05 07:52:56.311554
3019	t	3018	3018	6036	1	\N	\N	2018-07-05 07:52:56.311554
3020	t	3019	3019	6038	2	\N	\N	2018-07-05 07:52:56.311554
3021	t	3020	3020	6040	1	\N	\N	2018-07-05 07:52:56.311554
3022	t	3021	3021	6042	2	\N	\N	2018-07-05 07:52:56.311554
3023	t	3022	3022	6044	1	\N	\N	2018-07-05 07:52:56.311554
3024	t	3023	3023	6046	2	\N	\N	2018-07-05 07:52:56.311554
3025	t	3024	3024	6048	1	\N	\N	2018-07-05 07:52:56.311554
3026	t	3025	3025	6050	2	\N	\N	2018-07-05 07:52:56.311554
3027	t	3026	3026	6052	1	\N	\N	2018-07-05 07:52:56.311554
3028	t	3027	3027	6054	2	\N	\N	2018-07-05 07:52:56.311554
3029	t	3028	3028	6056	1	\N	\N	2018-07-05 07:52:56.311554
3030	t	3029	3029	6058	2	\N	\N	2018-07-05 07:52:56.311554
3031	t	3030	3030	6060	1	\N	\N	2018-07-05 07:52:56.311554
3032	t	3031	3031	6062	2	\N	\N	2018-07-05 07:52:56.311554
3033	t	3032	3032	6064	1	\N	\N	2018-07-05 07:52:56.311554
3034	t	3033	3033	6066	2	\N	\N	2018-07-05 07:52:56.311554
3035	t	3034	3034	6068	1	\N	\N	2018-07-05 07:52:56.311554
3036	t	3035	3035	6070	2	\N	\N	2018-07-05 07:52:56.311554
3037	t	3036	3036	6072	1	\N	\N	2018-07-05 07:52:56.311554
3038	t	3037	3037	6074	2	\N	\N	2018-07-05 07:52:56.311554
3039	t	3038	3038	6076	1	\N	\N	2018-07-05 07:52:56.311554
3040	t	3039	3039	6078	2	\N	\N	2018-07-05 07:52:56.311554
3041	t	3040	3040	6080	1	\N	\N	2018-07-05 07:52:56.311554
3042	t	3041	3041	6082	2	\N	\N	2018-07-05 07:52:56.311554
3043	t	3042	3042	6084	1	\N	\N	2018-07-05 07:52:56.311554
3044	t	3043	3043	6086	2	\N	\N	2018-07-05 07:52:56.311554
3045	t	3044	3044	6088	1	\N	\N	2018-07-05 07:52:56.311554
3046	t	3045	3045	6090	2	\N	\N	2018-07-05 07:52:56.311554
3047	t	3046	3046	6092	1	\N	\N	2018-07-05 07:52:56.311554
3048	t	3047	3047	6094	2	\N	\N	2018-07-05 07:52:56.311554
3049	t	3048	3048	6096	1	\N	\N	2018-07-05 07:52:56.311554
3050	t	3049	3049	6098	2	\N	\N	2018-07-05 07:52:56.311554
3051	t	3050	3050	6100	1	\N	\N	2018-07-05 07:52:56.311554
3052	t	3051	3051	6102	2	\N	\N	2018-07-05 07:52:56.311554
3053	t	3052	3052	6104	1	\N	\N	2018-07-05 07:52:56.311554
3054	t	3053	3053	6106	2	\N	\N	2018-07-05 07:52:56.311554
3055	t	3054	3054	6108	1	\N	\N	2018-07-05 07:52:56.311554
3056	t	3055	3055	6110	2	\N	\N	2018-07-05 07:52:56.311554
3057	t	3056	3056	6112	1	\N	\N	2018-07-05 07:52:56.311554
3058	t	3057	3057	6114	2	\N	\N	2018-07-05 07:52:56.311554
3059	t	3058	3058	6116	1	\N	\N	2018-07-05 07:52:56.311554
3060	t	3059	3059	6118	2	\N	\N	2018-07-05 07:52:56.311554
3061	t	3060	3060	6120	1	\N	\N	2018-07-05 07:52:56.311554
3062	t	3061	3061	6122	2	\N	\N	2018-07-05 07:52:56.311554
3063	t	3062	3062	6124	1	\N	\N	2018-07-05 07:52:56.311554
3064	t	3063	3063	6126	2	\N	\N	2018-07-05 07:52:56.311554
3065	t	3064	3064	6128	1	\N	\N	2018-07-05 07:52:56.311554
3066	t	3065	3065	6130	2	\N	\N	2018-07-05 07:52:56.311554
3067	t	3066	3066	6132	1	\N	\N	2018-07-05 07:52:56.311554
3068	t	3067	3067	6134	2	\N	\N	2018-07-05 07:52:56.311554
3069	t	3068	3068	6136	1	\N	\N	2018-07-05 07:52:56.311554
3070	t	3069	3069	6138	2	\N	\N	2018-07-05 07:52:56.311554
3071	t	3070	3070	6140	1	\N	\N	2018-07-05 07:52:56.311554
3072	t	3071	3071	6142	2	\N	\N	2018-07-05 07:52:56.311554
3073	t	3072	3072	6144	1	\N	\N	2018-07-05 07:52:56.311554
3074	t	3073	3073	6146	2	\N	\N	2018-07-05 07:52:56.311554
3075	t	3074	3074	6148	1	\N	\N	2018-07-05 07:52:56.311554
3076	t	3075	3075	6150	2	\N	\N	2018-07-05 07:52:56.311554
3077	t	3076	3076	6152	1	\N	\N	2018-07-05 07:52:56.311554
3078	t	3077	3077	6154	2	\N	\N	2018-07-05 07:52:56.311554
3079	t	3078	3078	6156	1	\N	\N	2018-07-05 07:52:56.311554
3080	t	3079	3079	6158	2	\N	\N	2018-07-05 07:52:56.311554
3081	t	3080	3080	6160	1	\N	\N	2018-07-05 07:52:56.311554
3082	t	3081	3081	6162	2	\N	\N	2018-07-05 07:52:56.311554
3083	t	3082	3082	6164	1	\N	\N	2018-07-05 07:52:56.311554
3084	t	3083	3083	6166	2	\N	\N	2018-07-05 07:52:56.311554
3085	t	3084	3084	6168	1	\N	\N	2018-07-05 07:52:56.311554
3086	t	3085	3085	6170	2	\N	\N	2018-07-05 07:52:56.311554
3087	t	3086	3086	6172	1	\N	\N	2018-07-05 07:52:56.311554
3088	t	3087	3087	6174	2	\N	\N	2018-07-05 07:52:56.311554
3089	t	3088	3088	6176	1	\N	\N	2018-07-05 07:52:56.311554
3090	t	3089	3089	6178	2	\N	\N	2018-07-05 07:52:56.311554
3091	t	3090	3090	6180	1	\N	\N	2018-07-05 07:52:56.311554
3092	t	3091	3091	6182	2	\N	\N	2018-07-05 07:52:56.311554
3093	t	3092	3092	6184	1	\N	\N	2018-07-05 07:52:56.311554
3094	t	3093	3093	6186	2	\N	\N	2018-07-05 07:52:56.311554
3095	t	3094	3094	6188	1	\N	\N	2018-07-05 07:52:56.311554
3096	t	3095	3095	6190	2	\N	\N	2018-07-05 07:52:56.311554
3097	t	3096	3096	6192	1	\N	\N	2018-07-05 07:52:56.311554
3098	t	3097	3097	6194	2	\N	\N	2018-07-05 07:52:56.311554
3099	t	3098	3098	6196	1	\N	\N	2018-07-05 07:52:56.311554
3100	t	3099	3099	6198	2	\N	\N	2018-07-05 07:52:56.311554
3101	t	3100	3100	6200	1	\N	\N	2018-07-05 07:52:56.311554
3102	t	3101	3101	6202	2	\N	\N	2018-07-05 07:52:56.311554
3103	t	3102	3102	6204	1	\N	\N	2018-07-05 07:52:56.311554
3104	t	3103	3103	6206	2	\N	\N	2018-07-05 07:52:56.311554
3105	t	3104	3104	6208	1	\N	\N	2018-07-05 07:52:56.311554
3106	t	3105	3105	6210	2	\N	\N	2018-07-05 07:52:56.311554
3107	t	3106	3106	6212	1	\N	\N	2018-07-05 07:52:56.311554
3108	t	3107	3107	6214	2	\N	\N	2018-07-05 07:52:56.311554
3109	t	3108	3108	6216	1	\N	\N	2018-07-05 07:52:56.311554
3110	t	3109	3109	6218	2	\N	\N	2018-07-05 07:52:56.311554
3111	t	3110	3110	6220	1	\N	\N	2018-07-05 07:52:56.311554
3112	t	3111	3111	6222	2	\N	\N	2018-07-05 07:52:56.311554
3113	t	3112	3112	6224	1	\N	\N	2018-07-05 07:52:56.311554
3114	t	3113	3113	6226	2	\N	\N	2018-07-05 07:52:56.311554
3115	t	3114	3114	6228	1	\N	\N	2018-07-05 07:52:56.311554
3116	t	3115	3115	6230	2	\N	\N	2018-07-05 07:52:56.311554
3117	t	3116	3116	6232	1	\N	\N	2018-07-05 07:52:56.311554
3118	t	3117	3117	6234	2	\N	\N	2018-07-05 07:52:56.311554
3119	t	3118	3118	6236	1	\N	\N	2018-07-05 07:52:56.311554
3120	t	3119	3119	6238	2	\N	\N	2018-07-05 07:52:56.311554
3121	t	3120	3120	6240	1	\N	\N	2018-07-05 07:52:56.311554
3122	t	3121	3121	6242	2	\N	\N	2018-07-05 07:52:56.311554
3123	t	3122	3122	6244	1	\N	\N	2018-07-05 07:52:56.311554
3124	t	3123	3123	6246	2	\N	\N	2018-07-05 07:52:56.311554
3125	t	3124	3124	6248	1	\N	\N	2018-07-05 07:52:56.311554
3126	t	3125	3125	6250	2	\N	\N	2018-07-05 07:52:56.311554
3127	t	3126	3126	6252	1	\N	\N	2018-07-05 07:52:56.311554
3128	t	3127	3127	6254	2	\N	\N	2018-07-05 07:52:56.311554
3129	t	3128	3128	6256	1	\N	\N	2018-07-05 07:52:56.311554
3130	t	3129	3129	6258	2	\N	\N	2018-07-05 07:52:56.311554
3131	t	3130	3130	6260	1	\N	\N	2018-07-05 07:52:56.311554
3132	t	3131	3131	6262	2	\N	\N	2018-07-05 07:52:56.311554
3133	t	3132	3132	6264	1	\N	\N	2018-07-05 07:52:56.311554
3134	t	3133	3133	6266	2	\N	\N	2018-07-05 07:52:56.311554
3135	t	3134	3134	6268	1	\N	\N	2018-07-05 07:52:56.311554
3136	t	3135	3135	6270	2	\N	\N	2018-07-05 07:52:56.311554
3137	t	3136	3136	6272	1	\N	\N	2018-07-05 07:52:56.311554
3138	t	3137	3137	6274	2	\N	\N	2018-07-05 07:52:56.311554
3139	t	3138	3138	6276	1	\N	\N	2018-07-05 07:52:56.311554
3140	t	3139	3139	6278	2	\N	\N	2018-07-05 07:52:56.311554
3141	t	3140	3140	6280	1	\N	\N	2018-07-05 07:52:56.311554
3142	t	3141	3141	6282	2	\N	\N	2018-07-05 07:52:56.311554
3143	t	3142	3142	6284	1	\N	\N	2018-07-05 07:52:56.311554
3144	t	3143	3143	6286	2	\N	\N	2018-07-05 07:52:56.311554
3145	t	3144	3144	6288	1	\N	\N	2018-07-05 07:52:56.311554
3146	t	3145	3145	6290	2	\N	\N	2018-07-05 07:52:56.311554
3147	t	3146	3146	6292	1	\N	\N	2018-07-05 07:52:56.311554
3148	t	3147	3147	6294	2	\N	\N	2018-07-05 07:52:56.311554
3149	t	3148	3148	6296	1	\N	\N	2018-07-05 07:52:56.311554
3150	t	3149	3149	6298	2	\N	\N	2018-07-05 07:52:56.311554
3151	t	3150	3150	6300	1	\N	\N	2018-07-05 07:52:56.311554
3152	t	3151	3151	6302	2	\N	\N	2018-07-05 07:52:56.311554
3153	t	3152	3152	6304	1	\N	\N	2018-07-05 07:52:56.311554
3154	t	3153	3153	6306	2	\N	\N	2018-07-05 07:52:56.311554
3155	t	3154	3154	6308	1	\N	\N	2018-07-05 07:52:56.311554
3156	t	3155	3155	6310	2	\N	\N	2018-07-05 07:52:56.311554
3157	t	3156	3156	6312	1	\N	\N	2018-07-05 07:52:56.311554
3158	t	3157	3157	6314	2	\N	\N	2018-07-05 07:52:56.311554
3159	t	3158	3158	6316	1	\N	\N	2018-07-05 07:52:56.311554
3160	t	3159	3159	6318	2	\N	\N	2018-07-05 07:52:56.311554
3161	t	3160	3160	6320	1	\N	\N	2018-07-05 07:52:56.311554
3162	t	3161	3161	6322	2	\N	\N	2018-07-05 07:52:56.311554
3163	t	3162	3162	6324	1	\N	\N	2018-07-05 07:52:56.311554
3164	t	3163	3163	6326	2	\N	\N	2018-07-05 07:52:56.311554
3165	t	3164	3164	6328	1	\N	\N	2018-07-05 07:52:56.311554
3166	t	3165	3165	6330	2	\N	\N	2018-07-05 07:52:56.311554
3167	t	3166	3166	6332	1	\N	\N	2018-07-05 07:52:56.311554
3168	t	3167	3167	6334	2	\N	\N	2018-07-05 07:52:56.311554
3169	t	3168	3168	6336	1	\N	\N	2018-07-05 07:52:56.311554
3170	t	3169	3169	6338	2	\N	\N	2018-07-05 07:52:56.311554
3171	t	3170	3170	6340	1	\N	\N	2018-07-05 07:52:56.311554
3172	t	3171	3171	6342	2	\N	\N	2018-07-05 07:52:56.311554
3173	t	3172	3172	6344	1	\N	\N	2018-07-05 07:52:56.311554
3174	t	3173	3173	6346	2	\N	\N	2018-07-05 07:52:56.311554
3175	t	3174	3174	6348	1	\N	\N	2018-07-05 07:52:56.311554
3176	t	3175	3175	6350	2	\N	\N	2018-07-05 07:52:56.311554
3177	t	3176	3176	6352	1	\N	\N	2018-07-05 07:52:56.311554
3178	t	3177	3177	6354	2	\N	\N	2018-07-05 07:52:56.311554
3179	t	3178	3178	6356	1	\N	\N	2018-07-05 07:52:56.311554
3180	t	3179	3179	6358	2	\N	\N	2018-07-05 07:52:56.311554
3181	t	3180	3180	6360	1	\N	\N	2018-07-05 07:52:56.311554
3182	t	3181	3181	6362	2	\N	\N	2018-07-05 07:52:56.311554
3183	t	3182	3182	6364	1	\N	\N	2018-07-05 07:52:56.311554
3184	t	3183	3183	6366	2	\N	\N	2018-07-05 07:52:56.311554
3185	t	3184	3184	6368	1	\N	\N	2018-07-05 07:52:56.311554
3186	t	3185	3185	6370	2	\N	\N	2018-07-05 07:52:56.311554
3187	t	3186	3186	6372	1	\N	\N	2018-07-05 07:52:56.311554
3188	t	3187	3187	6374	2	\N	\N	2018-07-05 07:52:56.311554
3189	t	3188	3188	6376	1	\N	\N	2018-07-05 07:52:56.311554
3190	t	3189	3189	6378	2	\N	\N	2018-07-05 07:52:56.311554
3191	t	3190	3190	6380	1	\N	\N	2018-07-05 07:52:56.311554
3192	t	3191	3191	6382	2	\N	\N	2018-07-05 07:52:56.311554
3193	t	3192	3192	6384	1	\N	\N	2018-07-05 07:52:56.311554
3194	t	3193	3193	6386	2	\N	\N	2018-07-05 07:52:56.311554
3195	t	3194	3194	6388	1	\N	\N	2018-07-05 07:52:56.311554
3196	t	3195	3195	6390	2	\N	\N	2018-07-05 07:52:56.311554
3197	t	3196	3196	6392	1	\N	\N	2018-07-05 07:52:56.311554
3198	t	3197	3197	6394	2	\N	\N	2018-07-05 07:52:56.311554
3199	t	3198	3198	6396	1	\N	\N	2018-07-05 07:52:56.311554
3200	t	3199	3199	6398	2	\N	\N	2018-07-05 07:52:56.311554
3201	t	3200	3200	6400	1	\N	\N	2018-07-05 07:52:56.311554
3202	t	3201	3201	6402	2	\N	\N	2018-07-05 07:52:56.311554
3203	t	3202	3202	6404	1	\N	\N	2018-07-05 07:52:56.311554
3204	t	3203	3203	6406	2	\N	\N	2018-07-05 07:52:56.311554
3205	t	3204	3204	6408	1	\N	\N	2018-07-05 07:52:56.311554
3206	t	3205	3205	6410	2	\N	\N	2018-07-05 07:52:56.311554
3207	t	3206	3206	6412	1	\N	\N	2018-07-05 07:52:56.311554
3208	t	3207	3207	6414	2	\N	\N	2018-07-05 07:52:56.311554
3209	t	3208	3208	6416	1	\N	\N	2018-07-05 07:52:56.311554
3210	t	3209	3209	6418	2	\N	\N	2018-07-05 07:52:56.311554
3211	t	3210	3210	6420	1	\N	\N	2018-07-05 07:52:56.311554
3212	t	3211	3211	6422	2	\N	\N	2018-07-05 07:52:56.311554
3213	t	3212	3212	6424	1	\N	\N	2018-07-05 07:52:56.311554
3214	t	3213	3213	6426	2	\N	\N	2018-07-05 07:52:56.311554
3215	t	3214	3214	6428	1	\N	\N	2018-07-05 07:52:56.311554
3216	t	3215	3215	6430	2	\N	\N	2018-07-05 07:52:56.311554
3217	t	3216	3216	6432	1	\N	\N	2018-07-05 07:52:56.311554
3218	t	3217	3217	6434	2	\N	\N	2018-07-05 07:52:56.311554
3219	t	3218	3218	6436	1	\N	\N	2018-07-05 07:52:56.311554
3220	t	3219	3219	6438	2	\N	\N	2018-07-05 07:52:56.311554
3221	t	3220	3220	6440	1	\N	\N	2018-07-05 07:52:56.311554
3222	t	3221	3221	6442	2	\N	\N	2018-07-05 07:52:56.311554
3223	t	3222	3222	6444	1	\N	\N	2018-07-05 07:52:56.311554
3224	t	3223	3223	6446	2	\N	\N	2018-07-05 07:52:56.311554
3225	t	3224	3224	6448	1	\N	\N	2018-07-05 07:52:56.311554
3226	t	3225	3225	6450	2	\N	\N	2018-07-05 07:52:56.311554
3227	t	3226	3226	6452	1	\N	\N	2018-07-05 07:52:56.311554
3228	t	3227	3227	6454	2	\N	\N	2018-07-05 07:52:56.311554
3229	t	3228	3228	6456	1	\N	\N	2018-07-05 07:52:56.311554
3230	t	3229	3229	6458	2	\N	\N	2018-07-05 07:52:56.311554
3231	t	3230	3230	6460	1	\N	\N	2018-07-05 07:52:56.311554
3232	t	3231	3231	6462	2	\N	\N	2018-07-05 07:52:56.311554
3233	t	3232	3232	6464	1	\N	\N	2018-07-05 07:52:56.311554
3234	t	3233	3233	6466	2	\N	\N	2018-07-05 07:52:56.311554
3235	t	3234	3234	6468	1	\N	\N	2018-07-05 07:52:56.311554
3236	t	3235	3235	6470	2	\N	\N	2018-07-05 07:52:56.311554
3237	t	3236	3236	6472	1	\N	\N	2018-07-05 07:52:56.311554
3238	t	3237	3237	6474	2	\N	\N	2018-07-05 07:52:56.311554
3239	t	3238	3238	6476	1	\N	\N	2018-07-05 07:52:56.311554
3240	t	3239	3239	6478	2	\N	\N	2018-07-05 07:52:56.311554
3241	t	3240	3240	6480	1	\N	\N	2018-07-05 07:52:56.311554
3242	t	3241	3241	6482	2	\N	\N	2018-07-05 07:52:56.311554
3243	t	3242	3242	6484	1	\N	\N	2018-07-05 07:52:56.311554
3244	t	3243	3243	6486	2	\N	\N	2018-07-05 07:52:56.311554
3245	t	3244	3244	6488	1	\N	\N	2018-07-05 07:52:56.311554
3246	t	3245	3245	6490	2	\N	\N	2018-07-05 07:52:56.311554
3247	t	3246	3246	6492	1	\N	\N	2018-07-05 07:52:56.311554
3248	t	3247	3247	6494	2	\N	\N	2018-07-05 07:52:56.311554
3249	t	3248	3248	6496	1	\N	\N	2018-07-05 07:52:56.311554
3250	t	3249	3249	6498	2	\N	\N	2018-07-05 07:52:56.311554
3251	t	3250	3250	6500	1	\N	\N	2018-07-05 07:52:56.311554
3252	t	3251	3251	6502	2	\N	\N	2018-07-05 07:52:56.311554
3253	t	3252	3252	6504	1	\N	\N	2018-07-05 07:52:56.311554
3254	t	3253	3253	6506	2	\N	\N	2018-07-05 07:52:56.311554
3255	t	3254	3254	6508	1	\N	\N	2018-07-05 07:52:56.311554
3256	t	3255	3255	6510	2	\N	\N	2018-07-05 07:52:56.311554
3257	t	3256	3256	6512	1	\N	\N	2018-07-05 07:52:56.311554
3258	t	3257	3257	6514	2	\N	\N	2018-07-05 07:52:56.311554
3259	t	3258	3258	6516	1	\N	\N	2018-07-05 07:52:56.311554
3260	t	3259	3259	6518	2	\N	\N	2018-07-05 07:52:56.311554
3261	t	3260	3260	6520	1	\N	\N	2018-07-05 07:52:56.311554
3262	t	3261	3261	6522	2	\N	\N	2018-07-05 07:52:56.311554
3263	t	3262	3262	6524	1	\N	\N	2018-07-05 07:52:56.311554
3264	t	3263	3263	6526	2	\N	\N	2018-07-05 07:52:56.311554
3265	t	3264	3264	6528	1	\N	\N	2018-07-05 07:52:56.311554
3266	t	3265	3265	6530	2	\N	\N	2018-07-05 07:52:56.311554
3267	t	3266	3266	6532	1	\N	\N	2018-07-05 07:52:56.311554
3268	t	3267	3267	6534	2	\N	\N	2018-07-05 07:52:56.311554
3269	t	3268	3268	6536	1	\N	\N	2018-07-05 07:52:56.311554
3270	t	3269	3269	6538	2	\N	\N	2018-07-05 07:52:56.311554
3271	t	3270	3270	6540	1	\N	\N	2018-07-05 07:52:56.311554
3272	t	3271	3271	6542	2	\N	\N	2018-07-05 07:52:56.311554
3273	t	3272	3272	6544	1	\N	\N	2018-07-05 07:52:56.311554
3274	t	3273	3273	6546	2	\N	\N	2018-07-05 07:52:56.311554
3275	t	3274	3274	6548	1	\N	\N	2018-07-05 07:52:56.311554
3276	t	3275	3275	6550	2	\N	\N	2018-07-05 07:52:56.311554
3277	t	3276	3276	6552	1	\N	\N	2018-07-05 07:52:56.311554
3278	t	3277	3277	6554	2	\N	\N	2018-07-05 07:52:56.311554
3279	t	3278	3278	6556	1	\N	\N	2018-07-05 07:52:56.311554
3280	t	3279	3279	6558	2	\N	\N	2018-07-05 07:52:56.311554
3281	t	3280	3280	6560	1	\N	\N	2018-07-05 07:52:56.311554
3282	t	3281	3281	6562	2	\N	\N	2018-07-05 07:52:56.311554
3283	t	3282	3282	6564	1	\N	\N	2018-07-05 07:52:56.311554
3284	t	3283	3283	6566	2	\N	\N	2018-07-05 07:52:56.311554
3285	t	3284	3284	6568	1	\N	\N	2018-07-05 07:52:56.311554
3286	t	3285	3285	6570	2	\N	\N	2018-07-05 07:52:56.311554
3287	t	3286	3286	6572	1	\N	\N	2018-07-05 07:52:56.311554
3288	t	3287	3287	6574	2	\N	\N	2018-07-05 07:52:56.311554
3289	t	3288	3288	6576	1	\N	\N	2018-07-05 07:52:56.311554
3290	t	3289	3289	6578	2	\N	\N	2018-07-05 07:52:56.311554
3291	t	3290	3290	6580	1	\N	\N	2018-07-05 07:52:56.311554
3292	t	3291	3291	6582	2	\N	\N	2018-07-05 07:52:56.311554
3293	t	3292	3292	6584	1	\N	\N	2018-07-05 07:52:56.311554
3294	t	3293	3293	6586	2	\N	\N	2018-07-05 07:52:56.311554
3295	t	3294	3294	6588	1	\N	\N	2018-07-05 07:52:56.311554
3296	t	3295	3295	6590	2	\N	\N	2018-07-05 07:52:56.311554
3297	t	3296	3296	6592	1	\N	\N	2018-07-05 07:52:56.311554
3298	t	3297	3297	6594	2	\N	\N	2018-07-05 07:52:56.311554
3299	t	3298	3298	6596	1	\N	\N	2018-07-05 07:52:56.311554
3300	t	3299	3299	6598	2	\N	\N	2018-07-05 07:52:56.311554
3301	t	3300	3300	6600	1	\N	\N	2018-07-05 07:52:56.311554
3302	t	3301	3301	6602	2	\N	\N	2018-07-05 07:52:56.311554
3303	t	3302	3302	6604	1	\N	\N	2018-07-05 07:52:56.311554
3304	t	3303	3303	6606	2	\N	\N	2018-07-05 07:52:56.311554
3305	t	3304	3304	6608	1	\N	\N	2018-07-05 07:52:56.311554
3306	t	3305	3305	6610	2	\N	\N	2018-07-05 07:52:56.311554
3307	t	3306	3306	6612	1	\N	\N	2018-07-05 07:52:56.311554
3308	t	3307	3307	6614	2	\N	\N	2018-07-05 07:52:56.311554
3309	t	3308	3308	6616	1	\N	\N	2018-07-05 07:52:56.311554
3310	t	3309	3309	6618	2	\N	\N	2018-07-05 07:52:56.311554
3311	t	3310	3310	6620	1	\N	\N	2018-07-05 07:52:56.311554
3312	t	3311	3311	6622	2	\N	\N	2018-07-05 07:52:56.311554
3313	t	3312	3312	6624	1	\N	\N	2018-07-05 07:52:56.311554
3314	t	3313	3313	6626	2	\N	\N	2018-07-05 07:52:56.311554
3315	t	3314	3314	6628	1	\N	\N	2018-07-05 07:52:56.311554
3316	t	3315	3315	6630	2	\N	\N	2018-07-05 07:52:56.311554
3317	t	3316	3316	6632	1	\N	\N	2018-07-05 07:52:56.311554
3318	t	3317	3317	6634	2	\N	\N	2018-07-05 07:52:56.311554
3319	t	3318	3318	6636	1	\N	\N	2018-07-05 07:52:56.311554
3320	t	3319	3319	6638	2	\N	\N	2018-07-05 07:52:56.311554
3321	t	3320	3320	6640	1	\N	\N	2018-07-05 07:52:56.311554
3322	t	3321	3321	6642	2	\N	\N	2018-07-05 07:52:56.311554
3323	t	3322	3322	6644	1	\N	\N	2018-07-05 07:52:56.311554
3324	t	3323	3323	6646	2	\N	\N	2018-07-05 07:52:56.311554
3325	t	3324	3324	6648	1	\N	\N	2018-07-05 07:52:56.311554
3326	t	3325	3325	6650	2	\N	\N	2018-07-05 07:52:56.311554
3327	t	3326	3326	6652	1	\N	\N	2018-07-05 07:52:56.311554
3328	t	3327	3327	6654	2	\N	\N	2018-07-05 07:52:56.311554
3329	t	3328	3328	6656	1	\N	\N	2018-07-05 07:52:56.311554
3330	t	3329	3329	6658	2	\N	\N	2018-07-05 07:52:56.311554
3331	t	3330	3330	6660	1	\N	\N	2018-07-05 07:52:56.311554
3332	t	3331	3331	6662	2	\N	\N	2018-07-05 07:52:56.311554
3333	t	3332	3332	6664	1	\N	\N	2018-07-05 07:52:56.311554
3334	t	3333	3333	6666	2	\N	\N	2018-07-05 07:52:56.311554
3335	t	3334	3334	6668	1	\N	\N	2018-07-05 07:52:56.311554
3336	t	3335	3335	6670	2	\N	\N	2018-07-05 07:52:56.311554
3337	t	3336	3336	6672	1	\N	\N	2018-07-05 07:52:56.311554
3338	t	3337	3337	6674	2	\N	\N	2018-07-05 07:52:56.311554
3339	t	3338	3338	6676	1	\N	\N	2018-07-05 07:52:56.311554
3340	t	3339	3339	6678	2	\N	\N	2018-07-05 07:52:56.311554
3341	t	3340	3340	6680	1	\N	\N	2018-07-05 07:52:56.311554
3342	t	3341	3341	6682	2	\N	\N	2018-07-05 07:52:56.311554
3343	t	3342	3342	6684	1	\N	\N	2018-07-05 07:52:56.311554
3344	t	3343	3343	6686	2	\N	\N	2018-07-05 07:52:56.311554
3345	t	3344	3344	6688	1	\N	\N	2018-07-05 07:52:56.311554
3346	t	3345	3345	6690	2	\N	\N	2018-07-05 07:52:56.311554
3347	t	3346	3346	6692	1	\N	\N	2018-07-05 07:52:56.311554
3348	t	3347	3347	6694	2	\N	\N	2018-07-05 07:52:56.311554
3349	t	3348	3348	6696	1	\N	\N	2018-07-05 07:52:56.311554
3350	t	3349	3349	6698	2	\N	\N	2018-07-05 07:52:56.311554
3351	t	3350	3350	6700	1	\N	\N	2018-07-05 07:52:56.311554
3352	t	3351	3351	6702	2	\N	\N	2018-07-05 07:52:56.311554
3353	t	3352	3352	6704	1	\N	\N	2018-07-05 07:52:56.311554
3354	t	3353	3353	6706	2	\N	\N	2018-07-05 07:52:56.311554
3355	t	3354	3354	6708	1	\N	\N	2018-07-05 07:52:56.311554
3356	t	3355	3355	6710	2	\N	\N	2018-07-05 07:52:56.311554
3357	t	3356	3356	6712	1	\N	\N	2018-07-05 07:52:56.311554
3358	t	3357	3357	6714	2	\N	\N	2018-07-05 07:52:56.311554
3359	t	3358	3358	6716	1	\N	\N	2018-07-05 07:52:56.311554
3360	t	3359	3359	6718	2	\N	\N	2018-07-05 07:52:56.311554
3361	t	3360	3360	6720	1	\N	\N	2018-07-05 07:52:56.311554
3362	t	3361	3361	6722	2	\N	\N	2018-07-05 07:52:56.311554
3363	t	3362	3362	6724	1	\N	\N	2018-07-05 07:52:56.311554
3364	t	3363	3363	6726	2	\N	\N	2018-07-05 07:52:56.311554
3365	t	3364	3364	6728	1	\N	\N	2018-07-05 07:52:56.311554
3366	t	3365	3365	6730	2	\N	\N	2018-07-05 07:52:56.311554
3367	t	3366	3366	6732	1	\N	\N	2018-07-05 07:52:56.311554
3368	t	3367	3367	6734	2	\N	\N	2018-07-05 07:52:56.311554
3369	t	3368	3368	6736	1	\N	\N	2018-07-05 07:52:56.311554
3370	t	3369	3369	6738	2	\N	\N	2018-07-05 07:52:56.311554
3371	t	3370	3370	6740	1	\N	\N	2018-07-05 07:52:56.311554
3372	t	3371	3371	6742	2	\N	\N	2018-07-05 07:52:56.311554
3373	t	3372	3372	6744	1	\N	\N	2018-07-05 07:52:56.311554
3374	t	3373	3373	6746	2	\N	\N	2018-07-05 07:52:56.311554
3375	t	3374	3374	6748	1	\N	\N	2018-07-05 07:52:56.311554
3376	t	3375	3375	6750	2	\N	\N	2018-07-05 07:52:56.311554
3377	t	3376	3376	6752	1	\N	\N	2018-07-05 07:52:56.311554
3378	t	3377	3377	6754	2	\N	\N	2018-07-05 07:52:56.311554
3379	t	3378	3378	6756	1	\N	\N	2018-07-05 07:52:56.311554
3380	t	3379	3379	6758	2	\N	\N	2018-07-05 07:52:56.311554
3381	t	3380	3380	6760	1	\N	\N	2018-07-05 07:52:56.311554
3382	t	3381	3381	6762	2	\N	\N	2018-07-05 07:52:56.311554
3383	t	3382	3382	6764	1	\N	\N	2018-07-05 07:52:56.311554
3384	t	3383	3383	6766	2	\N	\N	2018-07-05 07:52:56.311554
3385	t	3384	3384	6768	1	\N	\N	2018-07-05 07:52:56.311554
3386	t	3385	3385	6770	2	\N	\N	2018-07-05 07:52:56.311554
3387	t	3386	3386	6772	1	\N	\N	2018-07-05 07:52:56.311554
3388	t	3387	3387	6774	2	\N	\N	2018-07-05 07:52:56.311554
3389	t	3388	3388	6776	1	\N	\N	2018-07-05 07:52:56.311554
3390	t	3389	3389	6778	2	\N	\N	2018-07-05 07:52:56.311554
3391	t	3390	3390	6780	1	\N	\N	2018-07-05 07:52:56.311554
3392	t	3391	3391	6782	2	\N	\N	2018-07-05 07:52:56.311554
3393	t	3392	3392	6784	1	\N	\N	2018-07-05 07:52:56.311554
3394	t	3393	3393	6786	2	\N	\N	2018-07-05 07:52:56.311554
3395	t	3394	3394	6788	1	\N	\N	2018-07-05 07:52:56.311554
3396	t	3395	3395	6790	2	\N	\N	2018-07-05 07:52:56.311554
3397	t	3396	3396	6792	1	\N	\N	2018-07-05 07:52:56.311554
3398	t	3397	3397	6794	2	\N	\N	2018-07-05 07:52:56.311554
3399	t	3398	3398	6796	1	\N	\N	2018-07-05 07:52:56.311554
3400	t	3399	3399	6798	2	\N	\N	2018-07-05 07:52:56.311554
3401	t	3400	3400	6800	1	\N	\N	2018-07-05 07:52:56.311554
3402	t	3401	3401	6802	2	\N	\N	2018-07-05 07:52:56.311554
3403	t	3402	3402	6804	1	\N	\N	2018-07-05 07:52:56.311554
3404	t	3403	3403	6806	2	\N	\N	2018-07-05 07:52:56.311554
3405	t	3404	3404	6808	1	\N	\N	2018-07-05 07:52:56.311554
3406	t	3405	3405	6810	2	\N	\N	2018-07-05 07:52:56.311554
3407	t	3406	3406	6812	1	\N	\N	2018-07-05 07:52:56.311554
3408	t	3407	3407	6814	2	\N	\N	2018-07-05 07:52:56.311554
3409	t	3408	3408	6816	1	\N	\N	2018-07-05 07:52:56.311554
3410	t	3409	3409	6818	2	\N	\N	2018-07-05 07:52:56.311554
3411	t	3410	3410	6820	1	\N	\N	2018-07-05 07:52:56.311554
3412	t	3411	3411	6822	2	\N	\N	2018-07-05 07:52:56.311554
3413	t	3412	3412	6824	1	\N	\N	2018-07-05 07:52:56.311554
3414	t	3413	3413	6826	2	\N	\N	2018-07-05 07:52:56.311554
3415	t	3414	3414	6828	1	\N	\N	2018-07-05 07:52:56.311554
3416	t	3415	3415	6830	2	\N	\N	2018-07-05 07:52:56.311554
3417	t	3416	3416	6832	1	\N	\N	2018-07-05 07:52:56.311554
3418	t	3417	3417	6834	2	\N	\N	2018-07-05 07:52:56.311554
3419	t	3418	3418	6836	1	\N	\N	2018-07-05 07:52:56.311554
3420	t	3419	3419	6838	2	\N	\N	2018-07-05 07:52:56.311554
3421	t	3420	3420	6840	1	\N	\N	2018-07-05 07:52:56.311554
3422	t	3421	3421	6842	2	\N	\N	2018-07-05 07:52:56.311554
3423	t	3422	3422	6844	1	\N	\N	2018-07-05 07:52:56.311554
3424	t	3423	3423	6846	2	\N	\N	2018-07-05 07:52:56.311554
3425	t	3424	3424	6848	1	\N	\N	2018-07-05 07:52:56.311554
3426	t	3425	3425	6850	2	\N	\N	2018-07-05 07:52:56.311554
3427	t	3426	3426	6852	1	\N	\N	2018-07-05 07:52:56.311554
3428	t	3427	3427	6854	2	\N	\N	2018-07-05 07:52:56.311554
3429	t	3428	3428	6856	1	\N	\N	2018-07-05 07:52:56.311554
3430	t	3429	3429	6858	2	\N	\N	2018-07-05 07:52:56.311554
3431	t	3430	3430	6860	1	\N	\N	2018-07-05 07:52:56.311554
3432	t	3431	3431	6862	2	\N	\N	2018-07-05 07:52:56.311554
3433	t	3432	3432	6864	1	\N	\N	2018-07-05 07:52:56.311554
3434	t	3433	3433	6866	2	\N	\N	2018-07-05 07:52:56.311554
3435	t	3434	3434	6868	1	\N	\N	2018-07-05 07:52:56.311554
3436	t	3435	3435	6870	2	\N	\N	2018-07-05 07:52:56.311554
3437	t	3436	3436	6872	1	\N	\N	2018-07-05 07:52:56.311554
3438	t	3437	3437	6874	2	\N	\N	2018-07-05 07:52:56.311554
3439	t	3438	3438	6876	1	\N	\N	2018-07-05 07:52:56.311554
3440	t	3439	3439	6878	2	\N	\N	2018-07-05 07:52:56.311554
3441	t	3440	3440	6880	1	\N	\N	2018-07-05 07:52:56.311554
3442	t	3441	3441	6882	2	\N	\N	2018-07-05 07:52:56.311554
3443	t	3442	3442	6884	1	\N	\N	2018-07-05 07:52:56.311554
3444	t	3443	3443	6886	2	\N	\N	2018-07-05 07:52:56.311554
3445	t	3444	3444	6888	1	\N	\N	2018-07-05 07:52:56.311554
3446	t	3445	3445	6890	2	\N	\N	2018-07-05 07:52:56.311554
3447	t	3446	3446	6892	1	\N	\N	2018-07-05 07:52:56.311554
3448	t	3447	3447	6894	2	\N	\N	2018-07-05 07:52:56.311554
3449	t	3448	3448	6896	1	\N	\N	2018-07-05 07:52:56.311554
3450	t	3449	3449	6898	2	\N	\N	2018-07-05 07:52:56.311554
3451	t	3450	3450	6900	1	\N	\N	2018-07-05 07:52:56.311554
3452	t	3451	3451	6902	2	\N	\N	2018-07-05 07:52:56.311554
3453	t	3452	3452	6904	1	\N	\N	2018-07-05 07:52:56.311554
3454	t	3453	3453	6906	2	\N	\N	2018-07-05 07:52:56.311554
3455	t	3454	3454	6908	1	\N	\N	2018-07-05 07:52:56.311554
3456	t	3455	3455	6910	2	\N	\N	2018-07-05 07:52:56.311554
3457	t	3456	3456	6912	1	\N	\N	2018-07-05 07:52:56.311554
3458	t	3457	3457	6914	2	\N	\N	2018-07-05 07:52:56.311554
3459	t	3458	3458	6916	1	\N	\N	2018-07-05 07:52:56.311554
3460	t	3459	3459	6918	2	\N	\N	2018-07-05 07:52:56.311554
3461	t	3460	3460	6920	1	\N	\N	2018-07-05 07:52:56.311554
3462	t	3461	3461	6922	2	\N	\N	2018-07-05 07:52:56.311554
3463	t	3462	3462	6924	1	\N	\N	2018-07-05 07:52:56.311554
3464	t	3463	3463	6926	2	\N	\N	2018-07-05 07:52:56.311554
3465	t	3464	3464	6928	1	\N	\N	2018-07-05 07:52:56.311554
3466	t	3465	3465	6930	2	\N	\N	2018-07-05 07:52:56.311554
3467	t	3466	3466	6932	1	\N	\N	2018-07-05 07:52:56.311554
3468	t	3467	3467	6934	2	\N	\N	2018-07-05 07:52:56.311554
3469	t	3468	3468	6936	1	\N	\N	2018-07-05 07:52:56.311554
3470	t	3469	3469	6938	2	\N	\N	2018-07-05 07:52:56.311554
3471	t	3470	3470	6940	1	\N	\N	2018-07-05 07:52:56.311554
3472	t	3471	3471	6942	2	\N	\N	2018-07-05 07:52:56.311554
3473	t	3472	3472	6944	1	\N	\N	2018-07-05 07:52:56.311554
3474	t	3473	3473	6946	2	\N	\N	2018-07-05 07:52:56.311554
3475	t	3474	3474	6948	1	\N	\N	2018-07-05 07:52:56.311554
3476	t	3475	3475	6950	2	\N	\N	2018-07-05 07:52:56.311554
3477	t	3476	3476	6952	1	\N	\N	2018-07-05 07:52:56.311554
3478	t	3477	3477	6954	2	\N	\N	2018-07-05 07:52:56.311554
3479	t	3478	3478	6956	1	\N	\N	2018-07-05 07:52:56.311554
3480	t	3479	3479	6958	2	\N	\N	2018-07-05 07:52:56.311554
3481	t	3480	3480	6960	1	\N	\N	2018-07-05 07:52:56.311554
3482	t	3481	3481	6962	2	\N	\N	2018-07-05 07:52:56.311554
3483	t	3482	3482	6964	1	\N	\N	2018-07-05 07:52:56.311554
3484	t	3483	3483	6966	2	\N	\N	2018-07-05 07:52:56.311554
3485	t	3484	3484	6968	1	\N	\N	2018-07-05 07:52:56.311554
3486	t	3485	3485	6970	2	\N	\N	2018-07-05 07:52:56.311554
3487	t	3486	3486	6972	1	\N	\N	2018-07-05 07:52:56.311554
3488	t	3487	3487	6974	2	\N	\N	2018-07-05 07:52:56.311554
3489	t	3488	3488	6976	1	\N	\N	2018-07-05 07:52:56.311554
3490	t	3489	3489	6978	2	\N	\N	2018-07-05 07:52:56.311554
3491	t	3490	3490	6980	1	\N	\N	2018-07-05 07:52:56.311554
3492	t	3491	3491	6982	2	\N	\N	2018-07-05 07:52:56.311554
3493	t	3492	3492	6984	1	\N	\N	2018-07-05 07:52:56.311554
3494	t	3493	3493	6986	2	\N	\N	2018-07-05 07:52:56.311554
3495	t	3494	3494	6988	1	\N	\N	2018-07-05 07:52:56.311554
3496	t	3495	3495	6990	2	\N	\N	2018-07-05 07:52:56.311554
3497	t	3496	3496	6992	1	\N	\N	2018-07-05 07:52:56.311554
3498	t	3497	3497	6994	2	\N	\N	2018-07-05 07:52:56.311554
3499	t	3498	3498	6996	1	\N	\N	2018-07-05 07:52:56.311554
3500	t	3499	3499	6998	2	\N	\N	2018-07-05 07:52:56.311554
3501	t	3500	3500	7000	1	\N	\N	2018-07-05 07:52:56.311554
3502	t	3501	3501	7002	2	\N	\N	2018-07-05 07:52:56.311554
3503	t	3502	3502	7004	1	\N	\N	2018-07-05 07:52:56.311554
3504	t	3503	3503	7006	2	\N	\N	2018-07-05 07:52:56.311554
3505	t	3504	3504	7008	1	\N	\N	2018-07-05 07:52:56.311554
3506	t	3505	3505	7010	2	\N	\N	2018-07-05 07:52:56.311554
3507	t	3506	3506	7012	1	\N	\N	2018-07-05 07:52:56.311554
3508	t	3507	3507	7014	2	\N	\N	2018-07-05 07:52:56.311554
3509	t	3508	3508	7016	1	\N	\N	2018-07-05 07:52:56.311554
3510	t	3509	3509	7018	2	\N	\N	2018-07-05 07:52:56.311554
3511	t	3510	3510	7020	1	\N	\N	2018-07-05 07:52:56.311554
3512	t	3511	3511	7022	2	\N	\N	2018-07-05 07:52:56.311554
3513	t	3512	3512	7024	1	\N	\N	2018-07-05 07:52:56.311554
3514	t	3513	3513	7026	2	\N	\N	2018-07-05 07:52:56.311554
3515	t	3514	3514	7028	1	\N	\N	2018-07-05 07:52:56.311554
3516	t	3515	3515	7030	2	\N	\N	2018-07-05 07:52:56.311554
3517	t	3516	3516	7032	1	\N	\N	2018-07-05 07:52:56.311554
3518	t	3517	3517	7034	2	\N	\N	2018-07-05 07:52:56.311554
3519	t	3518	3518	7036	1	\N	\N	2018-07-05 07:52:56.311554
3520	t	3519	3519	7038	2	\N	\N	2018-07-05 07:52:56.311554
3521	t	3520	3520	7040	1	\N	\N	2018-07-05 07:52:56.311554
3522	t	3521	3521	7042	2	\N	\N	2018-07-05 07:52:56.311554
3523	t	3522	3522	7044	1	\N	\N	2018-07-05 07:52:56.311554
3524	t	3523	3523	7046	2	\N	\N	2018-07-05 07:52:56.311554
3525	t	3524	3524	7048	1	\N	\N	2018-07-05 07:52:56.311554
3526	t	3525	3525	7050	2	\N	\N	2018-07-05 07:52:56.311554
3527	t	3526	3526	7052	1	\N	\N	2018-07-05 07:52:56.311554
3528	t	3527	3527	7054	2	\N	\N	2018-07-05 07:52:56.311554
3529	t	3528	3528	7056	1	\N	\N	2018-07-05 07:52:56.311554
3530	t	3529	3529	7058	2	\N	\N	2018-07-05 07:52:56.311554
3531	t	3530	3530	7060	1	\N	\N	2018-07-05 07:52:56.311554
3532	t	3531	3531	7062	2	\N	\N	2018-07-05 07:52:56.311554
3533	t	3532	3532	7064	1	\N	\N	2018-07-05 07:52:56.311554
3534	t	3533	3533	7066	2	\N	\N	2018-07-05 07:52:56.311554
3535	t	3534	3534	7068	1	\N	\N	2018-07-05 07:52:56.311554
3536	t	3535	3535	7070	2	\N	\N	2018-07-05 07:52:56.311554
3537	t	3536	3536	7072	1	\N	\N	2018-07-05 07:52:56.311554
3538	t	3537	3537	7074	2	\N	\N	2018-07-05 07:52:56.311554
3539	t	3538	3538	7076	1	\N	\N	2018-07-05 07:52:56.311554
3540	t	3539	3539	7078	2	\N	\N	2018-07-05 07:52:56.311554
3541	t	3540	3540	7080	1	\N	\N	2018-07-05 07:52:56.311554
3542	t	3541	3541	7082	2	\N	\N	2018-07-05 07:52:56.311554
3543	t	3542	3542	7084	1	\N	\N	2018-07-05 07:52:56.311554
3544	t	3543	3543	7086	2	\N	\N	2018-07-05 07:52:56.311554
3545	t	3544	3544	7088	1	\N	\N	2018-07-05 07:52:56.311554
3546	t	3545	3545	7090	2	\N	\N	2018-07-05 07:52:56.311554
3547	t	3546	3546	7092	1	\N	\N	2018-07-05 07:52:56.311554
3548	t	3547	3547	7094	2	\N	\N	2018-07-05 07:52:56.311554
3549	t	3548	3548	7096	1	\N	\N	2018-07-05 07:52:56.311554
3550	t	3549	3549	7098	2	\N	\N	2018-07-05 07:52:56.311554
3551	t	3550	3550	7100	1	\N	\N	2018-07-05 07:52:56.311554
3552	t	3551	3551	7102	2	\N	\N	2018-07-05 07:52:56.311554
3553	t	3552	3552	7104	1	\N	\N	2018-07-05 07:52:56.311554
3554	t	3553	3553	7106	2	\N	\N	2018-07-05 07:52:56.311554
3555	t	3554	3554	7108	1	\N	\N	2018-07-05 07:52:56.311554
3556	t	3555	3555	7110	2	\N	\N	2018-07-05 07:52:56.311554
3557	t	3556	3556	7112	1	\N	\N	2018-07-05 07:52:56.311554
3558	t	3557	3557	7114	2	\N	\N	2018-07-05 07:52:56.311554
3559	t	3558	3558	7116	1	\N	\N	2018-07-05 07:52:56.311554
3560	t	3559	3559	7118	2	\N	\N	2018-07-05 07:52:56.311554
3561	t	3560	3560	7120	1	\N	\N	2018-07-05 07:52:56.311554
3562	t	3561	3561	7122	2	\N	\N	2018-07-05 07:52:56.311554
3563	t	3562	3562	7124	1	\N	\N	2018-07-05 07:52:56.311554
3564	t	3563	3563	7126	2	\N	\N	2018-07-05 07:52:56.311554
3565	t	3564	3564	7128	1	\N	\N	2018-07-05 07:52:56.311554
3566	t	3565	3565	7130	2	\N	\N	2018-07-05 07:52:56.311554
3567	t	3566	3566	7132	1	\N	\N	2018-07-05 07:52:56.311554
3568	t	3567	3567	7134	2	\N	\N	2018-07-05 07:52:56.311554
3569	t	3568	3568	7136	1	\N	\N	2018-07-05 07:52:56.311554
3570	t	3569	3569	7138	2	\N	\N	2018-07-05 07:52:56.311554
3571	t	3570	3570	7140	1	\N	\N	2018-07-05 07:52:56.311554
3572	t	3571	3571	7142	2	\N	\N	2018-07-05 07:52:56.311554
3573	t	3572	3572	7144	1	\N	\N	2018-07-05 07:52:56.311554
3574	t	3573	3573	7146	2	\N	\N	2018-07-05 07:52:56.311554
3575	t	3574	3574	7148	1	\N	\N	2018-07-05 07:52:56.311554
3576	t	3575	3575	7150	2	\N	\N	2018-07-05 07:52:56.311554
3577	t	3576	3576	7152	1	\N	\N	2018-07-05 07:52:56.311554
3578	t	3577	3577	7154	2	\N	\N	2018-07-05 07:52:56.311554
3579	t	3578	3578	7156	1	\N	\N	2018-07-05 07:52:56.311554
3580	t	3579	3579	7158	2	\N	\N	2018-07-05 07:52:56.311554
3581	t	3580	3580	7160	1	\N	\N	2018-07-05 07:52:56.311554
3582	t	3581	3581	7162	2	\N	\N	2018-07-05 07:52:56.311554
3583	t	3582	3582	7164	1	\N	\N	2018-07-05 07:52:56.311554
3584	t	3583	3583	7166	2	\N	\N	2018-07-05 07:52:56.311554
3585	t	3584	3584	7168	1	\N	\N	2018-07-05 07:52:56.311554
3586	t	3585	3585	7170	2	\N	\N	2018-07-05 07:52:56.311554
3587	t	3586	3586	7172	1	\N	\N	2018-07-05 07:52:56.311554
3588	t	3587	3587	7174	2	\N	\N	2018-07-05 07:52:56.311554
3589	t	3588	3588	7176	1	\N	\N	2018-07-05 07:52:56.311554
3590	t	3589	3589	7178	2	\N	\N	2018-07-05 07:52:56.311554
3591	t	3590	3590	7180	1	\N	\N	2018-07-05 07:52:56.311554
3592	t	3591	3591	7182	2	\N	\N	2018-07-05 07:52:56.311554
3593	t	3592	3592	7184	1	\N	\N	2018-07-05 07:52:56.311554
3594	t	3593	3593	7186	2	\N	\N	2018-07-05 07:52:56.311554
3595	t	3594	3594	7188	1	\N	\N	2018-07-05 07:52:56.311554
3596	t	3595	3595	7190	2	\N	\N	2018-07-05 07:52:56.311554
3597	t	3596	3596	7192	1	\N	\N	2018-07-05 07:52:56.311554
3598	t	3597	3597	7194	2	\N	\N	2018-07-05 07:52:56.311554
3599	t	3598	3598	7196	1	\N	\N	2018-07-05 07:52:56.311554
3600	t	3599	3599	7198	2	\N	\N	2018-07-05 07:52:56.311554
3601	t	3600	3600	7200	1	\N	\N	2018-07-05 07:52:56.311554
3602	t	3601	3601	7202	2	\N	\N	2018-07-05 07:52:56.311554
3603	t	3602	3602	7204	1	\N	\N	2018-07-05 07:52:56.311554
3604	t	3603	3603	7206	2	\N	\N	2018-07-05 07:52:56.311554
3605	t	3604	3604	7208	1	\N	\N	2018-07-05 07:52:56.311554
3606	t	3605	3605	7210	2	\N	\N	2018-07-05 07:52:56.311554
3607	t	3606	3606	7212	1	\N	\N	2018-07-05 07:52:56.311554
3608	t	3607	3607	7214	2	\N	\N	2018-07-05 07:52:56.311554
3609	t	3608	3608	7216	1	\N	\N	2018-07-05 07:52:56.311554
3610	t	3609	3609	7218	2	\N	\N	2018-07-05 07:52:56.311554
3611	t	3610	3610	7220	1	\N	\N	2018-07-05 07:52:56.311554
3612	t	3611	3611	7222	2	\N	\N	2018-07-05 07:52:56.311554
3613	t	3612	3612	7224	1	\N	\N	2018-07-05 07:52:56.311554
3614	t	3613	3613	7226	2	\N	\N	2018-07-05 07:52:56.311554
3615	t	3614	3614	7228	1	\N	\N	2018-07-05 07:52:56.311554
3616	t	3615	3615	7230	2	\N	\N	2018-07-05 07:52:56.311554
3617	t	3616	3616	7232	1	\N	\N	2018-07-05 07:52:56.311554
3618	t	3617	3617	7234	2	\N	\N	2018-07-05 07:52:56.311554
3619	t	3618	3618	7236	1	\N	\N	2018-07-05 07:52:56.311554
3620	t	3619	3619	7238	2	\N	\N	2018-07-05 07:52:56.311554
3621	t	3620	3620	7240	1	\N	\N	2018-07-05 07:52:56.311554
3622	t	3621	3621	7242	2	\N	\N	2018-07-05 07:52:56.311554
3623	t	3622	3622	7244	1	\N	\N	2018-07-05 07:52:56.311554
3624	t	3623	3623	7246	2	\N	\N	2018-07-05 07:52:56.311554
3625	t	3624	3624	7248	1	\N	\N	2018-07-05 07:52:56.311554
3626	t	3625	3625	7250	2	\N	\N	2018-07-05 07:52:56.311554
3627	t	3626	3626	7252	1	\N	\N	2018-07-05 07:52:56.311554
3628	t	3627	3627	7254	2	\N	\N	2018-07-05 07:52:56.311554
3629	t	3628	3628	7256	1	\N	\N	2018-07-05 07:52:56.311554
3630	t	3629	3629	7258	2	\N	\N	2018-07-05 07:52:56.311554
3631	t	3630	3630	7260	1	\N	\N	2018-07-05 07:52:56.311554
3632	t	3631	3631	7262	2	\N	\N	2018-07-05 07:52:56.311554
3633	t	3632	3632	7264	1	\N	\N	2018-07-05 07:52:56.311554
3634	t	3633	3633	7266	2	\N	\N	2018-07-05 07:52:56.311554
3635	t	3634	3634	7268	1	\N	\N	2018-07-05 07:52:56.311554
3636	t	3635	3635	7270	2	\N	\N	2018-07-05 07:52:56.311554
3637	t	3636	3636	7272	1	\N	\N	2018-07-05 07:52:56.311554
3638	t	3637	3637	7274	2	\N	\N	2018-07-05 07:52:56.311554
3639	t	3638	3638	7276	1	\N	\N	2018-07-05 07:52:56.311554
3640	t	3639	3639	7278	2	\N	\N	2018-07-05 07:52:56.311554
3641	t	3640	3640	7280	1	\N	\N	2018-07-05 07:52:56.311554
3642	t	3641	3641	7282	2	\N	\N	2018-07-05 07:52:56.311554
3643	t	3642	3642	7284	1	\N	\N	2018-07-05 07:52:56.311554
3644	t	3643	3643	7286	2	\N	\N	2018-07-05 07:52:56.311554
3645	t	3644	3644	7288	1	\N	\N	2018-07-05 07:52:56.311554
3646	t	3645	3645	7290	2	\N	\N	2018-07-05 07:52:56.311554
3647	t	3646	3646	7292	1	\N	\N	2018-07-05 07:52:56.311554
3648	t	3647	3647	7294	2	\N	\N	2018-07-05 07:52:56.311554
3649	t	3648	3648	7296	1	\N	\N	2018-07-05 07:52:56.311554
3650	t	3649	3649	7298	2	\N	\N	2018-07-05 07:52:56.311554
3651	t	3650	3650	7300	1	\N	\N	2018-07-05 07:52:56.311554
3652	t	3651	3651	7302	2	\N	\N	2018-07-05 07:52:56.311554
3653	t	3652	3652	7304	1	\N	\N	2018-07-05 07:52:56.311554
3654	t	3653	3653	7306	2	\N	\N	2018-07-05 07:52:56.311554
3655	t	3654	3654	7308	1	\N	\N	2018-07-05 07:52:56.311554
3656	t	3655	3655	7310	2	\N	\N	2018-07-05 07:52:56.311554
3657	t	3656	3656	7312	1	\N	\N	2018-07-05 07:52:56.311554
3658	t	3657	3657	7314	2	\N	\N	2018-07-05 07:52:56.311554
3659	t	3658	3658	7316	1	\N	\N	2018-07-05 07:52:56.311554
3660	t	3659	3659	7318	2	\N	\N	2018-07-05 07:52:56.311554
3661	t	3660	3660	7320	1	\N	\N	2018-07-05 07:52:56.311554
3662	t	3661	3661	7322	2	\N	\N	2018-07-05 07:52:56.311554
3663	t	3662	3662	7324	1	\N	\N	2018-07-05 07:52:56.311554
3664	t	3663	3663	7326	2	\N	\N	2018-07-05 07:52:56.311554
3665	t	3664	3664	7328	1	\N	\N	2018-07-05 07:52:56.311554
3666	t	3665	3665	7330	2	\N	\N	2018-07-05 07:52:56.311554
3667	t	3666	3666	7332	1	\N	\N	2018-07-05 07:52:56.311554
3668	t	3667	3667	7334	2	\N	\N	2018-07-05 07:52:56.311554
3669	t	3668	3668	7336	1	\N	\N	2018-07-05 07:52:56.311554
3670	t	3669	3669	7338	2	\N	\N	2018-07-05 07:52:56.311554
3671	t	3670	3670	7340	1	\N	\N	2018-07-05 07:52:56.311554
3672	t	3671	3671	7342	2	\N	\N	2018-07-05 07:52:56.311554
3673	t	3672	3672	7344	1	\N	\N	2018-07-05 07:52:56.311554
3674	t	3673	3673	7346	2	\N	\N	2018-07-05 07:52:56.311554
3675	t	3674	3674	7348	1	\N	\N	2018-07-05 07:52:56.311554
3676	t	3675	3675	7350	2	\N	\N	2018-07-05 07:52:56.311554
3677	t	3676	3676	7352	1	\N	\N	2018-07-05 07:52:56.311554
3678	t	3677	3677	7354	2	\N	\N	2018-07-05 07:52:56.311554
3679	t	3678	3678	7356	1	\N	\N	2018-07-05 07:52:56.311554
3680	t	3679	3679	7358	2	\N	\N	2018-07-05 07:52:56.311554
3681	t	3680	3680	7360	1	\N	\N	2018-07-05 07:52:56.311554
3682	t	3681	3681	7362	2	\N	\N	2018-07-05 07:52:56.311554
3683	t	3682	3682	7364	1	\N	\N	2018-07-05 07:52:56.311554
3684	t	3683	3683	7366	2	\N	\N	2018-07-05 07:52:56.311554
3685	t	3684	3684	7368	1	\N	\N	2018-07-05 07:52:56.311554
3686	t	3685	3685	7370	2	\N	\N	2018-07-05 07:52:56.311554
3687	t	3686	3686	7372	1	\N	\N	2018-07-05 07:52:56.311554
3688	t	3687	3687	7374	2	\N	\N	2018-07-05 07:52:56.311554
3689	t	3688	3688	7376	1	\N	\N	2018-07-05 07:52:56.311554
3690	t	3689	3689	7378	2	\N	\N	2018-07-05 07:52:56.311554
3691	t	3690	3690	7380	1	\N	\N	2018-07-05 07:52:56.311554
3692	t	3691	3691	7382	2	\N	\N	2018-07-05 07:52:56.311554
3693	t	3692	3692	7384	1	\N	\N	2018-07-05 07:52:56.311554
3694	t	3693	3693	7386	2	\N	\N	2018-07-05 07:52:56.311554
3695	t	3694	3694	7388	1	\N	\N	2018-07-05 07:52:56.311554
3696	t	3695	3695	7390	2	\N	\N	2018-07-05 07:52:56.311554
3697	t	3696	3696	7392	1	\N	\N	2018-07-05 07:52:56.311554
3698	t	3697	3697	7394	2	\N	\N	2018-07-05 07:52:56.311554
3699	t	3698	3698	7396	1	\N	\N	2018-07-05 07:52:56.311554
3700	t	3699	3699	7398	2	\N	\N	2018-07-05 07:52:56.311554
3701	t	3700	3700	7400	1	\N	\N	2018-07-05 07:52:56.311554
3702	t	3701	3701	7402	2	\N	\N	2018-07-05 07:52:56.311554
3703	t	3702	3702	7404	1	\N	\N	2018-07-05 07:52:56.311554
3704	t	3703	3703	7406	2	\N	\N	2018-07-05 07:52:56.311554
3705	t	3704	3704	7408	1	\N	\N	2018-07-05 07:52:56.311554
3706	t	3705	3705	7410	2	\N	\N	2018-07-05 07:52:56.311554
3707	t	3706	3706	7412	1	\N	\N	2018-07-05 07:52:56.311554
3708	t	3707	3707	7414	2	\N	\N	2018-07-05 07:52:56.311554
3709	t	3708	3708	7416	1	\N	\N	2018-07-05 07:52:56.311554
3710	t	3709	3709	7418	2	\N	\N	2018-07-05 07:52:56.311554
3711	t	3710	3710	7420	1	\N	\N	2018-07-05 07:52:56.311554
3712	t	3711	3711	7422	2	\N	\N	2018-07-05 07:52:56.311554
3713	t	3712	3712	7424	1	\N	\N	2018-07-05 07:52:56.311554
3714	t	3713	3713	7426	2	\N	\N	2018-07-05 07:52:56.311554
3715	t	3714	3714	7428	1	\N	\N	2018-07-05 07:52:56.311554
3716	t	3715	3715	7430	2	\N	\N	2018-07-05 07:52:56.311554
3717	t	3716	3716	7432	1	\N	\N	2018-07-05 07:52:56.311554
3718	t	3717	3717	7434	2	\N	\N	2018-07-05 07:52:56.311554
3719	t	3718	3718	7436	1	\N	\N	2018-07-05 07:52:56.311554
3720	t	3719	3719	7438	2	\N	\N	2018-07-05 07:52:56.311554
3721	t	3720	3720	7440	1	\N	\N	2018-07-05 07:52:56.311554
3722	t	3721	3721	7442	2	\N	\N	2018-07-05 07:52:56.311554
3723	t	3722	3722	7444	1	\N	\N	2018-07-05 07:52:56.311554
3724	t	3723	3723	7446	2	\N	\N	2018-07-05 07:52:56.311554
3725	t	3724	3724	7448	1	\N	\N	2018-07-05 07:52:56.311554
3726	t	3725	3725	7450	2	\N	\N	2018-07-05 07:52:56.311554
3727	t	3726	3726	7452	1	\N	\N	2018-07-05 07:52:56.311554
3728	t	3727	3727	7454	2	\N	\N	2018-07-05 07:52:56.311554
3729	t	3728	3728	7456	1	\N	\N	2018-07-05 07:52:56.311554
3730	t	3729	3729	7458	2	\N	\N	2018-07-05 07:52:56.311554
3731	t	3730	3730	7460	1	\N	\N	2018-07-05 07:52:56.311554
3732	t	3731	3731	7462	2	\N	\N	2018-07-05 07:52:56.311554
3733	t	3732	3732	7464	1	\N	\N	2018-07-05 07:52:56.311554
3734	t	3733	3733	7466	2	\N	\N	2018-07-05 07:52:56.311554
3735	t	3734	3734	7468	1	\N	\N	2018-07-05 07:52:56.311554
3736	t	3735	3735	7470	2	\N	\N	2018-07-05 07:52:56.311554
3737	t	3736	3736	7472	1	\N	\N	2018-07-05 07:52:56.311554
3738	t	3737	3737	7474	2	\N	\N	2018-07-05 07:52:56.311554
3739	t	3738	3738	7476	1	\N	\N	2018-07-05 07:52:56.311554
3740	t	3739	3739	7478	2	\N	\N	2018-07-05 07:52:56.311554
3741	t	3740	3740	7480	1	\N	\N	2018-07-05 07:52:56.311554
3742	t	3741	3741	7482	2	\N	\N	2018-07-05 07:52:56.311554
3743	t	3742	3742	7484	1	\N	\N	2018-07-05 07:52:56.311554
3744	t	3743	3743	7486	2	\N	\N	2018-07-05 07:52:56.311554
3745	t	3744	3744	7488	1	\N	\N	2018-07-05 07:52:56.311554
3746	t	3745	3745	7490	2	\N	\N	2018-07-05 07:52:56.311554
3747	t	3746	3746	7492	1	\N	\N	2018-07-05 07:52:56.311554
3748	t	3747	3747	7494	2	\N	\N	2018-07-05 07:52:56.311554
3749	t	3748	3748	7496	1	\N	\N	2018-07-05 07:52:56.311554
3750	t	3749	3749	7498	2	\N	\N	2018-07-05 07:52:56.311554
3751	t	3750	3750	7500	1	\N	\N	2018-07-05 07:52:56.311554
3752	t	3751	3751	7502	2	\N	\N	2018-07-05 07:52:56.311554
3753	t	3752	3752	7504	1	\N	\N	2018-07-05 07:52:56.311554
3754	t	3753	3753	7506	2	\N	\N	2018-07-05 07:52:56.311554
3755	t	3754	3754	7508	1	\N	\N	2018-07-05 07:52:56.311554
3756	t	3755	3755	7510	2	\N	\N	2018-07-05 07:52:56.311554
3757	t	3756	3756	7512	1	\N	\N	2018-07-05 07:52:56.311554
3758	t	3757	3757	7514	2	\N	\N	2018-07-05 07:52:56.311554
3759	t	3758	3758	7516	1	\N	\N	2018-07-05 07:52:56.311554
3760	t	3759	3759	7518	2	\N	\N	2018-07-05 07:52:56.311554
3761	t	3760	3760	7520	1	\N	\N	2018-07-05 07:52:56.311554
3762	t	3761	3761	7522	2	\N	\N	2018-07-05 07:52:56.311554
3763	t	3762	3762	7524	1	\N	\N	2018-07-05 07:52:56.311554
3764	t	3763	3763	7526	2	\N	\N	2018-07-05 07:52:56.311554
3765	t	3764	3764	7528	1	\N	\N	2018-07-05 07:52:56.311554
3766	t	3765	3765	7530	2	\N	\N	2018-07-05 07:52:56.311554
3767	t	3766	3766	7532	1	\N	\N	2018-07-05 07:52:56.311554
3768	t	3767	3767	7534	2	\N	\N	2018-07-05 07:52:56.311554
3769	t	3768	3768	7536	1	\N	\N	2018-07-05 07:52:56.311554
3770	t	3769	3769	7538	2	\N	\N	2018-07-05 07:52:56.311554
3771	t	3770	3770	7540	1	\N	\N	2018-07-05 07:52:56.311554
3772	t	3771	3771	7542	2	\N	\N	2018-07-05 07:52:56.311554
3773	t	3772	3772	7544	1	\N	\N	2018-07-05 07:52:56.311554
3774	t	3773	3773	7546	2	\N	\N	2018-07-05 07:52:56.311554
3775	t	3774	3774	7548	1	\N	\N	2018-07-05 07:52:56.311554
3776	t	3775	3775	7550	2	\N	\N	2018-07-05 07:52:56.311554
3777	t	3776	3776	7552	1	\N	\N	2018-07-05 07:52:56.311554
3778	t	3777	3777	7554	2	\N	\N	2018-07-05 07:52:56.311554
3779	t	3778	3778	7556	1	\N	\N	2018-07-05 07:52:56.311554
3780	t	3779	3779	7558	2	\N	\N	2018-07-05 07:52:56.311554
3781	t	3780	3780	7560	1	\N	\N	2018-07-05 07:52:56.311554
3782	t	3781	3781	7562	2	\N	\N	2018-07-05 07:52:56.311554
3783	t	3782	3782	7564	1	\N	\N	2018-07-05 07:52:56.311554
3784	t	3783	3783	7566	2	\N	\N	2018-07-05 07:52:56.311554
3785	t	3784	3784	7568	1	\N	\N	2018-07-05 07:52:56.311554
3786	t	3785	3785	7570	2	\N	\N	2018-07-05 07:52:56.311554
3787	t	3786	3786	7572	1	\N	\N	2018-07-05 07:52:56.311554
3788	t	3787	3787	7574	2	\N	\N	2018-07-05 07:52:56.311554
3789	t	3788	3788	7576	1	\N	\N	2018-07-05 07:52:56.311554
3790	t	3789	3789	7578	2	\N	\N	2018-07-05 07:52:56.311554
3791	t	3790	3790	7580	1	\N	\N	2018-07-05 07:52:56.311554
3792	t	3791	3791	7582	2	\N	\N	2018-07-05 07:52:56.311554
3793	t	3792	3792	7584	1	\N	\N	2018-07-05 07:52:56.311554
3794	t	3793	3793	7586	2	\N	\N	2018-07-05 07:52:56.311554
3795	t	3794	3794	7588	1	\N	\N	2018-07-05 07:52:56.311554
3796	t	3795	3795	7590	2	\N	\N	2018-07-05 07:52:56.311554
3797	t	3796	3796	7592	1	\N	\N	2018-07-05 07:52:56.311554
3798	t	3797	3797	7594	2	\N	\N	2018-07-05 07:52:56.311554
3799	t	3798	3798	7596	1	\N	\N	2018-07-05 07:52:56.311554
3800	t	3799	3799	7598	2	\N	\N	2018-07-05 07:52:56.311554
3801	t	3800	3800	7600	1	\N	\N	2018-07-05 07:52:56.311554
3802	t	3801	3801	7602	2	\N	\N	2018-07-05 07:52:56.311554
3803	t	3802	3802	7604	1	\N	\N	2018-07-05 07:52:56.311554
3804	t	3803	3803	7606	2	\N	\N	2018-07-05 07:52:56.311554
3805	t	3804	3804	7608	1	\N	\N	2018-07-05 07:52:56.311554
3806	t	3805	3805	7610	2	\N	\N	2018-07-05 07:52:56.311554
3807	t	3806	3806	7612	1	\N	\N	2018-07-05 07:52:56.311554
3808	t	3807	3807	7614	2	\N	\N	2018-07-05 07:52:56.311554
3809	t	3808	3808	7616	1	\N	\N	2018-07-05 07:52:56.311554
3810	t	3809	3809	7618	2	\N	\N	2018-07-05 07:52:56.311554
3811	t	3810	3810	7620	1	\N	\N	2018-07-05 07:52:56.311554
3812	t	3811	3811	7622	2	\N	\N	2018-07-05 07:52:56.311554
3813	t	3812	3812	7624	1	\N	\N	2018-07-05 07:52:56.311554
3814	t	3813	3813	7626	2	\N	\N	2018-07-05 07:52:56.311554
3815	t	3814	3814	7628	1	\N	\N	2018-07-05 07:52:56.311554
3816	t	3815	3815	7630	2	\N	\N	2018-07-05 07:52:56.311554
3817	t	3816	3816	7632	1	\N	\N	2018-07-05 07:52:56.311554
3818	t	3817	3817	7634	2	\N	\N	2018-07-05 07:52:56.311554
3819	t	3818	3818	7636	1	\N	\N	2018-07-05 07:52:56.311554
3820	t	3819	3819	7638	2	\N	\N	2018-07-05 07:52:56.311554
3821	t	3820	3820	7640	1	\N	\N	2018-07-05 07:52:56.311554
3822	t	3821	3821	7642	2	\N	\N	2018-07-05 07:52:56.311554
3823	t	3822	3822	7644	1	\N	\N	2018-07-05 07:52:56.311554
3824	t	3823	3823	7646	2	\N	\N	2018-07-05 07:52:56.311554
3825	t	3824	3824	7648	1	\N	\N	2018-07-05 07:52:56.311554
3826	t	3825	3825	7650	2	\N	\N	2018-07-05 07:52:56.311554
3827	t	3826	3826	7652	1	\N	\N	2018-07-05 07:52:56.311554
3828	t	3827	3827	7654	2	\N	\N	2018-07-05 07:52:56.311554
3829	t	3828	3828	7656	1	\N	\N	2018-07-05 07:52:56.311554
3830	t	3829	3829	7658	2	\N	\N	2018-07-05 07:52:56.311554
3831	t	3830	3830	7660	1	\N	\N	2018-07-05 07:52:56.311554
3832	t	3831	3831	7662	2	\N	\N	2018-07-05 07:52:56.311554
3833	t	3832	3832	7664	1	\N	\N	2018-07-05 07:52:56.311554
3834	t	3833	3833	7666	2	\N	\N	2018-07-05 07:52:56.311554
3835	t	3834	3834	7668	1	\N	\N	2018-07-05 07:52:56.311554
3836	t	3835	3835	7670	2	\N	\N	2018-07-05 07:52:56.311554
3837	t	3836	3836	7672	1	\N	\N	2018-07-05 07:52:56.311554
3838	t	3837	3837	7674	2	\N	\N	2018-07-05 07:52:56.311554
3839	t	3838	3838	7676	1	\N	\N	2018-07-05 07:52:56.311554
3840	t	3839	3839	7678	2	\N	\N	2018-07-05 07:52:56.311554
3841	t	3840	3840	7680	1	\N	\N	2018-07-05 07:52:56.311554
3842	t	3841	3841	7682	2	\N	\N	2018-07-05 07:52:56.311554
3843	t	3842	3842	7684	1	\N	\N	2018-07-05 07:52:56.311554
3844	t	3843	3843	7686	2	\N	\N	2018-07-05 07:52:56.311554
3845	t	3844	3844	7688	1	\N	\N	2018-07-05 07:52:56.311554
3846	t	3845	3845	7690	2	\N	\N	2018-07-05 07:52:56.311554
3847	t	3846	3846	7692	1	\N	\N	2018-07-05 07:52:56.311554
3848	t	3847	3847	7694	2	\N	\N	2018-07-05 07:52:56.311554
3849	t	3848	3848	7696	1	\N	\N	2018-07-05 07:52:56.311554
3850	t	3849	3849	7698	2	\N	\N	2018-07-05 07:52:56.311554
3851	t	3850	3850	7700	1	\N	\N	2018-07-05 07:52:56.311554
3852	t	3851	3851	7702	2	\N	\N	2018-07-05 07:52:56.311554
3853	t	3852	3852	7704	1	\N	\N	2018-07-05 07:52:56.311554
3854	t	3853	3853	7706	2	\N	\N	2018-07-05 07:52:56.311554
3855	t	3854	3854	7708	1	\N	\N	2018-07-05 07:52:56.311554
3856	t	3855	3855	7710	2	\N	\N	2018-07-05 07:52:56.311554
3857	t	3856	3856	7712	1	\N	\N	2018-07-05 07:52:56.311554
3858	t	3857	3857	7714	2	\N	\N	2018-07-05 07:52:56.311554
3859	t	3858	3858	7716	1	\N	\N	2018-07-05 07:52:56.311554
3860	t	3859	3859	7718	2	\N	\N	2018-07-05 07:52:56.311554
3861	t	3860	3860	7720	1	\N	\N	2018-07-05 07:52:56.311554
3862	t	3861	3861	7722	2	\N	\N	2018-07-05 07:52:56.311554
3863	t	3862	3862	7724	1	\N	\N	2018-07-05 07:52:56.311554
3864	t	3863	3863	7726	2	\N	\N	2018-07-05 07:52:56.311554
3865	t	3864	3864	7728	1	\N	\N	2018-07-05 07:52:56.311554
3866	t	3865	3865	7730	2	\N	\N	2018-07-05 07:52:56.311554
3867	t	3866	3866	7732	1	\N	\N	2018-07-05 07:52:56.311554
3868	t	3867	3867	7734	2	\N	\N	2018-07-05 07:52:56.311554
3869	t	3868	3868	7736	1	\N	\N	2018-07-05 07:52:56.311554
3870	t	3869	3869	7738	2	\N	\N	2018-07-05 07:52:56.311554
3871	t	3870	3870	7740	1	\N	\N	2018-07-05 07:52:56.311554
3872	t	3871	3871	7742	2	\N	\N	2018-07-05 07:52:56.311554
3873	t	3872	3872	7744	1	\N	\N	2018-07-05 07:52:56.311554
3874	t	3873	3873	7746	2	\N	\N	2018-07-05 07:52:56.311554
3875	t	3874	3874	7748	1	\N	\N	2018-07-05 07:52:56.311554
3876	t	3875	3875	7750	2	\N	\N	2018-07-05 07:52:56.311554
3877	t	3876	3876	7752	1	\N	\N	2018-07-05 07:52:56.311554
3878	t	3877	3877	7754	2	\N	\N	2018-07-05 07:52:56.311554
3879	t	3878	3878	7756	1	\N	\N	2018-07-05 07:52:56.311554
3880	t	3879	3879	7758	2	\N	\N	2018-07-05 07:52:56.311554
3881	t	3880	3880	7760	1	\N	\N	2018-07-05 07:52:56.311554
3882	t	3881	3881	7762	2	\N	\N	2018-07-05 07:52:56.311554
3883	t	3882	3882	7764	1	\N	\N	2018-07-05 07:52:56.311554
3884	t	3883	3883	7766	2	\N	\N	2018-07-05 07:52:56.311554
3885	t	3884	3884	7768	1	\N	\N	2018-07-05 07:52:56.311554
3886	t	3885	3885	7770	2	\N	\N	2018-07-05 07:52:56.311554
3887	t	3886	3886	7772	1	\N	\N	2018-07-05 07:52:56.311554
3888	t	3887	3887	7774	2	\N	\N	2018-07-05 07:52:56.311554
3889	t	3888	3888	7776	1	\N	\N	2018-07-05 07:52:56.311554
3890	t	3889	3889	7778	2	\N	\N	2018-07-05 07:52:56.311554
3891	t	3890	3890	7780	1	\N	\N	2018-07-05 07:52:56.311554
3892	t	3891	3891	7782	2	\N	\N	2018-07-05 07:52:56.311554
3893	t	3892	3892	7784	1	\N	\N	2018-07-05 07:52:56.311554
3894	t	3893	3893	7786	2	\N	\N	2018-07-05 07:52:56.311554
3895	t	3894	3894	7788	1	\N	\N	2018-07-05 07:52:56.311554
3896	t	3895	3895	7790	2	\N	\N	2018-07-05 07:52:56.311554
3897	t	3896	3896	7792	1	\N	\N	2018-07-05 07:52:56.311554
3898	t	3897	3897	7794	2	\N	\N	2018-07-05 07:52:56.311554
3899	t	3898	3898	7796	1	\N	\N	2018-07-05 07:52:56.311554
3900	t	3899	3899	7798	2	\N	\N	2018-07-05 07:52:56.311554
3901	t	3900	3900	7800	1	\N	\N	2018-07-05 07:52:56.311554
3902	t	3901	3901	7802	2	\N	\N	2018-07-05 07:52:56.311554
3903	t	3902	3902	7804	1	\N	\N	2018-07-05 07:52:56.311554
3904	t	3903	3903	7806	2	\N	\N	2018-07-05 07:52:56.311554
3905	t	3904	3904	7808	1	\N	\N	2018-07-05 07:52:56.311554
3906	t	3905	3905	7810	2	\N	\N	2018-07-05 07:52:56.311554
3907	t	3906	3906	7812	1	\N	\N	2018-07-05 07:52:56.311554
3908	t	3907	3907	7814	2	\N	\N	2018-07-05 07:52:56.311554
3909	t	3908	3908	7816	1	\N	\N	2018-07-05 07:52:56.311554
3910	t	3909	3909	7818	2	\N	\N	2018-07-05 07:52:56.311554
3911	t	3910	3910	7820	1	\N	\N	2018-07-05 07:52:56.311554
3912	t	3911	3911	7822	2	\N	\N	2018-07-05 07:52:56.311554
3913	t	3912	3912	7824	1	\N	\N	2018-07-05 07:52:56.311554
3914	t	3913	3913	7826	2	\N	\N	2018-07-05 07:52:56.311554
3915	t	3914	3914	7828	1	\N	\N	2018-07-05 07:52:56.311554
3916	t	3915	3915	7830	2	\N	\N	2018-07-05 07:52:56.311554
3917	t	3916	3916	7832	1	\N	\N	2018-07-05 07:52:56.311554
3918	t	3917	3917	7834	2	\N	\N	2018-07-05 07:52:56.311554
3919	t	3918	3918	7836	1	\N	\N	2018-07-05 07:52:56.311554
3920	t	3919	3919	7838	2	\N	\N	2018-07-05 07:52:56.311554
3921	t	3920	3920	7840	1	\N	\N	2018-07-05 07:52:56.311554
3922	t	3921	3921	7842	2	\N	\N	2018-07-05 07:52:56.311554
3923	t	3922	3922	7844	1	\N	\N	2018-07-05 07:52:56.311554
3924	t	3923	3923	7846	2	\N	\N	2018-07-05 07:52:56.311554
3925	t	3924	3924	7848	1	\N	\N	2018-07-05 07:52:56.311554
3926	t	3925	3925	7850	2	\N	\N	2018-07-05 07:52:56.311554
3927	t	3926	3926	7852	1	\N	\N	2018-07-05 07:52:56.311554
3928	t	3927	3927	7854	2	\N	\N	2018-07-05 07:52:56.311554
3929	t	3928	3928	7856	1	\N	\N	2018-07-05 07:52:56.311554
3930	t	3929	3929	7858	2	\N	\N	2018-07-05 07:52:56.311554
3931	t	3930	3930	7860	1	\N	\N	2018-07-05 07:52:56.311554
3932	t	3931	3931	7862	2	\N	\N	2018-07-05 07:52:56.311554
3933	t	3932	3932	7864	1	\N	\N	2018-07-05 07:52:56.311554
3934	t	3933	3933	7866	2	\N	\N	2018-07-05 07:52:56.311554
3935	t	3934	3934	7868	1	\N	\N	2018-07-05 07:52:56.311554
3936	t	3935	3935	7870	2	\N	\N	2018-07-05 07:52:56.311554
3937	t	3936	3936	7872	1	\N	\N	2018-07-05 07:52:56.311554
3938	t	3937	3937	7874	2	\N	\N	2018-07-05 07:52:56.311554
3939	t	3938	3938	7876	1	\N	\N	2018-07-05 07:52:56.311554
3940	t	3939	3939	7878	2	\N	\N	2018-07-05 07:52:56.311554
3941	t	3940	3940	7880	1	\N	\N	2018-07-05 07:52:56.311554
3942	t	3941	3941	7882	2	\N	\N	2018-07-05 07:52:56.311554
3943	t	3942	3942	7884	1	\N	\N	2018-07-05 07:52:56.311554
3944	t	3943	3943	7886	2	\N	\N	2018-07-05 07:52:56.311554
3945	t	3944	3944	7888	1	\N	\N	2018-07-05 07:52:56.311554
3946	t	3945	3945	7890	2	\N	\N	2018-07-05 07:52:56.311554
3947	t	3946	3946	7892	1	\N	\N	2018-07-05 07:52:56.311554
3948	t	3947	3947	7894	2	\N	\N	2018-07-05 07:52:56.311554
3949	t	3948	3948	7896	1	\N	\N	2018-07-05 07:52:56.311554
3950	t	3949	3949	7898	2	\N	\N	2018-07-05 07:52:56.311554
3951	t	3950	3950	7900	1	\N	\N	2018-07-05 07:52:56.311554
3952	t	3951	3951	7902	2	\N	\N	2018-07-05 07:52:56.311554
3953	t	3952	3952	7904	1	\N	\N	2018-07-05 07:52:56.311554
3954	t	3953	3953	7906	2	\N	\N	2018-07-05 07:52:56.311554
3955	t	3954	3954	7908	1	\N	\N	2018-07-05 07:52:56.311554
3956	t	3955	3955	7910	2	\N	\N	2018-07-05 07:52:56.311554
3957	t	3956	3956	7912	1	\N	\N	2018-07-05 07:52:56.311554
3958	t	3957	3957	7914	2	\N	\N	2018-07-05 07:52:56.311554
3959	t	3958	3958	7916	1	\N	\N	2018-07-05 07:52:56.311554
3960	t	3959	3959	7918	2	\N	\N	2018-07-05 07:52:56.311554
3961	t	3960	3960	7920	1	\N	\N	2018-07-05 07:52:56.311554
3962	t	3961	3961	7922	2	\N	\N	2018-07-05 07:52:56.311554
3963	t	3962	3962	7924	1	\N	\N	2018-07-05 07:52:56.311554
3964	t	3963	3963	7926	2	\N	\N	2018-07-05 07:52:56.311554
3965	t	3964	3964	7928	1	\N	\N	2018-07-05 07:52:56.311554
3966	t	3965	3965	7930	2	\N	\N	2018-07-05 07:52:56.311554
3967	t	3966	3966	7932	1	\N	\N	2018-07-05 07:52:56.311554
3968	t	3967	3967	7934	2	\N	\N	2018-07-05 07:52:56.311554
3969	t	3968	3968	7936	1	\N	\N	2018-07-05 07:52:56.311554
3970	t	3969	3969	7938	2	\N	\N	2018-07-05 07:52:56.311554
3971	t	3970	3970	7940	1	\N	\N	2018-07-05 07:52:56.311554
3972	t	3971	3971	7942	2	\N	\N	2018-07-05 07:52:56.311554
3973	t	3972	3972	7944	1	\N	\N	2018-07-05 07:52:56.311554
3974	t	3973	3973	7946	2	\N	\N	2018-07-05 07:52:56.311554
3975	t	3974	3974	7948	1	\N	\N	2018-07-05 07:52:56.311554
3976	t	3975	3975	7950	2	\N	\N	2018-07-05 07:52:56.311554
3977	t	3976	3976	7952	1	\N	\N	2018-07-05 07:52:56.311554
3978	t	3977	3977	7954	2	\N	\N	2018-07-05 07:52:56.311554
3979	t	3978	3978	7956	1	\N	\N	2018-07-05 07:52:56.311554
3980	t	3979	3979	7958	2	\N	\N	2018-07-05 07:52:56.311554
3981	t	3980	3980	7960	1	\N	\N	2018-07-05 07:52:56.311554
3982	t	3981	3981	7962	2	\N	\N	2018-07-05 07:52:56.311554
3983	t	3982	3982	7964	1	\N	\N	2018-07-05 07:52:56.311554
3984	t	3983	3983	7966	2	\N	\N	2018-07-05 07:52:56.311554
3985	t	3984	3984	7968	1	\N	\N	2018-07-05 07:52:56.311554
3986	t	3985	3985	7970	2	\N	\N	2018-07-05 07:52:56.311554
3987	t	3986	3986	7972	1	\N	\N	2018-07-05 07:52:56.311554
3988	t	3987	3987	7974	2	\N	\N	2018-07-05 07:52:56.311554
3989	t	3988	3988	7976	1	\N	\N	2018-07-05 07:52:56.311554
3990	t	3989	3989	7978	2	\N	\N	2018-07-05 07:52:56.311554
3991	t	3990	3990	7980	1	\N	\N	2018-07-05 07:52:56.311554
3992	t	3991	3991	7982	2	\N	\N	2018-07-05 07:52:56.311554
3993	t	3992	3992	7984	1	\N	\N	2018-07-05 07:52:56.311554
3994	t	3993	3993	7986	2	\N	\N	2018-07-05 07:52:56.311554
3995	t	3994	3994	7988	1	\N	\N	2018-07-05 07:52:56.311554
3996	t	3995	3995	7990	2	\N	\N	2018-07-05 07:52:56.311554
3997	t	3996	3996	7992	1	\N	\N	2018-07-05 07:52:56.311554
3998	t	3997	3997	7994	2	\N	\N	2018-07-05 07:52:56.311554
3999	t	3998	3998	7996	1	\N	\N	2018-07-05 07:52:56.311554
4000	t	3999	3999	7998	2	\N	\N	2018-07-05 07:52:56.311554
4001	t	4000	4000	8000	1	\N	\N	2018-07-05 07:52:56.311554
4002	t	4001	4001	8002	2	\N	\N	2018-07-05 07:52:56.311554
4003	t	4002	4002	8004	1	\N	\N	2018-07-05 07:52:56.311554
4004	t	4003	4003	8006	2	\N	\N	2018-07-05 07:52:56.311554
4005	t	4004	4004	8008	1	\N	\N	2018-07-05 07:52:56.311554
4006	t	4005	4005	8010	2	\N	\N	2018-07-05 07:52:56.311554
4007	t	4006	4006	8012	1	\N	\N	2018-07-05 07:52:56.311554
4008	t	4007	4007	8014	2	\N	\N	2018-07-05 07:52:56.311554
4009	t	4008	4008	8016	1	\N	\N	2018-07-05 07:52:56.311554
4010	t	4009	4009	8018	2	\N	\N	2018-07-05 07:52:56.311554
4011	t	4010	4010	8020	1	\N	\N	2018-07-05 07:52:56.311554
4012	t	4011	4011	8022	2	\N	\N	2018-07-05 07:52:56.311554
4013	t	4012	4012	8024	1	\N	\N	2018-07-05 07:52:56.311554
4014	t	4013	4013	8026	2	\N	\N	2018-07-05 07:52:56.311554
4015	t	4014	4014	8028	1	\N	\N	2018-07-05 07:52:56.311554
4016	t	4015	4015	8030	2	\N	\N	2018-07-05 07:52:56.311554
4017	t	4016	4016	8032	1	\N	\N	2018-07-05 07:52:56.311554
4018	t	4017	4017	8034	2	\N	\N	2018-07-05 07:52:56.311554
4019	t	4018	4018	8036	1	\N	\N	2018-07-05 07:52:56.311554
4020	t	4019	4019	8038	2	\N	\N	2018-07-05 07:52:56.311554
4021	t	4020	4020	8040	1	\N	\N	2018-07-05 07:52:56.311554
4022	t	4021	4021	8042	2	\N	\N	2018-07-05 07:52:56.311554
4023	t	4022	4022	8044	1	\N	\N	2018-07-05 07:52:56.311554
4024	t	4023	4023	8046	2	\N	\N	2018-07-05 07:52:56.311554
4025	t	4024	4024	8048	1	\N	\N	2018-07-05 07:52:56.311554
4026	t	4025	4025	8050	2	\N	\N	2018-07-05 07:52:56.311554
4027	t	4026	4026	8052	1	\N	\N	2018-07-05 07:52:56.311554
4028	t	4027	4027	8054	2	\N	\N	2018-07-05 07:52:56.311554
4029	t	4028	4028	8056	1	\N	\N	2018-07-05 07:52:56.311554
4030	t	4029	4029	8058	2	\N	\N	2018-07-05 07:52:56.311554
4031	t	4030	4030	8060	1	\N	\N	2018-07-05 07:52:56.311554
4032	t	4031	4031	8062	2	\N	\N	2018-07-05 07:52:56.311554
4033	t	4032	4032	8064	1	\N	\N	2018-07-05 07:52:56.311554
4034	t	4033	4033	8066	2	\N	\N	2018-07-05 07:52:56.311554
4035	t	4034	4034	8068	1	\N	\N	2018-07-05 07:52:56.311554
4036	t	4035	4035	8070	2	\N	\N	2018-07-05 07:52:56.311554
4037	t	4036	4036	8072	1	\N	\N	2018-07-05 07:52:56.311554
4038	t	4037	4037	8074	2	\N	\N	2018-07-05 07:52:56.311554
4039	t	4038	4038	8076	1	\N	\N	2018-07-05 07:52:56.311554
4040	t	4039	4039	8078	2	\N	\N	2018-07-05 07:52:56.311554
4041	t	4040	4040	8080	1	\N	\N	2018-07-05 07:52:56.311554
4042	t	4041	4041	8082	2	\N	\N	2018-07-05 07:52:56.311554
4043	t	4042	4042	8084	1	\N	\N	2018-07-05 07:52:56.311554
4044	t	4043	4043	8086	2	\N	\N	2018-07-05 07:52:56.311554
4045	t	4044	4044	8088	1	\N	\N	2018-07-05 07:52:56.311554
4046	t	4045	4045	8090	2	\N	\N	2018-07-05 07:52:56.311554
4047	t	4046	4046	8092	1	\N	\N	2018-07-05 07:52:56.311554
4048	t	4047	4047	8094	2	\N	\N	2018-07-05 07:52:56.311554
4049	t	4048	4048	8096	1	\N	\N	2018-07-05 07:52:56.311554
4050	t	4049	4049	8098	2	\N	\N	2018-07-05 07:52:56.311554
4051	t	4050	4050	8100	1	\N	\N	2018-07-05 07:52:56.311554
4052	t	4051	4051	8102	2	\N	\N	2018-07-05 07:52:56.311554
4053	t	4052	4052	8104	1	\N	\N	2018-07-05 07:52:56.311554
4054	t	4053	4053	8106	2	\N	\N	2018-07-05 07:52:56.311554
4055	t	4054	4054	8108	1	\N	\N	2018-07-05 07:52:56.311554
4056	t	4055	4055	8110	2	\N	\N	2018-07-05 07:52:56.311554
4057	t	4056	4056	8112	1	\N	\N	2018-07-05 07:52:56.311554
4058	t	4057	4057	8114	2	\N	\N	2018-07-05 07:52:56.311554
4059	t	4058	4058	8116	1	\N	\N	2018-07-05 07:52:56.311554
4060	t	4059	4059	8118	2	\N	\N	2018-07-05 07:52:56.311554
4061	t	4060	4060	8120	1	\N	\N	2018-07-05 07:52:56.311554
4062	t	4061	4061	8122	2	\N	\N	2018-07-05 07:52:56.311554
4063	t	4062	4062	8124	1	\N	\N	2018-07-05 07:52:56.311554
4064	t	4063	4063	8126	2	\N	\N	2018-07-05 07:52:56.311554
4065	t	4064	4064	8128	1	\N	\N	2018-07-05 07:52:56.311554
4066	t	4065	4065	8130	2	\N	\N	2018-07-05 07:52:56.311554
4067	t	4066	4066	8132	1	\N	\N	2018-07-05 07:52:56.311554
4068	t	4067	4067	8134	2	\N	\N	2018-07-05 07:52:56.311554
4069	t	4068	4068	8136	1	\N	\N	2018-07-05 07:52:56.311554
4070	t	4069	4069	8138	2	\N	\N	2018-07-05 07:52:56.311554
4071	t	4070	4070	8140	1	\N	\N	2018-07-05 07:52:56.311554
4072	t	4071	4071	8142	2	\N	\N	2018-07-05 07:52:56.311554
4073	t	4072	4072	8144	1	\N	\N	2018-07-05 07:52:56.311554
4074	t	4073	4073	8146	2	\N	\N	2018-07-05 07:52:56.311554
4075	t	4074	4074	8148	1	\N	\N	2018-07-05 07:52:56.311554
4076	t	4075	4075	8150	2	\N	\N	2018-07-05 07:52:56.311554
4077	t	4076	4076	8152	1	\N	\N	2018-07-05 07:52:56.311554
4078	t	4077	4077	8154	2	\N	\N	2018-07-05 07:52:56.311554
4079	t	4078	4078	8156	1	\N	\N	2018-07-05 07:52:56.311554
4080	t	4079	4079	8158	2	\N	\N	2018-07-05 07:52:56.311554
4081	t	4080	4080	8160	1	\N	\N	2018-07-05 07:52:56.311554
4082	t	4081	4081	8162	2	\N	\N	2018-07-05 07:52:56.311554
4083	t	4082	4082	8164	1	\N	\N	2018-07-05 07:52:56.311554
4084	t	4083	4083	8166	2	\N	\N	2018-07-05 07:52:56.311554
4085	t	4084	4084	8168	1	\N	\N	2018-07-05 07:52:56.311554
4086	t	4085	4085	8170	2	\N	\N	2018-07-05 07:52:56.311554
4087	t	4086	4086	8172	1	\N	\N	2018-07-05 07:52:56.311554
4088	t	4087	4087	8174	2	\N	\N	2018-07-05 07:52:56.311554
4089	t	4088	4088	8176	1	\N	\N	2018-07-05 07:52:56.311554
4090	t	4089	4089	8178	2	\N	\N	2018-07-05 07:52:56.311554
4091	t	4090	4090	8180	1	\N	\N	2018-07-05 07:52:56.311554
4092	t	4091	4091	8182	2	\N	\N	2018-07-05 07:52:56.311554
4093	t	4092	4092	8184	1	\N	\N	2018-07-05 07:52:56.311554
4094	t	4093	4093	8186	2	\N	\N	2018-07-05 07:52:56.311554
4095	t	4094	4094	8188	1	\N	\N	2018-07-05 07:52:56.311554
4096	t	4095	4095	8190	2	\N	\N	2018-07-05 07:52:56.311554
4097	t	4096	4096	8192	1	\N	\N	2018-07-05 07:52:56.311554
4098	t	4097	4097	8194	2	\N	\N	2018-07-05 07:52:56.311554
4099	t	4098	4098	8196	1	\N	\N	2018-07-05 07:52:56.311554
4100	t	4099	4099	8198	2	\N	\N	2018-07-05 07:52:56.311554
4101	t	4100	4100	8200	1	\N	\N	2018-07-05 07:52:56.311554
4102	t	4101	4101	8202	2	\N	\N	2018-07-05 07:52:56.311554
4103	t	4102	4102	8204	1	\N	\N	2018-07-05 07:52:56.311554
4104	t	4103	4103	8206	2	\N	\N	2018-07-05 07:52:56.311554
4105	t	4104	4104	8208	1	\N	\N	2018-07-05 07:52:56.311554
4106	t	4105	4105	8210	2	\N	\N	2018-07-05 07:52:56.311554
4107	t	4106	4106	8212	1	\N	\N	2018-07-05 07:52:56.311554
4108	t	4107	4107	8214	2	\N	\N	2018-07-05 07:52:56.311554
4109	t	4108	4108	8216	1	\N	\N	2018-07-05 07:52:56.311554
4110	t	4109	4109	8218	2	\N	\N	2018-07-05 07:52:56.311554
4111	t	4110	4110	8220	1	\N	\N	2018-07-05 07:52:56.311554
4112	t	4111	4111	8222	2	\N	\N	2018-07-05 07:52:56.311554
4113	t	4112	4112	8224	1	\N	\N	2018-07-05 07:52:56.311554
4114	t	4113	4113	8226	2	\N	\N	2018-07-05 07:52:56.311554
4115	t	4114	4114	8228	1	\N	\N	2018-07-05 07:52:56.311554
4116	t	4115	4115	8230	2	\N	\N	2018-07-05 07:52:56.311554
4117	t	4116	4116	8232	1	\N	\N	2018-07-05 07:52:56.311554
4118	t	4117	4117	8234	2	\N	\N	2018-07-05 07:52:56.311554
4119	t	4118	4118	8236	1	\N	\N	2018-07-05 07:52:56.311554
4120	t	4119	4119	8238	2	\N	\N	2018-07-05 07:52:56.311554
4121	t	4120	4120	8240	1	\N	\N	2018-07-05 07:52:56.311554
4122	t	4121	4121	8242	2	\N	\N	2018-07-05 07:52:56.311554
4123	t	4122	4122	8244	1	\N	\N	2018-07-05 07:52:56.311554
4124	t	4123	4123	8246	2	\N	\N	2018-07-05 07:52:56.311554
4125	t	4124	4124	8248	1	\N	\N	2018-07-05 07:52:56.311554
4126	t	4125	4125	8250	2	\N	\N	2018-07-05 07:52:56.311554
4127	t	4126	4126	8252	1	\N	\N	2018-07-05 07:52:56.311554
4128	t	4127	4127	8254	2	\N	\N	2018-07-05 07:52:56.311554
4129	t	4128	4128	8256	1	\N	\N	2018-07-05 07:52:56.311554
4130	t	4129	4129	8258	2	\N	\N	2018-07-05 07:52:56.311554
4131	t	4130	4130	8260	1	\N	\N	2018-07-05 07:52:56.311554
4132	t	4131	4131	8262	2	\N	\N	2018-07-05 07:52:56.311554
4133	t	4132	4132	8264	1	\N	\N	2018-07-05 07:52:56.311554
4134	t	4133	4133	8266	2	\N	\N	2018-07-05 07:52:56.311554
4135	t	4134	4134	8268	1	\N	\N	2018-07-05 07:52:56.311554
4136	t	4135	4135	8270	2	\N	\N	2018-07-05 07:52:56.311554
4137	t	4136	4136	8272	1	\N	\N	2018-07-05 07:52:56.311554
4138	t	4137	4137	8274	2	\N	\N	2018-07-05 07:52:56.311554
4139	t	4138	4138	8276	1	\N	\N	2018-07-05 07:52:56.311554
4140	t	4139	4139	8278	2	\N	\N	2018-07-05 07:52:56.311554
4141	t	4140	4140	8280	1	\N	\N	2018-07-05 07:52:56.311554
4142	t	4141	4141	8282	2	\N	\N	2018-07-05 07:52:56.311554
4143	t	4142	4142	8284	1	\N	\N	2018-07-05 07:52:56.311554
4144	t	4143	4143	8286	2	\N	\N	2018-07-05 07:52:56.311554
4145	t	4144	4144	8288	1	\N	\N	2018-07-05 07:52:56.311554
4146	t	4145	4145	8290	2	\N	\N	2018-07-05 07:52:56.311554
4147	t	4146	4146	8292	1	\N	\N	2018-07-05 07:52:56.311554
4148	t	4147	4147	8294	2	\N	\N	2018-07-05 07:52:56.311554
4149	t	4148	4148	8296	1	\N	\N	2018-07-05 07:52:56.311554
4150	t	4149	4149	8298	2	\N	\N	2018-07-05 07:52:56.311554
4151	t	4150	4150	8300	1	\N	\N	2018-07-05 07:52:56.311554
4152	t	4151	4151	8302	2	\N	\N	2018-07-05 07:52:56.311554
4153	t	4152	4152	8304	1	\N	\N	2018-07-05 07:52:56.311554
4154	t	4153	4153	8306	2	\N	\N	2018-07-05 07:52:56.311554
4155	t	4154	4154	8308	1	\N	\N	2018-07-05 07:52:56.311554
4156	t	4155	4155	8310	2	\N	\N	2018-07-05 07:52:56.311554
4157	t	4156	4156	8312	1	\N	\N	2018-07-05 07:52:56.311554
4158	t	4157	4157	8314	2	\N	\N	2018-07-05 07:52:56.311554
4159	t	4158	4158	8316	1	\N	\N	2018-07-05 07:52:56.311554
4160	t	4159	4159	8318	2	\N	\N	2018-07-05 07:52:56.311554
4161	t	4160	4160	8320	1	\N	\N	2018-07-05 07:52:56.311554
4162	t	4161	4161	8322	2	\N	\N	2018-07-05 07:52:56.311554
4163	t	4162	4162	8324	1	\N	\N	2018-07-05 07:52:56.311554
4164	t	4163	4163	8326	2	\N	\N	2018-07-05 07:52:56.311554
4165	t	4164	4164	8328	1	\N	\N	2018-07-05 07:52:56.311554
4166	t	4165	4165	8330	2	\N	\N	2018-07-05 07:52:56.311554
4167	t	4166	4166	8332	1	\N	\N	2018-07-05 07:52:56.311554
4168	t	4167	4167	8334	2	\N	\N	2018-07-05 07:52:56.311554
4169	t	4168	4168	8336	1	\N	\N	2018-07-05 07:52:56.311554
4170	t	4169	4169	8338	2	\N	\N	2018-07-05 07:52:56.311554
4171	t	4170	4170	8340	1	\N	\N	2018-07-05 07:52:56.311554
4172	t	4171	4171	8342	2	\N	\N	2018-07-05 07:52:56.311554
4173	t	4172	4172	8344	1	\N	\N	2018-07-05 07:52:56.311554
4174	t	4173	4173	8346	2	\N	\N	2018-07-05 07:52:56.311554
4175	t	4174	4174	8348	1	\N	\N	2018-07-05 07:52:56.311554
4176	t	4175	4175	8350	2	\N	\N	2018-07-05 07:52:56.311554
4177	t	4176	4176	8352	1	\N	\N	2018-07-05 07:52:56.311554
4178	t	4177	4177	8354	2	\N	\N	2018-07-05 07:52:56.311554
4179	t	4178	4178	8356	1	\N	\N	2018-07-05 07:52:56.311554
4180	t	4179	4179	8358	2	\N	\N	2018-07-05 07:52:56.311554
4181	t	4180	4180	8360	1	\N	\N	2018-07-05 07:52:56.311554
4182	t	4181	4181	8362	2	\N	\N	2018-07-05 07:52:56.311554
4183	t	4182	4182	8364	1	\N	\N	2018-07-05 07:52:56.311554
4184	t	4183	4183	8366	2	\N	\N	2018-07-05 07:52:56.311554
4185	t	4184	4184	8368	1	\N	\N	2018-07-05 07:52:56.311554
4186	t	4185	4185	8370	2	\N	\N	2018-07-05 07:52:56.311554
4187	t	4186	4186	8372	1	\N	\N	2018-07-05 07:52:56.311554
4188	t	4187	4187	8374	2	\N	\N	2018-07-05 07:52:56.311554
4189	t	4188	4188	8376	1	\N	\N	2018-07-05 07:52:56.311554
4190	t	4189	4189	8378	2	\N	\N	2018-07-05 07:52:56.311554
4191	t	4190	4190	8380	1	\N	\N	2018-07-05 07:52:56.311554
4192	t	4191	4191	8382	2	\N	\N	2018-07-05 07:52:56.311554
4193	t	4192	4192	8384	1	\N	\N	2018-07-05 07:52:56.311554
4194	t	4193	4193	8386	2	\N	\N	2018-07-05 07:52:56.311554
4195	t	4194	4194	8388	1	\N	\N	2018-07-05 07:52:56.311554
4196	t	4195	4195	8390	2	\N	\N	2018-07-05 07:52:56.311554
4197	t	4196	4196	8392	1	\N	\N	2018-07-05 07:52:56.311554
4198	t	4197	4197	8394	2	\N	\N	2018-07-05 07:52:56.311554
4199	t	4198	4198	8396	1	\N	\N	2018-07-05 07:52:56.311554
4200	t	4199	4199	8398	2	\N	\N	2018-07-05 07:52:56.311554
4201	t	4200	4200	8400	1	\N	\N	2018-07-05 07:52:56.311554
4202	t	4201	4201	8402	2	\N	\N	2018-07-05 07:52:56.311554
4203	t	4202	4202	8404	1	\N	\N	2018-07-05 07:52:56.311554
4204	t	4203	4203	8406	2	\N	\N	2018-07-05 07:52:56.311554
4205	t	4204	4204	8408	1	\N	\N	2018-07-05 07:52:56.311554
4206	t	4205	4205	8410	2	\N	\N	2018-07-05 07:52:56.311554
4207	t	4206	4206	8412	1	\N	\N	2018-07-05 07:52:56.311554
4208	t	4207	4207	8414	2	\N	\N	2018-07-05 07:52:56.311554
4209	t	4208	4208	8416	1	\N	\N	2018-07-05 07:52:56.311554
4210	t	4209	4209	8418	2	\N	\N	2018-07-05 07:52:56.311554
4211	t	4210	4210	8420	1	\N	\N	2018-07-05 07:52:56.311554
4212	t	4211	4211	8422	2	\N	\N	2018-07-05 07:52:56.311554
4213	t	4212	4212	8424	1	\N	\N	2018-07-05 07:52:56.311554
4214	t	4213	4213	8426	2	\N	\N	2018-07-05 07:52:56.311554
4215	t	4214	4214	8428	1	\N	\N	2018-07-05 07:52:56.311554
4216	t	4215	4215	8430	2	\N	\N	2018-07-05 07:52:56.311554
4217	t	4216	4216	8432	1	\N	\N	2018-07-05 07:52:56.311554
4218	t	4217	4217	8434	2	\N	\N	2018-07-05 07:52:56.311554
4219	t	4218	4218	8436	1	\N	\N	2018-07-05 07:52:56.311554
4220	t	4219	4219	8438	2	\N	\N	2018-07-05 07:52:56.311554
4221	t	4220	4220	8440	1	\N	\N	2018-07-05 07:52:56.311554
4222	t	4221	4221	8442	2	\N	\N	2018-07-05 07:52:56.311554
4223	t	4222	4222	8444	1	\N	\N	2018-07-05 07:52:56.311554
4224	t	4223	4223	8446	2	\N	\N	2018-07-05 07:52:56.311554
4225	t	4224	4224	8448	1	\N	\N	2018-07-05 07:52:56.311554
4226	t	4225	4225	8450	2	\N	\N	2018-07-05 07:52:56.311554
4227	t	4226	4226	8452	1	\N	\N	2018-07-05 07:52:56.311554
4228	t	4227	4227	8454	2	\N	\N	2018-07-05 07:52:56.311554
4229	t	4228	4228	8456	1	\N	\N	2018-07-05 07:52:56.311554
4230	t	4229	4229	8458	2	\N	\N	2018-07-05 07:52:56.311554
4231	t	4230	4230	8460	1	\N	\N	2018-07-05 07:52:56.311554
4232	t	4231	4231	8462	2	\N	\N	2018-07-05 07:52:56.311554
4233	t	4232	4232	8464	1	\N	\N	2018-07-05 07:52:56.311554
4234	t	4233	4233	8466	2	\N	\N	2018-07-05 07:52:56.311554
4235	t	4234	4234	8468	1	\N	\N	2018-07-05 07:52:56.311554
4236	t	4235	4235	8470	2	\N	\N	2018-07-05 07:52:56.311554
4237	t	4236	4236	8472	1	\N	\N	2018-07-05 07:52:56.311554
4238	t	4237	4237	8474	2	\N	\N	2018-07-05 07:52:56.311554
4239	t	4238	4238	8476	1	\N	\N	2018-07-05 07:52:56.311554
4240	t	4239	4239	8478	2	\N	\N	2018-07-05 07:52:56.311554
4241	t	4240	4240	8480	1	\N	\N	2018-07-05 07:52:56.311554
4242	t	4241	4241	8482	2	\N	\N	2018-07-05 07:52:56.311554
4243	t	4242	4242	8484	1	\N	\N	2018-07-05 07:52:56.311554
4244	t	4243	4243	8486	2	\N	\N	2018-07-05 07:52:56.311554
4245	t	4244	4244	8488	1	\N	\N	2018-07-05 07:52:56.311554
4246	t	4245	4245	8490	2	\N	\N	2018-07-05 07:52:56.311554
4247	t	4246	4246	8492	1	\N	\N	2018-07-05 07:52:56.311554
4248	t	4247	4247	8494	2	\N	\N	2018-07-05 07:52:56.311554
4249	t	4248	4248	8496	1	\N	\N	2018-07-05 07:52:56.311554
4250	t	4249	4249	8498	2	\N	\N	2018-07-05 07:52:56.311554
4251	t	4250	4250	8500	1	\N	\N	2018-07-05 07:52:56.311554
4252	t	4251	4251	8502	2	\N	\N	2018-07-05 07:52:56.311554
4253	t	4252	4252	8504	1	\N	\N	2018-07-05 07:52:56.311554
4254	t	4253	4253	8506	2	\N	\N	2018-07-05 07:52:56.311554
4255	t	4254	4254	8508	1	\N	\N	2018-07-05 07:52:56.311554
4256	t	4255	4255	8510	2	\N	\N	2018-07-05 07:52:56.311554
4257	t	4256	4256	8512	1	\N	\N	2018-07-05 07:52:56.311554
4258	t	4257	4257	8514	2	\N	\N	2018-07-05 07:52:56.311554
4259	t	4258	4258	8516	1	\N	\N	2018-07-05 07:52:56.311554
4260	t	4259	4259	8518	2	\N	\N	2018-07-05 07:52:56.311554
4261	t	4260	4260	8520	1	\N	\N	2018-07-05 07:52:56.311554
4262	t	4261	4261	8522	2	\N	\N	2018-07-05 07:52:56.311554
4263	t	4262	4262	8524	1	\N	\N	2018-07-05 07:52:56.311554
4264	t	4263	4263	8526	2	\N	\N	2018-07-05 07:52:56.311554
4265	t	4264	4264	8528	1	\N	\N	2018-07-05 07:52:56.311554
4266	t	4265	4265	8530	2	\N	\N	2018-07-05 07:52:56.311554
4267	t	4266	4266	8532	1	\N	\N	2018-07-05 07:52:56.311554
4268	t	4267	4267	8534	2	\N	\N	2018-07-05 07:52:56.311554
4269	t	4268	4268	8536	1	\N	\N	2018-07-05 07:52:56.311554
4270	t	4269	4269	8538	2	\N	\N	2018-07-05 07:52:56.311554
4271	t	4270	4270	8540	1	\N	\N	2018-07-05 07:52:56.311554
4272	t	4271	4271	8542	2	\N	\N	2018-07-05 07:52:56.311554
4273	t	4272	4272	8544	1	\N	\N	2018-07-05 07:52:56.311554
4274	t	4273	4273	8546	2	\N	\N	2018-07-05 07:52:56.311554
4275	t	4274	4274	8548	1	\N	\N	2018-07-05 07:52:56.311554
4276	t	4275	4275	8550	2	\N	\N	2018-07-05 07:52:56.311554
4277	t	4276	4276	8552	1	\N	\N	2018-07-05 07:52:56.311554
4278	t	4277	4277	8554	2	\N	\N	2018-07-05 07:52:56.311554
4279	t	4278	4278	8556	1	\N	\N	2018-07-05 07:52:56.311554
4280	t	4279	4279	8558	2	\N	\N	2018-07-05 07:52:56.311554
4281	t	4280	4280	8560	1	\N	\N	2018-07-05 07:52:56.311554
4282	t	4281	4281	8562	2	\N	\N	2018-07-05 07:52:56.311554
4283	t	4282	4282	8564	1	\N	\N	2018-07-05 07:52:56.311554
4284	t	4283	4283	8566	2	\N	\N	2018-07-05 07:52:56.311554
4285	t	4284	4284	8568	1	\N	\N	2018-07-05 07:52:56.311554
4286	t	4285	4285	8570	2	\N	\N	2018-07-05 07:52:56.311554
4287	t	4286	4286	8572	1	\N	\N	2018-07-05 07:52:56.311554
4288	t	4287	4287	8574	2	\N	\N	2018-07-05 07:52:56.311554
4289	t	4288	4288	8576	1	\N	\N	2018-07-05 07:52:56.311554
4290	t	4289	4289	8578	2	\N	\N	2018-07-05 07:52:56.311554
4291	t	4290	4290	8580	1	\N	\N	2018-07-05 07:52:56.311554
4292	t	4291	4291	8582	2	\N	\N	2018-07-05 07:52:56.311554
4293	t	4292	4292	8584	1	\N	\N	2018-07-05 07:52:56.311554
4294	t	4293	4293	8586	2	\N	\N	2018-07-05 07:52:56.311554
4295	t	4294	4294	8588	1	\N	\N	2018-07-05 07:52:56.311554
4296	t	4295	4295	8590	2	\N	\N	2018-07-05 07:52:56.311554
4297	t	4296	4296	8592	1	\N	\N	2018-07-05 07:52:56.311554
4298	t	4297	4297	8594	2	\N	\N	2018-07-05 07:52:56.311554
4299	t	4298	4298	8596	1	\N	\N	2018-07-05 07:52:56.311554
4300	t	4299	4299	8598	2	\N	\N	2018-07-05 07:52:56.311554
4301	t	4300	4300	8600	1	\N	\N	2018-07-05 07:52:56.311554
4302	t	4301	4301	8602	2	\N	\N	2018-07-05 07:52:56.311554
4303	t	4302	4302	8604	1	\N	\N	2018-07-05 07:52:56.311554
4304	t	4303	4303	8606	2	\N	\N	2018-07-05 07:52:56.311554
4305	t	4304	4304	8608	1	\N	\N	2018-07-05 07:52:56.311554
4306	t	4305	4305	8610	2	\N	\N	2018-07-05 07:52:56.311554
4307	t	4306	4306	8612	1	\N	\N	2018-07-05 07:52:56.311554
4308	t	4307	4307	8614	2	\N	\N	2018-07-05 07:52:56.311554
4309	t	4308	4308	8616	1	\N	\N	2018-07-05 07:52:56.311554
4310	t	4309	4309	8618	2	\N	\N	2018-07-05 07:52:56.311554
4311	t	4310	4310	8620	1	\N	\N	2018-07-05 07:52:56.311554
4312	t	4311	4311	8622	2	\N	\N	2018-07-05 07:52:56.311554
4313	t	4312	4312	8624	1	\N	\N	2018-07-05 07:52:56.311554
4314	t	4313	4313	8626	2	\N	\N	2018-07-05 07:52:56.311554
4315	t	4314	4314	8628	1	\N	\N	2018-07-05 07:52:56.311554
4316	t	4315	4315	8630	2	\N	\N	2018-07-05 07:52:56.311554
4317	t	4316	4316	8632	1	\N	\N	2018-07-05 07:52:56.311554
4318	t	4317	4317	8634	2	\N	\N	2018-07-05 07:52:56.311554
4319	t	4318	4318	8636	1	\N	\N	2018-07-05 07:52:56.311554
4320	t	4319	4319	8638	2	\N	\N	2018-07-05 07:52:56.311554
4321	t	4320	4320	8640	1	\N	\N	2018-07-05 07:52:56.311554
4322	t	4321	4321	8642	2	\N	\N	2018-07-05 07:52:56.311554
4323	t	4322	4322	8644	1	\N	\N	2018-07-05 07:52:56.311554
4324	t	4323	4323	8646	2	\N	\N	2018-07-05 07:52:56.311554
4325	t	4324	4324	8648	1	\N	\N	2018-07-05 07:52:56.311554
4326	t	4325	4325	8650	2	\N	\N	2018-07-05 07:52:56.311554
4327	t	4326	4326	8652	1	\N	\N	2018-07-05 07:52:56.311554
4328	t	4327	4327	8654	2	\N	\N	2018-07-05 07:52:56.311554
4329	t	4328	4328	8656	1	\N	\N	2018-07-05 07:52:56.311554
4330	t	4329	4329	8658	2	\N	\N	2018-07-05 07:52:56.311554
4331	t	4330	4330	8660	1	\N	\N	2018-07-05 07:52:56.311554
4332	t	4331	4331	8662	2	\N	\N	2018-07-05 07:52:56.311554
4333	t	4332	4332	8664	1	\N	\N	2018-07-05 07:52:56.311554
4334	t	4333	4333	8666	2	\N	\N	2018-07-05 07:52:56.311554
4335	t	4334	4334	8668	1	\N	\N	2018-07-05 07:52:56.311554
4336	t	4335	4335	8670	2	\N	\N	2018-07-05 07:52:56.311554
4337	t	4336	4336	8672	1	\N	\N	2018-07-05 07:52:56.311554
4338	t	4337	4337	8674	2	\N	\N	2018-07-05 07:52:56.311554
4339	t	4338	4338	8676	1	\N	\N	2018-07-05 07:52:56.311554
4340	t	4339	4339	8678	2	\N	\N	2018-07-05 07:52:56.311554
4341	t	4340	4340	8680	1	\N	\N	2018-07-05 07:52:56.311554
4342	t	4341	4341	8682	2	\N	\N	2018-07-05 07:52:56.311554
4343	t	4342	4342	8684	1	\N	\N	2018-07-05 07:52:56.311554
4344	t	4343	4343	8686	2	\N	\N	2018-07-05 07:52:56.311554
4345	t	4344	4344	8688	1	\N	\N	2018-07-05 07:52:56.311554
4346	t	4345	4345	8690	2	\N	\N	2018-07-05 07:52:56.311554
4347	t	4346	4346	8692	1	\N	\N	2018-07-05 07:52:56.311554
4348	t	4347	4347	8694	2	\N	\N	2018-07-05 07:52:56.311554
4349	t	4348	4348	8696	1	\N	\N	2018-07-05 07:52:56.311554
4350	t	4349	4349	8698	2	\N	\N	2018-07-05 07:52:56.311554
4351	t	4350	4350	8700	1	\N	\N	2018-07-05 07:52:56.311554
4352	t	4351	4351	8702	2	\N	\N	2018-07-05 07:52:56.311554
4353	t	4352	4352	8704	1	\N	\N	2018-07-05 07:52:56.311554
4354	t	4353	4353	8706	2	\N	\N	2018-07-05 07:52:56.311554
4355	t	4354	4354	8708	1	\N	\N	2018-07-05 07:52:56.311554
4356	t	4355	4355	8710	2	\N	\N	2018-07-05 07:52:56.311554
4357	t	4356	4356	8712	1	\N	\N	2018-07-05 07:52:56.311554
4358	t	4357	4357	8714	2	\N	\N	2018-07-05 07:52:56.311554
4359	t	4358	4358	8716	1	\N	\N	2018-07-05 07:52:56.311554
4360	t	4359	4359	8718	2	\N	\N	2018-07-05 07:52:56.311554
4361	t	4360	4360	8720	1	\N	\N	2018-07-05 07:52:56.311554
4362	t	4361	4361	8722	2	\N	\N	2018-07-05 07:52:56.311554
4363	t	4362	4362	8724	1	\N	\N	2018-07-05 07:52:56.311554
4364	t	4363	4363	8726	2	\N	\N	2018-07-05 07:52:56.311554
4365	t	4364	4364	8728	1	\N	\N	2018-07-05 07:52:56.311554
4366	t	4365	4365	8730	2	\N	\N	2018-07-05 07:52:56.311554
4367	t	4366	4366	8732	1	\N	\N	2018-07-05 07:52:56.311554
4368	t	4367	4367	8734	2	\N	\N	2018-07-05 07:52:56.311554
4369	t	4368	4368	8736	1	\N	\N	2018-07-05 07:52:56.311554
4370	t	4369	4369	8738	2	\N	\N	2018-07-05 07:52:56.311554
4371	t	4370	4370	8740	1	\N	\N	2018-07-05 07:52:56.311554
4372	t	4371	4371	8742	2	\N	\N	2018-07-05 07:52:56.311554
4373	t	4372	4372	8744	1	\N	\N	2018-07-05 07:52:56.311554
4374	t	4373	4373	8746	2	\N	\N	2018-07-05 07:52:56.311554
4375	t	4374	4374	8748	1	\N	\N	2018-07-05 07:52:56.311554
4376	t	4375	4375	8750	2	\N	\N	2018-07-05 07:52:56.311554
4377	t	4376	4376	8752	1	\N	\N	2018-07-05 07:52:56.311554
4378	t	4377	4377	8754	2	\N	\N	2018-07-05 07:52:56.311554
4379	t	4378	4378	8756	1	\N	\N	2018-07-05 07:52:56.311554
4380	t	4379	4379	8758	2	\N	\N	2018-07-05 07:52:56.311554
4381	t	4380	4380	8760	1	\N	\N	2018-07-05 07:52:56.311554
4382	t	4381	4381	8762	2	\N	\N	2018-07-05 07:52:56.311554
4383	t	4382	4382	8764	1	\N	\N	2018-07-05 07:52:56.311554
4384	t	4383	4383	8766	2	\N	\N	2018-07-05 07:52:56.311554
4385	t	4384	4384	8768	1	\N	\N	2018-07-05 07:52:56.311554
4386	t	4385	4385	8770	2	\N	\N	2018-07-05 07:52:56.311554
4387	t	4386	4386	8772	1	\N	\N	2018-07-05 07:52:56.311554
4388	t	4387	4387	8774	2	\N	\N	2018-07-05 07:52:56.311554
4389	t	4388	4388	8776	1	\N	\N	2018-07-05 07:52:56.311554
4390	t	4389	4389	8778	2	\N	\N	2018-07-05 07:52:56.311554
4391	t	4390	4390	8780	1	\N	\N	2018-07-05 07:52:56.311554
4392	t	4391	4391	8782	2	\N	\N	2018-07-05 07:52:56.311554
4393	t	4392	4392	8784	1	\N	\N	2018-07-05 07:52:56.311554
4394	t	4393	4393	8786	2	\N	\N	2018-07-05 07:52:56.311554
4395	t	4394	4394	8788	1	\N	\N	2018-07-05 07:52:56.311554
4396	t	4395	4395	8790	2	\N	\N	2018-07-05 07:52:56.311554
4397	t	4396	4396	8792	1	\N	\N	2018-07-05 07:52:56.311554
4398	t	4397	4397	8794	2	\N	\N	2018-07-05 07:52:56.311554
4399	t	4398	4398	8796	1	\N	\N	2018-07-05 07:52:56.311554
4400	t	4399	4399	8798	2	\N	\N	2018-07-05 07:52:56.311554
4401	t	4400	4400	8800	1	\N	\N	2018-07-05 07:52:56.311554
4402	t	4401	4401	8802	2	\N	\N	2018-07-05 07:52:56.311554
4403	t	4402	4402	8804	1	\N	\N	2018-07-05 07:52:56.311554
4404	t	4403	4403	8806	2	\N	\N	2018-07-05 07:52:56.311554
4405	t	4404	4404	8808	1	\N	\N	2018-07-05 07:52:56.311554
4406	t	4405	4405	8810	2	\N	\N	2018-07-05 07:52:56.311554
4407	t	4406	4406	8812	1	\N	\N	2018-07-05 07:52:56.311554
4408	t	4407	4407	8814	2	\N	\N	2018-07-05 07:52:56.311554
4409	t	4408	4408	8816	1	\N	\N	2018-07-05 07:52:56.311554
4410	t	4409	4409	8818	2	\N	\N	2018-07-05 07:52:56.311554
4411	t	4410	4410	8820	1	\N	\N	2018-07-05 07:52:56.311554
4412	t	4411	4411	8822	2	\N	\N	2018-07-05 07:52:56.311554
4413	t	4412	4412	8824	1	\N	\N	2018-07-05 07:52:56.311554
4414	t	4413	4413	8826	2	\N	\N	2018-07-05 07:52:56.311554
4415	t	4414	4414	8828	1	\N	\N	2018-07-05 07:52:56.311554
4416	t	4415	4415	8830	2	\N	\N	2018-07-05 07:52:56.311554
4417	t	4416	4416	8832	1	\N	\N	2018-07-05 07:52:56.311554
4418	t	4417	4417	8834	2	\N	\N	2018-07-05 07:52:56.311554
4419	t	4418	4418	8836	1	\N	\N	2018-07-05 07:52:56.311554
4420	t	4419	4419	8838	2	\N	\N	2018-07-05 07:52:56.311554
4421	t	4420	4420	8840	1	\N	\N	2018-07-05 07:52:56.311554
4422	t	4421	4421	8842	2	\N	\N	2018-07-05 07:52:56.311554
4423	t	4422	4422	8844	1	\N	\N	2018-07-05 07:52:56.311554
4424	t	4423	4423	8846	2	\N	\N	2018-07-05 07:52:56.311554
4425	t	4424	4424	8848	1	\N	\N	2018-07-05 07:52:56.311554
4426	t	4425	4425	8850	2	\N	\N	2018-07-05 07:52:56.311554
4427	t	4426	4426	8852	1	\N	\N	2018-07-05 07:52:56.311554
4428	t	4427	4427	8854	2	\N	\N	2018-07-05 07:52:56.311554
4429	t	4428	4428	8856	1	\N	\N	2018-07-05 07:52:56.311554
4430	t	4429	4429	8858	2	\N	\N	2018-07-05 07:52:56.311554
4431	t	4430	4430	8860	1	\N	\N	2018-07-05 07:52:56.311554
4432	t	4431	4431	8862	2	\N	\N	2018-07-05 07:52:56.311554
4433	t	4432	4432	8864	1	\N	\N	2018-07-05 07:52:56.311554
4434	t	4433	4433	8866	2	\N	\N	2018-07-05 07:52:56.311554
4435	t	4434	4434	8868	1	\N	\N	2018-07-05 07:52:56.311554
4436	t	4435	4435	8870	2	\N	\N	2018-07-05 07:52:56.311554
4437	t	4436	4436	8872	1	\N	\N	2018-07-05 07:52:56.311554
4438	t	4437	4437	8874	2	\N	\N	2018-07-05 07:52:56.311554
4439	t	4438	4438	8876	1	\N	\N	2018-07-05 07:52:56.311554
4440	t	4439	4439	8878	2	\N	\N	2018-07-05 07:52:56.311554
4441	t	4440	4440	8880	1	\N	\N	2018-07-05 07:52:56.311554
4442	t	4441	4441	8882	2	\N	\N	2018-07-05 07:52:56.311554
4443	t	4442	4442	8884	1	\N	\N	2018-07-05 07:52:56.311554
4444	t	4443	4443	8886	2	\N	\N	2018-07-05 07:52:56.311554
4445	t	4444	4444	8888	1	\N	\N	2018-07-05 07:52:56.311554
4446	t	4445	4445	8890	2	\N	\N	2018-07-05 07:52:56.311554
4447	t	4446	4446	8892	1	\N	\N	2018-07-05 07:52:56.311554
4448	t	4447	4447	8894	2	\N	\N	2018-07-05 07:52:56.311554
4449	t	4448	4448	8896	1	\N	\N	2018-07-05 07:52:56.311554
4450	t	4449	4449	8898	2	\N	\N	2018-07-05 07:52:56.311554
4451	t	4450	4450	8900	1	\N	\N	2018-07-05 07:52:56.311554
4452	t	4451	4451	8902	2	\N	\N	2018-07-05 07:52:56.311554
4453	t	4452	4452	8904	1	\N	\N	2018-07-05 07:52:56.311554
4454	t	4453	4453	8906	2	\N	\N	2018-07-05 07:52:56.311554
4455	t	4454	4454	8908	1	\N	\N	2018-07-05 07:52:56.311554
4456	t	4455	4455	8910	2	\N	\N	2018-07-05 07:52:56.311554
4457	t	4456	4456	8912	1	\N	\N	2018-07-05 07:52:56.311554
4458	t	4457	4457	8914	2	\N	\N	2018-07-05 07:52:56.311554
4459	t	4458	4458	8916	1	\N	\N	2018-07-05 07:52:56.311554
4460	t	4459	4459	8918	2	\N	\N	2018-07-05 07:52:56.311554
4461	t	4460	4460	8920	1	\N	\N	2018-07-05 07:52:56.311554
4462	t	4461	4461	8922	2	\N	\N	2018-07-05 07:52:56.311554
4463	t	4462	4462	8924	1	\N	\N	2018-07-05 07:52:56.311554
4464	t	4463	4463	8926	2	\N	\N	2018-07-05 07:52:56.311554
4465	t	4464	4464	8928	1	\N	\N	2018-07-05 07:52:56.311554
4466	t	4465	4465	8930	2	\N	\N	2018-07-05 07:52:56.311554
4467	t	4466	4466	8932	1	\N	\N	2018-07-05 07:52:56.311554
4468	t	4467	4467	8934	2	\N	\N	2018-07-05 07:52:56.311554
4469	t	4468	4468	8936	1	\N	\N	2018-07-05 07:52:56.311554
4470	t	4469	4469	8938	2	\N	\N	2018-07-05 07:52:56.311554
4471	t	4470	4470	8940	1	\N	\N	2018-07-05 07:52:56.311554
4472	t	4471	4471	8942	2	\N	\N	2018-07-05 07:52:56.311554
4473	t	4472	4472	8944	1	\N	\N	2018-07-05 07:52:56.311554
4474	t	4473	4473	8946	2	\N	\N	2018-07-05 07:52:56.311554
4475	t	4474	4474	8948	1	\N	\N	2018-07-05 07:52:56.311554
4476	t	4475	4475	8950	2	\N	\N	2018-07-05 07:52:56.311554
4477	t	4476	4476	8952	1	\N	\N	2018-07-05 07:52:56.311554
4478	t	4477	4477	8954	2	\N	\N	2018-07-05 07:52:56.311554
4479	t	4478	4478	8956	1	\N	\N	2018-07-05 07:52:56.311554
4480	t	4479	4479	8958	2	\N	\N	2018-07-05 07:52:56.311554
4481	t	4480	4480	8960	1	\N	\N	2018-07-05 07:52:56.311554
4482	t	4481	4481	8962	2	\N	\N	2018-07-05 07:52:56.311554
4483	t	4482	4482	8964	1	\N	\N	2018-07-05 07:52:56.311554
4484	t	4483	4483	8966	2	\N	\N	2018-07-05 07:52:56.311554
4485	t	4484	4484	8968	1	\N	\N	2018-07-05 07:52:56.311554
4486	t	4485	4485	8970	2	\N	\N	2018-07-05 07:52:56.311554
4487	t	4486	4486	8972	1	\N	\N	2018-07-05 07:52:56.311554
4488	t	4487	4487	8974	2	\N	\N	2018-07-05 07:52:56.311554
4489	t	4488	4488	8976	1	\N	\N	2018-07-05 07:52:56.311554
4490	t	4489	4489	8978	2	\N	\N	2018-07-05 07:52:56.311554
4491	t	4490	4490	8980	1	\N	\N	2018-07-05 07:52:56.311554
4492	t	4491	4491	8982	2	\N	\N	2018-07-05 07:52:56.311554
4493	t	4492	4492	8984	1	\N	\N	2018-07-05 07:52:56.311554
4494	t	4493	4493	8986	2	\N	\N	2018-07-05 07:52:56.311554
4495	t	4494	4494	8988	1	\N	\N	2018-07-05 07:52:56.311554
4496	t	4495	4495	8990	2	\N	\N	2018-07-05 07:52:56.311554
4497	t	4496	4496	8992	1	\N	\N	2018-07-05 07:52:56.311554
4498	t	4497	4497	8994	2	\N	\N	2018-07-05 07:52:56.311554
4499	t	4498	4498	8996	1	\N	\N	2018-07-05 07:52:56.311554
4500	t	4499	4499	8998	2	\N	\N	2018-07-05 07:52:56.311554
4501	t	4500	4500	9000	1	\N	\N	2018-07-05 07:52:56.311554
4502	t	4501	4501	9002	2	\N	\N	2018-07-05 07:52:56.311554
4503	t	4502	4502	9004	1	\N	\N	2018-07-05 07:52:56.311554
4504	t	4503	4503	9006	2	\N	\N	2018-07-05 07:52:56.311554
4505	t	4504	4504	9008	1	\N	\N	2018-07-05 07:52:56.311554
4506	t	4505	4505	9010	2	\N	\N	2018-07-05 07:52:56.311554
4507	t	4506	4506	9012	1	\N	\N	2018-07-05 07:52:56.311554
4508	t	4507	4507	9014	2	\N	\N	2018-07-05 07:52:56.311554
4509	t	4508	4508	9016	1	\N	\N	2018-07-05 07:52:56.311554
4510	t	4509	4509	9018	2	\N	\N	2018-07-05 07:52:56.311554
4511	t	4510	4510	9020	1	\N	\N	2018-07-05 07:52:56.311554
4512	t	4511	4511	9022	2	\N	\N	2018-07-05 07:52:56.311554
4513	t	4512	4512	9024	1	\N	\N	2018-07-05 07:52:56.311554
4514	t	4513	4513	9026	2	\N	\N	2018-07-05 07:52:56.311554
4515	t	4514	4514	9028	1	\N	\N	2018-07-05 07:52:56.311554
4516	t	4515	4515	9030	2	\N	\N	2018-07-05 07:52:56.311554
4517	t	4516	4516	9032	1	\N	\N	2018-07-05 07:52:56.311554
4518	t	4517	4517	9034	2	\N	\N	2018-07-05 07:52:56.311554
4519	t	4518	4518	9036	1	\N	\N	2018-07-05 07:52:56.311554
4520	t	4519	4519	9038	2	\N	\N	2018-07-05 07:52:56.311554
4521	t	4520	4520	9040	1	\N	\N	2018-07-05 07:52:56.311554
4522	t	4521	4521	9042	2	\N	\N	2018-07-05 07:52:56.311554
4523	t	4522	4522	9044	1	\N	\N	2018-07-05 07:52:56.311554
4524	t	4523	4523	9046	2	\N	\N	2018-07-05 07:52:56.311554
4525	t	4524	4524	9048	1	\N	\N	2018-07-05 07:52:56.311554
4526	t	4525	4525	9050	2	\N	\N	2018-07-05 07:52:56.311554
4527	t	4526	4526	9052	1	\N	\N	2018-07-05 07:52:56.311554
4528	t	4527	4527	9054	2	\N	\N	2018-07-05 07:52:56.311554
4529	t	4528	4528	9056	1	\N	\N	2018-07-05 07:52:56.311554
4530	t	4529	4529	9058	2	\N	\N	2018-07-05 07:52:56.311554
4531	t	4530	4530	9060	1	\N	\N	2018-07-05 07:52:56.311554
4532	t	4531	4531	9062	2	\N	\N	2018-07-05 07:52:56.311554
4533	t	4532	4532	9064	1	\N	\N	2018-07-05 07:52:56.311554
4534	t	4533	4533	9066	2	\N	\N	2018-07-05 07:52:56.311554
4535	t	4534	4534	9068	1	\N	\N	2018-07-05 07:52:56.311554
4536	t	4535	4535	9070	2	\N	\N	2018-07-05 07:52:56.311554
4537	t	4536	4536	9072	1	\N	\N	2018-07-05 07:52:56.311554
4538	t	4537	4537	9074	2	\N	\N	2018-07-05 07:52:56.311554
4539	t	4538	4538	9076	1	\N	\N	2018-07-05 07:52:56.311554
4540	t	4539	4539	9078	2	\N	\N	2018-07-05 07:52:56.311554
4541	t	4540	4540	9080	1	\N	\N	2018-07-05 07:52:56.311554
4542	t	4541	4541	9082	2	\N	\N	2018-07-05 07:52:56.311554
4543	t	4542	4542	9084	1	\N	\N	2018-07-05 07:52:56.311554
4544	t	4543	4543	9086	2	\N	\N	2018-07-05 07:52:56.311554
4545	t	4544	4544	9088	1	\N	\N	2018-07-05 07:52:56.311554
4546	t	4545	4545	9090	2	\N	\N	2018-07-05 07:52:56.311554
4547	t	4546	4546	9092	1	\N	\N	2018-07-05 07:52:56.311554
4548	t	4547	4547	9094	2	\N	\N	2018-07-05 07:52:56.311554
4549	t	4548	4548	9096	1	\N	\N	2018-07-05 07:52:56.311554
4550	t	4549	4549	9098	2	\N	\N	2018-07-05 07:52:56.311554
4551	t	4550	4550	9100	1	\N	\N	2018-07-05 07:52:56.311554
4552	t	4551	4551	9102	2	\N	\N	2018-07-05 07:52:56.311554
4553	t	4552	4552	9104	1	\N	\N	2018-07-05 07:52:56.311554
4554	t	4553	4553	9106	2	\N	\N	2018-07-05 07:52:56.311554
4555	t	4554	4554	9108	1	\N	\N	2018-07-05 07:52:56.311554
4556	t	4555	4555	9110	2	\N	\N	2018-07-05 07:52:56.311554
4557	t	4556	4556	9112	1	\N	\N	2018-07-05 07:52:56.311554
4558	t	4557	4557	9114	2	\N	\N	2018-07-05 07:52:56.311554
4559	t	4558	4558	9116	1	\N	\N	2018-07-05 07:52:56.311554
4560	t	4559	4559	9118	2	\N	\N	2018-07-05 07:52:56.311554
4561	t	4560	4560	9120	1	\N	\N	2018-07-05 07:52:56.311554
4562	t	4561	4561	9122	2	\N	\N	2018-07-05 07:52:56.311554
4563	t	4562	4562	9124	1	\N	\N	2018-07-05 07:52:56.311554
4564	t	4563	4563	9126	2	\N	\N	2018-07-05 07:52:56.311554
4565	t	4564	4564	9128	1	\N	\N	2018-07-05 07:52:56.311554
4566	t	4565	4565	9130	2	\N	\N	2018-07-05 07:52:56.311554
4567	t	4566	4566	9132	1	\N	\N	2018-07-05 07:52:56.311554
4568	t	4567	4567	9134	2	\N	\N	2018-07-05 07:52:56.311554
4569	t	4568	4568	9136	1	\N	\N	2018-07-05 07:52:56.311554
4570	t	4569	4569	9138	2	\N	\N	2018-07-05 07:52:56.311554
4571	t	4570	4570	9140	1	\N	\N	2018-07-05 07:52:56.311554
4572	t	4571	4571	9142	2	\N	\N	2018-07-05 07:52:56.311554
4573	t	4572	4572	9144	1	\N	\N	2018-07-05 07:52:56.311554
4574	t	4573	4573	9146	2	\N	\N	2018-07-05 07:52:56.311554
4575	t	4574	4574	9148	1	\N	\N	2018-07-05 07:52:56.311554
4576	t	4575	4575	9150	2	\N	\N	2018-07-05 07:52:56.311554
4577	t	4576	4576	9152	1	\N	\N	2018-07-05 07:52:56.311554
4578	t	4577	4577	9154	2	\N	\N	2018-07-05 07:52:56.311554
4579	t	4578	4578	9156	1	\N	\N	2018-07-05 07:52:56.311554
4580	t	4579	4579	9158	2	\N	\N	2018-07-05 07:52:56.311554
4581	t	4580	4580	9160	1	\N	\N	2018-07-05 07:52:56.311554
4582	t	4581	4581	9162	2	\N	\N	2018-07-05 07:52:56.311554
4583	t	4582	4582	9164	1	\N	\N	2018-07-05 07:52:56.311554
4584	t	4583	4583	9166	2	\N	\N	2018-07-05 07:52:56.311554
4585	t	4584	4584	9168	1	\N	\N	2018-07-05 07:52:56.311554
4586	t	4585	4585	9170	2	\N	\N	2018-07-05 07:52:56.311554
4587	t	4586	4586	9172	1	\N	\N	2018-07-05 07:52:56.311554
4588	t	4587	4587	9174	2	\N	\N	2018-07-05 07:52:56.311554
4589	t	4588	4588	9176	1	\N	\N	2018-07-05 07:52:56.311554
4590	t	4589	4589	9178	2	\N	\N	2018-07-05 07:52:56.311554
4591	t	4590	4590	9180	1	\N	\N	2018-07-05 07:52:56.311554
4592	t	4591	4591	9182	2	\N	\N	2018-07-05 07:52:56.311554
4593	t	4592	4592	9184	1	\N	\N	2018-07-05 07:52:56.311554
4594	t	4593	4593	9186	2	\N	\N	2018-07-05 07:52:56.311554
4595	t	4594	4594	9188	1	\N	\N	2018-07-05 07:52:56.311554
4596	t	4595	4595	9190	2	\N	\N	2018-07-05 07:52:56.311554
4597	t	4596	4596	9192	1	\N	\N	2018-07-05 07:52:56.311554
4598	t	4597	4597	9194	2	\N	\N	2018-07-05 07:52:56.311554
4599	t	4598	4598	9196	1	\N	\N	2018-07-05 07:52:56.311554
4600	t	4599	4599	9198	2	\N	\N	2018-07-05 07:52:56.311554
4601	t	4600	4600	9200	1	\N	\N	2018-07-05 07:52:56.311554
4602	t	4601	4601	9202	2	\N	\N	2018-07-05 07:52:56.311554
4603	t	4602	4602	9204	1	\N	\N	2018-07-05 07:52:56.311554
4604	t	4603	4603	9206	2	\N	\N	2018-07-05 07:52:56.311554
4605	t	4604	4604	9208	1	\N	\N	2018-07-05 07:52:56.311554
4606	t	4605	4605	9210	2	\N	\N	2018-07-05 07:52:56.311554
4607	t	4606	4606	9212	1	\N	\N	2018-07-05 07:52:56.311554
4608	t	4607	4607	9214	2	\N	\N	2018-07-05 07:52:56.311554
4609	t	4608	4608	9216	1	\N	\N	2018-07-05 07:52:56.311554
4610	t	4609	4609	9218	2	\N	\N	2018-07-05 07:52:56.311554
4611	t	4610	4610	9220	1	\N	\N	2018-07-05 07:52:56.311554
4612	t	4611	4611	9222	2	\N	\N	2018-07-05 07:52:56.311554
4613	t	4612	4612	9224	1	\N	\N	2018-07-05 07:52:56.311554
4614	t	4613	4613	9226	2	\N	\N	2018-07-05 07:52:56.311554
4615	t	4614	4614	9228	1	\N	\N	2018-07-05 07:52:56.311554
4616	t	4615	4615	9230	2	\N	\N	2018-07-05 07:52:56.311554
4617	t	4616	4616	9232	1	\N	\N	2018-07-05 07:52:56.311554
4618	t	4617	4617	9234	2	\N	\N	2018-07-05 07:52:56.311554
4619	t	4618	4618	9236	1	\N	\N	2018-07-05 07:52:56.311554
4620	t	4619	4619	9238	2	\N	\N	2018-07-05 07:52:56.311554
4621	t	4620	4620	9240	1	\N	\N	2018-07-05 07:52:56.311554
4622	t	4621	4621	9242	2	\N	\N	2018-07-05 07:52:56.311554
4623	t	4622	4622	9244	1	\N	\N	2018-07-05 07:52:56.311554
4624	t	4623	4623	9246	2	\N	\N	2018-07-05 07:52:56.311554
4625	t	4624	4624	9248	1	\N	\N	2018-07-05 07:52:56.311554
4626	t	4625	4625	9250	2	\N	\N	2018-07-05 07:52:56.311554
4627	t	4626	4626	9252	1	\N	\N	2018-07-05 07:52:56.311554
4628	t	4627	4627	9254	2	\N	\N	2018-07-05 07:52:56.311554
4629	t	4628	4628	9256	1	\N	\N	2018-07-05 07:52:56.311554
4630	t	4629	4629	9258	2	\N	\N	2018-07-05 07:52:56.311554
4631	t	4630	4630	9260	1	\N	\N	2018-07-05 07:52:56.311554
4632	t	4631	4631	9262	2	\N	\N	2018-07-05 07:52:56.311554
4633	t	4632	4632	9264	1	\N	\N	2018-07-05 07:52:56.311554
4634	t	4633	4633	9266	2	\N	\N	2018-07-05 07:52:56.311554
4635	t	4634	4634	9268	1	\N	\N	2018-07-05 07:52:56.311554
4636	t	4635	4635	9270	2	\N	\N	2018-07-05 07:52:56.311554
4637	t	4636	4636	9272	1	\N	\N	2018-07-05 07:52:56.311554
4638	t	4637	4637	9274	2	\N	\N	2018-07-05 07:52:56.311554
4639	t	4638	4638	9276	1	\N	\N	2018-07-05 07:52:56.311554
4640	t	4639	4639	9278	2	\N	\N	2018-07-05 07:52:56.311554
4641	t	4640	4640	9280	1	\N	\N	2018-07-05 07:52:56.311554
4642	t	4641	4641	9282	2	\N	\N	2018-07-05 07:52:56.311554
4643	t	4642	4642	9284	1	\N	\N	2018-07-05 07:52:56.311554
4644	t	4643	4643	9286	2	\N	\N	2018-07-05 07:52:56.311554
4645	t	4644	4644	9288	1	\N	\N	2018-07-05 07:52:56.311554
4646	t	4645	4645	9290	2	\N	\N	2018-07-05 07:52:56.311554
4647	t	4646	4646	9292	1	\N	\N	2018-07-05 07:52:56.311554
4648	t	4647	4647	9294	2	\N	\N	2018-07-05 07:52:56.311554
4649	t	4648	4648	9296	1	\N	\N	2018-07-05 07:52:56.311554
4650	t	4649	4649	9298	2	\N	\N	2018-07-05 07:52:56.311554
4651	t	4650	4650	9300	1	\N	\N	2018-07-05 07:52:56.311554
4652	t	4651	4651	9302	2	\N	\N	2018-07-05 07:52:56.311554
4653	t	4652	4652	9304	1	\N	\N	2018-07-05 07:52:56.311554
4654	t	4653	4653	9306	2	\N	\N	2018-07-05 07:52:56.311554
4655	t	4654	4654	9308	1	\N	\N	2018-07-05 07:52:56.311554
4656	t	4655	4655	9310	2	\N	\N	2018-07-05 07:52:56.311554
4657	t	4656	4656	9312	1	\N	\N	2018-07-05 07:52:56.311554
4658	t	4657	4657	9314	2	\N	\N	2018-07-05 07:52:56.311554
4659	t	4658	4658	9316	1	\N	\N	2018-07-05 07:52:56.311554
4660	t	4659	4659	9318	2	\N	\N	2018-07-05 07:52:56.311554
4661	t	4660	4660	9320	1	\N	\N	2018-07-05 07:52:56.311554
4662	t	4661	4661	9322	2	\N	\N	2018-07-05 07:52:56.311554
4663	t	4662	4662	9324	1	\N	\N	2018-07-05 07:52:56.311554
4664	t	4663	4663	9326	2	\N	\N	2018-07-05 07:52:56.311554
4665	t	4664	4664	9328	1	\N	\N	2018-07-05 07:52:56.311554
4666	t	4665	4665	9330	2	\N	\N	2018-07-05 07:52:56.311554
4667	t	4666	4666	9332	1	\N	\N	2018-07-05 07:52:56.311554
4668	t	4667	4667	9334	2	\N	\N	2018-07-05 07:52:56.311554
4669	t	4668	4668	9336	1	\N	\N	2018-07-05 07:52:56.311554
4670	t	4669	4669	9338	2	\N	\N	2018-07-05 07:52:56.311554
4671	t	4670	4670	9340	1	\N	\N	2018-07-05 07:52:56.311554
4672	t	4671	4671	9342	2	\N	\N	2018-07-05 07:52:56.311554
4673	t	4672	4672	9344	1	\N	\N	2018-07-05 07:52:56.311554
4674	t	4673	4673	9346	2	\N	\N	2018-07-05 07:52:56.311554
4675	t	4674	4674	9348	1	\N	\N	2018-07-05 07:52:56.311554
4676	t	4675	4675	9350	2	\N	\N	2018-07-05 07:52:56.311554
4677	t	4676	4676	9352	1	\N	\N	2018-07-05 07:52:56.311554
4678	t	4677	4677	9354	2	\N	\N	2018-07-05 07:52:56.311554
4679	t	4678	4678	9356	1	\N	\N	2018-07-05 07:52:56.311554
4680	t	4679	4679	9358	2	\N	\N	2018-07-05 07:52:56.311554
4681	t	4680	4680	9360	1	\N	\N	2018-07-05 07:52:56.311554
4682	t	4681	4681	9362	2	\N	\N	2018-07-05 07:52:56.311554
4683	t	4682	4682	9364	1	\N	\N	2018-07-05 07:52:56.311554
4684	t	4683	4683	9366	2	\N	\N	2018-07-05 07:52:56.311554
4685	t	4684	4684	9368	1	\N	\N	2018-07-05 07:52:56.311554
4686	t	4685	4685	9370	2	\N	\N	2018-07-05 07:52:56.311554
4687	t	4686	4686	9372	1	\N	\N	2018-07-05 07:52:56.311554
4688	t	4687	4687	9374	2	\N	\N	2018-07-05 07:52:56.311554
4689	t	4688	4688	9376	1	\N	\N	2018-07-05 07:52:56.311554
4690	t	4689	4689	9378	2	\N	\N	2018-07-05 07:52:56.311554
4691	t	4690	4690	9380	1	\N	\N	2018-07-05 07:52:56.311554
4692	t	4691	4691	9382	2	\N	\N	2018-07-05 07:52:56.311554
4693	t	4692	4692	9384	1	\N	\N	2018-07-05 07:52:56.311554
4694	t	4693	4693	9386	2	\N	\N	2018-07-05 07:52:56.311554
4695	t	4694	4694	9388	1	\N	\N	2018-07-05 07:52:56.311554
4696	t	4695	4695	9390	2	\N	\N	2018-07-05 07:52:56.311554
4697	t	4696	4696	9392	1	\N	\N	2018-07-05 07:52:56.311554
4698	t	4697	4697	9394	2	\N	\N	2018-07-05 07:52:56.311554
4699	t	4698	4698	9396	1	\N	\N	2018-07-05 07:52:56.311554
4700	t	4699	4699	9398	2	\N	\N	2018-07-05 07:52:56.311554
4701	t	4700	4700	9400	1	\N	\N	2018-07-05 07:52:56.311554
4702	t	4701	4701	9402	2	\N	\N	2018-07-05 07:52:56.311554
4703	t	4702	4702	9404	1	\N	\N	2018-07-05 07:52:56.311554
4704	t	4703	4703	9406	2	\N	\N	2018-07-05 07:52:56.311554
4705	t	4704	4704	9408	1	\N	\N	2018-07-05 07:52:56.311554
4706	t	4705	4705	9410	2	\N	\N	2018-07-05 07:52:56.311554
4707	t	4706	4706	9412	1	\N	\N	2018-07-05 07:52:56.311554
4708	t	4707	4707	9414	2	\N	\N	2018-07-05 07:52:56.311554
4709	t	4708	4708	9416	1	\N	\N	2018-07-05 07:52:56.311554
4710	t	4709	4709	9418	2	\N	\N	2018-07-05 07:52:56.311554
4711	t	4710	4710	9420	1	\N	\N	2018-07-05 07:52:56.311554
4712	t	4711	4711	9422	2	\N	\N	2018-07-05 07:52:56.311554
4713	t	4712	4712	9424	1	\N	\N	2018-07-05 07:52:56.311554
4714	t	4713	4713	9426	2	\N	\N	2018-07-05 07:52:56.311554
4715	t	4714	4714	9428	1	\N	\N	2018-07-05 07:52:56.311554
4716	t	4715	4715	9430	2	\N	\N	2018-07-05 07:52:56.311554
4717	t	4716	4716	9432	1	\N	\N	2018-07-05 07:52:56.311554
4718	t	4717	4717	9434	2	\N	\N	2018-07-05 07:52:56.311554
4719	t	4718	4718	9436	1	\N	\N	2018-07-05 07:52:56.311554
4720	t	4719	4719	9438	2	\N	\N	2018-07-05 07:52:56.311554
4721	t	4720	4720	9440	1	\N	\N	2018-07-05 07:52:56.311554
4722	t	4721	4721	9442	2	\N	\N	2018-07-05 07:52:56.311554
4723	t	4722	4722	9444	1	\N	\N	2018-07-05 07:52:56.311554
4724	t	4723	4723	9446	2	\N	\N	2018-07-05 07:52:56.311554
4725	t	4724	4724	9448	1	\N	\N	2018-07-05 07:52:56.311554
4726	t	4725	4725	9450	2	\N	\N	2018-07-05 07:52:56.311554
4727	t	4726	4726	9452	1	\N	\N	2018-07-05 07:52:56.311554
4728	t	4727	4727	9454	2	\N	\N	2018-07-05 07:52:56.311554
4729	t	4728	4728	9456	1	\N	\N	2018-07-05 07:52:56.311554
4730	t	4729	4729	9458	2	\N	\N	2018-07-05 07:52:56.311554
4731	t	4730	4730	9460	1	\N	\N	2018-07-05 07:52:56.311554
4732	t	4731	4731	9462	2	\N	\N	2018-07-05 07:52:56.311554
4733	t	4732	4732	9464	1	\N	\N	2018-07-05 07:52:56.311554
4734	t	4733	4733	9466	2	\N	\N	2018-07-05 07:52:56.311554
4735	t	4734	4734	9468	1	\N	\N	2018-07-05 07:52:56.311554
4736	t	4735	4735	9470	2	\N	\N	2018-07-05 07:52:56.311554
4737	t	4736	4736	9472	1	\N	\N	2018-07-05 07:52:56.311554
4738	t	4737	4737	9474	2	\N	\N	2018-07-05 07:52:56.311554
4739	t	4738	4738	9476	1	\N	\N	2018-07-05 07:52:56.311554
4740	t	4739	4739	9478	2	\N	\N	2018-07-05 07:52:56.311554
4741	t	4740	4740	9480	1	\N	\N	2018-07-05 07:52:56.311554
4742	t	4741	4741	9482	2	\N	\N	2018-07-05 07:52:56.311554
4743	t	4742	4742	9484	1	\N	\N	2018-07-05 07:52:56.311554
4744	t	4743	4743	9486	2	\N	\N	2018-07-05 07:52:56.311554
4745	t	4744	4744	9488	1	\N	\N	2018-07-05 07:52:56.311554
4746	t	4745	4745	9490	2	\N	\N	2018-07-05 07:52:56.311554
4747	t	4746	4746	9492	1	\N	\N	2018-07-05 07:52:56.311554
4748	t	4747	4747	9494	2	\N	\N	2018-07-05 07:52:56.311554
4749	t	4748	4748	9496	1	\N	\N	2018-07-05 07:52:56.311554
4750	t	4749	4749	9498	2	\N	\N	2018-07-05 07:52:56.311554
4751	t	4750	4750	9500	1	\N	\N	2018-07-05 07:52:56.311554
4752	t	4751	4751	9502	2	\N	\N	2018-07-05 07:52:56.311554
4753	t	4752	4752	9504	1	\N	\N	2018-07-05 07:52:56.311554
4754	t	4753	4753	9506	2	\N	\N	2018-07-05 07:52:56.311554
4755	t	4754	4754	9508	1	\N	\N	2018-07-05 07:52:56.311554
4756	t	4755	4755	9510	2	\N	\N	2018-07-05 07:52:56.311554
4757	t	4756	4756	9512	1	\N	\N	2018-07-05 07:52:56.311554
4758	t	4757	4757	9514	2	\N	\N	2018-07-05 07:52:56.311554
4759	t	4758	4758	9516	1	\N	\N	2018-07-05 07:52:56.311554
4760	t	4759	4759	9518	2	\N	\N	2018-07-05 07:52:56.311554
4761	t	4760	4760	9520	1	\N	\N	2018-07-05 07:52:56.311554
4762	t	4761	4761	9522	2	\N	\N	2018-07-05 07:52:56.311554
4763	t	4762	4762	9524	1	\N	\N	2018-07-05 07:52:56.311554
4764	t	4763	4763	9526	2	\N	\N	2018-07-05 07:52:56.311554
4765	t	4764	4764	9528	1	\N	\N	2018-07-05 07:52:56.311554
4766	t	4765	4765	9530	2	\N	\N	2018-07-05 07:52:56.311554
4767	t	4766	4766	9532	1	\N	\N	2018-07-05 07:52:56.311554
4768	t	4767	4767	9534	2	\N	\N	2018-07-05 07:52:56.311554
4769	t	4768	4768	9536	1	\N	\N	2018-07-05 07:52:56.311554
4770	t	4769	4769	9538	2	\N	\N	2018-07-05 07:52:56.311554
4771	t	4770	4770	9540	1	\N	\N	2018-07-05 07:52:56.311554
4772	t	4771	4771	9542	2	\N	\N	2018-07-05 07:52:56.311554
4773	t	4772	4772	9544	1	\N	\N	2018-07-05 07:52:56.311554
4774	t	4773	4773	9546	2	\N	\N	2018-07-05 07:52:56.311554
4775	t	4774	4774	9548	1	\N	\N	2018-07-05 07:52:56.311554
4776	t	4775	4775	9550	2	\N	\N	2018-07-05 07:52:56.311554
4777	t	4776	4776	9552	1	\N	\N	2018-07-05 07:52:56.311554
4778	t	4777	4777	9554	2	\N	\N	2018-07-05 07:52:56.311554
4779	t	4778	4778	9556	1	\N	\N	2018-07-05 07:52:56.311554
4780	t	4779	4779	9558	2	\N	\N	2018-07-05 07:52:56.311554
4781	t	4780	4780	9560	1	\N	\N	2018-07-05 07:52:56.311554
4782	t	4781	4781	9562	2	\N	\N	2018-07-05 07:52:56.311554
4783	t	4782	4782	9564	1	\N	\N	2018-07-05 07:52:56.311554
4784	t	4783	4783	9566	2	\N	\N	2018-07-05 07:52:56.311554
4785	t	4784	4784	9568	1	\N	\N	2018-07-05 07:52:56.311554
4786	t	4785	4785	9570	2	\N	\N	2018-07-05 07:52:56.311554
4787	t	4786	4786	9572	1	\N	\N	2018-07-05 07:52:56.311554
4788	t	4787	4787	9574	2	\N	\N	2018-07-05 07:52:56.311554
4789	t	4788	4788	9576	1	\N	\N	2018-07-05 07:52:56.311554
4790	t	4789	4789	9578	2	\N	\N	2018-07-05 07:52:56.311554
4791	t	4790	4790	9580	1	\N	\N	2018-07-05 07:52:56.311554
4792	t	4791	4791	9582	2	\N	\N	2018-07-05 07:52:56.311554
4793	t	4792	4792	9584	1	\N	\N	2018-07-05 07:52:56.311554
4794	t	4793	4793	9586	2	\N	\N	2018-07-05 07:52:56.311554
4795	t	4794	4794	9588	1	\N	\N	2018-07-05 07:52:56.311554
4796	t	4795	4795	9590	2	\N	\N	2018-07-05 07:52:56.311554
4797	t	4796	4796	9592	1	\N	\N	2018-07-05 07:52:56.311554
4798	t	4797	4797	9594	2	\N	\N	2018-07-05 07:52:56.311554
4799	t	4798	4798	9596	1	\N	\N	2018-07-05 07:52:56.311554
4800	t	4799	4799	9598	2	\N	\N	2018-07-05 07:52:56.311554
4801	t	4800	4800	9600	1	\N	\N	2018-07-05 07:52:56.311554
4802	t	4801	4801	9602	2	\N	\N	2018-07-05 07:52:56.311554
4803	t	4802	4802	9604	1	\N	\N	2018-07-05 07:52:56.311554
4804	t	4803	4803	9606	2	\N	\N	2018-07-05 07:52:56.311554
4805	t	4804	4804	9608	1	\N	\N	2018-07-05 07:52:56.311554
4806	t	4805	4805	9610	2	\N	\N	2018-07-05 07:52:56.311554
4807	t	4806	4806	9612	1	\N	\N	2018-07-05 07:52:56.311554
4808	t	4807	4807	9614	2	\N	\N	2018-07-05 07:52:56.311554
4809	t	4808	4808	9616	1	\N	\N	2018-07-05 07:52:56.311554
4810	t	4809	4809	9618	2	\N	\N	2018-07-05 07:52:56.311554
4811	t	4810	4810	9620	1	\N	\N	2018-07-05 07:52:56.311554
4812	t	4811	4811	9622	2	\N	\N	2018-07-05 07:52:56.311554
4813	t	4812	4812	9624	1	\N	\N	2018-07-05 07:52:56.311554
4814	t	4813	4813	9626	2	\N	\N	2018-07-05 07:52:56.311554
4815	t	4814	4814	9628	1	\N	\N	2018-07-05 07:52:56.311554
4816	t	4815	4815	9630	2	\N	\N	2018-07-05 07:52:56.311554
4817	t	4816	4816	9632	1	\N	\N	2018-07-05 07:52:56.311554
4818	t	4817	4817	9634	2	\N	\N	2018-07-05 07:52:56.311554
4819	t	4818	4818	9636	1	\N	\N	2018-07-05 07:52:56.311554
4820	t	4819	4819	9638	2	\N	\N	2018-07-05 07:52:56.311554
4821	t	4820	4820	9640	1	\N	\N	2018-07-05 07:52:56.311554
4822	t	4821	4821	9642	2	\N	\N	2018-07-05 07:52:56.311554
4823	t	4822	4822	9644	1	\N	\N	2018-07-05 07:52:56.311554
4824	t	4823	4823	9646	2	\N	\N	2018-07-05 07:52:56.311554
4825	t	4824	4824	9648	1	\N	\N	2018-07-05 07:52:56.311554
4826	t	4825	4825	9650	2	\N	\N	2018-07-05 07:52:56.311554
4827	t	4826	4826	9652	1	\N	\N	2018-07-05 07:52:56.311554
4828	t	4827	4827	9654	2	\N	\N	2018-07-05 07:52:56.311554
4829	t	4828	4828	9656	1	\N	\N	2018-07-05 07:52:56.311554
4830	t	4829	4829	9658	2	\N	\N	2018-07-05 07:52:56.311554
4831	t	4830	4830	9660	1	\N	\N	2018-07-05 07:52:56.311554
4832	t	4831	4831	9662	2	\N	\N	2018-07-05 07:52:56.311554
4833	t	4832	4832	9664	1	\N	\N	2018-07-05 07:52:56.311554
4834	t	4833	4833	9666	2	\N	\N	2018-07-05 07:52:56.311554
4835	t	4834	4834	9668	1	\N	\N	2018-07-05 07:52:56.311554
4836	t	4835	4835	9670	2	\N	\N	2018-07-05 07:52:56.311554
4837	t	4836	4836	9672	1	\N	\N	2018-07-05 07:52:56.311554
4838	t	4837	4837	9674	2	\N	\N	2018-07-05 07:52:56.311554
4839	t	4838	4838	9676	1	\N	\N	2018-07-05 07:52:56.311554
4840	t	4839	4839	9678	2	\N	\N	2018-07-05 07:52:56.311554
4841	t	4840	4840	9680	1	\N	\N	2018-07-05 07:52:56.311554
4842	t	4841	4841	9682	2	\N	\N	2018-07-05 07:52:56.311554
4843	t	4842	4842	9684	1	\N	\N	2018-07-05 07:52:56.311554
4844	t	4843	4843	9686	2	\N	\N	2018-07-05 07:52:56.311554
4845	t	4844	4844	9688	1	\N	\N	2018-07-05 07:52:56.311554
4846	t	4845	4845	9690	2	\N	\N	2018-07-05 07:52:56.311554
4847	t	4846	4846	9692	1	\N	\N	2018-07-05 07:52:56.311554
4848	t	4847	4847	9694	2	\N	\N	2018-07-05 07:52:56.311554
4849	t	4848	4848	9696	1	\N	\N	2018-07-05 07:52:56.311554
4850	t	4849	4849	9698	2	\N	\N	2018-07-05 07:52:56.311554
4851	t	4850	4850	9700	1	\N	\N	2018-07-05 07:52:56.311554
4852	t	4851	4851	9702	2	\N	\N	2018-07-05 07:52:56.311554
4853	t	4852	4852	9704	1	\N	\N	2018-07-05 07:52:56.311554
4854	t	4853	4853	9706	2	\N	\N	2018-07-05 07:52:56.311554
4855	t	4854	4854	9708	1	\N	\N	2018-07-05 07:52:56.311554
4856	t	4855	4855	9710	2	\N	\N	2018-07-05 07:52:56.311554
4857	t	4856	4856	9712	1	\N	\N	2018-07-05 07:52:56.311554
4858	t	4857	4857	9714	2	\N	\N	2018-07-05 07:52:56.311554
4859	t	4858	4858	9716	1	\N	\N	2018-07-05 07:52:56.311554
4860	t	4859	4859	9718	2	\N	\N	2018-07-05 07:52:56.311554
4861	t	4860	4860	9720	1	\N	\N	2018-07-05 07:52:56.311554
4862	t	4861	4861	9722	2	\N	\N	2018-07-05 07:52:56.311554
4863	t	4862	4862	9724	1	\N	\N	2018-07-05 07:52:56.311554
4864	t	4863	4863	9726	2	\N	\N	2018-07-05 07:52:56.311554
4865	t	4864	4864	9728	1	\N	\N	2018-07-05 07:52:56.311554
4866	t	4865	4865	9730	2	\N	\N	2018-07-05 07:52:56.311554
4867	t	4866	4866	9732	1	\N	\N	2018-07-05 07:52:56.311554
4868	t	4867	4867	9734	2	\N	\N	2018-07-05 07:52:56.311554
4869	t	4868	4868	9736	1	\N	\N	2018-07-05 07:52:56.311554
4870	t	4869	4869	9738	2	\N	\N	2018-07-05 07:52:56.311554
4871	t	4870	4870	9740	1	\N	\N	2018-07-05 07:52:56.311554
4872	t	4871	4871	9742	2	\N	\N	2018-07-05 07:52:56.311554
4873	t	4872	4872	9744	1	\N	\N	2018-07-05 07:52:56.311554
4874	t	4873	4873	9746	2	\N	\N	2018-07-05 07:52:56.311554
4875	t	4874	4874	9748	1	\N	\N	2018-07-05 07:52:56.311554
4876	t	4875	4875	9750	2	\N	\N	2018-07-05 07:52:56.311554
4877	t	4876	4876	9752	1	\N	\N	2018-07-05 07:52:56.311554
4878	t	4877	4877	9754	2	\N	\N	2018-07-05 07:52:56.311554
4879	t	4878	4878	9756	1	\N	\N	2018-07-05 07:52:56.311554
4880	t	4879	4879	9758	2	\N	\N	2018-07-05 07:52:56.311554
4881	t	4880	4880	9760	1	\N	\N	2018-07-05 07:52:56.311554
4882	t	4881	4881	9762	2	\N	\N	2018-07-05 07:52:56.311554
4883	t	4882	4882	9764	1	\N	\N	2018-07-05 07:52:56.311554
4884	t	4883	4883	9766	2	\N	\N	2018-07-05 07:52:56.311554
4885	t	4884	4884	9768	1	\N	\N	2018-07-05 07:52:56.311554
4886	t	4885	4885	9770	2	\N	\N	2018-07-05 07:52:56.311554
4887	t	4886	4886	9772	1	\N	\N	2018-07-05 07:52:56.311554
4888	t	4887	4887	9774	2	\N	\N	2018-07-05 07:52:56.311554
4889	t	4888	4888	9776	1	\N	\N	2018-07-05 07:52:56.311554
4890	t	4889	4889	9778	2	\N	\N	2018-07-05 07:52:56.311554
4891	t	4890	4890	9780	1	\N	\N	2018-07-05 07:52:56.311554
4892	t	4891	4891	9782	2	\N	\N	2018-07-05 07:52:56.311554
4893	t	4892	4892	9784	1	\N	\N	2018-07-05 07:52:56.311554
4894	t	4893	4893	9786	2	\N	\N	2018-07-05 07:52:56.311554
4895	t	4894	4894	9788	1	\N	\N	2018-07-05 07:52:56.311554
4896	t	4895	4895	9790	2	\N	\N	2018-07-05 07:52:56.311554
4897	t	4896	4896	9792	1	\N	\N	2018-07-05 07:52:56.311554
4898	t	4897	4897	9794	2	\N	\N	2018-07-05 07:52:56.311554
4899	t	4898	4898	9796	1	\N	\N	2018-07-05 07:52:56.311554
4900	t	4899	4899	9798	2	\N	\N	2018-07-05 07:52:56.311554
4901	t	4900	4900	9800	1	\N	\N	2018-07-05 07:52:56.311554
4902	t	4901	4901	9802	2	\N	\N	2018-07-05 07:52:56.311554
4903	t	4902	4902	9804	1	\N	\N	2018-07-05 07:52:56.311554
4904	t	4903	4903	9806	2	\N	\N	2018-07-05 07:52:56.311554
4905	t	4904	4904	9808	1	\N	\N	2018-07-05 07:52:56.311554
4906	t	4905	4905	9810	2	\N	\N	2018-07-05 07:52:56.311554
4907	t	4906	4906	9812	1	\N	\N	2018-07-05 07:52:56.311554
4908	t	4907	4907	9814	2	\N	\N	2018-07-05 07:52:56.311554
4909	t	4908	4908	9816	1	\N	\N	2018-07-05 07:52:56.311554
4910	t	4909	4909	9818	2	\N	\N	2018-07-05 07:52:56.311554
4911	t	4910	4910	9820	1	\N	\N	2018-07-05 07:52:56.311554
4912	t	4911	4911	9822	2	\N	\N	2018-07-05 07:52:56.311554
4913	t	4912	4912	9824	1	\N	\N	2018-07-05 07:52:56.311554
4914	t	4913	4913	9826	2	\N	\N	2018-07-05 07:52:56.311554
4915	t	4914	4914	9828	1	\N	\N	2018-07-05 07:52:56.311554
4916	t	4915	4915	9830	2	\N	\N	2018-07-05 07:52:56.311554
4917	t	4916	4916	9832	1	\N	\N	2018-07-05 07:52:56.311554
4918	t	4917	4917	9834	2	\N	\N	2018-07-05 07:52:56.311554
4919	t	4918	4918	9836	1	\N	\N	2018-07-05 07:52:56.311554
4920	t	4919	4919	9838	2	\N	\N	2018-07-05 07:52:56.311554
4921	t	4920	4920	9840	1	\N	\N	2018-07-05 07:52:56.311554
4922	t	4921	4921	9842	2	\N	\N	2018-07-05 07:52:56.311554
4923	t	4922	4922	9844	1	\N	\N	2018-07-05 07:52:56.311554
4924	t	4923	4923	9846	2	\N	\N	2018-07-05 07:52:56.311554
4925	t	4924	4924	9848	1	\N	\N	2018-07-05 07:52:56.311554
4926	t	4925	4925	9850	2	\N	\N	2018-07-05 07:52:56.311554
4927	t	4926	4926	9852	1	\N	\N	2018-07-05 07:52:56.311554
4928	t	4927	4927	9854	2	\N	\N	2018-07-05 07:52:56.311554
4929	t	4928	4928	9856	1	\N	\N	2018-07-05 07:52:56.311554
4930	t	4929	4929	9858	2	\N	\N	2018-07-05 07:52:56.311554
4931	t	4930	4930	9860	1	\N	\N	2018-07-05 07:52:56.311554
4932	t	4931	4931	9862	2	\N	\N	2018-07-05 07:52:56.311554
4933	t	4932	4932	9864	1	\N	\N	2018-07-05 07:52:56.311554
4934	t	4933	4933	9866	2	\N	\N	2018-07-05 07:52:56.311554
4935	t	4934	4934	9868	1	\N	\N	2018-07-05 07:52:56.311554
4936	t	4935	4935	9870	2	\N	\N	2018-07-05 07:52:56.311554
4937	t	4936	4936	9872	1	\N	\N	2018-07-05 07:52:56.311554
4938	t	4937	4937	9874	2	\N	\N	2018-07-05 07:52:56.311554
4939	t	4938	4938	9876	1	\N	\N	2018-07-05 07:52:56.311554
4940	t	4939	4939	9878	2	\N	\N	2018-07-05 07:52:56.311554
4941	t	4940	4940	9880	1	\N	\N	2018-07-05 07:52:56.311554
4942	t	4941	4941	9882	2	\N	\N	2018-07-05 07:52:56.311554
4943	t	4942	4942	9884	1	\N	\N	2018-07-05 07:52:56.311554
4944	t	4943	4943	9886	2	\N	\N	2018-07-05 07:52:56.311554
4945	t	4944	4944	9888	1	\N	\N	2018-07-05 07:52:56.311554
4946	t	4945	4945	9890	2	\N	\N	2018-07-05 07:52:56.311554
4947	t	4946	4946	9892	1	\N	\N	2018-07-05 07:52:56.311554
4948	t	4947	4947	9894	2	\N	\N	2018-07-05 07:52:56.311554
4949	t	4948	4948	9896	1	\N	\N	2018-07-05 07:52:56.311554
4950	t	4949	4949	9898	2	\N	\N	2018-07-05 07:52:56.311554
4951	t	4950	4950	9900	1	\N	\N	2018-07-05 07:52:56.311554
4952	t	4951	4951	9902	2	\N	\N	2018-07-05 07:52:56.311554
4953	t	4952	4952	9904	1	\N	\N	2018-07-05 07:52:56.311554
4954	t	4953	4953	9906	2	\N	\N	2018-07-05 07:52:56.311554
4955	t	4954	4954	9908	1	\N	\N	2018-07-05 07:52:56.311554
4956	t	4955	4955	9910	2	\N	\N	2018-07-05 07:52:56.311554
4957	t	4956	4956	9912	1	\N	\N	2018-07-05 07:52:56.311554
4958	t	4957	4957	9914	2	\N	\N	2018-07-05 07:52:56.311554
4959	t	4958	4958	9916	1	\N	\N	2018-07-05 07:52:56.311554
4960	t	4959	4959	9918	2	\N	\N	2018-07-05 07:52:56.311554
4961	t	4960	4960	9920	1	\N	\N	2018-07-05 07:52:56.311554
4962	t	4961	4961	9922	2	\N	\N	2018-07-05 07:52:56.311554
4963	t	4962	4962	9924	1	\N	\N	2018-07-05 07:52:56.311554
4964	t	4963	4963	9926	2	\N	\N	2018-07-05 07:52:56.311554
4965	t	4964	4964	9928	1	\N	\N	2018-07-05 07:52:56.311554
4966	t	4965	4965	9930	2	\N	\N	2018-07-05 07:52:56.311554
4967	t	4966	4966	9932	1	\N	\N	2018-07-05 07:52:56.311554
4968	t	4967	4967	9934	2	\N	\N	2018-07-05 07:52:56.311554
4969	t	4968	4968	9936	1	\N	\N	2018-07-05 07:52:56.311554
4970	t	4969	4969	9938	2	\N	\N	2018-07-05 07:52:56.311554
4971	t	4970	4970	9940	1	\N	\N	2018-07-05 07:52:56.311554
4972	t	4971	4971	9942	2	\N	\N	2018-07-05 07:52:56.311554
4973	t	4972	4972	9944	1	\N	\N	2018-07-05 07:52:56.311554
4974	t	4973	4973	9946	2	\N	\N	2018-07-05 07:52:56.311554
4975	t	4974	4974	9948	1	\N	\N	2018-07-05 07:52:56.311554
4976	t	4975	4975	9950	2	\N	\N	2018-07-05 07:52:56.311554
4977	t	4976	4976	9952	1	\N	\N	2018-07-05 07:52:56.311554
4978	t	4977	4977	9954	2	\N	\N	2018-07-05 07:52:56.311554
4979	t	4978	4978	9956	1	\N	\N	2018-07-05 07:52:56.311554
4980	t	4979	4979	9958	2	\N	\N	2018-07-05 07:52:56.311554
4981	t	4980	4980	9960	1	\N	\N	2018-07-05 07:52:56.311554
4982	t	4981	4981	9962	2	\N	\N	2018-07-05 07:52:56.311554
4983	t	4982	4982	9964	1	\N	\N	2018-07-05 07:52:56.311554
4984	t	4983	4983	9966	2	\N	\N	2018-07-05 07:52:56.311554
4985	t	4984	4984	9968	1	\N	\N	2018-07-05 07:52:56.311554
4986	t	4985	4985	9970	2	\N	\N	2018-07-05 07:52:56.311554
4987	t	4986	4986	9972	1	\N	\N	2018-07-05 07:52:56.311554
4988	t	4987	4987	9974	2	\N	\N	2018-07-05 07:52:56.311554
4989	t	4988	4988	9976	1	\N	\N	2018-07-05 07:52:56.311554
4990	t	4989	4989	9978	2	\N	\N	2018-07-05 07:52:56.311554
4991	t	4990	4990	9980	1	\N	\N	2018-07-05 07:52:56.311554
4992	t	4991	4991	9982	2	\N	\N	2018-07-05 07:52:56.311554
4993	t	4992	4992	9984	1	\N	\N	2018-07-05 07:52:56.311554
4994	t	4993	4993	9986	2	\N	\N	2018-07-05 07:52:56.311554
4995	t	4994	4994	9988	1	\N	\N	2018-07-05 07:52:56.311554
4996	t	4995	4995	9990	2	\N	\N	2018-07-05 07:52:56.311554
4997	t	4996	4996	9992	1	\N	\N	2018-07-05 07:52:56.311554
4998	t	4997	4997	9994	2	\N	\N	2018-07-05 07:52:56.311554
4999	t	4998	4998	9996	1	\N	\N	2018-07-05 07:52:56.311554
5000	t	4999	4999	9998	2	\N	\N	2018-07-05 07:52:56.311554
5001	t	5000	5000	10000	1	\N	\N	2018-07-05 07:52:56.311554
\.


--
-- Name: stok_hareketi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stok_hareketi_id_seq', 5001, true);


--
-- Data for Name: stok_karti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stok_karti (id, validity, stok_kodu, stok_adi, stok_grubu, alis_iskonto, satis_iskonto, yetkili_iskonto, stok_tipi_id) FROM stdin;
\.


--
-- Name: stok_karti_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stok_karti_id_seq', 5, true);


--
-- Data for Name: stok_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stok_tipi (id, validity, tip, is_default, is_stok) FROM stdin;
\.


--
-- Name: stok_tipi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stok_tipi_id_seq', 3, true);


--
-- Data for Name: sys_application_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_application_settings (id, validity, logo, unvan, tel1, tel2, tel3, tel4, tel5, fax1, fax2, mersis_no, web_sitesi, eposta_adresi, vergi_dairesi, vergi_no, form_color, donem, mukellef_tipi, tam_adres, ticaret_sicil_no, ulke, sehir, ilce, mahalle, cadde, sokak, posta_kodu, bina, kapi_no, eftr_appstr, eftr_username, eftr_password, eftr_version, efatura_fatura_kodu) FROM stdin;
1	t	\N	AYBEY ELEKTRONİK A.Ş.	0216 394 50 55	\N	\N	\N	\N	0216 394 50 58	\N	1234567891	www.aybey.com	sales@aybey.com	PENDİK	1234567890	92836	2018	VKN	Tam adres	784238748	TÜRKİYE	İSTANBUL	PENDİK	SANAYİ	HIZIR REİS	\N	34949	2	26	\N	\N	\N	\N	AAA
\.


--
-- Name: sys_application_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_application_settings_id_seq', 1, true);


--
-- Data for Name: sys_application_settings_other; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_application_settings_other (id, validity, is_edefter_aktif, uygunsuzluk_mail_sender, uygunsuzluk_mail_sender_username, uygunsuzluk_mail_sender_password, uygunsuzluk_mail_sender_port, uygunsuzluk_mail_alici1, uygunsuzluk_mail_alici2, uygunsuzluk_mail_alici3, varsayilan_satis_cari_kod, varsayilan_alis_cari_kod, bolum_ambarda_uretim_yap, uretim_muhasebe_kaydi_olustursun, stok_satimda_negatife_dusebilir, mal_satis_sayilarini_goster, pcb_uretim, proforma_no_goster, satis_takip, hammadde_girise_gore_sirala, uretim_entegrasyon_hammadde_kullanim_hesabi_iscilikle, tahsilat_listesi_virmanli, ortalama_vade_0_ise_sevkiyata_izin_verme, sipariste_teslim_tarihi_yazdir, teklif_ayrintilarini_goster, fatura_irsaliye_no_0_ile_baslasin, excel_ekli_irsaliye_yazdirma, ambarlararasi_transfer_numara_otomatik_gelsin, ambarlararasi_transfer_onayli_calissin, alis_teklif_alis_sipariste_ham_alis_fiyatini_kullan, tahsilat_listesine_120_bulut_hesabini_dahil_etme, satis_listesi_varsayilan_filtre_mamul_hammadde, is_recete_maliyet_analizi_baska_db_kullanarak_yap, is_efatura_aktif, is_stok_transfer_fiyati_kullanici_degistirebilir, is_hesaplar_rapolarda_cikmasin, is_siparisi_baska_programa_otomatik_kayit_yap, is_active_uretim_takip, is_pano_programina_otomatik_kayit, is_nakit_akista_farkli_db_kullan, is_ihrac_fiyati_yerine_satis_fiyatini_kullan, is_statik_iskonto_orani_kullan, is_eirsaliye_aktif, is_stok_recete_adi_birlikte_guncellensin, is_kur_bilgisini_1_olarak_kullan, is_genel_kdv_orani_kullan, xslt_sablon_adi, maliyet_analiz_host, maliyet_analiz_db_name, maliyet_analiz_user_name, maliyet_analiz_password, maliyet_analiz_port, genel_iskonto_gecerlilik_tarihi, en_fazla_fatura_satir_sayisi, en_fazla_e_fatura_satir_sayisi, en_fazla_irsaliye_satir_sayisi, en_fazla_e_irsaliye_satir_sayisi, siparis_kopyalanacak_kaynak_cari_kod, siparis_kopyalanacak_hedef_cari_kod, ana_dil, maliyet_analizi_iskonto_orani, genel_kdv_orani, path_teklif_hesaplama_conf, path_proforma_file, path_mal_stok_seviyesi_eord_rapor, path_update, path_stok_karti_resim, path_proforma_pdf_kayit) FROM stdin;
\.


--
-- Name: sys_application_settings_other_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_application_settings_other_id_seq', 1, false);


--
-- Data for Name: sys_grid_col_color; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_col_color (id, validity, table_name, column_name, min_value, min_color, max_value, max_color) FROM stdin;
\.


--
-- Name: sys_grid_col_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_col_color_id_seq', 4, true);


--
-- Data for Name: sys_grid_col_percent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_col_percent (id, validity, table_name, column_name, max_value, color_bar, color_bar_back, color_bar_text, color_bar_text_active) FROM stdin;
\.


--
-- Name: sys_grid_col_percent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_col_percent_id_seq', 1, true);


--
-- Data for Name: sys_grid_col_width; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_col_width (id, validity, table_name, column_name, column_width, sequence_no) FROM stdin;
62	t	Sys Lang Contents	Value	450	5
64	t	Sys Lang Contents	Is Factory Setting	110	6
58	t	Sys Lang Contents	Lang	50	1
86	t	Sys Lang Contents	Content Type	100	3
51	t	Sehir	Sehir Adi	150	1
53	t	Sehir	Ulke Adi	150	2
41	t	Sys Grid Col Color	Min Color	100	3
40	t	Sys Grid Col Color	Max Value	100	4
12	t	Sys Permission Source Group	Source Group	350	1
39	t	Sys Grid Col Color	Min Value	100	5
73	t	Sys Table Lang Content	Value	350	5
37	t	Sys Grid Col Color	Table Name	100	1
38	t	Sys Grid Col Color	Column Name	100	2
55	t	Sehir	Plaka Kodu	80	3
42	t	Sys Grid Col Color	Max Color	100	6
10	t	Para Birimi	Aciklama	250	3
9	t	Para Birimi	Is Varsayilan	85	4
74	t	Sys Quality Form Number	Table Name	150	1
75	t	Sys Quality Form Number	Form No	250	2
3	t	Ulke	Ulke Kodu	65	1
5	t	Ulke	Iso Year	60	3
6	t	Ulke	Iso Cctld Code	80	4
4	t	Ulke	Ulke Adi	200	2
50	t	Sys Grid Col Percent	Color Bar Text Active	100	7
21	t	Sys User Access Right	Is Read	90	4
22	t	Sys User Access Right	Is Add Record	90	5
23	t	Sys User Access Right	Is Update	90	6
24	t	Sys User Access Right	Is Delete	90	7
57	t	Sys User Access Right	Source Name	100	2
28	t	Sys Grid Col Width	Table Name	140	1
26	t	Sys User Access Right	User Name	150	3
13	t	Sys Permission Source	Source Code	90	1
15	t	Sys Permission Source	Source Name	200	2
19	t	Sys Permission Source	Source Group	200	3
76	t	Ayar Stok Hareket Tipi	Deger	250	1
7	t	Para Birimi	Kod	40	1
35	t	Sys Grid Col Width	Sequence No	80	3
34	t	Sys Grid Col Width	Column Width	90	4
33	t	Sys Grid Col Width	Column Name	140	2
8	t	Para Birimi	Sembol	50	2
60	t	Sys Lang Contents	Code	250	2
44	t	Sys Grid Col Percent	Table Name	100	1
45	t	Sys Grid Col Percent	Column Name	120	2
46	t	Sys Grid Col Percent	Max Value	80	3
47	t	Sys Grid Col Percent	Color Bar	80	4
49	t	Sys Grid Col Percent	Color Bar Text	100	5
27	t	Sys Lang	Language	350	1
88	t	Sys Lang Contents	Table Name	100	4
48	t	Sys Grid Col Percent	Color Bar Back	100	6
65	t	Sys Table Lang Content	Lang	90	1
20	t	Sys User Access Right	Source Code	100	1
69	t	Sys Table Lang Content	Table Name	150	2
71	t	Sys Table Lang Content	Column Name	150	3
72	t	Sys Table Lang Content	Row Id	60	4
78	t	Stok Hareketi	Stok Kodu	100	1
79	t	Stok Hareketi	Miktar	100	2
80	t	Stok Hareketi	Tutar	130	3
81	t	Stok Hareketi	Hareket Tipi	110	4
82	t	Stok Hareketi	Tarih	70	5
83	t	Sys Grid Default Order Filter	Key	120	1
84	t	Sys Grid Default Order Filter	Value	120	2
85	t	Sys Grid Default Order Filter	Is Order	120	3
\.


--
-- Name: sys_grid_col_width_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_col_width_id_seq', 88, true);


--
-- Data for Name: sys_grid_default_order_filter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_default_order_filter (id, validity, key, value, is_order) FROM stdin;
5	t	Sys Grid Col Width	table_name ASC, sequence_no ASC	t
\.


--
-- Name: sys_grid_default_order_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_default_order_filter_id_seq', 6, true);


--
-- Data for Name: sys_lang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_lang (id, validity, language) FROM stdin;
1	t	Türkçe TR
2	t	English EN
3	t	Deutsch DE
\.


--
-- Data for Name: sys_lang_contents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_lang_contents (id, validity, lang, code, value, is_factory_setting, content_type, table_name) FROM stdin;
37	t	Türkçe TR	Confirmation Lower	İşlem Onayı	t	General	System
11	t	Türkçe TR	No Upper	HAYIR	t	General	System
16	t	English EN	No Lower	No	t	General	System
14	t	English EN	Yes Lower	Yes	t	General	System
15	t	Türkçe TR	No Lower	Hayır	t	General	System
47	t	Türkçe TR	Record Deleted Message	Kayıtları tekrar kontrol edin!	t	Error	System
79	t	Türkçe TR	Kod	Kod	f	Input.LabelCaption	Para Birimi
81	t	Türkçe TR	Is Varsayilan	Varsayılan	f	Input.LabelCaption	Para Birimi
10	t	English EN	Yes Upper	YES	t	General	System
7	t	Türkçe TR	Active Transaction	Aktif bir transaction var. Önce onu tamamlayın!	t	Warning	System
51	t	Türkçe TR	Access Right	Erişim hakkı hatası!!!	t	Error	System
18	t	English EN	Locked Record	The record is locked by another user. Try again later.	t	Warning	System
82	t	Türkçe TR	Sembol	Sembol	f	Input.LabelCaption	Para Birimi
5	t	Türkçe TR	Update Record	Kaydı güncellemek istediğinizden emin misin?	t	Message	System
61	t	Türkçe TR	Sehir	Şehir	f	Input.FormCaption	\N
4	t	English EN	Delete Record	Are you sure you want to delete record?	t	Message	System
87	t	Türkçe TR	Para Birimi	Para Birimi	f	Input.FormCaption	\N
113	t	Türkçe TR	Unsupported Process	Desteklenmeyen işlem!	t	Message	System
3	t	Türkçe TR	Delete Record	Kaydı silmek istediğinden emin misin?	t	Message	System
97	t	Türkçe TR	Ulke Kodu	Ülke Kodu	f	Input.LabelCaption	Ulke
12	t	English EN	No Upper	NO	t	General	System
263	t	Türkçe TR	Main	Ana Ekran	t	Input.FormCaption	\N
69	t	Türkçe TR	Sehir Adi	Şehir Adı	f	Input.LabelCaption	Sehir
6	t	English EN	Update Record	Are you sure you want to update record?	t	Message	System
103	t	English EN	ParaBirimleri	Currencies	f	Button	Main
106	t	Türkçe TR	SysPermissionSourceGroup	Sistem Erişim Hakkı Grupları	t	Button	Main
1	t	Türkçe TR	Confirmation Upper	İŞLEM ONAYI	t	General	System
41	t	Türkçe TR	Delete	SİL	t	Button	System
104	t	Türkçe TR	Ulkeler	Ülkeler	f	Button	Main
111	t	English EN	SysUserAccessRight	System User Access Rights	t	Button	Main
109	t	English EN	SysPermissionSource	System Permission Sources	t	Button	Main
107	t	English EN	SysPermissionSourceGroup	System Permission Source Groups	t	Button	Main
21	t	Türkçe TR	Close	KAPAT	t	Button	System
2	t	English EN	Confirmation Upper	CONFIRMATION	t	General	System
9	t	Türkçe TR	Yes Upper	EVET	t	General	System
102	t	Türkçe TR	ParaBirimleri	Para Birimleri	f	Button	Main
22	t	English EN	Close	CLOSE	t	Button	System
48	t	English EN	Record Deleted Message	Check the current records again!	t	Error	System
31	t	Türkçe TR	Required Data	Zorunlu alanlar boş bırakılamaz!	t	Error	System
43	t	Türkçe TR	Cancel	İPTAL	t	Button	System
44	t	English EN	Cancel	CANCEL	t	Button	System
40	t	English EN	Update	UPDATE	t	Button	System
34	t	English EN	Red Inputs Required	Red colored controls are required	t	Error	System
24	t	English EN	Delete	DELETE	t	Status	System
42	t	English EN	Delete	DELETE	t	Button	System
55	t	Türkçe TR	Add	KAYIT EKLE	t	Button	System
105	t	English EN	Ulkeler	Countries	f	Button	Main
50	t	English EN	Accept	CONFIRM	t	Button	System
49	t	Türkçe TR	Accept	ONAYLA	t	Button	System
73	t	Türkçe TR	Export Excel	Excel Kaydet	t	Popup	System
38	t	English EN	Confirmation Lower	Confirmation	t	General	System
114	t	English EN	Unsupported Process	Unsupported process!	t	Message	System
36	t	English EN	Close Window	Are you sure you want to exit?   All changes will be canceled!!!	t	Message	System
32	t	English EN	Required Data	Can\\'t be empty required input controls!	t	Error	System
13	t	Türkçe TR	Yes Lower	Evet	t	General	System
33	t	Türkçe TR	Red Inputs Required	Kırmızı renkli girişler zorunlu bilgiler.	t	Error	System
52	t	English EN	Access Right	Access right failure!	t	Error	System
76	t	Türkçe TR	Sembol	Sembol	f	Grid.FieldCaption	Para Birimi
28	t	English EN	Cancel	CANCEL/CLOSE	t	Status	System
26	t	English EN	Accept	CONFIRM	t	Status	System
56	t	English EN	Add	ADD RECORD	t	Button	System
23	t	Türkçe TR	Delete	SİL	t	Status	System
27	t	Türkçe TR	Cancel	İPTAL/KAPAT	t	Status	System
30	t	English EN	Add	ADD RECORD	t	Status	System
25	t	Türkçe TR	Accept	ONAY	t	Status	System
29	t	Türkçe TR	Add	KAYIT EKLE	t	Status	System
75	t	Türkçe TR	Kod	Kod	f	Grid.FieldCaption	Para Birimi
264	t	English EN	Main	Main	t	Input.FormCaption	\N
17	t	Türkçe TR	Locked Record	Kayıt başka kullanıcı tarafından kilitlendir. Daha sonra tekrar deneyin.	t	Warning	System
8	t	English EN	Active Transaction	There is an active transaction. Complete it first!	t	Warning	System
78	t	Türkçe TR	Aciklama	Açıklama	f	Grid.FieldCaption	Para Birimi
65	t	Türkçe TR	Sehir Adi	Şehir Adı	f	Grid.FieldCaption	Sehir
67	t	Türkçe TR	Ulke Adi	Ülke Adı	f	Grid.FieldCaption	Sehir
57	t	Türkçe TR	Preview	İncele	t	Popup	System
268	t	Türkçe TR	FrameworkSettings	Şablo Ayarları	f	Tab	Main
269	t	Türkçe TR	Settings	Ayarlar	f	Tab	Main
84	t	English EN	Aciklama	Code Comment	f	Input.LabelCaption	Para Birimi
86	t	English EN	Sembol	Symbol	f	Input.LabelCaption	Para Birimi
190	t	Türkçe TR	SysGridColColor	Sistem Grid Renkli Kolonlar	t	Button	Main
85	t	English EN	Is Varsayilan	Default	f	Input.LabelCaption	Para Birimi
186	t	Türkçe TR	SysGridColPercent	Sistem Grid Yüzdelik Kolonlar	t	Button	Main
100	t	Türkçe TR	Sehirler	Şehirler	f	Button	Main
192	t	English EN	SysGridColColor	System Grid Colored Columns	t	Button	Main
101	t	English EN	Sehirler	Cities	f	Button	Main
70	t	English EN	Sehir Adi	City Name	f	Input.LabelCaption	Sehir
141	t	Türkçe TR	Filter	FİLTRELE	t	Button	System
183	t	English EN	SysLangContent	System Language Contents	t	Button	Main
187	t	English EN	SysGridColPercent	System Grid Percent Columns	t	Button	Main
189	t	English EN	SysGridColWidth	System Grid Column Width And Sequence	t	Button	Main
270	t	Türkçe TR	Staff	Personel	f	Tab	Main
126	t	Türkçe TR	Database	Veri Tabanı Adı	t	Login	System
123	t	Türkçe TR	Password	Şifre	t	Login	System
134	t	English EN	User Name	Username	t	Login	System
115	t	Türkçe TR	Database Connection	Veri tabanı ile bağlantı kurulamadı!	t	Error	System
121	t	Türkçe TR	User Name	Kullanıcı Adı	t	Login	System
132	t	English EN	Server	Server Address	t	Login	System
124	t	Türkçe TR	Server	Sunucu Adres	t	Login	System
62	t	English EN	Sehir	City	f	Input.FormCaption	\N
88	t	English EN	Para Birimi	Currency	f	Input.FormCaption	\N
142	t	English EN	Filter	FILTER	t	Button	System
140	t	English EN	Login	Login	t	Input.FormCaption	\N
147	t	English EN	Filter	Filter	t	Input.FormCaption	\N
138	t	English EN	Save Settings	Save Settings	t	Login	System
137	t	Türkçe TR	Save Settings	Ayarları Kaydet	t	Login	System
136	t	English EN	Port No	Port Number	t	Login	System
135	t	Türkçe TR	Port No	Port Numarası	t	Login	System
179	t	English EN	Open Window	Another window has been opened for input / update. Complete the operation that was opened first.	t	Warning	System
151	t	English EN	Filter Criteria Title	Filter Criteria	t	Filter	System
176	t	Türkçe TR	Record Count	Toplam	t	General	System
175	t	English EN	Print	Print	t	Popup	System
166	t	Türkçe TR	Remove Filter	Filtre Kaldır	t	Popup	System
148	t	Türkçe TR	Key Value	Filtre Anahtar Değeri	t	Filter	System
174	t	Türkçe TR	Print	Yazdır	t	Popup	System
169	t	Türkçe TR	Remove Sort	Sıralamayı Kaldır	t	Popup	System
164	t	Türkçe TR	Filter	Filtrele	t	Popup	System
58	t	English EN	Preview	Preview	t	Popup	System
168	t	English EN	Remove Filter	Remove Filter	t	Popup	System
157	t	English EN	With Start	with start...	t	Filter	System
178	t	Türkçe TR	Open Window	Başka bir pencere giriş veya güncelleme için açılmış, önce bu işlemi tamamlayın.	t	Warning	System
153	t	English EN	Not Like	not like	t	Filter	System
161	t	English EN	Select Filter Fields	Select data fields to filter	t	Filter	System
160	t	Türkçe TR	Select Filter Fields	Filtrelenecek alanları seçin	t	Filter	System
159	t	English EN	With End	...with end	t	Filter	System
158	t	Türkçe TR	With End	...ile biten	t	Filter	System
150	t	Türkçe TR	Filter Criteria Title	Filtreleme Kriteri	t	Filter	System
131	t	English EN	Password	Password	t	Login	System
155	t	Türkçe TR	Not Like	içermeyen	t	Filter	System
156	t	Türkçe TR	With Start	ile başlayan...	t	Filter	System
154	t	English EN	Like	like	t	Filter	System
152	t	Türkçe TR	Like	içeren	t	Filter	System
177	t	English EN	Record Count	Total	t	General	System
92	t	English EN	Aciklama	Comment	f	Grid.FieldCaption	Para Birimi
68	t	English EN	Ulke Adi	Country Name	f	Grid.FieldCaption	Sehir
139	t	Türkçe TR	Login	Giriş	t	Input.FormCaption	\N
116	t	English EN	Database Connection	Failed to connect to database!	t	Error	System
120	t	English EN	Login	Username/Password not defined or correct!	t	Error	System
119	t	Türkçe TR	Login	Kullanıcı Adı/Şifre tanımlı değil veya doğru değil!	t	Error	System
185	t	English EN	SysLang	System Languages	t	Button	Main
181	t	Türkçe TR	SysLangContent	Sistem Dil İçerikleri	t	Button	Main
74	t	English EN	Export Excel	Export Excel	t	Popup	System
165	t	English EN	Filter	Filter	t	Popup	System
173	t	English EN	Remove Sort	Remove Sort	t	Popup	System
207	t	English EN	SysTableLangContent	System Table Language Contents	t	Button	Main
184	t	Türkçe TR	SysLang	Sistem Dilleri	t	Button	Main
94	t	English EN	Sembol	Symbol	f	Grid.FieldCaption	Para Birimi
93	t	English EN	Is Varsayilan	Default?	f	Grid.FieldCaption	Para Birimi
91	t	English EN	Kod	Code	f	Grid.FieldCaption	Para Birimi
149	t	English EN	Key Value	Filter Key Value	t	Filter	System
122	t	Türkçe TR	Language	Dil	t	Login	System
130	t	English EN	Language	Language	t	Login	System
271	t	Türkçe TR	Equipment	Demirbaş	f	Tab	Main
272	t	Türkçe TR	Production	Üretim	f	Tab	Main
273	t	Türkçe TR	Accounting	Hesap	f	Tab	Main
72	t	English EN	Ulke Adi	Country Name	f	Input.LabelCaption	Sehir
71	t	Türkçe TR	Ulke Adi	Ülke Adı	f	Input.LabelCaption	Sehir
220	t	Türkçe TR	Table Name	Tablo Adı	f	Grid.FieldCaption	Sys Quality Form Number
133	t	English EN	Server Example	Server Example: 192.168.1.100 / localhost / 127.0.0.1	t	Login	System
127	t	English EN	Database	Database Name	t	Login	System
222	t	English EN	Form No	Form No	f	Grid.FieldCaption	Sys Quality Form Number
206	t	English EN	SysQualityFormNumber	System Quality Form Numbers	t	Button	Main
226	t	Türkçe TR	SysDefaultOrderFilter	Sistem Varsayılan Sıralama ve Filtre	t	Button	Main
221	t	Türkçe TR	Form No	Form Numarası	f	Grid.FieldCaption	Sys Quality Form Number
66	t	English EN	Sehir Adi	City Name	f	Grid.FieldCaption	Sehir
35	t	Türkçe TR	Close Window	Çıkmak istediğinden emin misin?  Tüm değişiklkler iptal olacak!!!	t	Message	System
227	t	English EN	SysDefaultOrderFilter	System Default Sequence And Filter	t	Button	Main
224	t	Türkçe TR	StokHareketi	Stok Hareketleri	f	Button	Main
204	t	Türkçe TR	SysQualityFormNumber	Sistem Kalite Form Numaraları	t	Button	Main
208	t	Türkçe TR	Lang	Dil	f	Grid.FieldCaption	Sys Table Lang Content
225	t	English EN	StokHareketi	Stock Transactions	f	Button	Main
188	t	Türkçe TR	SysGridColWidth	Sistem Grid Genişlikleri ve Sıra Numaraları	t	Button	Main
223	t	English EN	Table Name	Table Name	f	Grid.FieldCaption	Sys Quality Form Number
228	t	Türkçe TR	Sys Permission Source Group	Erişim Hakkı Grupları	t	Output.FormCaption	\N
252	t	Türkçe TR	Sys Permission Source Group	Erişim Hak Grubu	t	Input.FormCaption	\N
237	t	Türkçe TR	Sys Lang	Sistem Dilleri	t	Output.FormCaption	\N
203	t	English EN	Sys Permission Source	System Access Rights	t	Output.FormCaption	\N
239	t	English EN	Sys Grid Col Width	System Grid Column Width And Sequence Numbers	t	Output.FormCaption	\N
238	t	English EN	Sys Lang	System Languages	t	Output.FormCaption	\N
240	t	Türkçe TR	Sys Grid Col Width	Sistem Grid Kolon Genişlikleri ve Sıra Numaraları	t	Output.FormCaption	\N
248	t	Türkçe TR	Sys Grid Col Percent	Sistem Grid Yüzdelik Kolonlar	t	Output.FormCaption	\N
249	t	English EN	Sys Grid Col Percent	System Grid Percent Columns	t	Output.FormCaption	\N
89	t	Türkçe TR	Para Birimi	Para Birimleri	f	Output.FormCaption	\N
245	t	Türkçe TR	Sys Grid Col Color	Sistem Grid Renkli Kolonlar	t	Output.FormCaption	\N
247	t	English EN	Sys Grid Col Color	System Grid Colored Columns	t	Output.FormCaption	\N
196	t	Türkçe TR	Sehir	Şehirler	f	Output.FormCaption	\N
199	t	English EN	Ulke	Country	f	Input.FormCaption	\N
197	t	English EN	Sehir	Cities	f	Output.FormCaption	\N
193	t	Türkçe TR	Ulke	Ülkeler	f	Output.FormCaption	\N
229	t	English EN	Sys Permission Source Group	Access Right Groups	t	Output.FormCaption	\N
198	t	Türkçe TR	Ulke	Ülke	f	Input.FormCaption	\N
210	t	Türkçe TR	Column Name	Kolon Adı	f	Grid.FieldCaption	Sys Table Lang Content
201	t	English EN	Sys Permission Source	System Access Right	t	Input.FormCaption	\N
200	t	Türkçe TR	Sys Permission Source	Sistem Erişim Hakkı	t	Input.FormCaption	\N
236	t	English EN	Sys Lang	System Language	t	Input.FormCaption	\N
235	t	Türkçe TR	Sys Lang	Sistem Dili	t	Input.FormCaption	\N
242	t	English EN	Sys Grid Col Width	System Grid Column Width And Sequence Number	t	Input.FormCaption	\N
241	t	Türkçe TR	Sys Grid Col Width	Sistem Grid Kolon Genişliği ve Sıra Numarası	t	Input.FormCaption	\N
251	t	English EN	Sys Grid Col Percent	System Grid Percent Column	t	Input.FormCaption	\N
243	t	English EN	Sys Grid Col Color	System Grid Colored Column	t	Input.FormCaption	\N
96	t	English EN	Ulke Kodu	Country Code	f	Grid.FieldCaption	Ulke
244	t	Türkçe TR	Sys Grid Col Color	Sistem Grid Renkli Kolon	t	Input.FormCaption	\N
250	t	Türkçe TR	Sys Grid Col Percent	Sistem Grid Yüzdelik Kolon	t	Input.FormCaption	\N
90	t	English EN	Para Birimi	Currencies	f	Output.FormCaption	\N
217	t	English EN	Row Id	Row ID	f	Grid.FieldCaption	Sys Table Lang Content
219	t	English EN	Value	Value	f	Grid.FieldCaption	Sys Table Lang Content
212	t	Türkçe TR	Value	Değer	f	Grid.FieldCaption	Sys Table Lang Content
231	t	Türkçe TR	Sys User Access Right	Kullanıcı Erişim Hakları	t	Output.FormCaption	\N
143	t	Türkçe TR	Filter	Filtre	t	Input.FormCaption	\N
232	t	English EN	Sys User Access Right	User Access Right	t	Input.FormCaption	\N
234	t	Türkçe TR	Sys User Access Right	Kullanıcı Erişim Hakkı	t	Input.FormCaption	\N
194	t	English EN	Ulke	Countries	f	Output.FormCaption	\N
230	t	English EN	Sys User Access Right	User Access Rights	t	Output.FormCaption	\N
202	t	Türkçe TR	Sys Permission Source	Sistem Erişim Hakları	t	Output.FormCaption	\N
218	t	English EN	Table Name	Table Name	f	Grid.FieldCaption	Sys Table Lang Content
253	t	English EN	Sys Permission Source Group	Permission Right Group	t	Input.FormCaption	\N
211	t	Türkçe TR	Row Id	Satır ID	f	Grid.FieldCaption	Sys Table Lang Content
214	t	English EN	Lang	Language	f	Grid.FieldCaption	Sys Table Lang Content
125	t	Türkçe TR	Server Example	Sunucu Örnek: 192.168.1.100 / localhost / 127.0.0.1	t	Login	System
53	t	Türkçe TR	Application Terminate	Program sonlandırılacak. Programı kapatmak istediğinden emin misin?	t	Message	System
54	t	English EN	Application Terminate	Application terminated. Are you sure you want close application?	t	Message	System
293	t	Türkçe TR	User Name	Kullanıcı Adı	f	Grid.FieldCaption	Sys User Access Right
295	t	Türkçe TR	Is Read	Okuma?	f	Grid.FieldCaption	Sys User Access Right
83	t	English EN	Kod	Code	f	Input.LabelCaption	Para Birimi
297	t	Türkçe TR	Source Group	Kaynak Grubu	f	Grid.FieldCaption	Sys Permission Source Group
80	t	Türkçe TR	Aciklama	Kod Açıklama	f	Input.LabelCaption	Para Birimi
296	t	Türkçe TR	Is Add Record	Kayıt Ekleme?	f	Grid.FieldCaption	Sys User Access Right
324	t	Türkçe TR	Is Factory Setting	Template Ayarı?	f	Grid.FieldCaption	Sys Lang Contents
215	t	English EN	Column Name	Column Name	f	Grid.FieldCaption	Sys Table Lang Content
254	t	Türkçe TR	Copy Record	Seçili Kaydı Kopyala	t	Popup	System
256	t	English EN	Copy Record	Copy Selected Record	t	Popup	System
259	t	Türkçe TR	Exclude Filter	Seçili Hariç Filtrele	t	Popup	System
260	t	English EN	Exclude Filter	Exclude Filter	t	Popup	System
261	t	Türkçe TR	Export Excel All	Tümünü Excele Aktar	t	Popup	System
262	t	English EN	Export Excel All	Export Excel All	t	Popup	System
299	t	Türkçe TR	Is Delete	Silme?	f	Grid.FieldCaption	Sys User Access Right
300	t	Türkçe TR	Language	Dil	f	Grid.FieldCaption	Sys Lang
19	t	Türkçe TR	Record Deleted	Siz inceleme ekranındayken kayıt başka kullanıcı tarafından silinmiş.	t	Error	System
20	t	English EN	Record Deleted	The record was deleted by another user while you were on the review screen.	t	Error	System
39	t	Türkçe TR	Update	GÜNCELLE	t	Button	System
110	t	Türkçe TR	SysUserAccessRight	Sistem Kullanıcı Erişim Hakkı	t	Button	Main
205	t	Türkçe TR	SysTableLangContent	Sistem Tablo Dil İçerikleri	t	Button	Main
108	t	Türkçe TR	SysPermissionSource	Sistem Erişim Hakları	t	Button	Main
301	t	Türkçe TR	Source Code	Kaynak Kodu	f	Grid.FieldCaption	Sys Permission Source
302	t	Türkçe TR	Source Name	Kaynak Adı	f	Grid.FieldCaption	Sys Permission Source
303	t	Türkçe TR	Source Group	Kaynak Grubu	f	Grid.FieldCaption	Sys Permission Source
267	t	English EN	AyarStokHareketTipi	Setting Stock Transaction Types	f	Button	Main
265	t	Türkçe TR	AyarStokHareketTipi	Ayar Stok Hareket Tipi	f	Button	Main
275	t	Türkçe TR	Stock	Stok	f	Tab	Main
276	t	Türkçe TR	Sales	Satış	f	Tab	Main
277	t	Türkçe TR	Buying	Alış	f	Tab	Main
278	t	Türkçe TR	General	Genel	f	Tab	Main
279	t	English EN	FrameworkSettings	Framework Settings	f	Tab	Main
280	t	English EN	Settings	Settings	f	Tab	Main
281	t	English EN	Staff	Staff	f	Tab	Main
282	t	English EN	Equipment	Equipment	f	Tab	Main
283	t	English EN	Production	Production	f	Tab	Main
284	t	English EN	Accounting	Accounting	f	Tab	Main
285	t	English EN	Stock	Stock	f	Tab	Main
286	t	English EN	Sales	Sales	f	Tab	Main
287	t	English EN	Buying	Buying	f	Tab	Main
288	t	English EN	General	General	f	Tab	Main
289	t	Türkçe TR	Add Language Content	Dil Dosyasına Ekle	t	Popup	System
290	t	English EN	Add Language Content	Add Language Content	t	Popup	System
257	t	Türkçe TR	Add Language Data	Dil Datasını Ekle	t	Popup	System
258	t	English EN	Add Language Data	Add Language Data	t	Popup	System
291	t	Türkçe TR	Source Code	Kaynak Kodu	f	Grid.FieldCaption	Sys User Access Right
292	t	Türkçe TR	Source Name	Kaynak Adı	f	Grid.FieldCaption	Sys User Access Right
304	t	Türkçe TR	Table Name	Tablo Adı	f	Grid.FieldCaption	Sys Grid Col Width
305	t	Türkçe TR	Column Name	Kolon Adı	f	Grid.FieldCaption	Sys Grid Col Width
306	t	Türkçe TR	Sequence No	Sıra No	f	Grid.FieldCaption	Sys Grid Col Width
307	t	Türkçe TR	Column Width	Kolon Genişliği	f	Grid.FieldCaption	Sys Grid Col Width
308	t	Türkçe TR	Table Name	Tablo Adı	f	Grid.FieldCaption	Sys Grid Col Color
309	t	Türkçe TR	Column Name	Kolon Adı	f	Grid.FieldCaption	Sys Grid Col Color
311	t	Türkçe TR	Max Value	Maksimum Değer	f	Grid.FieldCaption	Sys Grid Col Color
310	t	Türkçe TR	Min Color	Minimum Değer Rengi	f	Grid.FieldCaption	Sys Grid Col Color
312	t	Türkçe TR	Min Value	Minimum Değer	f	Grid.FieldCaption	Sys Grid Col Color
313	t	Türkçe TR	Max Color	Maksimum Değer Rengi	f	Grid.FieldCaption	Sys Grid Col Color
314	t	Türkçe TR	Table Name	Tablo Adı	f	Grid.FieldCaption	Sys Grid Col Percent
315	t	Türkçe TR	Column Name	Kolon Adı	f	Grid.FieldCaption	Sys Grid Col Percent
316	t	Türkçe TR	Max Value	Maks Değer	f	Grid.FieldCaption	Sys Grid Col Percent
318	t	Türkçe TR	Color Bar Text	Yazı Rengi	f	Grid.FieldCaption	Sys Grid Col Percent
317	t	Türkçe TR	Color Bar	Yüzdelik Şerit Rengi	f	Grid.FieldCaption	Sys Grid Col Percent
319	t	Türkçe TR	Color Bar Back	Şerit Rengi	f	Grid.FieldCaption	Sys Grid Col Percent
320	t	Türkçe TR	Color Bar Text Active	Aktif Yazı Rengi	f	Grid.FieldCaption	Sys Grid Col Percent
321	t	Türkçe TR	Lang	Dil	f	Grid.FieldCaption	Sys Lang Contents
322	t	Türkçe TR	Code	Kod	f	Grid.FieldCaption	Sys Lang Contents
323	t	Türkçe TR	Value	Değer	f	Grid.FieldCaption	Sys Lang Contents
325	t	Türkçe TR	Key	Anahtar	f	Grid.FieldCaption	Sys Grid Default Order Filter
326	t	Türkçe TR	Value	Value	f	Grid.FieldCaption	Sys Grid Default Order Filter
327	t	Türkçe TR	Is Order	Sıralama?	f	Grid.FieldCaption	Sys Grid Default Order Filter
298	t	Türkçe TR	Is Update	Güncelleme?	f	Grid.FieldCaption	Sys User Access Right
209	t	Türkçe TR	Table Name	Tablo Adı	f	Grid.FieldCaption	Sys Table Lang Content
95	t	Türkçe TR	Ulke Kodu	Ülke Kodu	f	Grid.FieldCaption	Ulke
328	t	Türkçe TR	Ulke Adi	Ülke Adı	f	Grid.FieldCaption	Ulke
329	t	Türkçe TR	Iso Year	Yıl	f	Grid.FieldCaption	Ulke
330	t	Türkçe TR	Iso Cctld Code	CCTLD Kodu	f	Grid.FieldCaption	Ulke
331	t	Türkçe TR	Plaka Kodu	Plaka Kodu	f	Grid.FieldCaption	Sehir
77	t	Türkçe TR	Is Varsayilan	Varsayılan?	f	Grid.FieldCaption	Para Birimi
332	t	English EN	Ulke Adi	Country Name	f	Grid.FieldCaption	Ulke
333	t	English EN	Iso Cctld Code	CCTLD Code	f	Grid.FieldCaption	Ulke
334	t	English EN	Iso Year	Year	f	Grid.FieldCaption	Ulke
335	t	English EN	Plaka Kodu	Car Licence Code	f	Grid.FieldCaption	Sehir
336	t	English EN	Stok Kodu	Stock Code	f	Grid.FieldCaption	Stok Hareketi
337	t	English EN	Miktar	Quantity	f	Grid.FieldCaption	Stok Hareketi
338	t	English EN	Tutar	Amount	f	Grid.FieldCaption	Stok Hareketi
339	t	English EN	Hareket Tipi	Transaction Type	f	Grid.FieldCaption	Stok Hareketi
340	t	English EN	Tarih	Date	f	Grid.FieldCaption	Stok Hareketi
341	t	English EN	Deger	Value	f	Grid.FieldCaption	Ayar Stok Hareket Tipi
342	t	English EN	Source Code	Source Code	f	Grid.FieldCaption	Sys Permission Source
343	t	English EN	Source Name	Source Name	f	Grid.FieldCaption	Sys Permission Source
344	t	English EN	Source Group	Source Group	f	Grid.FieldCaption	Sys Permission Source
345	t	English EN	Source Group	Source Group	f	Grid.FieldCaption	Sys Permission Source Group
346	t	English EN	Source Code	Source Code	f	Grid.FieldCaption	Sys User Access Right
347	t	English EN	Source Name	Source Name	f	Grid.FieldCaption	Sys User Access Right
348	t	English EN	User Name	User Name	f	Grid.FieldCaption	Sys User Access Right
349	t	English EN	Is Read	Read?	f	Grid.FieldCaption	Sys User Access Right
350	t	English EN	Is Add Record	Add Record?	f	Grid.FieldCaption	Sys User Access Right
351	t	English EN	Is Update	Update?	f	Grid.FieldCaption	Sys User Access Right
352	t	English EN	Is Delete	Delete?	f	Grid.FieldCaption	Sys User Access Right
353	t	English EN	Language	Language	f	Grid.FieldCaption	Sys Lang
354	t	English EN	Table Name	Table Name	f	Grid.FieldCaption	Sys Grid Col Width
355	t	English EN	Column Name	Column Name	f	Grid.FieldCaption	Sys Grid Col Width
356	t	English EN	Sequence No	Sequence No	f	Grid.FieldCaption	Sys Grid Col Width
357	t	English EN	Column Width	Column Width	f	Grid.FieldCaption	Sys Grid Col Width
358	t	English EN	Table Name	Table Name	f	Grid.FieldCaption	Sys Grid Col Color
359	t	English EN	Column Name	Column Name	f	Grid.FieldCaption	Sys Grid Col Color
360	t	English EN	Min Color	Min Color	f	Grid.FieldCaption	Sys Grid Col Color
361	t	English EN	Max Value	Max Value	f	Grid.FieldCaption	Sys Grid Col Color
362	t	English EN	Min Value	Min Value	f	Grid.FieldCaption	Sys Grid Col Color
363	t	English EN	Max Color	Max Color	f	Grid.FieldCaption	Sys Grid Col Color
364	t	English EN	Table Name	Table Name	f	Grid.FieldCaption	Sys Grid Col Percent
365	t	English EN	Column Name	Column Name	f	Grid.FieldCaption	Sys Grid Col Percent
366	t	English EN	Max Value	Max Value	f	Grid.FieldCaption	Sys Grid Col Percent
368	t	English EN	Color Bar Text	Text Color	f	Grid.FieldCaption	Sys Grid Col Percent
367	t	English EN	Color Bar	Percent Color	f	Grid.FieldCaption	Sys Grid Col Percent
369	t	English EN	Color Bar Back	Bar Color	f	Grid.FieldCaption	Sys Grid Col Percent
370	t	English EN	Color Bar Text Active	Active Text Color	f	Grid.FieldCaption	Sys Grid Col Percent
371	t	English EN	Lang	Language	f	Grid.FieldCaption	Sys Lang Contents
372	t	English EN	Code	Code	f	Grid.FieldCaption	Sys Lang Contents
373	t	English EN	Value	Value	f	Grid.FieldCaption	Sys Lang Contents
374	t	English EN	Is Factory Setting	Factory Setting?	f	Grid.FieldCaption	Sys Lang Contents
375	t	English EN	Key	Key	f	Grid.FieldCaption	Sys Grid Default Order Filter
376	t	English EN	Value	Value	f	Grid.FieldCaption	Sys Grid Default Order Filter
377	t	English EN	Is Order	Order?	f	Grid.FieldCaption	Sys Grid Default Order Filter
378	t	Türkçe TR	StokKodu	Stok Kodu	f	Input.LabelCaption	Stok Hareketi
380	t	Türkçe TR	SourceCode	Kaynak Kodu	f	Input.LabelCaption	Sys Permission Source
381	t	Türkçe TR	SourceName	Kaynak Adı	f	Input.LabelCaption	Sys Permission Source
382	t	Türkçe TR	SourceGroup	Kaynak Grubu	f	Input.LabelCaption	Sys Permission Source
387	t	Türkçe TR	SourceGroup	Kaynak Grubu	f	Input.LabelCaption	Sys Permission Source Group
392	t	Türkçe TR	Language	Dil	f	Input.LabelCaption	Sys Lang
394	t	Türkçe TR	UserName	Kullanıcı Adı	f	Input.LabelCaption	Sys User Access Right
395	t	Türkçe TR	SourceName	Kaynak Adı	f	Input.LabelCaption	Sys User Access Right
396	t	Türkçe TR	IsRead	Okuma?	f	Input.LabelCaption	Sys User Access Right
397	t	Türkçe TR	IsAddRecord	Yeni Kayıt?	f	Input.LabelCaption	Sys User Access Right
398	t	Türkçe TR	IsUpdate	Güncelleme?	f	Input.LabelCaption	Sys User Access Right
399	t	Türkçe TR	IsDelete	Silme?	f	Input.LabelCaption	Sys User Access Right
400	t	Türkçe TR	IsSpecial	Özel Hak?	f	Input.LabelCaption	Sys User Access Right
401	t	Türkçe TR	TableName	Tablo Adı	f	Input.LabelCaption	Sys Grid Col Width
402	t	Türkçe TR	ColumnName	Kolon Adı	f	Input.LabelCaption	Sys Grid Col Width
403	t	Türkçe TR	ColumnWidth	Kolon Genişliği	f	Input.LabelCaption	Sys Grid Col Width
404	t	Türkçe TR	SequenceNo	Sıra Numarası	f	Input.LabelCaption	Sys Grid Col Width
405	t	Türkçe TR	Lang	Dil	f	Input.LabelCaption	Sys Lang Contents
406	t	Türkçe TR	Code	Kod	f	Input.LabelCaption	Sys Lang Contents
407	t	Türkçe TR	ContentType	İçerik Tipi	f	Input.LabelCaption	Sys Lang Contents
408	t	Türkçe TR	Label2	Tablo Adı	f	Input.LabelCaption	Sys Lang Contents
409	t	Türkçe TR	Value	Değer	f	Input.LabelCaption	Sys Lang Contents
410	t	Türkçe TR	IsFactorySetting	Template Ayarı?	f	Input.LabelCaption	Sys Lang Contents
411	t	Türkçe TR	TableName1	Tablo Adı	f	Input.LabelCaption	Sys Quality Form Number
412	t	Türkçe TR	FormNo	Form Numarası	f	Input.LabelCaption	Sys Quality Form Number
413	t	Türkçe TR	Key	Anahtar	f	Input.LabelCaption	Sys Grid Default Order Filter
414	t	Türkçe TR	Value	Değer	f	Input.LabelCaption	Sys Grid Default Order Filter
415	t	Türkçe TR	IsOrder	Sıralama?	f	Input.LabelCaption	Sys Grid Default Order Filter
416	t	Türkçe TR	Lang	Dil	f	Input.LabelCaption	Sys Table Lang Content
417	t	Türkçe TR	TableName1	Tablo Adı	f	Input.LabelCaption	Sys Table Lang Content
418	t	Türkçe TR	ColumnName	Kolon Adı	f	Input.LabelCaption	Sys Table Lang Content
419	t	Türkçe TR	RowID	Satır ID	f	Input.LabelCaption	Sys Table Lang Content
420	t	Türkçe TR	Value	Değer	f	Input.LabelCaption	Sys Table Lang Content
421	t	Türkçe TR	Content Type	İçerik Tipi	f	Grid.FieldCaption	Sys Lang Contents
422	t	Türkçe TR	Table Name	Tablo Adı	f	Grid.FieldCaption	Sys Lang Contents
\.


--
-- Name: sys_lang_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_lang_contents_id_seq', 422, true);


--
-- Name: sys_lang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_lang_id_seq', 3, true);


--
-- Data for Name: sys_permission_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission_source (id, validity, source_code, source_name, source_group_id) FROM stdin;
1	t	1001	PARA BİRİMİ	2
2	t	1002	ÜLKE	2
7	t	1003	ŞEHİR	1
4	t	1000	AYARLAR	1
9	t	1010	TABLO DİL İÇERİKLERİ	1
10	t	1011	KALİTE FORMLARI	1
11	t	1013	AYAR STOK HAREKETİ TİPİ	1
12	t	1	FRAMEWORK SETTINGS	5
\.


--
-- Data for Name: sys_permission_source_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission_source_group (id, validity, source_group) FROM stdin;
3	t	STOK
4	t	DİĞER
2	t	GENEL
1	t	AYARLAR
5	t	FRAMEWORK
\.


--
-- Name: sys_permission_source_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_source_group_id_seq', 5, true);


--
-- Name: sys_permission_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_source_id_seq', 12, true);


--
-- Data for Name: sys_quality_form_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_quality_form_number (id, validity, table_name, form_no) FROM stdin;
1	t	Ulke	Rev 3.4/45/A
2	t	Para Birimi	Rev 1-0.2A
\.


--
-- Name: sys_quality_form_number_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_quality_form_number_id_seq', 2, true);


--
-- Data for Name: sys_table_lang_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_table_lang_content (id, validity, lang, table_name, column_name, row_id, value) FROM stdin;
1	t	Türkçe TR	Ayar Stok Hareket Tipi	Deger	2	ÇIKIŞ
7	t	English EN	Ayar Stok Hareket Tipi	Deger	1	IN
2	t	English EN	Ayar Stok Hareket Tipi	Deger	2	OUT
3	t	Türkçe TR	Ayar Stok Hareket Tipi	Deger	1	GİRİŞ
\.


--
-- Name: sys_table_lang_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_table_lang_content_id_seq', 9, true);


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user (id, validity, user_name, user_password, is_admin, is_active_user, is_online, app_version, db_version, ip_address, mac_address, is_super_user) FROM stdin;
1	t	FERHAT	1	t	t	f	1	1	127.0.0.1	\N	t
\.


--
-- Data for Name: sys_user_access_right; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user_access_right (id, validity, source_code, is_read, is_add_record, is_update, is_delete, is_special, user_name) FROM stdin;
3	t	1001	t	t	t	t	t	FERHAT
4	t	1000	t	t	t	t	t	FERHAT
5	t	1003	t	t	t	t	t	FERHAT
1	t	1002	t	t	t	t	t	FERHAT
6	t	1010	t	t	t	t	t	FERHAT
7	t	1011	t	t	t	t	t	FERHAT
8	t	1013	t	t	t	t	t	FERHAT
9	t	1	t	t	t	t	t	FERHAT
\.


--
-- Name: sys_user_access_right_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_access_right_id_seq', 9, true);


--
-- Name: sys_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_id_seq', 1, true);


--
-- Data for Name: ulke; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ulke (id, validity, ulke_kodu, ulke_adi, iso_year, iso_cctld_code) FROM stdin;
1	t	TR	TÜRKİYE	1978	.tr
\.


--
-- Name: ulke_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ulke_id_seq', 1, true);


--
-- Name: alis_teklif_detay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_teklif_detay
    ADD CONSTRAINT alis_teklif_detay_pkey PRIMARY KEY (id);


--
-- Name: alis_teklif_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_teklif
    ADD CONSTRAINT alis_teklif_pkey PRIMARY KEY (id);


--
-- Name: alis_tsif_kur_alis_fatura_id_para_birimi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur
    ADD CONSTRAINT alis_tsif_kur_alis_fatura_id_para_birimi_key UNIQUE (alis_fatura_id, para_birimi);


--
-- Name: alis_tsif_kur_alis_irsaliye_id_para_birimi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur
    ADD CONSTRAINT alis_tsif_kur_alis_irsaliye_id_para_birimi_key UNIQUE (alis_irsaliye_id, para_birimi);


--
-- Name: alis_tsif_kur_alis_siparis_id_para_birimi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur
    ADD CONSTRAINT alis_tsif_kur_alis_siparis_id_para_birimi_key UNIQUE (alis_siparis_id, para_birimi);


--
-- Name: alis_tsif_kur_alis_teklif_id_para_birimi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur
    ADD CONSTRAINT alis_tsif_kur_alis_teklif_id_para_birimi_key UNIQUE (alis_teklif_id, para_birimi);


--
-- Name: alis_tsif_kur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur
    ADD CONSTRAINT alis_tsif_kur_pkey PRIMARY KEY (id);


--
-- Name: ambar_ambar_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambar
    ADD CONSTRAINT ambar_ambar_key UNIQUE (ambar);


--
-- Name: ambar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ambar
    ADD CONSTRAINT ambar_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_iletisim_kanali_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali
    ADD CONSTRAINT ayar_efatura_iletisim_kanali_kod_key UNIQUE (kod);


--
-- Name: ayar_efatura_iletisim_kanali_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali
    ADD CONSTRAINT ayar_efatura_iletisim_kanali_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_invoice_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_invoice_type
    ADD CONSTRAINT ayar_efatura_invoice_type_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_invoice_type_tip_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_invoice_type
    ADD CONSTRAINT ayar_efatura_invoice_type_tip_key UNIQUE (tip);


--
-- Name: ayar_efatura_istisna_kodu_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_istisna_kodu
    ADD CONSTRAINT ayar_efatura_istisna_kodu_kodu_key UNIQUE (kodu);


--
-- Name: ayar_efatura_istisna_kodu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_istisna_kodu
    ADD CONSTRAINT ayar_efatura_istisna_kodu_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_kimlik_semalari_deger_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari
    ADD CONSTRAINT ayar_efatura_kimlik_semalari_deger_key UNIQUE (deger);


--
-- Name: ayar_efatura_kimlik_semalari_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari
    ADD CONSTRAINT ayar_efatura_kimlik_semalari_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_response_code_deger_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_response_code
    ADD CONSTRAINT ayar_efatura_response_code_deger_key UNIQUE (deger);


--
-- Name: ayar_efatura_response_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_response_code
    ADD CONSTRAINT ayar_efatura_response_code_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_senaryo_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi
    ADD CONSTRAINT ayar_efatura_senaryo_tipi_pkey PRIMARY KEY (id);


--
-- Name: ayar_efatura_senaryo_tipi_tip_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi
    ADD CONSTRAINT ayar_efatura_senaryo_tipi_tip_key UNIQUE (tip);


--
-- Name: ayar_efatura_tevkifat_kodu_kodu_pay_payda_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu
    ADD CONSTRAINT ayar_efatura_tevkifat_kodu_kodu_pay_payda_key UNIQUE (kodu, pay, payda);


--
-- Name: ayar_efatura_tevkifat_kodu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu
    ADD CONSTRAINT ayar_efatura_tevkifat_kodu_pkey PRIMARY KEY (id);


--
-- Name: ayar_evrak_tipi_deger_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_evrak_tipi
    ADD CONSTRAINT ayar_evrak_tipi_deger_key UNIQUE (deger);


--
-- Name: ayar_evrak_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_evrak_tipi
    ADD CONSTRAINT ayar_evrak_tipi_pkey PRIMARY KEY (id);


--
-- Name: ayar_firma_tipi_detay_firma_tipi_deger_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi_detay
    ADD CONSTRAINT ayar_firma_tipi_detay_firma_tipi_deger_key UNIQUE (firma_tipi, deger);


--
-- Name: ayar_firma_tipi_detay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi_detay
    ADD CONSTRAINT ayar_firma_tipi_detay_pkey PRIMARY KEY (id);


--
-- Name: ayar_firma_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi
    ADD CONSTRAINT ayar_firma_tipi_pkey PRIMARY KEY (id);


--
-- Name: ayar_firma_tipi_tip_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi
    ADD CONSTRAINT ayar_firma_tipi_tip_key UNIQUE (tip);


--
-- Name: ayar_genel_ayarlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_genel_ayarlar
    ADD CONSTRAINT ayar_genel_ayarlar_pkey PRIMARY KEY (id);


--
-- Name: ayar_genel_ayarlar_tc_no_firma_tipi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_genel_ayarlar
    ADD CONSTRAINT ayar_genel_ayarlar_tc_no_firma_tipi_key UNIQUE (tc_no, firma_tipi);


--
-- Name: ayar_genel_ayarlar_vergi_no_firma_tipi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_genel_ayarlar
    ADD CONSTRAINT ayar_genel_ayarlar_vergi_no_firma_tipi_key UNIQUE (vergi_no, firma_tipi);


--
-- Name: ayar_hane_sayisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_hane_sayisi
    ADD CONSTRAINT ayar_hane_sayisi_pkey PRIMARY KEY (id);


--
-- Name: ayar_hane_sayisi_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_hane_sayisi
    ADD CONSTRAINT ayar_hane_sayisi_ukey UNIQUE (hesap_bakiye, alis_miktar, alis_fiyat, alis_tutar, satis_miktar, satis_fiyat, satis_tutar, stok_miktar, stok_fiyat);


--
-- Name: ayar_sabit_degisken_deger_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_sabit_degisken
    ADD CONSTRAINT ayar_sabit_degisken_deger_key UNIQUE (deger);


--
-- Name: ayar_sabit_degisken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_sabit_degisken
    ADD CONSTRAINT ayar_sabit_degisken_pkey PRIMARY KEY (id);


--
-- Name: ayar_stok_hareket_tipi_deger_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareket_tipi
    ADD CONSTRAINT ayar_stok_hareket_tipi_deger_key UNIQUE (deger);


--
-- Name: ayar_stok_hareket_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareket_tipi
    ADD CONSTRAINT ayar_stok_hareket_tipi_pkey PRIMARY KEY (id);


--
-- Name: ayar_stok_hareketi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareketi
    ADD CONSTRAINT ayar_stok_hareketi_pkey PRIMARY KEY (id);


--
-- Name: ayar_teslim_sekli_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_teslim_sekli
    ADD CONSTRAINT ayar_teslim_sekli_kod_key UNIQUE (kod);


--
-- Name: ayar_teslim_sekli_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_teslim_sekli
    ADD CONSTRAINT ayar_teslim_sekli_pkey PRIMARY KEY (id);


--
-- Name: banka_adi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka
    ADD CONSTRAINT banka_adi_key UNIQUE (adi);


--
-- Name: banka_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka
    ADD CONSTRAINT banka_pkey PRIMARY KEY (id);


--
-- Name: banka_subesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka_subesi
    ADD CONSTRAINT banka_subesi_pkey PRIMARY KEY (id);


--
-- Name: bolge_bolge_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT bolge_bolge_key UNIQUE (bolge);


--
-- Name: bolge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT bolge_pkey PRIMARY KEY (id);


--
-- Name: bolge_turu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge_turu
    ADD CONSTRAINT bolge_turu_pkey PRIMARY KEY (id);


--
-- Name: bolge_turu_tur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge_turu
    ADD CONSTRAINT bolge_turu_tur_key UNIQUE (tur);


--
-- Name: efatura_vergi_kodu_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_vergi_kodu
    ADD CONSTRAINT efatura_vergi_kodu_kodu_key UNIQUE (kodu);


--
-- Name: efatura_vergi_kodu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_efatura_vergi_kodu
    ADD CONSTRAINT efatura_vergi_kodu_pkey PRIMARY KEY (id);


--
-- Name: hesap_grubu_grup_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap_grubu
    ADD CONSTRAINT hesap_grubu_grup_key UNIQUE (grup);


--
-- Name: hesap_grubu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap_grubu
    ADD CONSTRAINT hesap_grubu_pkey PRIMARY KEY (id);


--
-- Name: hesap_hesap_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT hesap_hesap_kodu_key UNIQUE (hesap_kodu);


--
-- Name: hesap_muhasebe_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT hesap_muhasebe_kodu_key UNIQUE (muhasebe_kodu);


--
-- Name: hesap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT hesap_pkey PRIMARY KEY (id);


--
-- Name: hesap_plani_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap_plani
    ADD CONSTRAINT hesap_plani_pkey PRIMARY KEY (id);


--
-- Name: hesap_plani_plan_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hesap_plani
    ADD CONSTRAINT hesap_plani_plan_kodu_key UNIQUE (plan_kodu);


--
-- Name: muhasebe_hesap_plani_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhasebe_hesap_plani
    ADD CONSTRAINT muhasebe_hesap_plani_pkey PRIMARY KEY (id);


--
-- Name: muhasebe_hesap_plani_plan_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhasebe_hesap_plani
    ADD CONSTRAINT muhasebe_hesap_plani_plan_kodu_key UNIQUE (plan_kodu);


--
-- Name: olcu_birimi_birim_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.olcu_birimi
    ADD CONSTRAINT olcu_birimi_birim_key UNIQUE (birim);


--
-- Name: olcu_birimi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.olcu_birimi
    ADD CONSTRAINT olcu_birimi_pkey PRIMARY KEY (id);


--
-- Name: para_birimi_kod_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.para_birimi
    ADD CONSTRAINT para_birimi_kod_ukey UNIQUE (kod);


--
-- Name: para_birimi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.para_birimi
    ADD CONSTRAINT para_birimi_pkey PRIMARY KEY (id);


--
-- Name: personel_ayrilma_nedeni_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi
    ADD CONSTRAINT personel_ayrilma_nedeni_tipi_pkey PRIMARY KEY (id);


--
-- Name: personel_ayrilma_nedeni_tipi_tip_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi
    ADD CONSTRAINT personel_ayrilma_nedeni_tipi_tip_key UNIQUE (tip);


--
-- Name: personel_bilgisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_bilgisi
    ADD CONSTRAINT personel_bilgisi_pkey PRIMARY KEY (id);


--
-- Name: personel_birim_bolum_id_birim_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_birim
    ADD CONSTRAINT personel_birim_bolum_id_birim_key UNIQUE (bolum_id, birim);


--
-- Name: personel_birim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_birim
    ADD CONSTRAINT personel_birim_pkey PRIMARY KEY (id);


--
-- Name: personel_bolum_bolum_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_bolum
    ADD CONSTRAINT personel_bolum_bolum_key UNIQUE (bolum);


--
-- Name: personel_bolum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_bolum
    ADD CONSTRAINT personel_bolum_pkey PRIMARY KEY (id);


--
-- Name: personel_calisma_gecmisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_calisma_gecmisi
    ADD CONSTRAINT personel_calisma_gecmisi_pkey PRIMARY KEY (id);


--
-- Name: personel_gorev_gorev_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_gorev
    ADD CONSTRAINT personel_gorev_gorev_key UNIQUE (gorev);


--
-- Name: personel_gorev_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_gorev
    ADD CONSTRAINT personel_gorev_pkey PRIMARY KEY (id);


--
-- Name: personel_servis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_tasima_servis
    ADD CONSTRAINT personel_servis_pkey PRIMARY KEY (id);


--
-- Name: personel_tasima_servis_servis_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_tasima_servis
    ADD CONSTRAINT personel_tasima_servis_servis_no_key UNIQUE (servis_no);


--
-- Name: recete_hammadde_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_pkey PRIMARY KEY (id);


--
-- Name: recete_hammadde_stok_kodu_header_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_stok_kodu_header_id_key UNIQUE (stok_kodu, header_id);


--
-- Name: recete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_pkey PRIMARY KEY (id);


--
-- Name: recete_recete_adi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_recete_adi_key UNIQUE (recete_adi);


--
-- Name: satis_fatura_detay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_fatura_detay
    ADD CONSTRAINT satis_fatura_detay_pkey PRIMARY KEY (id);


--
-- Name: satis_fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_fatura
    ADD CONSTRAINT satis_fatura_pkey PRIMARY KEY (id);


--
-- Name: satis_irsaliye_detay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_irsaliye_detay
    ADD CONSTRAINT satis_irsaliye_detay_pkey PRIMARY KEY (id);


--
-- Name: satis_irsaliye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_irsaliye
    ADD CONSTRAINT satis_irsaliye_pkey PRIMARY KEY (id);


--
-- Name: satis_siparis_detay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_siparis_detay
    ADD CONSTRAINT satis_siparis_detay_pkey PRIMARY KEY (id);


--
-- Name: satis_siparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_siparis
    ADD CONSTRAINT satis_siparis_pkey PRIMARY KEY (id);


--
-- Name: satis_teklif_detay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_teklif_detay
    ADD CONSTRAINT satis_teklif_detay_pkey PRIMARY KEY (id);


--
-- Name: satis_teklif_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_pkey PRIMARY KEY (id);


--
-- Name: sehir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_pkey PRIMARY KEY (id);


--
-- Name: sehir_sehir_adi_ulke_adi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_sehir_adi_ulke_adi_key UNIQUE (sehir_adi, ulke_adi);


--
-- Name: stok_grubu_grup_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_grubu
    ADD CONSTRAINT stok_grubu_grup_key UNIQUE (grup);


--
-- Name: stok_grubu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_grubu
    ADD CONSTRAINT stok_grubu_pkey PRIMARY KEY (id);


--
-- Name: stok_hareketi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_pkey PRIMARY KEY (id);


--
-- Name: stok_karti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_karti
    ADD CONSTRAINT stok_karti_pkey PRIMARY KEY (id);


--
-- Name: stok_karti_stok_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_karti
    ADD CONSTRAINT stok_karti_stok_kodu_key UNIQUE (stok_kodu);


--
-- Name: stok_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_pkey PRIMARY KEY (id);


--
-- Name: stok_tipi_tip_is_default_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_tip_is_default_key UNIQUE (tip, is_default);


--
-- Name: stok_tipi_tip_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_tip_key UNIQUE (tip);


--
-- Name: sys_application_settings_other_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_application_settings_other
    ADD CONSTRAINT sys_application_settings_other_pkey PRIMARY KEY (id);


--
-- Name: sys_application_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_application_settings
    ADD CONSTRAINT sys_application_settings_pkey PRIMARY KEY (id);


--
-- Name: sys_grid_col_color_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_color
    ADD CONSTRAINT sys_grid_col_color_pkey PRIMARY KEY (id);


--
-- Name: sys_grid_col_color_table_name_column_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_color
    ADD CONSTRAINT sys_grid_col_color_table_name_column_name_key UNIQUE (table_name, column_name);


--
-- Name: sys_grid_col_percent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_percent
    ADD CONSTRAINT sys_grid_col_percent_pkey PRIMARY KEY (id);


--
-- Name: sys_grid_col_percent_table_name_column_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_percent
    ADD CONSTRAINT sys_grid_col_percent_table_name_column_name_key UNIQUE (table_name, column_name);


--
-- Name: sys_grid_col_width_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_width
    ADD CONSTRAINT sys_grid_col_width_pkey PRIMARY KEY (id);


--
-- Name: sys_grid_col_width_table_name_column_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_width
    ADD CONSTRAINT sys_grid_col_width_table_name_column_name_key UNIQUE (table_name, column_name);


--
-- Name: sys_grid_col_width_table_name_sequence_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_col_width
    ADD CONSTRAINT sys_grid_col_width_table_name_sequence_no_key UNIQUE (table_name, sequence_no);


--
-- Name: sys_grid_default_order_filter_key_is_order_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_default_order_filter
    ADD CONSTRAINT sys_grid_default_order_filter_key_is_order_key UNIQUE (key, is_order);


--
-- Name: sys_grid_default_order_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grid_default_order_filter
    ADD CONSTRAINT sys_grid_default_order_filter_pkey PRIMARY KEY (id);


--
-- Name: sys_lang_contents_lang_code_content_type_table_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang_contents
    ADD CONSTRAINT sys_lang_contents_lang_code_content_type_table_name_key UNIQUE (lang, code, content_type, table_name);


--
-- Name: sys_lang_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang_contents
    ADD CONSTRAINT sys_lang_contents_pkey PRIMARY KEY (id);


--
-- Name: sys_lang_language_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang
    ADD CONSTRAINT sys_lang_language_key UNIQUE (language);


--
-- Name: sys_lang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang
    ADD CONSTRAINT sys_lang_pkey PRIMARY KEY (id);


--
-- Name: sys_permission_source_group_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source_group
    ADD CONSTRAINT sys_permission_source_group_id_pkey PRIMARY KEY (id);


--
-- Name: sys_permission_source_group_source_group_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source_group
    ADD CONSTRAINT sys_permission_source_group_source_group_ukey UNIQUE (source_group);


--
-- Name: sys_permission_source_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT sys_permission_source_pkey PRIMARY KEY (id);


--
-- Name: sys_permission_source_source_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT sys_permission_source_source_code_key UNIQUE (source_code);


--
-- Name: sys_quality_form_number_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_quality_form_number
    ADD CONSTRAINT sys_quality_form_number_pkey PRIMARY KEY (id);


--
-- Name: sys_quality_form_number_table_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_quality_form_number
    ADD CONSTRAINT sys_quality_form_number_table_name_key UNIQUE (table_name);


--
-- Name: sys_table_lang_content_lang_table_name_column_name_row_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_table_lang_content
    ADD CONSTRAINT sys_table_lang_content_lang_table_name_column_name_row_id_key UNIQUE (lang, table_name, column_name, row_id);


--
-- Name: sys_table_lang_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_table_lang_content
    ADD CONSTRAINT sys_table_lang_content_pkey PRIMARY KEY (id);


--
-- Name: sys_user_access_right_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_pkey PRIMARY KEY (id);


--
-- Name: sys_user_access_right_source_code_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_source_code_user_name_key UNIQUE (source_code, user_name);


--
-- Name: sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (id);


--
-- Name: sys_user_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_user_name_key UNIQUE (user_name);


--
-- Name: ulke_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_pkey PRIMARY KEY (id);


--
-- Name: ulke_ulke_adi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_ulke_adi_key UNIQUE (ulke_adi);


--
-- Name: ulke_ulke_kodu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_ulke_kodu_key UNIQUE (ulke_kodu);


--
-- Name: fki_stok_tipi_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_stok_tipi_id ON public.stok_karti USING btree (stok_tipi_id);


--
-- Name: sys_grid_col_width_table_notify; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sys_grid_col_width_table_notify AFTER INSERT OR DELETE OR UPDATE ON public.sys_grid_col_width FOR EACH ROW EXECUTE PROCEDURE public.table_notify();


--
-- Name: alis_teklif_detay_header_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_teklif_detay
    ADD CONSTRAINT alis_teklif_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.alis_teklif(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alis_tsif_kur_alis_teklif_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alis_tsif_kur
    ADD CONSTRAINT alis_tsif_kur_alis_teklif_id_fkey FOREIGN KEY (alis_teklif_id) REFERENCES public.alis_teklif(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ayar_firma_tipi_detay_firma_tipi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_firma_tipi_detay
    ADD CONSTRAINT ayar_firma_tipi_detay_firma_tipi_fkey FOREIGN KEY (firma_tipi) REFERENCES public.ayar_firma_tipi(tip) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ayar_stok_hareketi_cikis_ayari_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareketi
    ADD CONSTRAINT ayar_stok_hareketi_cikis_ayari_fkey FOREIGN KEY (cikis_ayari) REFERENCES public.ayar_evrak_tipi(deger) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ayar_stok_hareketi_giris_ayari_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareketi
    ADD CONSTRAINT ayar_stok_hareketi_giris_ayari_fkey FOREIGN KEY (giris_ayari) REFERENCES public.ayar_evrak_tipi(deger) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: banka_subesi_banka_adi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka_subesi
    ADD CONSTRAINT banka_subesi_banka_adi_fkey FOREIGN KEY (banka_adi) REFERENCES public.banka(adi) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bolge_bolge_turu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT bolge_bolge_turu_fkey FOREIGN KEY (bolge_turu) REFERENCES public.bolge_turu(tur) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_stok_tipi_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_karti
    ADD CONSTRAINT fk_stok_tipi_id FOREIGN KEY (stok_tipi_id) REFERENCES public.stok_tipi(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel_birim_bolum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_birim
    ADD CONSTRAINT personel_birim_bolum_id_fkey FOREIGN KEY (bolum_id) REFERENCES public.personel_bolum(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: recete_hammadde_header_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.recete(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: recete_hammadde_recete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_recete_id_fkey FOREIGN KEY (recete_id) REFERENCES public.recete(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: recete_hammadde_stok_kodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_stok_kodu_fkey FOREIGN KEY (stok_kodu) REFERENCES public.stok_karti(stok_kodu) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: recete_mamul_stok_kodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_mamul_stok_kodu_fkey FOREIGN KEY (mamul_stok_kodu) REFERENCES public.stok_karti(stok_kodu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: satis_fatura_detay_header_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_fatura_detay
    ADD CONSTRAINT satis_fatura_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_fatura(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: satis_irsaliye_detay_header_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_irsaliye_detay
    ADD CONSTRAINT satis_irsaliye_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_irsaliye(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: satis_siparis_detay_header_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_siparis_detay
    ADD CONSTRAINT satis_siparis_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_siparis(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: satis_teklif_detay_header_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satis_teklif_detay
    ADD CONSTRAINT satis_teklif_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_teklif(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sehir_ulke_adi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_ulke_adi_fkey FOREIGN KEY (ulke_adi) REFERENCES public.ulke(ulke_adi) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stok_hareketi_alan_ambar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_alan_ambar_fkey FOREIGN KEY (alan_ambar) REFERENCES public.ambar(ambar) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stok_hareketi_giris_cikis_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_giris_cikis_tip_id_fkey FOREIGN KEY (giris_cikis_tip_id) REFERENCES public.ayar_stok_hareket_tipi(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stok_hareketi_veren_ambar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_veren_ambar_fkey FOREIGN KEY (veren_ambar) REFERENCES public.ambar(ambar) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stok_tipi_tip_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_tip_fkey FOREIGN KEY (tip) REFERENCES public.stok_tipi(tip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_lang_contents_lang_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang_contents
    ADD CONSTRAINT sys_lang_contents_lang_fkey FOREIGN KEY (lang) REFERENCES public.sys_lang(language) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: sys_permission_source_sys_permission_source_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT sys_permission_source_sys_permission_source_group_fkey FOREIGN KEY (source_group_id) REFERENCES public.sys_permission_source_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user_access_right_source_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_source_code_fkey FOREIGN KEY (source_code) REFERENCES public.sys_permission_source(source_code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_user_access_right_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_user_id_fkey FOREIGN KEY (user_name) REFERENCES public.sys_user(user_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: ths_admin
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM ths_admin;
GRANT ALL ON SCHEMA public TO ths_admin;


--
-- Name: FUNCTION audit(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.audit() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.audit() FROM postgres;


--
-- Name: FUNCTION get_default_stok_tipi(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.get_default_stok_tipi() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.get_default_stok_tipi() FROM postgres;


--
-- Name: FUNCTION getdefaultparabirimi(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.getdefaultparabirimi() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.getdefaultparabirimi() FROM postgres;


--
-- Name: FUNCTION login(kullanici_adi text, pwd text, surum text, mac_adres text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) FROM postgres;


--
-- Name: FUNCTION shield(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.shield() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.shield() FROM postgres;


--
-- Name: FUNCTION table_notify(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.table_notify() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.table_notify() FROM postgres;


--
-- Name: TABLE alis_teklif; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.alis_teklif FROM PUBLIC;
REVOKE ALL ON TABLE public.alis_teklif FROM postgres;
GRANT ALL ON TABLE public.alis_teklif TO postgres;
GRANT ALL ON TABLE public.alis_teklif TO PUBLIC;


--
-- Name: TABLE alis_teklif_detay; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.alis_teklif_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.alis_teklif_detay FROM postgres;
GRANT ALL ON TABLE public.alis_teklif_detay TO postgres;
GRANT ALL ON TABLE public.alis_teklif_detay TO PUBLIC;


--
-- Name: SEQUENCE alis_teklif_detay_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.alis_teklif_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.alis_teklif_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_detay_id_seq TO PUBLIC;


--
-- Name: SEQUENCE alis_teklif_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.alis_teklif_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.alis_teklif_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_id_seq TO PUBLIC;


--
-- Name: TABLE alis_tsif_kur; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.alis_tsif_kur FROM PUBLIC;
REVOKE ALL ON TABLE public.alis_tsif_kur FROM postgres;
GRANT ALL ON TABLE public.alis_tsif_kur TO postgres;
GRANT ALL ON TABLE public.alis_tsif_kur TO PUBLIC;


--
-- Name: SEQUENCE alis_tsif_kur_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.alis_tsif_kur_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.alis_tsif_kur_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.alis_tsif_kur_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.alis_tsif_kur_id_seq TO PUBLIC;


--
-- Name: TABLE ambar; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ambar FROM PUBLIC;
REVOKE ALL ON TABLE public.ambar FROM postgres;
GRANT ALL ON TABLE public.ambar TO postgres;
GRANT ALL ON TABLE public.ambar TO PUBLIC;


--
-- Name: SEQUENCE ambar_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ambar_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ambar_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ambar_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ambar_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_iletisim_kanali; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_iletisim_kanali FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_iletisim_kanali FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_iletisim_kanali TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_iletisim_kanali TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_iletisim_kanali_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_invoice_type; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_invoice_type FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_invoice_type FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_invoice_type TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_invoice_type TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_invoice_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_invoice_type_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_invoice_type_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_invoice_type_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_invoice_type_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_istisna_kodu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_istisna_kodu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_istisna_kodu FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_istisna_kodu TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_istisna_kodu TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_istisna_kodu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_kimlik_semalari; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_kimlik_semalari FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_kimlik_semalari FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_kimlik_semalari TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_kimlik_semalari TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_kimlik_semalari_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_response_code; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_response_code FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_response_code FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_response_code TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_response_code TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_response_code_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_senaryo_tipi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_senaryo_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_senaryo_tipi FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_senaryo_tipi TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_senaryo_tipi TO PUBLIC;


--
-- Name: TABLE ayar_efatura_tevkifat_kodu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_tevkifat_kodu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_tevkifat_kodu FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_tevkifat_kodu TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_tevkifat_kodu TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_tevkifat_kodu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_efatura_vergi_kodu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_efatura_vergi_kodu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_vergi_kodu FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_vergi_kodu TO postgres;
GRANT ALL ON TABLE public.ayar_efatura_vergi_kodu TO PUBLIC;


--
-- Name: SEQUENCE ayar_efatura_vergi_kodu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_evrak_tipi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_evrak_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_evrak_tipi FROM postgres;
GRANT ALL ON TABLE public.ayar_evrak_tipi TO postgres;
GRANT ALL ON TABLE public.ayar_evrak_tipi TO PUBLIC;


--
-- Name: SEQUENCE ayar_evrak_tipi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_evrak_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_evrak_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_evrak_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_evrak_tipi_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_firma_tipi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_firma_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_firma_tipi FROM postgres;
GRANT ALL ON TABLE public.ayar_firma_tipi TO postgres;
GRANT ALL ON TABLE public.ayar_firma_tipi TO PUBLIC;


--
-- Name: TABLE ayar_firma_tipi_detay; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_firma_tipi_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_firma_tipi_detay FROM postgres;
GRANT ALL ON TABLE public.ayar_firma_tipi_detay TO postgres;
GRANT ALL ON TABLE public.ayar_firma_tipi_detay TO PUBLIC;


--
-- Name: SEQUENCE ayar_firma_tipi_detay_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_firma_tipi_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_firma_tipi_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_firma_tipi_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_firma_tipi_detay_id_seq TO PUBLIC;


--
-- Name: SEQUENCE ayar_firma_tipi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_firma_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_firma_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_firma_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_firma_tipi_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_genel_ayarlar; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_genel_ayarlar FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_genel_ayarlar FROM postgres;
GRANT ALL ON TABLE public.ayar_genel_ayarlar TO postgres;
GRANT ALL ON TABLE public.ayar_genel_ayarlar TO PUBLIC;


--
-- Name: SEQUENCE ayar_genel_ayarlar_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_sabit_degisken; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_sabit_degisken FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_sabit_degisken FROM postgres;
GRANT ALL ON TABLE public.ayar_sabit_degisken TO postgres;
GRANT ALL ON TABLE public.ayar_sabit_degisken TO PUBLIC;


--
-- Name: SEQUENCE ayar_sabit_degisken_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq TO PUBLIC;


--
-- Name: TABLE ayar_stok_hareketi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_stok_hareketi FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_stok_hareketi FROM postgres;
GRANT ALL ON TABLE public.ayar_stok_hareketi TO postgres;
GRANT ALL ON TABLE public.ayar_stok_hareketi TO PUBLIC;


--
-- Name: SEQUENCE ayar_stok_hareketi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_stok_hareketi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_stok_hareketi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_stok_hareketi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_stok_hareketi_id_seq TO PUBLIC;


--
-- Name: TABLE bolge; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.bolge FROM PUBLIC;
REVOKE ALL ON TABLE public.bolge FROM postgres;
GRANT ALL ON TABLE public.bolge TO postgres;
GRANT ALL ON TABLE public.bolge TO PUBLIC;


--
-- Name: SEQUENCE bolge_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.bolge_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.bolge_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.bolge_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.bolge_id_seq TO PUBLIC;


--
-- Name: TABLE bolge_turu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.bolge_turu FROM PUBLIC;
REVOKE ALL ON TABLE public.bolge_turu FROM postgres;
GRANT ALL ON TABLE public.bolge_turu TO postgres;
GRANT ALL ON TABLE public.bolge_turu TO PUBLIC;


--
-- Name: SEQUENCE bolge_turu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.bolge_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.bolge_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.bolge_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.bolge_turu_id_seq TO PUBLIC;


--
-- Name: TABLE hesap; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.hesap FROM PUBLIC;
REVOKE ALL ON TABLE public.hesap FROM postgres;


--
-- Name: TABLE hesap_grubu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.hesap_grubu FROM PUBLIC;
REVOKE ALL ON TABLE public.hesap_grubu FROM postgres;
GRANT ALL ON TABLE public.hesap_grubu TO postgres;
GRANT ALL ON TABLE public.hesap_grubu TO PUBLIC;


--
-- Name: SEQUENCE hesap_grubu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.hesap_grubu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.hesap_grubu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.hesap_grubu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.hesap_grubu_id_seq TO PUBLIC;


--
-- Name: SEQUENCE hesap_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.hesap_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.hesap_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.hesap_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.hesap_id_seq TO PUBLIC;


--
-- Name: TABLE hesap_plani; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.hesap_plani FROM PUBLIC;
REVOKE ALL ON TABLE public.hesap_plani FROM postgres;
GRANT ALL ON TABLE public.hesap_plani TO postgres;
GRANT ALL ON TABLE public.hesap_plani TO PUBLIC;


--
-- Name: SEQUENCE hesap_plani_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.hesap_plani_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.hesap_plani_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.hesap_plani_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.hesap_plani_id_seq TO PUBLIC;


--
-- Name: TABLE muhasebe_hesap_plani; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.muhasebe_hesap_plani FROM PUBLIC;
REVOKE ALL ON TABLE public.muhasebe_hesap_plani FROM postgres;
GRANT ALL ON TABLE public.muhasebe_hesap_plani TO postgres;
GRANT ALL ON TABLE public.muhasebe_hesap_plani TO PUBLIC;


--
-- Name: SEQUENCE muhasebe_hesap_plani_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq TO PUBLIC;


--
-- Name: TABLE olcu_birimi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.olcu_birimi FROM PUBLIC;
REVOKE ALL ON TABLE public.olcu_birimi FROM postgres;
GRANT ALL ON TABLE public.olcu_birimi TO postgres;
GRANT ALL ON TABLE public.olcu_birimi TO PUBLIC;


--
-- Name: SEQUENCE olcu_birimi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.olcu_birimi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.olcu_birimi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.olcu_birimi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.olcu_birimi_id_seq TO PUBLIC;


--
-- Name: TABLE para_birimi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.para_birimi FROM PUBLIC;
REVOKE ALL ON TABLE public.para_birimi FROM postgres;
GRANT ALL ON TABLE public.para_birimi TO postgres;
GRANT ALL ON TABLE public.para_birimi TO PUBLIC;


--
-- Name: TABLE personel_ayrilma_nedeni_tipi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_ayrilma_nedeni_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_ayrilma_nedeni_tipi FROM postgres;
GRANT ALL ON TABLE public.personel_ayrilma_nedeni_tipi TO postgres;
GRANT ALL ON TABLE public.personel_ayrilma_nedeni_tipi TO PUBLIC;


--
-- Name: SEQUENCE personel_ayrilma_nedeni_tipi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq TO PUBLIC;


--
-- Name: TABLE personel_bilgisi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_bilgisi FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_bilgisi FROM postgres;
GRANT ALL ON TABLE public.personel_bilgisi TO postgres;
GRANT ALL ON TABLE public.personel_bilgisi TO elektromed_admin;
GRANT ALL ON TABLE public.personel_bilgisi TO PUBLIC;
GRANT ALL ON TABLE public.personel_bilgisi TO guest;


--
-- Name: SEQUENCE personel_bilgisi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_bilgisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_bilgisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_bilgisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_bilgisi_id_seq TO PUBLIC;


--
-- Name: TABLE personel_birim; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_birim FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_birim FROM postgres;
GRANT ALL ON TABLE public.personel_birim TO postgres;
GRANT ALL ON TABLE public.personel_birim TO PUBLIC;


--
-- Name: SEQUENCE personel_birim_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_birim_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_birim_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_birim_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_birim_id_seq TO PUBLIC;


--
-- Name: TABLE personel_bolum; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_bolum FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_bolum FROM postgres;
GRANT ALL ON TABLE public.personel_bolum TO postgres;
GRANT ALL ON TABLE public.personel_bolum TO PUBLIC;


--
-- Name: SEQUENCE personel_bolum_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_bolum_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_bolum_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_bolum_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_bolum_id_seq TO PUBLIC;


--
-- Name: TABLE personel_calisma_gecmisi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_calisma_gecmisi FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_calisma_gecmisi FROM postgres;
GRANT ALL ON TABLE public.personel_calisma_gecmisi TO postgres;
GRANT ALL ON TABLE public.personel_calisma_gecmisi TO elektromed_admin;
GRANT ALL ON TABLE public.personel_calisma_gecmisi TO PUBLIC;
GRANT ALL ON TABLE public.personel_calisma_gecmisi TO guest;


--
-- Name: SEQUENCE personel_calisma_gecmisi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq TO PUBLIC;


--
-- Name: TABLE personel_gorev; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_gorev FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_gorev FROM postgres;
GRANT ALL ON TABLE public.personel_gorev TO postgres;
GRANT ALL ON TABLE public.personel_gorev TO PUBLIC;


--
-- Name: SEQUENCE personel_gorev_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_gorev_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_gorev_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_gorev_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_gorev_id_seq TO PUBLIC;


--
-- Name: TABLE personel_tasima_servis; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.personel_tasima_servis FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_tasima_servis FROM postgres;
GRANT ALL ON TABLE public.personel_tasima_servis TO postgres;
GRANT ALL ON TABLE public.personel_tasima_servis TO PUBLIC;


--
-- Name: SEQUENCE personel_tasima_servis_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.personel_tasima_servis_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_tasima_servis_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_tasima_servis_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_tasima_servis_id_seq TO PUBLIC;


--
-- Name: TABLE recete; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.recete FROM PUBLIC;
REVOKE ALL ON TABLE public.recete FROM postgres;
GRANT ALL ON TABLE public.recete TO postgres;
GRANT ALL ON TABLE public.recete TO PUBLIC;


--
-- Name: TABLE recete_hammadde; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.recete_hammadde FROM PUBLIC;
REVOKE ALL ON TABLE public.recete_hammadde FROM postgres;
GRANT ALL ON TABLE public.recete_hammadde TO postgres;
GRANT ALL ON TABLE public.recete_hammadde TO PUBLIC;


--
-- Name: SEQUENCE recete_hammadde_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.recete_hammadde_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.recete_hammadde_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.recete_hammadde_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.recete_hammadde_id_seq TO PUBLIC;


--
-- Name: SEQUENCE recete_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.recete_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.recete_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.recete_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.recete_id_seq TO PUBLIC;


--
-- Name: TABLE satis_fatura; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_fatura FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_fatura FROM postgres;
GRANT ALL ON TABLE public.satis_fatura TO postgres;
GRANT ALL ON TABLE public.satis_fatura TO PUBLIC;


--
-- Name: TABLE satis_fatura_detay; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_fatura_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_fatura_detay FROM postgres;
GRANT ALL ON TABLE public.satis_fatura_detay TO postgres;
GRANT ALL ON TABLE public.satis_fatura_detay TO PUBLIC;


--
-- Name: SEQUENCE satis_fatura_detay_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_fatura_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_fatura_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_detay_id_seq TO PUBLIC;


--
-- Name: SEQUENCE satis_fatura_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_fatura_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_fatura_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_id_seq TO PUBLIC;


--
-- Name: TABLE satis_irsaliye; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_irsaliye FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_irsaliye FROM postgres;
GRANT ALL ON TABLE public.satis_irsaliye TO postgres;
GRANT ALL ON TABLE public.satis_irsaliye TO PUBLIC;


--
-- Name: TABLE satis_irsaliye_detay; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_irsaliye_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_irsaliye_detay FROM postgres;
GRANT ALL ON TABLE public.satis_irsaliye_detay TO postgres;
GRANT ALL ON TABLE public.satis_irsaliye_detay TO PUBLIC;


--
-- Name: SEQUENCE satis_irsaliye_detay_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq TO PUBLIC;


--
-- Name: SEQUENCE satis_irsaliye_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_irsaliye_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_irsaliye_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_id_seq TO PUBLIC;


--
-- Name: TABLE satis_siparis; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_siparis FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_siparis FROM postgres;
GRANT ALL ON TABLE public.satis_siparis TO postgres;
GRANT ALL ON TABLE public.satis_siparis TO PUBLIC;


--
-- Name: TABLE satis_siparis_detay; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_siparis_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_siparis_detay FROM postgres;
GRANT ALL ON TABLE public.satis_siparis_detay TO postgres;
GRANT ALL ON TABLE public.satis_siparis_detay TO PUBLIC;


--
-- Name: SEQUENCE satis_siparis_detay_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_siparis_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_siparis_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_detay_id_seq TO PUBLIC;


--
-- Name: SEQUENCE satis_siparis_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_siparis_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_siparis_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_id_seq TO PUBLIC;


--
-- Name: TABLE satis_teklif; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_teklif FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_teklif FROM postgres;
GRANT ALL ON TABLE public.satis_teklif TO postgres;
GRANT ALL ON TABLE public.satis_teklif TO PUBLIC;


--
-- Name: TABLE satis_teklif_detay; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.satis_teklif_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_teklif_detay FROM postgres;
GRANT ALL ON TABLE public.satis_teklif_detay TO postgres;
GRANT ALL ON TABLE public.satis_teklif_detay TO PUBLIC;


--
-- Name: SEQUENCE satis_teklif_detay_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_teklif_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_teklif_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_teklif_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_teklif_detay_id_seq TO PUBLIC;


--
-- Name: SEQUENCE satis_teklif_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.satis_teklif_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_teklif_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_teklif_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_teklif_id_seq TO PUBLIC;


--
-- Name: TABLE sehir; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sehir FROM PUBLIC;
REVOKE ALL ON TABLE public.sehir FROM postgres;
GRANT ALL ON TABLE public.sehir TO postgres;


--
-- Name: TABLE stok_grubu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.stok_grubu FROM PUBLIC;
REVOKE ALL ON TABLE public.stok_grubu FROM postgres;
GRANT ALL ON TABLE public.stok_grubu TO postgres;
GRANT ALL ON TABLE public.stok_grubu TO PUBLIC;


--
-- Name: SEQUENCE stok_grubu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.stok_grubu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_grubu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_grubu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_grubu_id_seq TO PUBLIC;


--
-- Name: TABLE stok_karti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.stok_karti FROM PUBLIC;
REVOKE ALL ON TABLE public.stok_karti FROM postgres;
GRANT ALL ON TABLE public.stok_karti TO postgres;
GRANT ALL ON TABLE public.stok_karti TO PUBLIC;


--
-- Name: SEQUENCE stok_karti_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.stok_karti_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_karti_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_karti_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_karti_id_seq TO PUBLIC;


--
-- Name: TABLE stok_tipi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.stok_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.stok_tipi FROM postgres;
GRANT ALL ON TABLE public.stok_tipi TO postgres;
GRANT ALL ON TABLE public.stok_tipi TO PUBLIC;


--
-- Name: SEQUENCE stok_tipi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.stok_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_tipi_id_seq TO PUBLIC;


--
-- Name: TABLE sys_grid_col_color; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_grid_col_color FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_grid_col_color FROM postgres;
GRANT ALL ON TABLE public.sys_grid_col_color TO postgres;
GRANT ALL ON TABLE public.sys_grid_col_color TO PUBLIC;


--
-- Name: TABLE sys_grid_col_percent; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_grid_col_percent FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_grid_col_percent FROM postgres;
GRANT ALL ON TABLE public.sys_grid_col_percent TO postgres;
GRANT ALL ON TABLE public.sys_grid_col_percent TO PUBLIC;


--
-- Name: TABLE sys_grid_col_width; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_grid_col_width FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_grid_col_width FROM postgres;
GRANT ALL ON TABLE public.sys_grid_col_width TO postgres;
GRANT ALL ON TABLE public.sys_grid_col_width TO PUBLIC;


--
-- Name: TABLE sys_lang; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_lang FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_lang FROM postgres;
GRANT ALL ON TABLE public.sys_lang TO postgres;
GRANT ALL ON TABLE public.sys_lang TO PUBLIC;


--
-- Name: TABLE sys_lang_contents; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_lang_contents FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_lang_contents FROM postgres;
GRANT ALL ON TABLE public.sys_lang_contents TO postgres;
GRANT ALL ON TABLE public.sys_lang_contents TO PUBLIC;


--
-- Name: SEQUENCE sys_lang_contents_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sys_lang_contents_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_lang_contents_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_lang_contents_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_lang_contents_id_seq TO PUBLIC;


--
-- Name: SEQUENCE sys_lang_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sys_lang_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_lang_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_lang_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_lang_id_seq TO PUBLIC;


--
-- Name: TABLE sys_permission_source; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_permission_source FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_permission_source FROM postgres;
GRANT ALL ON TABLE public.sys_permission_source TO postgres;
GRANT ALL ON TABLE public.sys_permission_source TO PUBLIC;


--
-- Name: TABLE sys_permission_source_group; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_permission_source_group FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_permission_source_group FROM postgres;
GRANT ALL ON TABLE public.sys_permission_source_group TO postgres;
GRANT ALL ON TABLE public.sys_permission_source_group TO PUBLIC;


--
-- Name: SEQUENCE sys_permission_source_group_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sys_permission_source_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_permission_source_group_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_group_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_group_id_seq TO PUBLIC;


--
-- Name: SEQUENCE sys_permission_source_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sys_permission_source_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_permission_source_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_id_seq TO PUBLIC;


--
-- Name: TABLE sys_user; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_user FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_user FROM postgres;
GRANT ALL ON TABLE public.sys_user TO postgres;
GRANT SELECT ON TABLE public.sys_user TO guest;
GRANT ALL ON TABLE public.sys_user TO elektromed_admin;
GRANT ALL ON TABLE public.sys_user TO PUBLIC;


--
-- Name: TABLE sys_user_access_right; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.sys_user_access_right FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_user_access_right FROM postgres;
GRANT ALL ON TABLE public.sys_user_access_right TO postgres;
GRANT ALL ON TABLE public.sys_user_access_right TO PUBLIC;


--
-- Name: SEQUENCE sys_user_access_right_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sys_user_access_right_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_user_access_right_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_user_access_right_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_user_access_right_id_seq TO PUBLIC;


--
-- Name: SEQUENCE sys_user_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sys_user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_user_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_user_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_user_id_seq TO PUBLIC;


--
-- Name: TABLE ulke; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ulke FROM PUBLIC;
REVOKE ALL ON TABLE public.ulke FROM postgres;
GRANT ALL ON TABLE public.ulke TO postgres;


--
-- PostgreSQL database dump complete
--

