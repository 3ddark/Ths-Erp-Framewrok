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
    tip character varying(32),
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
-- Name: ayar_ondalik_hane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayar_ondalik_hane (
    id integer NOT NULL,
    validity boolean DEFAULT true,
    hesap_bakiye integer DEFAULT 2,
    alim_miktar integer DEFAULT 2,
    alim_fiyat integer DEFAULT 2,
    alim_tutar integer DEFAULT 2,
    satim_miktar integer DEFAULT 2,
    satim_fiyat integer DEFAULT 2,
    satim_tutar integer DEFAULT 2,
    stok_miktar integer DEFAULT 2,
    stok_fiyat integer DEFAULT 2
);


ALTER TABLE public.ayar_ondalik_hane OWNER TO postgres;

--
-- Name: ayar_ondalik_hane_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayar_ondalik_hane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayar_ondalik_hane_id_seq OWNER TO postgres;

--
-- Name: ayar_ondalik_hane_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayar_ondalik_hane_id_seq OWNED BY public.ayar_ondalik_hane.id;


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
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    city_name character varying(32) NOT NULL,
    country_name character varying(128) NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_id_seq OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    country_code character varying(2),
    country_name character varying(128),
    iso_year integer,
    iso_cctld_code character varying(3)
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- Name: currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency (
    id integer NOT NULL,
    code character varying(3) NOT NULL,
    symbol character varying(3) NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    code_comment character varying(128)
);


ALTER TABLE public.currency OWNER TO postgres;

--
-- Name: currency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.currency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currency_id_seq OWNER TO postgres;

--
-- Name: currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.currency_id_seq OWNED BY public.currency.id;


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
    stok_kodu character varying(32),
    miktar double precision,
    tutar double precision,
    alan_ambar character varying(32),
    veren_ambar character varying(32),
    tarih timestamp without time zone
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
-- Name: sys_grid_col_color; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_grid_col_color (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying,
    column_name character varying,
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
    table_name character varying,
    column_name character varying,
    column_width integer DEFAULT 0 NOT NULL,
    sequence_no integer NOT NULL
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
    lang character varying(16),
    code character varying(64),
    value text,
    is_factory_settings boolean DEFAULT false NOT NULL
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
    mac_address character varying(32)
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
-- Name: view_tables; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_tables AS
 SELECT tables.table_name
   FROM information_schema.tables
  WHERE (((tables.table_schema)::text = 'public'::text) AND ((tables.table_type)::text = 'BASE TABLE'::text))
  ORDER BY tables.table_name;


ALTER TABLE public.view_tables OWNER TO postgres;

--
-- Name: sys_view_columns; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sys_view_columns AS
 SELECT columns.table_name,
    columns.column_name,
    columns.is_nullable,
    columns.data_type,
    columns.character_maximum_length
   FROM information_schema.columns
  WHERE ((columns.table_name)::text IN ( SELECT view_tables.table_name
           FROM public.view_tables))
  ORDER BY columns.table_name, columns.ordinal_position;


ALTER TABLE public.sys_view_columns OWNER TO postgres;

--
-- Name: view_databases; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_databases AS
 SELECT pg_database.datname AS database_name,
    pg_shdescription.description AS aciklama
   FROM (pg_shdescription
     JOIN pg_database ON ((pg_shdescription.objoid = pg_database.oid)))
  WHERE ((1 = 1) AND (pg_shdescription.description = 'THS ERP Systems'::text));


ALTER TABLE public.view_databases OWNER TO postgres;

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

ALTER TABLE ONLY public.ayar_ondalik_hane ALTER COLUMN id SET DEFAULT nextval('public.ayar_ondalik_hane_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_sabit_degisken ALTER COLUMN id SET DEFAULT nextval('public.ayar_sabit_degisken_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareketi ALTER COLUMN id SET DEFAULT nextval('public.ayar_stok_hareketi_id_seq'::regclass);


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

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency ALTER COLUMN id SET DEFAULT nextval('public.currency_id_seq'::regclass);


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

ALTER TABLE ONLY public.sys_user ALTER COLUMN id SET DEFAULT nextval('public.sys_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right ALTER COLUMN id SET DEFAULT nextval('public.sys_user_access_right_id_seq'::regclass);


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
2	t	TEMELFATURA	TEMEL FATURA SÜRECİNİ BELİRTİR
3	t	TICARIFATURA	TİCARİ FATURA SÜRECİNİ BELİRTİR
1	t	TEMELIRSALIYE	TEMEL İRSALİYE SÜRECİNİ BELİRTİR
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
-- Data for Name: ayar_ondalik_hane; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayar_ondalik_hane (id, validity, hesap_bakiye, alim_miktar, alim_fiyat, alim_tutar, satim_miktar, satim_fiyat, satim_tutar, stok_miktar, stok_fiyat) FROM stdin;
1	t	2	6	6	2	2	2	2	4	6
\.


--
-- Name: ayar_ondalik_hane_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayar_ondalik_hane_id_seq', 1, true);


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
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, validity, city_name, country_name) FROM stdin;
1	t	İSTANBUL	TÜRKİYE
6	t	ANKARA	TÜRKİYE
3	t	FRANKFURT	ALMANYA
2	t	ÇANKIRI	TÜRKİYE
5	t	İZMİR	TÜRKİYE
8	t	ADANA	TÜRKİYE
\.


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_id_seq', 8, true);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (id, validity, country_code, country_name, iso_year, iso_cctld_code) FROM stdin;
7	t	JP	JAPONYA	1970	.jp
2	t	RU	RUSYA	1974	.ru
6	t	DE	ALMANYA	1974	.de
8	t	CZ	ÇEK CUMHURİYETİ	1986	.CZ
1	t	TR	TÜRKİYE	3500	.TR
\.


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 9, true);


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency (id, code, symbol, is_default, code_comment) FROM stdin;
3	EUR	€	f	AVRUPA BİRLİĞİ PARA BİRİMİ
2	USD	$	f	AMERİKAN DOLARI
1	YTL	₺	t	YENİ TÜRK LİRASI
\.


--
-- Name: currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.currency_id_seq', 5, true);


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

COPY public.stok_hareketi (id, validity, stok_kodu, miktar, tutar, alan_ambar, veren_ambar, tarih) FROM stdin;
\.


--
-- Name: stok_hareketi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stok_hareketi_id_seq', 1, false);


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
-- Data for Name: sys_grid_col_color; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_col_color (id, validity, table_name, column_name, min_value, min_color, max_value, max_color) FROM stdin;
1	t	city	id	3	10999495	7	3087082
\.


--
-- Name: sys_grid_col_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_col_color_id_seq', 2, true);


--
-- Data for Name: sys_grid_col_percent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_col_percent (id, validity, table_name, column_name, max_value, color_bar, color_bar_back, color_bar_text, color_bar_text_active) FROM stdin;
1	t	country	iso_year	5000	3087082	11002236	15234780	235968
\.


--
-- Name: sys_grid_col_percent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_col_percent_id_seq', 1, true);


--
-- Data for Name: sys_grid_col_width; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_grid_col_width (id, validity, table_name, column_name, column_width, sequence_no) FROM stdin;
3	t	country	country_code	100	1
4	t	country	country_name	100	2
5	t	country	iso_year	100	3
7	t	currency	code	100	1
8	t	currency	symbol	100	2
9	t	currency	is_default	100	3
10	t	currency	code_comment	250	4
13	t	sys_permission_source	source_code	100	1
15	t	sys_permission_source	source_name	100	2
19	t	sys_permission_source	source_group	100	3
20	t	sys_user_access_right	source_code	100	1
21	t	sys_user_access_right	is_read	90	2
22	t	sys_user_access_right	is_add_record	90	3
23	t	sys_user_access_right	is_update	90	4
24	t	sys_user_access_right	is_delete	90	5
25	t	sys_user_access_right	is_special	90	6
26	t	sys_user_access_right	user_name	90	7
1	t	city	city_name	150	1
2	t	city	country_name	200	2
6	t	country	iso_cctld_code	100	4
12	t	sys_permission_source_group	source_group	350	1
\.


--
-- Name: sys_grid_col_width_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grid_col_width_id_seq', 26, true);


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

COPY public.sys_lang_contents (id, validity, lang, code, value, is_factory_settings) FROM stdin;
73	t	Türkçe TR	POPUP EXCEL	Excel Kaydet	t
53	t	Türkçe TR	MESAJ UYGULAMA KAPATMA	Program sonlandırılacak. Programı kapatmak istediğinden emin misin?	t
75	t	Türkçe TR	GridFieldCaption.currency.code	KOD	f
76	t	Türkçe TR	GridFieldCaption.currency.symbol	SEMBOL	f
80	t	Türkçe TR	LabelCaption.Input.currency.code_comment	Kod Açıklama	f
82	t	Türkçe TR	LabelCaption.Input.currency.symbol	Sembol	f
71	t	Türkçe TR	LabelCaption.Input.city.country_name	Ülke Adı	f
81	t	Türkçe TR	LabelCaption.Input.currency.is_default	Varsayılan	f
87	t	Türkçe TR	FormCaption.Input.currency	Para Birimi	f
89	t	Türkçe TR	FormCaption.Output.currency	Para Birimleri	f
78	t	Türkçe TR	GridFieldCaption.currency.code_comment	KOD AÇIKLAMA	f
77	t	Türkçe TR	GridFieldCaption.currency.is_default	VARSAYILAN?	f
95	t	Türkçe TR	GridFieldCaption.country.country_code	ÜLKE KODU	f
97	t	Türkçe TR	LabelCaption.Input.country.country_code	Ülke Kodu	f
102	t	Türkçe TR	ButonCaption.Main.currency	PARA BİRİMLERİ	f
106	t	Türkçe TR	ButonCaption.Main.permissionsourcegroup	ERİŞİM HAKKI GRUBU	f
108	t	Türkçe TR	ButonCaption.Main.permissionsource	ERİŞİM HAKKI	f
110	t	Türkçe TR	ButonCaption.Main.useraccessright	KULLANICI ERİŞİM HAKKI	f
104	t	Türkçe TR	ButonCaption.Main.country	ÜLKELER	f
2	t	English EN	İŞLEM ONAYI BÜYÜK	CONFIRMATION	t
4	t	English EN	MESAJ KAYIT SİL	Are you sure you want to delete record?	t
6	t	English EN	MESAJ KAYIT GÜNCELLE	Are you sure you want to update record?	t
8	t	English EN	UYARI AKTİF TRANSACTION	There is an active transaction. Complete it first!	t
10	t	English EN	MANTIK EVET BÜYÜK	YES	t
12	t	English EN	MANTIK HAYIR BÜYÜK	NO	t
14	t	English EN	MANTIK EVET KÜÇÜK	Yes	t
16	t	English EN	MANTIK HAYIR KÜÇÜK	No	t
18	t	English EN	UYARI KİLİTLİ KAYIT	The record is locked by another user. Try again later.	t
20	t	English EN	HATA KAYIT SİLİNMİŞ	The record was deleted by another user while you were on the review screen.	t
22	t	English EN	BUTON KAPAT	CLOSE	t
24	t	English EN	BAR SİL	DELETE	t
26	t	English EN	BAR ONAY	CONFIRM	t
28	t	English EN	BAR İPTAL	CANCEL/CLOSE	t
30	t	English EN	BAR EKLE	ADD RECORD	t
32	t	English EN	HATA ZORUNLU ALAN	Can\\'t be empty required input controls!	t
34	t	English EN	HATA KIRMIZI ZORUNLU	Red colored controls are required	t
36	t	English EN	MESAJ İŞLEM İPTAL	Are you sure you want to exit?   All changes will be canceled!!!	t
38	t	English EN	İŞLEM ONAYI KÜÇÜK	Confirmation	t
40	t	English EN	BUTON GÜNCELLE	UPDATE	t
42	t	English EN	BUTON SİL	DELETE	t
44	t	English EN	BUTON İPTAL	CANCEL	t
48	t	English EN	HATA KAYIT SİLİNMİŞ MESAJ	Check the current records again!	t
113	t	Türkçe TR	MESAJ DESTEKLENMEYEN İŞLEM	Desteklenmeyen işlem!	t
114	t	English EN	MESAJ DESTEKLENMEYEN İŞLEM	Unsuopperted process!	t
1	t	Türkçe TR	İŞLEM ONAYI BÜYÜK	İŞLEM ONAYI	t
3	t	Türkçe TR	MESAJ KAYIT SİL	Kaydı silmek istediğinden emin misin?	t
5	t	Türkçe TR	MESAJ KAYIT GÜNCELLE	Kaydı güncellemek istediğinizden emin misin?	t
7	t	Türkçe TR	UYARI AKTİF TRANSACTION	Aktif bir transaction var. Önce onu tamamlayın!	t
9	t	Türkçe TR	MANTIK EVET BÜYÜK	EVET	t
11	t	Türkçe TR	MANTIK HAYIR BÜYÜK	HAYIR	t
13	t	Türkçe TR	MANTIK EVET KÜÇÜK	Evet	t
15	t	Türkçe TR	MANTIK HAYIR KÜÇÜK	Hayır	t
17	t	Türkçe TR	UYARI KİLİTLİ KAYIT	Kayıt başka kullanıcı tarafından kilitlendir. Daha sonra tekrar deneyin.	t
19	t	Türkçe TR	HATA KAYIT SİLİNMİŞ	Siz inceleme ekranındayken kayıt başka kullanıcı tarafından silinmiş.	t
21	t	Türkçe TR	BUTON KAPAT	KAPAT	t
23	t	Türkçe TR	BAR SİL	SİL	t
25	t	Türkçe TR	BAR ONAY	ONAY	t
27	t	Türkçe TR	BAR İPTAL	İPTAL/KAPAT	t
29	t	Türkçe TR	BAR EKLE	KAYIT EKLE	t
31	t	Türkçe TR	HATA ZORUNLU ALAN	Zorunlu alanlar boş bırakılamaz!	t
33	t	Türkçe TR	HATA KIRMIZI ZORUNLU	Kırmızı renkli girişler zorunlu bilgiler.	t
35	t	Türkçe TR	MESAJ İŞLEM İPTAL	Çıkmak istediğinden emin misin?  Tüm değişiklkler iptal olacak!!!	t
37	t	Türkçe TR	İŞLEM ONAYI KÜÇÜK	İşlem Onayı	t
39	t	Türkçe TR	BUTON GÜNCELLE	GÜNCELLE	t
41	t	Türkçe TR	BUTON SİL	SİL	t
43	t	Türkçe TR	BUTON İPTAL	İPTAL	t
47	t	Türkçe TR	HATA KAYIT SİLİNMİŞ MESAJ	Kayıtları tekrar kontrol edin!	t
49	t	Türkçe TR	BUTON ONAY	ONAYLA	t
51	t	Türkçe TR	HATA ERİŞİM HAKKI	Erişim hakkı hatası!!!	t
79	t	Türkçe TR	LabelCaption.Input.currency.code	Kod	f
100	t	Türkçe TR	ButonCaption.Main.city	ŞEHİRLER	f
55	t	Türkçe TR	BUTON EKLE	KAYIT EKLE	t
61	t	Türkçe TR	FormCaption.Input.city	Şehir	f
63	t	Türkçe TR	FormCaption.Output.city	Şehirler	f
65	t	Türkçe TR	GridFieldCaption.city.city_name	ŞEHİR ADI	f
67	t	Türkçe TR	GridFieldCaption.city.country_name	ÜLKE ADI	f
69	t	Türkçe TR	LabelCaption.Input.city.city_name	Şehir Adı	f
57	t	Türkçe TR	POPUP İNCELE	İncele	t
101	t	English EN	ButonCaption.Main.city	CITIES	f
103	t	English EN	ButonCaption.Main.currency	CURRENCIES	f
105	t	English EN	ButonCaption.Main.country	COUNTRIES	f
107	t	English EN	ButonCaption.Main.permissionsourcegroup	PERMISSION SOURCE GROUP	f
109	t	English EN	ButonCaption.Main.permissionsource	PERMISSION SOURCE	f
111	t	English EN	ButonCaption.Main.useraccessright	USER ACCESS RIGHT	f
50	t	English EN	BUTON ONAY	CONFIRM	t
52	t	English EN	HATA ERİŞİM HAKKI	Access right failure!	t
70	t	English EN	LabelCaption.Input.city.city_name	City Name	f
56	t	English EN	BUTON EKLE	ADD RECORD	t
64	t	English EN	FormCaption.Output.city	Cities	f
62	t	English EN	FormCaption.Input.city	City	f
66	t	English EN	GridFieldCaption.city.city_name	CITY NAME	f
68	t	English EN	GridFieldCaption.city.country_name	COUNTRY NAME	f
86	t	English EN	LabelCaption.Input.currency.symbol	Symbol	f
58	t	English EN	POPUP İNCELE	Preview	t
74	t	English EN	POPUP EXCEL	Export Excel	t
54	t	English EN	MESAJ UYGULAMA KAPATMA	Application terminated. Are you sure you want close application?	t
72	t	English EN	LabelCaption.Input.city.country_name	Country Name	f
83	t	English EN	LabelCaption.Input.currency.code	Code	f
84	t	English EN	LabelCaption.Input.currency.code_comment	Code Comment	f
85	t	English EN	LabelCaption.Input.currency.is_default	Default	f
88	t	English EN	FormCaption.Input.currency	Curreny	f
90	t	English EN	FormCaption.Output.currency	Currencies	f
91	t	English EN	GridFieldCaption.currency.code	CODE	f
92	t	English EN	GridFieldCaption.currency.code_comment	CODE COMMENT	f
93	t	English EN	GridFieldCaption.currency.is_default	DEFAULT?	f
94	t	English EN	GridFieldCaption.currency.symbol	SYMBOL	f
96	t	English EN	GridFieldCaption.country.country_code	COUNTRY CODE	f
115	t	Türkçe TR	HATA VERİ TABANI BAĞLANTISI	Veri tabanı ile bağlantı kurulamadı!	t
116	t	English EN	HATA VERİ TABANI BAĞLANTISI	Failed to connect to database!	t
119	t	Türkçe TR	HATA KULLANICI ADI	Kullanıcı Adı/Şifre tanımlı değil veya doğru değil!	t
122	t	Türkçe TR	LabelCaption.Input.login.language	Dil	f
123	t	Türkçe TR	LabelCaption.Input.login.password	Şifre	f
121	t	Türkçe TR	LabelCaption.Input.login.username	Kullanıcı Adı	f
126	t	Türkçe TR	LabelCaption.Input.login.database	Veri Tabanı Adı	f
127	t	English EN	LabelCaption.Input.login.database	Database Name	f
130	t	English EN	LabelCaption.Input.login.language	Language	f
131	t	English EN	LabelCaption.Input.login.password	Password	f
132	t	English EN	LabelCaption.Input.login.server	Server Address	f
124	t	Türkçe TR	LabelCaption.Input.login.server	Sunucu Adres	f
134	t	English EN	LabelCaption.Input.login.username	Username	f
120	t	English EN	HATA KULLANICI ADI	Username/Password not defined or correct!	t
139	t	Türkçe TR	FormCaption.Input.login	Giriş	f
140	t	English EN	FormCaption.Input.login	Login	f
135	t	Türkçe TR	LabelCaption.Input.login.portno	Port Numarası	f
136	t	English EN	LabelCaption.Input.login.portno	Port Number	f
137	t	Türkçe TR	LabelCaption.Input.login.savesettings	Ayarları Kaydet	f
138	t	English EN	LabelCaption.Input.login.savesettings	Save Settings	f
125	t	Türkçe TR	LabelCaption.Input.login.serverexample	Sunucu Örnek: 192.168.1.100 / localhost / 127.0.0.1	f
133	t	English EN	LabelCaption.Input.login.serverexample	Server Example: 192.168.1.100 / localhost / 127.0.0.1	f
\.


--
-- Name: sys_lang_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_lang_contents_id_seq', 140, true);


--
-- Name: sys_lang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_lang_id_seq', 3, true);


--
-- Data for Name: sys_permission_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission_source (id, validity, source_code, source_name, source_group_id) FROM stdin;
2	t	1002	COUNTRY	2
4	t	1000	SETTINGS	1
1	t	1001	CURRENCY	2
7	t	1003	CITY	1
\.


--
-- Data for Name: sys_permission_source_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission_source_group (id, validity, source_group) FROM stdin;
3	t	STOK
4	t	DİĞER
2	t	GENEL
1	t	AYARLAR
\.


--
-- Name: sys_permission_source_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_source_group_id_seq', 4, true);


--
-- Name: sys_permission_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_source_id_seq', 8, true);


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user (id, validity, user_name, user_password, is_admin, is_active_user, is_online, app_version, db_version, ip_address, mac_address) FROM stdin;
1	t	FERHAT	1	t	t	f	1	1	127.0.0.1	\N
\.


--
-- Data for Name: sys_user_access_right; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user_access_right (id, validity, source_code, is_read, is_add_record, is_update, is_delete, is_special, user_name) FROM stdin;
3	t	1001	t	t	t	t	t	FERHAT
4	t	1000	t	t	t	t	t	FERHAT
5	t	1003	t	t	t	t	t	FERHAT
1	t	1002	t	t	t	t	t	FERHAT
\.


--
-- Name: sys_user_access_right_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_access_right_id_seq', 5, true);


--
-- Name: sys_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_id_seq', 1, true);


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
-- Name: ayar_ondalik_hane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_ondalik_hane
    ADD CONSTRAINT ayar_ondalik_hane_pkey PRIMARY KEY (id);


--
-- Name: ayar_ondalik_hane_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_ondalik_hane
    ADD CONSTRAINT ayar_ondalik_hane_ukey UNIQUE (hesap_bakiye, alim_miktar, alim_fiyat, alim_tutar, satim_miktar, satim_fiyat, satim_tutar, stok_miktar, stok_fiyat);


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
-- Name: ayar_stok_hareketi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayar_stok_hareketi
    ADD CONSTRAINT ayar_stok_hareketi_pkey PRIMARY KEY (id);


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
-- Name: city_city_name_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_country_name_key UNIQUE (city_name, country_name);


--
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: country_country_code_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_code_ukey UNIQUE (country_code);


--
-- Name: country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: currency_code_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_code_ukey UNIQUE (code);


--
-- Name: currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);


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
-- Name: source_code_source_name_source_group_id_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT source_code_source_name_source_group_id_ukey UNIQUE (source_code, source_name, source_group_id);


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
-- Name: sys_lang_contents_lang_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_lang_contents
    ADD CONSTRAINT sys_lang_contents_lang_code_key UNIQUE (lang, code);


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
-- Name: sys_user_access_right_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_pkey PRIMARY KEY (id);


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
-- Name: fki_stok_tipi_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_stok_tipi_id ON public.stok_karti USING btree (stok_tipi_id);


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
-- Name: bolge_bolge_turu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT bolge_bolge_turu_fkey FOREIGN KEY (bolge_turu) REFERENCES public.bolge_turu(tur) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: city_country_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_name_fkey FOREIGN KEY (country_name) REFERENCES public.country(country_name) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: stok_hareketi_alan_ambar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_alan_ambar_fkey FOREIGN KEY (alan_ambar) REFERENCES public.ambar(ambar) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stok_hareketi_stok_kodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_stok_kodu_fkey FOREIGN KEY (stok_kodu) REFERENCES public.stok_karti(stok_kodu) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: SEQUENCE ayar_efatura_senaryo_tipi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq TO PUBLIC;


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
-- Name: TABLE ayar_ondalik_hane; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.ayar_ondalik_hane FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_ondalik_hane FROM postgres;
GRANT ALL ON TABLE public.ayar_ondalik_hane TO postgres;
GRANT ALL ON TABLE public.ayar_ondalik_hane TO PUBLIC;


--
-- Name: SEQUENCE ayar_ondalik_hane_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ayar_ondalik_hane_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_ondalik_hane_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_ondalik_hane_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_ondalik_hane_id_seq TO PUBLIC;


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
-- Name: TABLE city; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.city FROM PUBLIC;
REVOKE ALL ON TABLE public.city FROM postgres;
GRANT ALL ON TABLE public.city TO postgres;


--
-- Name: SEQUENCE city_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.city_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.city_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.city_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.city_id_seq TO PUBLIC;


--
-- Name: TABLE country; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.country FROM PUBLIC;
REVOKE ALL ON TABLE public.country FROM postgres;
GRANT ALL ON TABLE public.country TO postgres;


--
-- Name: SEQUENCE country_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.country_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.country_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.country_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.country_id_seq TO PUBLIC;


--
-- Name: TABLE currency; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.currency FROM PUBLIC;
REVOKE ALL ON TABLE public.currency FROM postgres;
GRANT ALL ON TABLE public.currency TO postgres;
GRANT ALL ON TABLE public.currency TO PUBLIC;


--
-- Name: SEQUENCE currency_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.currency_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.currency_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.currency_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.currency_id_seq TO PUBLIC;


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
-- Name: TABLE stok_hareketi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.stok_hareketi FROM PUBLIC;
REVOKE ALL ON TABLE public.stok_hareketi FROM postgres;
GRANT ALL ON TABLE public.stok_hareketi TO postgres;
GRANT ALL ON TABLE public.stok_hareketi TO PUBLIC;


--
-- Name: SEQUENCE stok_hareketi_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.stok_hareketi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_hareketi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_hareketi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_hareketi_id_seq TO PUBLIC;


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
-- PostgreSQL database dump complete
--

