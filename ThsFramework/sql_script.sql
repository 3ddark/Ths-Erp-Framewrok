PGDMP         *                 w            ths_erp2018    9.5.13    9.5.13 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    477421    ths_erp2018    DATABASE     �   CREATE DATABASE ths_erp2018 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Turkish_Turkey.1254' LC_CTYPE = 'Turkish_Turkey.1254';
    DROP DATABASE ths_erp2018;
             postgres    false            �           0    0    DATABASE ths_erp2018    COMMENT     6   COMMENT ON DATABASE ths_erp2018 IS 'THS ERP Systems';
                  postgres    false    4278                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    8            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO ths_admin;
                  postgres    false    8                        3079    12355    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    477422    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                  false    8            �           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                       false    2            �           1255    477472    audit()    FUNCTION     _  CREATE FUNCTION public.audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
declare
_username varchar;
_ip varchar;
_database varchar;
_sql text;
_old_val text[];
_test text;
_tarih timestamp without time zone;
BEGIN

	IF (TG_OP = 'INSERT') OR (TG_OP = 'DELETE') OR ((TG_OP = 'UPDATE') AND (ARRAY[OLD] <> ARRAY[NEW])) THEN

		_username 	:= (upper(session_user)); 
		_ip 		:= (inet_client_addr());
		_database	:= (SELECT current_database());
		_tarih		:= (SELECT NOW());

		IF (TG_OP = 'INSERT') THEN
			_old_val	:= (SELECT array[NEW]);
		ELSE
			_old_val	:= (SELECT array[OLD]);
		END IF;

		_test		:= (SELECT array_to_string(_old_val, ', '));

--		raise exception 'Mesaj =%', _test;

		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, ',,', ', null,');
		_test := replace(_test, '"', '''');
		_test := replace(_test, '(', '''');
		_test := replace(_test, ')', '''');
		_test := replace(_test, ',', ''', ''');
		_test := replace(_test, '''''', '''');
		_test := replace(_test, ''' null''', ' null');

		--raise exception 'Mesaj =%', _test;

		_sql		:= (SELECT format('INSERT INTO %I.%I VALUES (%L, %L, %L, %L, %s)', _database, TG_TABLE_NAME, _username, _ip, _tarih, TG_OP, _test));

		--raise exception 'Mesaj =%', _sql;

		PERFORM dblink(
			'host=localhost user=ths_admin password=THSERP dbname=ths_erp_log port=5432', 
			' ' || _sql || ';'
		);

	END IF;

	RETURN NULL;
/*
	EXECUTE format('INSERT INTO %I.%I VALUES ($1.*)', (SELECT current_database()), TG_TABLE_NAME, _username, _ip)
	USING OLD;
	RETURN OLD;

	RETURN null;
	IF OLD IS NOT DISTINCT FROM NEW THEN
*/

END
$_$;
    DROP FUNCTION public.audit();
       public       postgres    false    8    1            �           1255    477473    audit_old()    FUNCTION     �  CREATE FUNCTION public.audit_old() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$DECLARE
	_username varchar;
	_ip varchar;
	_table_name varchar;
	_orj_table_name varchar;
	_row_id integer;
	_access_type varchar;
	_time_of_change timestamp without time zone;
	_db_name varchar;
	_old_data text;
    BEGIN
	_username 		:= (upper(session_user)); 
	_ip 			:= (inet_client_addr());
	_table_name 		:= (upper(TG_TABLE_NAME)); 
	_orj_table_name		:= (TG_TABLE_NAME);
	_time_of_change 	:= (now());
	_db_name 		:= (current_database());
	_old_data		:= '';

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
		--_old_data	:= (SELECT * FROM _orj_table_name);
	    END IF;
	END IF;

	IF (TG_OP = 'DELETE') THEN
            _access_type	:= (TG_OP);
            _row_id 		:= (OLD.id);
        END IF;


	PERFORM dblink('host=localhost user=postgres password=123 dbname=ths_erp2017_log port=5432', 
	'INSERT INTO audit(username, ip, table_name, access_type, time_of_change, row_id, db_name, old_data) ' || 
	'VALUES(' || 
		(quote_literal(_username)) || ',' || 
		(quote_literal(_ip)) || ',' ||  
		(quote_literal(upper(_table_name))) || ',' || 
		(quote_literal(_access_type)) || ',' || 
		(quote_literal(_time_of_change)) || ',' ||
		(quote_literal(_row_id)) || ',' || 
		(quote_literal(_db_name)) || ',' ||
		(quote_literal(_old_data)) || ');');
	    
        RETURN NULL;
    END;
$$;
 "   DROP FUNCTION public.audit_old();
       public       postgres    false    1    8            �           1255    477474    delete_table_lang_content()    FUNCTION     ^  CREATE FUNCTION public.delete_table_lang_content() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$DECLARE
    BEGIN
    
	IF (TG_OP = 'DELETE') THEN
            DELETE FROM sys_table_lang_content WHERE table_name=initcap(replace(TG_TABLE_NAME, '_', ' ')) AND row_id=OLD.id;
        END IF;

        RETURN NULL;
    END;
$$;
 2   DROP FUNCTION public.delete_table_lang_content();
       public       postgres    false    8    1            �           1255    477475    get_default_para_birimi()    FUNCTION     �   CREATE FUNCTION public.get_default_para_birimi() RETURNS character varying
    LANGUAGE sql
    AS $$SELECT kod FROM public.para_birimi WHERE is_varsayilan limit 1$$;
 0   DROP FUNCTION public.get_default_para_birimi();
       public       postgres    false    8            �           1255    477476    get_default_para_birimi_id()    FUNCTION     �   CREATE FUNCTION public.get_default_para_birimi_id() RETURNS integer
    LANGUAGE sql
    AS $$SELECT id FROM public.para_birimi WHERE is_varsayilan limit 1$$;
 3   DROP FUNCTION public.get_default_para_birimi_id();
       public       postgres    false    8            �           1255    477477    get_default_stok_tipi()    FUNCTION     �   CREATE FUNCTION public.get_default_stok_tipi() RETURNS integer
    LANGUAGE sql
    AS $$SELECT id FROM stok_tipi WHERE is_default=true$$;
 .   DROP FUNCTION public.get_default_stok_tipi();
       public       postgres    false    8            �           0    0     FUNCTION get_default_stok_tipi()    ACL     �   REVOKE ALL ON FUNCTION public.get_default_stok_tipi() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.get_default_stok_tipi() FROM postgres;
            public       postgres    false    509            �           1255    477478 .   get_lang_text(text, text, text, integer, text)    FUNCTION     �  CREATE FUNCTION public.get_lang_text(_default_value text, _table_name text, _column_name text, _row_id integer, _lang text) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$declare
	dmp text;
begin
	SELECT INTO dmp value FROM sys_lang_data_content 
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
 {   DROP FUNCTION public.get_lang_text(_default_value text, _table_name text, _column_name text, _row_id integer, _lang text);
       public       postgres    false    8    1                        1255    477479    login(text, text, text, text)    FUNCTION     �  CREATE FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) RETURNS integer
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
 V   DROP FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text);
       public       postgres    false    8    1            �           0    0 H   FUNCTION login(kullanici_adi text, pwd text, surum text, mac_adres text)    ACL     �   REVOKE ALL ON FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.login(kullanici_adi text, pwd text, surum text, mac_adres text) FROM postgres;
            public       postgres    false    512                       1255    477480    mal_ortalama_maliyet_2()    FUNCTION     �	  CREATE FUNCTION public.mal_ortalama_maliyet_2() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$DECLARE
    stok_hareketi RECORD;
    stok_hareketi_donem_basi RECORD;
    _miktar float;
    _ortalama_maliyet numeric;
    _stok_kodu character varying;
    _bHesapla boolean;
    ondalikli_hane RECORD;
BEGIN
	_miktar := 0;
	_ortalama_maliyet := 0;
	_bHesapla := true;

	IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN
		_stok_kodu := NEW.stok_kodu;
	ELSIF (TG_OP = 'DELETE') THEN
		_stok_kodu := OLD.stok_kodu;
	END IF;

	IF _bHesapla = true THEN
		--her ambarın ayrıdönem başı hareketi var(fiyat aynıdır, miktarlar toplanır)
		FOR stok_hareketi_donem_basi IN SELECT miktar, tutar FROM stok_hareketi WHERE stok_kodu=_stok_kodu AND stok_hareketi.is_donem_basi_hareket = true AND stok_hareketi.miktar > 0 
		LOOP
			_miktar := _miktar + stok_hareketi_donem_basi.miktar;
			_ortalama_maliyet := stok_hareketi_donem_basi.tutar;
		END LOOP;
	

		FOR stok_hareketi IN SELECT giris_cikis, miktar, tutar FROM stok_hareketi WHERE stok_kodu= _stok_kodu AND stok_hareketi.is_donem_basi_hareket = FALSE AND stok_hareketi.miktar <> 0 ORDER BY tarih, id
		LOOP
			IF (mal_hareketi.giris_cikis_tip_id = 1)  THEN	--giriş
				IF _miktar > 0 THEN
					IF _miktar + stok_hareketi.miktar <= 0 THEN
						_ortalama_maliyet := 0;	
					ELSIF _miktar + stok_hareketi.miktar > 0 THEN
						_ortalama_maliyet := (_miktar * _ortalama_maliyet + mal_hareketi.miktar * mal_hareketi.tl_fiyat) / ( _miktar + mal_hareketi.miktar );
					END IF;
				ELSIF _miktar <= 0 THEN
					IF _miktar + mal_hareketi.miktar <= 0 THEN
						_ortalama_maliyet := 0;
					ELSIF (_miktar + mal_hareketi.miktar) > 0 THEN
						_ortalama_maliyet := mal_hareketi.tl_fiyat;
					END IF;
				END IF;
			END IF;	
			--miktar çıkışta negatif girişte pozitif o yüzden sadece topla
			_miktar := _miktar + mal_hareketi.miktar;
		END LOOP;
		
		SELECT mallar_fiyat, alim_fiyat, satim_fiyat into ondalikli_hane FROM ondalikli_haneler;
		 
		_ortalama_maliyet := round(_ortalama_maliyet, greatest(ondalikli_hane.mallar_fiyat, ondalikli_hane.alim_fiyat, ondalikli_hane.satim_fiyat));

		UPDATE mallar SET ortalama_maliyet=_ortalama_maliyet WHERE mal_kodu = _mal_kodu;
		
	END IF;
	
	IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_OP = 'DELETE') THEN
		RETURN OLD;
	END IF;
END$$;
 /   DROP FUNCTION public.mal_ortalama_maliyet_2();
       public       postgres    false    8    1            �           0    0 !   FUNCTION mal_ortalama_maliyet_2()    COMMENT     �   COMMENT ON FUNCTION public.mal_ortalama_maliyet_2() IS 'mal_hareketleri tablosunda 
after insert, update, delete 
işlemden sonra malın tüm hareketlerinden ortalama maliyet hesaplar
şu an kullanılan trigger';
            public       postgres    false    513            �           0    0 !   FUNCTION mal_ortalama_maliyet_2()    ACL     �   REVOKE ALL ON FUNCTION public.mal_ortalama_maliyet_2() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.mal_ortalama_maliyet_2() FROM postgres;
GRANT ALL ON FUNCTION public.mal_ortalama_maliyet_2() TO postgres;
            public       postgres    false    513            �           1255    477481    personel_adsoyad()    FUNCTION     ]  CREATE FUNCTION public.personel_adsoyad() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$DECLARE
    BEGIN
	IF (TG_OP = 'UPDATE') OR (TG_OP = 'INSERT') THEN
		UPDATE personel_karti SET 
			personel_ad_soyad=personel_ad || ' ' || personel_soyad
		WHERE personel_karti.id=NEW.id;
	END IF;
	
        RETURN NULL;
    END;
$$;
 )   DROP FUNCTION public.personel_adsoyad();
       public       postgres    false    1    8            �           0    0    FUNCTION personel_adsoyad()    ACL     �   REVOKE ALL ON FUNCTION public.personel_adsoyad() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.personel_adsoyad() FROM postgres;
GRANT ALL ON FUNCTION public.personel_adsoyad() TO postgres;
GRANT ALL ON FUNCTION public.personel_adsoyad() TO PUBLIC;
            public       postgres    false    510            �           1255    477482 	   sp_stok()    FUNCTION     �  CREATE FUNCTION public.sp_stok() RETURNS TABLE(stokkodu character varying, stokadi character varying, satisfiyat double precision, elma character varying)
    LANGUAGE plpgsql
    AS $$/*
ali yaptı
neden yaptı
tarihte yaptı
mehmet için yaptı
*/
BEGIN
	RETURN query 
	SELECT stok_kodu,
	stok_adi,
	satis_fiyat,
	satis_para_birim
	FROM
	stok_karti
	ORDER BY
stok_kodu DESC;

END;
$$;
     DROP FUNCTION public.sp_stok();
       public       postgres    false    8    1            �           0    0    FUNCTION sp_stok()    COMMENT     l   COMMENT ON FUNCTION public.sp_stok() IS '/*
ali yaptı
neden yaptı
tarihte yaptı
mehmet için yaptı
*/';
            public       postgres    false    508            �           1255    477483    table_notify()    FUNCTION     �  CREATE FUNCTION public.table_notify() RETURNS trigger
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
 %   DROP FUNCTION public.table_notify();
       public       postgres    false    8    1            �           0    0    FUNCTION table_notify()    ACL     v   REVOKE ALL ON FUNCTION public.table_notify() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.table_notify() FROM postgres;
            public       postgres    false    511            �            1259    477486    adres    TABLE     �  CREATE TABLE public.adres (
    id integer NOT NULL,
    ulke_id integer,
    sehir_id integer,
    ilce character varying(64),
    mahalle character varying(64),
    cadde character varying(64),
    sokak character varying(64),
    bina character varying(8),
    kapi_no character varying(8),
    posta_kutusu character varying(16),
    posta_kodu character varying(16),
    web_sitesi character varying(64),
    eposta_adresi character varying(128)
);
    DROP TABLE public.adres;
       public         postgres    false    8            �            1259    477492    adres_id_seq    SEQUENCE     u   CREATE SEQUENCE public.adres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.adres_id_seq;
       public       postgres    false    183    8            �           0    0    adres_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.adres_id_seq OWNED BY public.adres.id;
            public       postgres    false    184            �            1259    477494    alis_teklif    TABLE     �  CREATE TABLE public.alis_teklif (
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
    DROP TABLE public.alis_teklif;
       public         postgres    false    8            �           0    0    TABLE alis_teklif    ACL     �   REVOKE ALL ON TABLE public.alis_teklif FROM PUBLIC;
REVOKE ALL ON TABLE public.alis_teklif FROM postgres;
GRANT ALL ON TABLE public.alis_teklif TO postgres;
            public       postgres    false    185            �            1259    477508    alis_teklif_detay    TABLE     �   CREATE TABLE public.alis_teklif_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer
);
 %   DROP TABLE public.alis_teklif_detay;
       public         postgres    false    8            �           0    0    TABLE alis_teklif_detay    ACL     �   REVOKE ALL ON TABLE public.alis_teklif_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.alis_teklif_detay FROM postgres;
GRANT ALL ON TABLE public.alis_teklif_detay TO postgres;
            public       postgres    false    186            �            1259    477512    alis_teklif_detay_id_seq    SEQUENCE     �   CREATE SEQUENCE public.alis_teklif_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.alis_teklif_detay_id_seq;
       public       postgres    false    8    186            �           0    0    alis_teklif_detay_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.alis_teklif_detay_id_seq OWNED BY public.alis_teklif_detay.id;
            public       postgres    false    187            �           0    0 !   SEQUENCE alis_teklif_detay_id_seq    ACL       REVOKE ALL ON SEQUENCE public.alis_teklif_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.alis_teklif_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_detay_id_seq TO PUBLIC;
            public       postgres    false    187            �            1259    477514    alis_teklif_id_seq    SEQUENCE     {   CREATE SEQUENCE public.alis_teklif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.alis_teklif_id_seq;
       public       postgres    false    8    185            �           0    0    alis_teklif_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.alis_teklif_id_seq OWNED BY public.alis_teklif.id;
            public       postgres    false    188            �           0    0    SEQUENCE alis_teklif_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.alis_teklif_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.alis_teklif_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.alis_teklif_id_seq TO PUBLIC;
            public       postgres    false    188            �            1259    477522    ambar    TABLE     I  CREATE TABLE public.ambar (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    ambar_adi character varying(32),
    is_varsayilan_hammadde_ambari boolean DEFAULT false NOT NULL,
    is_varsayilan_uretim_ambari boolean DEFAULT false NOT NULL,
    is_varsayilan_satis_ambari boolean DEFAULT false NOT NULL
);
    DROP TABLE public.ambar;
       public         postgres    false    8            �           0    0    TABLE ambar    COMMENT     Q   COMMENT ON TABLE public.ambar IS 'Stok hareketlerinin tutulduğu ambar bilgisi';
            public       postgres    false    189            �           0    0    TABLE ambar    ACL     �   REVOKE ALL ON TABLE public.ambar FROM PUBLIC;
REVOKE ALL ON TABLE public.ambar FROM postgres;
GRANT ALL ON TABLE public.ambar TO postgres;
            public       postgres    false    189            �            1259    477529    ambar_id_seq    SEQUENCE     u   CREATE SEQUENCE public.ambar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.ambar_id_seq;
       public       postgres    false    189    8            �           0    0    ambar_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.ambar_id_seq OWNED BY public.ambar.id;
            public       postgres    false    190            �           0    0    SEQUENCE ambar_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.ambar_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ambar_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ambar_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ambar_id_seq TO PUBLIC;
            public       postgres    false    190            �            1259    477531    ayar_barkod_hazirlik_dosya_turu    TABLE     �   CREATE TABLE public.ayar_barkod_hazirlik_dosya_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(32) NOT NULL
);
 3   DROP TABLE public.ayar_barkod_hazirlik_dosya_turu;
       public         postgres    false    8            �            1259    477535 &   ayar_barkod_hazirlik_dosya_turu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq;
       public       postgres    false    8    191            �           0    0 &   ayar_barkod_hazirlik_dosya_turu_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq OWNED BY public.ayar_barkod_hazirlik_dosya_turu.id;
            public       postgres    false    192            �           0    0 /   SEQUENCE ayar_barkod_hazirlik_dosya_turu_id_seq    ACL     F  REVOKE ALL ON SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_hazirlik_dosya_turu_id_seq TO PUBLIC;
            public       postgres    false    192            �            1259    477537    ayar_barkod_serino_turu    TABLE     �   CREATE TABLE public.ayar_barkod_serino_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(4) NOT NULL,
    aciklama character varying(16) NOT NULL
);
 +   DROP TABLE public.ayar_barkod_serino_turu;
       public         postgres    false    8            �            1259    477541    ayar_barkod_serino_turu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_barkod_serino_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_barkod_serino_turu_id_seq;
       public       postgres    false    193    8            �           0    0    ayar_barkod_serino_turu_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_barkod_serino_turu_id_seq OWNED BY public.ayar_barkod_serino_turu.id;
            public       postgres    false    194            �           0    0 '   SEQUENCE ayar_barkod_serino_turu_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_barkod_serino_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_barkod_serino_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_serino_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_serino_turu_id_seq TO PUBLIC;
            public       postgres    false    194            �            1259    477543    ayar_barkod_tezgah    TABLE     �   CREATE TABLE public.ayar_barkod_tezgah (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tezgah_adi character varying(32) NOT NULL,
    ambar_id integer NOT NULL
);
 &   DROP TABLE public.ayar_barkod_tezgah;
       public         postgres    false    8            �            1259    477547    ayar_barkod_tezgah_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_barkod_tezgah_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ayar_barkod_tezgah_id_seq;
       public       postgres    false    8    195            �           0    0    ayar_barkod_tezgah_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.ayar_barkod_tezgah_id_seq OWNED BY public.ayar_barkod_tezgah.id;
            public       postgres    false    196            �           0    0 "   SEQUENCE ayar_barkod_tezgah_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_barkod_tezgah_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_barkod_tezgah_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_tezgah_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_tezgah_id_seq TO PUBLIC;
            public       postgres    false    196            �            1259    477549    ayar_barkod_urun_turu    TABLE     �   CREATE TABLE public.ayar_barkod_urun_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(16) NOT NULL
);
 )   DROP TABLE public.ayar_barkod_urun_turu;
       public         postgres    false    8            �            1259    477553    ayar_barkod_urun_turu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_barkod_urun_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.ayar_barkod_urun_turu_id_seq;
       public       postgres    false    8    197            �           0    0    ayar_barkod_urun_turu_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.ayar_barkod_urun_turu_id_seq OWNED BY public.ayar_barkod_urun_turu.id;
            public       postgres    false    198            �           0    0 %   SEQUENCE ayar_barkod_urun_turu_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_barkod_urun_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_barkod_urun_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_urun_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_barkod_urun_turu_id_seq TO PUBLIC;
            public       postgres    false    198            �            1259    477555    ayar_bordro_tipi    TABLE     �   CREATE TABLE public.ayar_bordro_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL
);
 $   DROP TABLE public.ayar_bordro_tipi;
       public         postgres    false    8            �            1259    477559    ayar_bordro_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_bordro_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.ayar_bordro_tipi_id_seq;
       public       postgres    false    8    199            �           0    0    ayar_bordro_tipi_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.ayar_bordro_tipi_id_seq OWNED BY public.ayar_bordro_tipi.id;
            public       postgres    false    200            �           0    0     SEQUENCE ayar_bordro_tipi_id_seq    ACL     
  REVOKE ALL ON SEQUENCE public.ayar_bordro_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_bordro_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_bordro_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_bordro_tipi_id_seq TO PUBLIC;
            public       postgres    false    200            �            1259    477561    ayar_cek_senet_cash_edici_tipi    TABLE     �   CREATE TABLE public.ayar_cek_senet_cash_edici_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32)
);
 2   DROP TABLE public.ayar_cek_senet_cash_edici_tipi;
       public         postgres    false    8            �            1259    477565 %   ayar_cek_senet_cash_edici_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq;
       public       postgres    false    201    8            �           0    0 %   ayar_cek_senet_cash_edici_tipi_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq OWNED BY public.ayar_cek_senet_cash_edici_tipi.id;
            public       postgres    false    202            �           0    0 .   SEQUENCE ayar_cek_senet_cash_edici_tipi_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_cek_senet_cash_edici_tipi_id_seq TO PUBLIC;
            public       postgres    false    202            �            1259    477567     ayar_cek_senet_tahsil_odeme_tipi    TABLE     �   CREATE TABLE public.ayar_cek_senet_tahsil_odeme_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL
);
 4   DROP TABLE public.ayar_cek_senet_tahsil_odeme_tipi;
       public         postgres    false    8            �            1259    477571 '   ayar_cek_senet_tahsil_odeme_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq;
       public       postgres    false    8    203            �           0    0 '   ayar_cek_senet_tahsil_odeme_tipi_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq OWNED BY public.ayar_cek_senet_tahsil_odeme_tipi.id;
            public       postgres    false    204            �           0    0 0   SEQUENCE ayar_cek_senet_tahsil_odeme_tipi_id_seq    ACL     J  REVOKE ALL ON SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_cek_senet_tahsil_odeme_tipi_id_seq TO PUBLIC;
            public       postgres    false    204            �            1259    477573    ayar_cek_senet_tipi    TABLE     �   CREATE TABLE public.ayar_cek_senet_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL
);
 '   DROP TABLE public.ayar_cek_senet_tipi;
       public         postgres    false    8            �            1259    477577    ayar_cek_senet_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_cek_senet_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.ayar_cek_senet_tipi_id_seq;
       public       postgres    false    8    205            �           0    0    ayar_cek_senet_tipi_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.ayar_cek_senet_tipi_id_seq OWNED BY public.ayar_cek_senet_tipi.id;
            public       postgres    false    206            �           0    0 #   SEQUENCE ayar_cek_senet_tipi_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_cek_senet_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_cek_senet_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_cek_senet_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_cek_senet_tipi_id_seq TO PUBLIC;
            public       postgres    false    206            �            1259    477579    ayar_diger_database_bilgisi    TABLE     :  CREATE TABLE public.ayar_diger_database_bilgisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    db_name character varying(64),
    host_name character varying(64),
    db_user character varying(64),
    db_pass character varying(64),
    db_port integer,
    firma_adi character varying(64),
    is_aybey_teklif_hesapla boolean DEFAULT false NOT NULL,
    is_bulut_teklif_hesapla boolean DEFAULT false NOT NULL,
    is_maliyet_analiz boolean DEFAULT false NOT NULL,
    is_siparis_kopyala boolean DEFAULT false NOT NULL,
    is_otomatik_doviz_kaydet boolean DEFAULT false NOT NULL,
    is_staff_personel_bilgisi boolean DEFAULT false NOT NULL,
    is_uretim_takip boolean DEFAULT false NOT NULL,
    is_pano_uretim boolean DEFAULT false NOT NULL,
    is_nakit_akis boolean DEFAULT false NOT NULL
);
 /   DROP TABLE public.ayar_diger_database_bilgisi;
       public         postgres    false    8            �            1259    477592 "   ayar_diger_database_bilgisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_diger_database_bilgisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.ayar_diger_database_bilgisi_id_seq;
       public       postgres    false    207    8            �           0    0 "   ayar_diger_database_bilgisi_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.ayar_diger_database_bilgisi_id_seq OWNED BY public.ayar_diger_database_bilgisi.id;
            public       postgres    false    208            �           0    0 +   SEQUENCE ayar_diger_database_bilgisi_id_seq    ACL     6  REVOKE ALL ON SEQUENCE public.ayar_diger_database_bilgisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_diger_database_bilgisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_diger_database_bilgisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_diger_database_bilgisi_id_seq TO PUBLIC;
            public       postgres    false    208            �            1259    477594    ayar_edefter_donem_raporu    TABLE       CREATE TABLE public.ayar_edefter_donem_raporu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    rapor_baslangic_donemi date,
    rapor_bitis_donemi date,
    rapor_alma_tarihi date,
    yevmiye_no_baslangic integer,
    yevmiye_no_bitis integer
);
 -   DROP TABLE public.ayar_edefter_donem_raporu;
       public         postgres    false    8            �            1259    477598     ayar_edefter_donem_raporu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_edefter_donem_raporu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.ayar_edefter_donem_raporu_id_seq;
       public       postgres    false    8    209            �           0    0     ayar_edefter_donem_raporu_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.ayar_edefter_donem_raporu_id_seq OWNED BY public.ayar_edefter_donem_raporu.id;
            public       postgres    false    210            �           0    0 )   SEQUENCE ayar_edefter_donem_raporu_id_seq    ACL     .  REVOKE ALL ON SEQUENCE public.ayar_edefter_donem_raporu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_edefter_donem_raporu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_edefter_donem_raporu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_edefter_donem_raporu_id_seq TO PUBLIC;
            public       postgres    false    210            �            1259    477600    ayar_efatura_alici_bilgisi    TABLE     �  CREATE TABLE public.ayar_efatura_alici_bilgisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    alias character varying(128),
    title character varying(256),
    type_ character varying(128),
    first_creation_time character varying(32),
    alias_creation_time character varying(32),
    register_time character varying(32),
    identifier character varying(11)
);
 .   DROP TABLE public.ayar_efatura_alici_bilgisi;
       public         postgres    false    8            �            1259    477607 !   ayar_efatura_alici_bilgisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq;
       public       postgres    false    8    211            �           0    0 !   ayar_efatura_alici_bilgisi_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq OWNED BY public.ayar_efatura_alici_bilgisi.id;
            public       postgres    false    212            �           0    0 *   SEQUENCE ayar_efatura_alici_bilgisi_id_seq    ACL     2  REVOKE ALL ON SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_alici_bilgisi_id_seq TO PUBLIC;
            public       postgres    false    212            �            1259    477609    ayar_efatura_evrak_cinsi    TABLE     �   CREATE TABLE public.ayar_efatura_evrak_cinsi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    evrak_cinsi character varying(32)
);
 ,   DROP TABLE public.ayar_efatura_evrak_cinsi;
       public         postgres    false    8            �            1259    477613    ayar_efatura_evrak_cinsi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq;
       public       postgres    false    8    213            �           0    0    ayar_efatura_evrak_cinsi_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq OWNED BY public.ayar_efatura_evrak_cinsi.id;
            public       postgres    false    214            �           0    0 (   SEQUENCE ayar_efatura_evrak_cinsi_id_seq    ACL     *  REVOKE ALL ON SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_evrak_cinsi_id_seq TO PUBLIC;
            public       postgres    false    214            �            1259    477615    ayar_efatura_evrak_tipi    TABLE     �   CREATE TABLE public.ayar_efatura_evrak_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    evrak_tipi character varying(32)
);
 +   DROP TABLE public.ayar_efatura_evrak_tipi;
       public         postgres    false    8            �            1259    477619    ayar_efatura_evrak_tipi_cinsi    TABLE     �   CREATE TABLE public.ayar_efatura_evrak_tipi_cinsi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    evrak_tipi_id integer,
    evrak_cinsi_id integer
);
 1   DROP TABLE public.ayar_efatura_evrak_tipi_cinsi;
       public         postgres    false    8            �            1259    477623 $   ayar_efatura_evrak_tipi_cinsi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq;
       public       postgres    false    216    8            �           0    0 $   ayar_efatura_evrak_tipi_cinsi_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq OWNED BY public.ayar_efatura_evrak_tipi_cinsi.id;
            public       postgres    false    217            �           0    0 -   SEQUENCE ayar_efatura_evrak_tipi_cinsi_id_seq    ACL     >  REVOKE ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_cinsi_id_seq TO PUBLIC;
            public       postgres    false    217            �            1259    477625    ayar_efatura_evrak_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_evrak_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_efatura_evrak_tipi_id_seq;
       public       postgres    false    215    8            �           0    0    ayar_efatura_evrak_tipi_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_efatura_evrak_tipi_id_seq OWNED BY public.ayar_efatura_evrak_tipi.id;
            public       postgres    false    218            �           0    0 '   SEQUENCE ayar_efatura_evrak_tipi_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_evrak_tipi_id_seq TO PUBLIC;
            public       postgres    false    218            �            1259    477627    ayar_efatura_fatura_tipi    TABLE     �   CREATE TABLE public.ayar_efatura_fatura_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32) NOT NULL
);
 ,   DROP TABLE public.ayar_efatura_fatura_tipi;
       public         postgres    false    8            �           0    0    TABLE ayar_efatura_fatura_tipi    COMMENT     J   COMMENT ON TABLE public.ayar_efatura_fatura_tipi IS 'eFatura Evrak Tipi';
            public       postgres    false    219            �            1259    477631    ayar_efatura_fatura_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_fatura_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.ayar_efatura_fatura_tipi_id_seq;
       public       postgres    false    8    219            �           0    0    ayar_efatura_fatura_tipi_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.ayar_efatura_fatura_tipi_id_seq OWNED BY public.ayar_efatura_fatura_tipi.id;
            public       postgres    false    220            �           0    0 (   SEQUENCE ayar_efatura_fatura_tipi_id_seq    ACL     *  REVOKE ALL ON SEQUENCE public.ayar_efatura_fatura_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_fatura_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_fatura_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_fatura_tipi_id_seq TO PUBLIC;
            public       postgres    false    220            �            1259    477633    ayar_efatura_gonderici_bilgisi    TABLE     �  CREATE TABLE public.ayar_efatura_gonderici_bilgisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    alias character varying(128),
    title character varying(256),
    type_ character varying(128),
    first_creation_time character varying(32),
    alias_creation_time character varying(32),
    register_time character varying(32),
    identifier character varying(11)
);
 2   DROP TABLE public.ayar_efatura_gonderici_bilgisi;
       public         postgres    false    8            �            1259    477640 %   ayar_efatura_gonderici_bilgisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq;
       public       postgres    false    221    8            �           0    0 %   ayar_efatura_gonderici_bilgisi_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq OWNED BY public.ayar_efatura_gonderici_bilgisi.id;
            public       postgres    false    222            �           0    0 .   SEQUENCE ayar_efatura_gonderici_bilgisi_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_gonderici_bilgisi_id_seq TO PUBLIC;
            public       postgres    false    222            �            1259    477642    ayar_efatura_gonderim_sekli    TABLE       CREATE TABLE public.ayar_efatura_gonderim_sekli (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(8),
    kod_adi character varying(64),
    aciklama character varying(1024),
    is_active boolean DEFAULT true NOT NULL
);
 /   DROP TABLE public.ayar_efatura_gonderim_sekli;
       public         postgres    false    8            �            1259    477650 "   ayar_efatura_gonderim_sekli_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq;
       public       postgres    false    223    8            �           0    0 "   ayar_efatura_gonderim_sekli_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq OWNED BY public.ayar_efatura_gonderim_sekli.id;
            public       postgres    false    224            �           0    0 +   SEQUENCE ayar_efatura_gonderim_sekli_id_seq    ACL     6  REVOKE ALL ON SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_gonderim_sekli_id_seq TO PUBLIC;
            public       postgres    false    224            �            1259    477652 (   ayar_efatura_ihrac_kayitli_fatura_sebebi    TABLE     �   CREATE TABLE public.ayar_efatura_ihrac_kayitli_fatura_sebebi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(3),
    aciklama character varying(256)
);
 <   DROP TABLE public.ayar_efatura_ihrac_kayitli_fatura_sebebi;
       public         postgres    false    8            �            1259    477656 /   ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 F   DROP SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq;
       public       postgres    false    225    8            �           0    0 /   ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq OWNED BY public.ayar_efatura_ihrac_kayitli_fatura_sebebi.id;
            public       postgres    false    226            �           0    0 8   SEQUENCE ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq    ACL     j  REVOKE ALL ON SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq TO PUBLIC;
            public       postgres    false    226            �            1259    477658    ayar_efatura_iletisim_kanali    TABLE     �   CREATE TABLE public.ayar_efatura_iletisim_kanali (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(2) NOT NULL,
    aciklama character varying(512)
);
 0   DROP TABLE public.ayar_efatura_iletisim_kanali;
       public         postgres    false    8            �           0    0 "   TABLE ayar_efatura_iletisim_kanali    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_iletisim_kanali FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_iletisim_kanali FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_iletisim_kanali TO postgres;
            public       postgres    false    227            �            1259    477665 #   ayar_efatura_iletisim_kanali_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq;
       public       postgres    false    8    227            �           0    0 #   ayar_efatura_iletisim_kanali_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq OWNED BY public.ayar_efatura_iletisim_kanali.id;
            public       postgres    false    228            �           0    0 ,   SEQUENCE ayar_efatura_iletisim_kanali_id_seq    ACL     :  REVOKE ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_iletisim_kanali_id_seq TO PUBLIC;
            public       postgres    false    228            �            1259    477667    ayar_efatura_istisna_kodu    TABLE     "  CREATE TABLE public.ayar_efatura_istisna_kodu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(4) NOT NULL,
    aciklama character varying(512) NOT NULL,
    is_tam_istisna boolean DEFAULT true NOT NULL,
    fatura_tip_id integer NOT NULL
);
 -   DROP TABLE public.ayar_efatura_istisna_kodu;
       public         postgres    false    8            �           0    0    TABLE ayar_efatura_istisna_kodu    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_istisna_kodu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_istisna_kodu FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_istisna_kodu TO postgres;
            public       postgres    false    229            �            1259    477675     ayar_efatura_istisna_kodu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_istisna_kodu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.ayar_efatura_istisna_kodu_id_seq;
       public       postgres    false    229    8            �           0    0     ayar_efatura_istisna_kodu_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.ayar_efatura_istisna_kodu_id_seq OWNED BY public.ayar_efatura_istisna_kodu.id;
            public       postgres    false    230            �           0    0 )   SEQUENCE ayar_efatura_istisna_kodu_id_seq    ACL     .  REVOKE ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_istisna_kodu_id_seq TO PUBLIC;
            public       postgres    false    230            �            1259    477677    ayar_efatura_kimlik_semalari    TABLE     �   CREATE TABLE public.ayar_efatura_kimlik_semalari (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(16),
    aciklama character varying(64)
);
 0   DROP TABLE public.ayar_efatura_kimlik_semalari;
       public         postgres    false    8            �           0    0 "   TABLE ayar_efatura_kimlik_semalari    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_kimlik_semalari FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_kimlik_semalari FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_kimlik_semalari TO postgres;
            public       postgres    false    231            �            1259    477681 #   ayar_efatura_kimlik_semalari_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq;
       public       postgres    false    8    231            �           0    0 #   ayar_efatura_kimlik_semalari_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq OWNED BY public.ayar_efatura_kimlik_semalari.id;
            public       postgres    false    232            �           0    0 ,   SEQUENCE ayar_efatura_kimlik_semalari_id_seq    ACL     :  REVOKE ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_kimlik_semalari_id_seq TO PUBLIC;
            public       postgres    false    232            �            1259    477683    ayar_efatura_odeme_sekli    TABLE     >  CREATE TABLE public.ayar_efatura_odeme_sekli (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(16),
    odeme_sekli character varying(96),
    aciklama character varying(512),
    is_efatura boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT false NOT NULL
);
 ,   DROP TABLE public.ayar_efatura_odeme_sekli;
       public         postgres    false    8            �            1259    477692    ayar_efatura_odeme_sekli_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_odeme_sekli_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.ayar_efatura_odeme_sekli_id_seq;
       public       postgres    false    233    8            �           0    0    ayar_efatura_odeme_sekli_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.ayar_efatura_odeme_sekli_id_seq OWNED BY public.ayar_efatura_odeme_sekli.id;
            public       postgres    false    234            �           0    0 (   SEQUENCE ayar_efatura_odeme_sekli_id_seq    ACL     *  REVOKE ALL ON SEQUENCE public.ayar_efatura_odeme_sekli_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_odeme_sekli_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_odeme_sekli_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_odeme_sekli_id_seq TO PUBLIC;
            public       postgres    false    234            �            1259    477694    ayar_efatura_paket_tipi    TABLE       CREATE TABLE public.ayar_efatura_paket_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(2),
    paket_adi character varying(128),
    aciklama character varying(512),
    is_active boolean DEFAULT true NOT NULL
);
 +   DROP TABLE public.ayar_efatura_paket_tipi;
       public         postgres    false    8            �            1259    477702    ayar_efatura_paket_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_paket_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_efatura_paket_tipi_id_seq;
       public       postgres    false    235    8            �           0    0    ayar_efatura_paket_tipi_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_efatura_paket_tipi_id_seq OWNED BY public.ayar_efatura_paket_tipi.id;
            public       postgres    false    236            �           0    0 '   SEQUENCE ayar_efatura_paket_tipi_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_efatura_paket_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_paket_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_paket_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_paket_tipi_id_seq TO PUBLIC;
            public       postgres    false    236            �            1259    477704    ayar_efatura_response_code    TABLE     �   CREATE TABLE public.ayar_efatura_response_code (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(8)
);
 .   DROP TABLE public.ayar_efatura_response_code;
       public         postgres    false    8                        0    0     TABLE ayar_efatura_response_code    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_response_code FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_response_code FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_response_code TO postgres;
            public       postgres    false    237            �            1259    477708 !   ayar_efatura_response_code_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_response_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.ayar_efatura_response_code_id_seq;
       public       postgres    false    8    237                       0    0 !   ayar_efatura_response_code_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.ayar_efatura_response_code_id_seq OWNED BY public.ayar_efatura_response_code.id;
            public       postgres    false    238                       0    0 *   SEQUENCE ayar_efatura_response_code_id_seq    ACL     2  REVOKE ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_response_code_id_seq TO PUBLIC;
            public       postgres    false    238            �            1259    477710    ayar_efatura_senaryo_tipi    TABLE     �   CREATE TABLE public.ayar_efatura_senaryo_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32) NOT NULL,
    aciklama character varying(64)
);
 -   DROP TABLE public.ayar_efatura_senaryo_tipi;
       public         postgres    false    8                       0    0    TABLE ayar_efatura_senaryo_tipi    COMMENT     P   COMMENT ON TABLE public.ayar_efatura_senaryo_tipi IS 'eFatura Senaryo tipleri';
            public       postgres    false    239                       0    0    TABLE ayar_efatura_senaryo_tipi    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_senaryo_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_senaryo_tipi FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_senaryo_tipi TO postgres;
            public       postgres    false    239            �            1259    477714     ayar_efatura_senaryo_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq;
       public       postgres    false    239    8                       0    0     ayar_efatura_senaryo_tipi_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq OWNED BY public.ayar_efatura_senaryo_tipi.id;
            public       postgres    false    240                       0    0 )   SEQUENCE ayar_efatura_senaryo_tipi_id_seq    ACL     .  REVOKE ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_senaryo_tipi_id_seq TO PUBLIC;
            public       postgres    false    240            �            1259    477716    ayar_efatura_teslim_sarti    TABLE     (  CREATE TABLE public.ayar_efatura_teslim_sarti (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(16) NOT NULL,
    aciklama character varying(64) NOT NULL,
    is_efatura boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);
 -   DROP TABLE public.ayar_efatura_teslim_sarti;
       public         postgres    false    8            �            1259    477722     ayar_efatura_teslim_sarti_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_teslim_sarti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.ayar_efatura_teslim_sarti_id_seq;
       public       postgres    false    8    241                       0    0     ayar_efatura_teslim_sarti_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.ayar_efatura_teslim_sarti_id_seq OWNED BY public.ayar_efatura_teslim_sarti.id;
            public       postgres    false    242                       0    0 )   SEQUENCE ayar_efatura_teslim_sarti_id_seq    ACL     .  REVOKE ALL ON SEQUENCE public.ayar_efatura_teslim_sarti_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_teslim_sarti_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_teslim_sarti_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_teslim_sarti_id_seq TO PUBLIC;
            public       postgres    false    242            �            1259    477724    ayar_efatura_tevkifat_kodu    TABLE     �   CREATE TABLE public.ayar_efatura_tevkifat_kodu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kodu character varying(3),
    adi character varying(256),
    orani character varying(32),
    pay integer,
    payda integer
);
 .   DROP TABLE public.ayar_efatura_tevkifat_kodu;
       public         postgres    false    8            	           0    0     TABLE ayar_efatura_tevkifat_kodu    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_tevkifat_kodu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_tevkifat_kodu FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_tevkifat_kodu TO postgres;
            public       postgres    false    243            �            1259    477728 !   ayar_efatura_tevkifat_kodu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq;
       public       postgres    false    8    243            
           0    0 !   ayar_efatura_tevkifat_kodu_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq OWNED BY public.ayar_efatura_tevkifat_kodu.id;
            public       postgres    false    244                       0    0 *   SEQUENCE ayar_efatura_tevkifat_kodu_id_seq    ACL     2  REVOKE ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_tevkifat_kodu_id_seq TO PUBLIC;
            public       postgres    false    244            �            1259    477730    ayar_efatura_vergi_kodu    TABLE       CREATE TABLE public.ayar_efatura_vergi_kodu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kodu character varying(4),
    adi character varying(128),
    kisaltma character varying(32),
    tevkifat boolean DEFAULT false NOT NULL
);
 +   DROP TABLE public.ayar_efatura_vergi_kodu;
       public         postgres    false    8                       0    0    TABLE ayar_efatura_vergi_kodu    ACL     �   REVOKE ALL ON TABLE public.ayar_efatura_vergi_kodu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_efatura_vergi_kodu FROM postgres;
GRANT ALL ON TABLE public.ayar_efatura_vergi_kodu TO postgres;
            public       postgres    false    245            �            1259    477735    ayar_efatura_vergi_kodu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_efatura_vergi_kodu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_efatura_vergi_kodu_id_seq;
       public       postgres    false    245    8                       0    0    ayar_efatura_vergi_kodu_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_efatura_vergi_kodu_id_seq OWNED BY public.ayar_efatura_vergi_kodu.id;
            public       postgres    false    246                       0    0 '   SEQUENCE ayar_efatura_vergi_kodu_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_efatura_vergi_kodu_id_seq TO PUBLIC;
            public       postgres    false    246            �            1259    477737    ayar_fatura_no_serisi    TABLE     �   CREATE TABLE public.ayar_fatura_no_serisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    fatura_seri_id integer NOT NULL,
    deger character varying(16) NOT NULL
);
 )   DROP TABLE public.ayar_fatura_no_serisi;
       public         postgres    false    8            �            1259    477741    ayar_fatura_no_serisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_fatura_no_serisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.ayar_fatura_no_serisi_id_seq;
       public       postgres    false    8    247                       0    0    ayar_fatura_no_serisi_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.ayar_fatura_no_serisi_id_seq OWNED BY public.ayar_fatura_no_serisi.id;
            public       postgres    false    248                       0    0 %   SEQUENCE ayar_fatura_no_serisi_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_fatura_no_serisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_fatura_no_serisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_fatura_no_serisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_fatura_no_serisi_id_seq TO PUBLIC;
            public       postgres    false    248            �            1259    477743    ayar_firma_tipi    TABLE     �   CREATE TABLE public.ayar_firma_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    firma_turu_id integer NOT NULL,
    firma_tipi character varying(48) NOT NULL
);
 #   DROP TABLE public.ayar_firma_tipi;
       public         postgres    false    8                       0    0    TABLE ayar_firma_tipi    ACL     �   REVOKE ALL ON TABLE public.ayar_firma_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_firma_tipi FROM postgres;
GRANT ALL ON TABLE public.ayar_firma_tipi TO postgres;
            public       postgres    false    249            �            1259    477747    ayar_firma_tipi_id_seq    SEQUENCE        CREATE SEQUENCE public.ayar_firma_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.ayar_firma_tipi_id_seq;
       public       postgres    false    249    8                       0    0    ayar_firma_tipi_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.ayar_firma_tipi_id_seq OWNED BY public.ayar_firma_tipi.id;
            public       postgres    false    250            �            1259    477749    ayar_firma_turu    TABLE     �   CREATE TABLE public.ayar_firma_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(32) NOT NULL
);
 #   DROP TABLE public.ayar_firma_turu;
       public         postgres    false    8                       0    0    TABLE ayar_firma_turu    ACL     �   REVOKE ALL ON TABLE public.ayar_firma_turu FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_firma_turu FROM postgres;
GRANT ALL ON TABLE public.ayar_firma_turu TO postgres;
            public       postgres    false    251            �            1259    477753    ayar_firma_turu_id_seq    SEQUENCE        CREATE SEQUENCE public.ayar_firma_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.ayar_firma_turu_id_seq;
       public       postgres    false    8    251                       0    0    ayar_firma_turu_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.ayar_firma_turu_id_seq OWNED BY public.ayar_firma_turu.id;
            public       postgres    false    252            �            1259    477755    ayar_fis_tipi    TABLE     �   CREATE TABLE public.ayar_fis_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL
);
 !   DROP TABLE public.ayar_fis_tipi;
       public         postgres    false    8                       0    0    TABLE ayar_fis_tipi    COMMENT     �   COMMENT ON TABLE public.ayar_fis_tipi IS 'Muhasebe fişlerinin tip bilgisini tutar Örnek: MAHSUP, AÇILIŞ, KAPANIŞ, ÖDEME, TAHSİL';
            public       postgres    false    253            �            1259    477759    ayar_fis_tipi_id_seq    SEQUENCE     }   CREATE SEQUENCE public.ayar_fis_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.ayar_fis_tipi_id_seq;
       public       postgres    false    253    8                       0    0    ayar_fis_tipi_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.ayar_fis_tipi_id_seq OWNED BY public.ayar_fis_tipi.id;
            public       postgres    false    254                       0    0    SEQUENCE ayar_fis_tipi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.ayar_fis_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_fis_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_fis_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_fis_tipi_id_seq TO PUBLIC;
            public       postgres    false    254            �            1259    477761    ayar_genel_ayarlar    TABLE     (  CREATE TABLE public.ayar_genel_ayarlar (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    donem integer,
    unvan character varying(256),
    vergi_no character varying(10),
    tc_no character varying(11),
    firma_tipi character varying(32),
    diger_ayarlar json
);
 &   DROP TABLE public.ayar_genel_ayarlar;
       public         postgres    false    8                       0    0    TABLE ayar_genel_ayarlar    ACL     �   REVOKE ALL ON TABLE public.ayar_genel_ayarlar FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_genel_ayarlar FROM postgres;
GRANT ALL ON TABLE public.ayar_genel_ayarlar TO postgres;
            public       postgres    false    255                        1259    477768    ayar_genel_ayarlar_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_genel_ayarlar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ayar_genel_ayarlar_id_seq;
       public       postgres    false    8    255                       0    0    ayar_genel_ayarlar_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.ayar_genel_ayarlar_id_seq OWNED BY public.ayar_genel_ayarlar.id;
            public       postgres    false    256                       0    0 "   SEQUENCE ayar_genel_ayarlar_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_genel_ayarlar_id_seq TO PUBLIC;
            public       postgres    false    256                       1259    477770    ayar_hane_sayisi    TABLE     �  CREATE TABLE public.ayar_hane_sayisi (
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
 $   DROP TABLE public.ayar_hane_sayisi;
       public         postgres    false    8                       1259    477783    ayar_hane_sayisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_hane_sayisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.ayar_hane_sayisi_id_seq;
       public       postgres    false    257    8                       0    0    ayar_hane_sayisi_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.ayar_hane_sayisi_id_seq OWNED BY public.ayar_hane_sayisi.id;
            public       postgres    false    258                       0    0     SEQUENCE ayar_hane_sayisi_id_seq    ACL     
  REVOKE ALL ON SEQUENCE public.ayar_hane_sayisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_hane_sayisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_hane_sayisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_hane_sayisi_id_seq TO PUBLIC;
            public       postgres    false    258                       1259    477785    ayar_hesap_tipi    TABLE     �   CREATE TABLE public.ayar_hesap_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    hesap_tipi character varying(16) NOT NULL
);
 #   DROP TABLE public.ayar_hesap_tipi;
       public         postgres    false    8                       1259    477789    ayar_hesap_tipi_id_seq    SEQUENCE        CREATE SEQUENCE public.ayar_hesap_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.ayar_hesap_tipi_id_seq;
       public       postgres    false    8    259                       0    0    ayar_hesap_tipi_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.ayar_hesap_tipi_id_seq OWNED BY public.ayar_hesap_tipi.id;
            public       postgres    false    260                       0    0    SEQUENCE ayar_hesap_tipi_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_hesap_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_hesap_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_hesap_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_hesap_tipi_id_seq TO PUBLIC;
            public       postgres    false    260                       1259    477791    ayar_irsaliye_fatura_no_serisi    TABLE     �   CREATE TABLE public.ayar_irsaliye_fatura_no_serisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(8),
    is_fatura boolean DEFAULT false NOT NULL,
    is_irsaliye boolean DEFAULT false NOT NULL
);
 2   DROP TABLE public.ayar_irsaliye_fatura_no_serisi;
       public         postgres    false    8                       1259    477797 %   ayar_irsaliye_fatura_no_serisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq;
       public       postgres    false    261    8                       0    0 %   ayar_irsaliye_fatura_no_serisi_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq OWNED BY public.ayar_irsaliye_fatura_no_serisi.id;
            public       postgres    false    262                        0    0 .   SEQUENCE ayar_irsaliye_fatura_no_serisi_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_irsaliye_fatura_no_serisi_id_seq TO PUBLIC;
            public       postgres    false    262                       1259    477799    ayar_irsaliye_no_serisi    TABLE     �   CREATE TABLE public.ayar_irsaliye_no_serisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    irsaliye_seri_id integer NOT NULL,
    deger character varying(16) NOT NULL
);
 +   DROP TABLE public.ayar_irsaliye_no_serisi;
       public         postgres    false    8                       1259    477803    ayar_irsaliye_no_serisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_irsaliye_no_serisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_irsaliye_no_serisi_id_seq;
       public       postgres    false    8    263            !           0    0    ayar_irsaliye_no_serisi_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_irsaliye_no_serisi_id_seq OWNED BY public.ayar_irsaliye_no_serisi.id;
            public       postgres    false    264            "           0    0 '   SEQUENCE ayar_irsaliye_no_serisi_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_irsaliye_no_serisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_irsaliye_no_serisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_irsaliye_no_serisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_irsaliye_no_serisi_id_seq TO PUBLIC;
            public       postgres    false    264            	           1259    477805    ayar_modul_tipi    TABLE     �   CREATE TABLE public.ayar_modul_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(16)
);
 #   DROP TABLE public.ayar_modul_tipi;
       public         postgres    false    8            
           1259    477809    ayar_modul_tipi_id_seq    SEQUENCE        CREATE SEQUENCE public.ayar_modul_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.ayar_modul_tipi_id_seq;
       public       postgres    false    265    8            #           0    0    ayar_modul_tipi_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.ayar_modul_tipi_id_seq OWNED BY public.ayar_modul_tipi.id;
            public       postgres    false    266            $           0    0    SEQUENCE ayar_modul_tipi_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_modul_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_modul_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_modul_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_modul_tipi_id_seq TO PUBLIC;
            public       postgres    false    266                       1259    477811    ayar_mukellef_tipi    TABLE     �   CREATE TABLE public.ayar_mukellef_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL,
    is_default boolean DEFAULT false NOT NULL
);
 &   DROP TABLE public.ayar_mukellef_tipi;
       public         postgres    false    8                       1259    477816    ayar_mukellef_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_mukellef_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ayar_mukellef_tipi_id_seq;
       public       postgres    false    8    267            %           0    0    ayar_mukellef_tipi_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.ayar_mukellef_tipi_id_seq OWNED BY public.ayar_mukellef_tipi.id;
            public       postgres    false    268                       1259    477818    ayar_musteri_firma_turu    TABLE     �   CREATE TABLE public.ayar_musteri_firma_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(64) NOT NULL
);
 +   DROP TABLE public.ayar_musteri_firma_turu;
       public         postgres    false    8                       1259    477822    ayar_musteri_firma_turu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_musteri_firma_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_musteri_firma_turu_id_seq;
       public       postgres    false    269    8            &           0    0    ayar_musteri_firma_turu_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_musteri_firma_turu_id_seq OWNED BY public.ayar_musteri_firma_turu.id;
            public       postgres    false    270            '           0    0 '   SEQUENCE ayar_musteri_firma_turu_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_musteri_firma_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_musteri_firma_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_musteri_firma_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_musteri_firma_turu_id_seq TO PUBLIC;
            public       postgres    false    270                       1259    477824    ayar_odeme_baslangic_donemi    TABLE     �   CREATE TABLE public.ayar_odeme_baslangic_donemi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL,
    aciklama character varying(64),
    is_active boolean DEFAULT true NOT NULL
);
 /   DROP TABLE public.ayar_odeme_baslangic_donemi;
       public         postgres    false    8                       1259    477829 "   ayar_odeme_baslangic_donemi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq;
       public       postgres    false    8    271            (           0    0 "   ayar_odeme_baslangic_donemi_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq OWNED BY public.ayar_odeme_baslangic_donemi.id;
            public       postgres    false    272            )           0    0 +   SEQUENCE ayar_odeme_baslangic_donemi_id_seq    ACL     6  REVOKE ALL ON SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_odeme_baslangic_donemi_id_seq TO PUBLIC;
            public       postgres    false    272                       1259    477831    ayar_odeme_sekli    TABLE     >  CREATE TABLE public.ayar_odeme_sekli (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    kod character varying(8),
    odeme_sekli character varying(96) NOT NULL,
    aciklama character varying(512),
    is_efatura boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT false NOT NULL
);
 $   DROP TABLE public.ayar_odeme_sekli;
       public         postgres    false    8                       1259    477840    ayar_odeme_sekli_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_odeme_sekli_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.ayar_odeme_sekli_id_seq;
       public       postgres    false    273    8            *           0    0    ayar_odeme_sekli_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.ayar_odeme_sekli_id_seq OWNED BY public.ayar_odeme_sekli.id;
            public       postgres    false    274            +           0    0     SEQUENCE ayar_odeme_sekli_id_seq    ACL     
  REVOKE ALL ON SEQUENCE public.ayar_odeme_sekli_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_odeme_sekli_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_odeme_sekli_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_odeme_sekli_id_seq TO PUBLIC;
            public       postgres    false    274            �           1259    793020    ayar_prs_askerlik_durumu    TABLE     ~   CREATE TABLE public.ayar_prs_askerlik_durumu (
    id integer NOT NULL,
    askerlik_durumu character varying(16) NOT NULL
);
 ,   DROP TABLE public.ayar_prs_askerlik_durumu;
       public         postgres    false    8            �           1259    793018    ayar_prs_askerlik_durumu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_askerlik_durumu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.ayar_prs_askerlik_durumu_id_seq;
       public       postgres    false    413    8            ,           0    0    ayar_prs_askerlik_durumu_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.ayar_prs_askerlik_durumu_id_seq OWNED BY public.ayar_prs_askerlik_durumu.id;
            public       postgres    false    412            �           1259    821958    ayar_prs_ayrilma_nedeni    TABLE     |   CREATE TABLE public.ayar_prs_ayrilma_nedeni (
    id integer NOT NULL,
    ayrilma_nedeni character varying(32) NOT NULL
);
 +   DROP TABLE public.ayar_prs_ayrilma_nedeni;
       public         postgres    false    8            �           1259    821956    ayar_prs_ayrilma_nedeni_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_ayrilma_nedeni_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_prs_ayrilma_nedeni_id_seq;
       public       postgres    false    8    448            -           0    0    ayar_prs_ayrilma_nedeni_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_prs_ayrilma_nedeni_id_seq OWNED BY public.ayar_prs_ayrilma_nedeni.id;
            public       postgres    false    447            �           1259    820768    ayar_prs_birim    TABLE     �   CREATE TABLE public.ayar_prs_birim (
    id integer NOT NULL,
    bolum_id integer NOT NULL,
    birim character varying(32) NOT NULL
);
 "   DROP TABLE public.ayar_prs_birim;
       public         postgres    false    8            .           0    0    TABLE ayar_prs_birim    COMMENT     �   COMMENT ON TABLE public.ayar_prs_birim IS 'Personelin şirket içindeki bölüm içindeki birimi(Departman içindeki alt kol)';
            public       postgres    false    446            �           1259    820766    ayar_prs_birim_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.ayar_prs_birim_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.ayar_prs_birim_id_seq;
       public       postgres    false    8    446            /           0    0    ayar_prs_birim_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.ayar_prs_birim_id_seq OWNED BY public.ayar_prs_birim.id;
            public       postgres    false    445            �           1259    820747    ayar_prs_bolum    TABLE     j   CREATE TABLE public.ayar_prs_bolum (
    id integer NOT NULL,
    bolum character varying(32) NOT NULL
);
 "   DROP TABLE public.ayar_prs_bolum;
       public         postgres    false    8            0           0    0    TABLE ayar_prs_bolum    COMMENT     p   COMMENT ON TABLE public.ayar_prs_bolum IS 'Personelin şirket içindeki çalıştığı bölüme ait bilgiler';
            public       postgres    false    444            �           1259    820745    ayar_prs_bolum_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.ayar_prs_bolum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.ayar_prs_bolum_id_seq;
       public       postgres    false    8    444            1           0    0    ayar_prs_bolum_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.ayar_prs_bolum_id_seq OWNED BY public.ayar_prs_bolum.id;
            public       postgres    false    443            �           1259    820721    ayar_prs_cinsiyet    TABLE     �   CREATE TABLE public.ayar_prs_cinsiyet (
    id integer NOT NULL,
    cinsiyet character varying(32) NOT NULL,
    is_man boolean DEFAULT false NOT NULL
);
 %   DROP TABLE public.ayar_prs_cinsiyet;
       public         postgres    false    8            �           1259    820719    ayar_prs_cinsiyet_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_cinsiyet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.ayar_prs_cinsiyet_id_seq;
       public       postgres    false    442    8            2           0    0    ayar_prs_cinsiyet_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.ayar_prs_cinsiyet_id_seq OWNED BY public.ayar_prs_cinsiyet.id;
            public       postgres    false    441            �           1259    820683    ayar_prs_egitim_durumu    TABLE     z   CREATE TABLE public.ayar_prs_egitim_durumu (
    id integer NOT NULL,
    egitim_durumu character varying(32) NOT NULL
);
 *   DROP TABLE public.ayar_prs_egitim_durumu;
       public         postgres    false    8            �           1259    820681    ayar_prs_egitim_durumu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_egitim_durumu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.ayar_prs_egitim_durumu_id_seq;
       public       postgres    false    436    8            3           0    0    ayar_prs_egitim_durumu_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.ayar_prs_egitim_durumu_id_seq OWNED BY public.ayar_prs_egitim_durumu.id;
            public       postgres    false    435            �           1259    820673    ayar_prs_ehliyet_tipi    TABLE     x   CREATE TABLE public.ayar_prs_ehliyet_tipi (
    id integer NOT NULL,
    ehliyet_tipi character varying(32) NOT NULL
);
 )   DROP TABLE public.ayar_prs_ehliyet_tipi;
       public         postgres    false    8            �           1259    820671    ayar_prs_ehliyet_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_ehliyet_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.ayar_prs_ehliyet_tipi_id_seq;
       public       postgres    false    434    8            4           0    0    ayar_prs_ehliyet_tipi_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.ayar_prs_ehliyet_tipi_id_seq OWNED BY public.ayar_prs_ehliyet_tipi.id;
            public       postgres    false    433            �           1259    820658    ayar_prs_gorev    TABLE     j   CREATE TABLE public.ayar_prs_gorev (
    id integer NOT NULL,
    gorev character varying(32) NOT NULL
);
 "   DROP TABLE public.ayar_prs_gorev;
       public         postgres    false    8            5           0    0    TABLE ayar_prs_gorev    COMMENT     R   COMMENT ON TABLE public.ayar_prs_gorev IS 'Personelin şirket içindeki görevi';
            public       postgres    false    432            �           1259    820656    ayar_prs_gorev_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.ayar_prs_gorev_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.ayar_prs_gorev_id_seq;
       public       postgres    false    432    8            6           0    0    ayar_prs_gorev_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.ayar_prs_gorev_id_seq OWNED BY public.ayar_prs_gorev.id;
            public       postgres    false    431            �           1259    812289    ayar_prs_izin_tipi    TABLE     r   CREATE TABLE public.ayar_prs_izin_tipi (
    id integer NOT NULL,
    izin_tipi character varying(32) NOT NULL
);
 &   DROP TABLE public.ayar_prs_izin_tipi;
       public         postgres    false    8            �           1259    812287    ayar_prs_izin_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_izin_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ayar_prs_izin_tipi_id_seq;
       public       postgres    false    8    429            7           0    0    ayar_prs_izin_tipi_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.ayar_prs_izin_tipi_id_seq OWNED BY public.ayar_prs_izin_tipi.id;
            public       postgres    false    428            �           1259    819110    ayar_prs_kan_grubu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_kan_grubu_id_seq
    START WITH 8
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.ayar_prs_kan_grubu_id_seq;
       public       postgres    false    8            8           0    0 "   SEQUENCE ayar_prs_kan_grubu_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_prs_kan_grubu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_prs_kan_grubu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_prs_kan_grubu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_prs_kan_grubu_id_seq TO PUBLIC;
            public       postgres    false    430            �           1259    801407    ayar_prs_medeni_durum    TABLE     �   CREATE TABLE public.ayar_prs_medeni_durum (
    id integer NOT NULL,
    medeni_durum character varying(32) NOT NULL,
    is_married boolean DEFAULT false NOT NULL
);
 )   DROP TABLE public.ayar_prs_medeni_durum;
       public         postgres    false    8            �           1259    801405    ayar_prs_medeni_durum_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_medeni_durum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.ayar_prs_medeni_durum_id_seq;
       public       postgres    false    427    8            9           0    0    ayar_prs_medeni_durum_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.ayar_prs_medeni_durum_id_seq OWNED BY public.ayar_prs_medeni_durum.id;
            public       postgres    false    426            �           1259    801397    ayar_prs_mektup_tipi    TABLE     v   CREATE TABLE public.ayar_prs_mektup_tipi (
    id integer NOT NULL,
    mektup_tipi character varying(32) NOT NULL
);
 (   DROP TABLE public.ayar_prs_mektup_tipi;
       public         postgres    false    8            �           1259    801395    ayar_prs_mektup_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_mektup_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.ayar_prs_mektup_tipi_id_seq;
       public       postgres    false    425    8            :           0    0    ayar_prs_mektup_tipi_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.ayar_prs_mektup_tipi_id_seq OWNED BY public.ayar_prs_mektup_tipi.id;
            public       postgres    false    424            �           1259    801387    ayar_prs_myk_tipi    TABLE     p   CREATE TABLE public.ayar_prs_myk_tipi (
    id integer NOT NULL,
    myk_tipi character varying(32) NOT NULL
);
 %   DROP TABLE public.ayar_prs_myk_tipi;
       public         postgres    false    8            �           1259    801385    ayar_prs_myk_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_myk_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.ayar_prs_myk_tipi_id_seq;
       public       postgres    false    423    8            ;           0    0    ayar_prs_myk_tipi_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.ayar_prs_myk_tipi_id_seq OWNED BY public.ayar_prs_myk_tipi.id;
            public       postgres    false    422            �           1259    793030    ayar_prs_personel_tipi    TABLE     �   CREATE TABLE public.ayar_prs_personel_tipi (
    id integer NOT NULL,
    personel_tipi character varying(32) NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);
 *   DROP TABLE public.ayar_prs_personel_tipi;
       public         postgres    false    8            <           0    0    TABLE ayar_prs_personel_tipi    COMMENT     ^   COMMENT ON TABLE public.ayar_prs_personel_tipi IS 'Personelin tipi (Beyaz Yaka - Mavi Yaka)';
            public       postgres    false    415            �           1259    793028    ayar_prs_personel_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_personel_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.ayar_prs_personel_tipi_id_seq;
       public       postgres    false    415    8            =           0    0    ayar_prs_personel_tipi_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.ayar_prs_personel_tipi_id_seq OWNED BY public.ayar_prs_personel_tipi.id;
            public       postgres    false    414            �           1259    801363    ayar_prs_rapor_tipi    TABLE     t   CREATE TABLE public.ayar_prs_rapor_tipi (
    id integer NOT NULL,
    rapor_tipi character varying(32) NOT NULL
);
 '   DROP TABLE public.ayar_prs_rapor_tipi;
       public         postgres    false    8            �           1259    801361    ayar_prs_rapor_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_rapor_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.ayar_prs_rapor_tipi_id_seq;
       public       postgres    false    8    419            >           0    0    ayar_prs_rapor_tipi_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.ayar_prs_rapor_tipi_id_seq OWNED BY public.ayar_prs_rapor_tipi.id;
            public       postgres    false    418            �           1259    801373    ayar_prs_src_tipi    TABLE     p   CREATE TABLE public.ayar_prs_src_tipi (
    id integer NOT NULL,
    src_tipi character varying(32) NOT NULL
);
 %   DROP TABLE public.ayar_prs_src_tipi;
       public         postgres    false    8            �           1259    801371    ayar_prs_src_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_src_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.ayar_prs_src_tipi_id_seq;
       public       postgres    false    8    421            ?           0    0    ayar_prs_src_tipi_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.ayar_prs_src_tipi_id_seq OWNED BY public.ayar_prs_src_tipi.id;
            public       postgres    false    420            �           1259    794527    ayar_prs_tatil_tipi    TABLE     �   CREATE TABLE public.ayar_prs_tatil_tipi (
    id integer NOT NULL,
    tatil_tipi character varying(32) NOT NULL,
    is_resmi_tatil boolean DEFAULT true NOT NULL
);
 '   DROP TABLE public.ayar_prs_tatil_tipi;
       public         postgres    false    8            �           1259    794525    ayar_prs_tatil_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_tatil_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.ayar_prs_tatil_tipi_id_seq;
       public       postgres    false    417    8            @           0    0    ayar_prs_tatil_tipi_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.ayar_prs_tatil_tipi_id_seq OWNED BY public.ayar_prs_tatil_tipi.id;
            public       postgres    false    416            �           1259    820703    ayar_prs_yabanci_dil    TABLE     v   CREATE TABLE public.ayar_prs_yabanci_dil (
    id integer NOT NULL,
    yabanci_dil character varying(16) NOT NULL
);
 (   DROP TABLE public.ayar_prs_yabanci_dil;
       public         postgres    false    8            �           1259    820701    ayar_prs_yabanci_dil_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_yabanci_dil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.ayar_prs_yabanci_dil_id_seq;
       public       postgres    false    440    8            A           0    0    ayar_prs_yabanci_dil_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.ayar_prs_yabanci_dil_id_seq OWNED BY public.ayar_prs_yabanci_dil.id;
            public       postgres    false    439            �           1259    820693    ayar_prs_yabanci_dil_seviyesi    TABLE     �   CREATE TABLE public.ayar_prs_yabanci_dil_seviyesi (
    id integer NOT NULL,
    yabanci_dil_seviyesi character varying(16) NOT NULL
);
 1   DROP TABLE public.ayar_prs_yabanci_dil_seviyesi;
       public         postgres    false    8            �           1259    820691 $   ayar_prs_yabanci_dil_seviyesi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_prs_yabanci_dil_seviyesi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.ayar_prs_yabanci_dil_seviyesi_id_seq;
       public       postgres    false    8    438            B           0    0 $   ayar_prs_yabanci_dil_seviyesi_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.ayar_prs_yabanci_dil_seviyesi_id_seq OWNED BY public.ayar_prs_yabanci_dil_seviyesi.id;
            public       postgres    false    437                       1259    477958    ayar_sabit_degisken    TABLE     o   CREATE TABLE public.ayar_sabit_degisken (
    id integer NOT NULL,
    deger character varying(16) NOT NULL
);
 '   DROP TABLE public.ayar_sabit_degisken;
       public         postgres    false    8            C           0    0    TABLE ayar_sabit_degisken    ACL     �   REVOKE ALL ON TABLE public.ayar_sabit_degisken FROM PUBLIC;
REVOKE ALL ON TABLE public.ayar_sabit_degisken FROM postgres;
GRANT ALL ON TABLE public.ayar_sabit_degisken TO postgres;
            public       postgres    false    275                       1259    477962    ayar_sabit_degisken_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_sabit_degisken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.ayar_sabit_degisken_id_seq;
       public       postgres    false    275    8            D           0    0    ayar_sabit_degisken_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.ayar_sabit_degisken_id_seq OWNED BY public.ayar_sabit_degisken.id;
            public       postgres    false    276            E           0    0 #   SEQUENCE ayar_sabit_degisken_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_sabit_degisken_id_seq TO PUBLIC;
            public       postgres    false    276                       1259    477964    ayar_sevkiyat_hazirlama_durumu    TABLE     �   CREATE TABLE public.ayar_sevkiyat_hazirlama_durumu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL
);
 2   DROP TABLE public.ayar_sevkiyat_hazirlama_durumu;
       public         postgres    false    8                       1259    477968 %   ayar_sevkiyat_hazirlama_durumu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq;
       public       postgres    false    277    8            F           0    0 %   ayar_sevkiyat_hazirlama_durumu_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq OWNED BY public.ayar_sevkiyat_hazirlama_durumu.id;
            public       postgres    false    278            G           0    0 .   SEQUENCE ayar_sevkiyat_hazirlama_durumu_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_sevkiyat_hazirlama_durumu_id_seq TO PUBLIC;
            public       postgres    false    278                       1259    477970    ayar_stok_hareket_ayari    TABLE     �   CREATE TABLE public.ayar_stok_hareket_ayari (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    giris_ayari character varying(16),
    cikis_ayari character varying(16)
);
 +   DROP TABLE public.ayar_stok_hareket_ayari;
       public         postgres    false    8                       1259    477974    ayar_stok_hareket_ayari_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_stok_hareket_ayari_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ayar_stok_hareket_ayari_id_seq;
       public       postgres    false    279    8            H           0    0    ayar_stok_hareket_ayari_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ayar_stok_hareket_ayari_id_seq OWNED BY public.ayar_stok_hareket_ayari.id;
            public       postgres    false    280            I           0    0 '   SEQUENCE ayar_stok_hareket_ayari_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.ayar_stok_hareket_ayari_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_stok_hareket_ayari_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_stok_hareket_ayari_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_stok_hareket_ayari_id_seq TO PUBLIC;
            public       postgres    false    280                       1259    477976    ayar_stok_hareket_tipi    TABLE     �   CREATE TABLE public.ayar_stok_hareket_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(8) NOT NULL,
    is_input boolean DEFAULT false NOT NULL
);
 *   DROP TABLE public.ayar_stok_hareket_tipi;
       public         postgres    false    8                       1259    477981    ayar_stok_hareket_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_stok_hareket_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.ayar_stok_hareket_tipi_id_seq;
       public       postgres    false    8    281            J           0    0    ayar_stok_hareket_tipi_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.ayar_stok_hareket_tipi_id_seq OWNED BY public.ayar_stok_hareket_tipi.id;
            public       postgres    false    282            K           0    0 &   SEQUENCE ayar_stok_hareket_tipi_id_seq    ACL     "  REVOKE ALL ON SEQUENCE public.ayar_stok_hareket_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_stok_hareket_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_stok_hareket_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_stok_hareket_tipi_id_seq TO PUBLIC;
            public       postgres    false    282                       1259    477983    ayar_teklif_durum    TABLE     �   CREATE TABLE public.ayar_teklif_durum (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL,
    aciklama character varying(64),
    is_active boolean DEFAULT true NOT NULL
);
 %   DROP TABLE public.ayar_teklif_durum;
       public         postgres    false    8                       1259    477988    ayar_teklif_durum_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_teklif_durum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.ayar_teklif_durum_id_seq;
       public       postgres    false    8    283            L           0    0    ayar_teklif_durum_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.ayar_teklif_durum_id_seq OWNED BY public.ayar_teklif_durum.id;
            public       postgres    false    284            M           0    0 !   SEQUENCE ayar_teklif_durum_id_seq    ACL       REVOKE ALL ON SEQUENCE public.ayar_teklif_durum_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_teklif_durum_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_teklif_durum_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_teklif_durum_id_seq TO PUBLIC;
            public       postgres    false    284                       1259    477990    ayar_teklif_tipi    TABLE     �   CREATE TABLE public.ayar_teklif_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(32) NOT NULL,
    aciklama character varying(64),
    is_active boolean DEFAULT true NOT NULL
);
 $   DROP TABLE public.ayar_teklif_tipi;
       public         postgres    false    8                       1259    477995    ayar_teklif_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_teklif_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.ayar_teklif_tipi_id_seq;
       public       postgres    false    8    285            N           0    0    ayar_teklif_tipi_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.ayar_teklif_tipi_id_seq OWNED BY public.ayar_teklif_tipi.id;
            public       postgres    false    286            O           0    0     SEQUENCE ayar_teklif_tipi_id_seq    ACL     
  REVOKE ALL ON SEQUENCE public.ayar_teklif_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_teklif_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_teklif_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_teklif_tipi_id_seq TO PUBLIC;
            public       postgres    false    286                       1259    477997    ayar_vergi_orani    TABLE     i  CREATE TABLE public.ayar_vergi_orani (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    vergi_orani double precision NOT NULL,
    satis_vergi_hesap_kodu character varying(32),
    satis_iade_vergi_hesap_kodu character varying(32),
    alis_vergi_hesap_kodu character varying(32),
    alis_iade_vergi_hesap_kodu character varying(32)
);
 $   DROP TABLE public.ayar_vergi_orani;
       public         postgres    false    8                        1259    478001    ayar_vergi_orani_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ayar_vergi_orani_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.ayar_vergi_orani_id_seq;
       public       postgres    false    8    287            P           0    0    ayar_vergi_orani_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.ayar_vergi_orani_id_seq OWNED BY public.ayar_vergi_orani.id;
            public       postgres    false    288            Q           0    0     SEQUENCE ayar_vergi_orani_id_seq    ACL     
  REVOKE ALL ON SEQUENCE public.ayar_vergi_orani_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ayar_vergi_orani_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ayar_vergi_orani_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ayar_vergi_orani_id_seq TO PUBLIC;
            public       postgres    false    288            !           1259    478003    banka    TABLE     �   CREATE TABLE public.banka (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    adi character varying(64) NOT NULL,
    swift_kodu character varying(16),
    is_active boolean DEFAULT true NOT NULL
);
    DROP TABLE public.banka;
       public         postgres    false    8            "           1259    478008    banka_id_seq    SEQUENCE     u   CREATE SEQUENCE public.banka_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.banka_id_seq;
       public       postgres    false    289    8            R           0    0    banka_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.banka_id_seq OWNED BY public.banka.id;
            public       postgres    false    290            S           0    0    SEQUENCE banka_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.banka_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.banka_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.banka_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.banka_id_seq TO PUBLIC;
            public       postgres    false    290            #           1259    478010    banka_subesi    TABLE     �   CREATE TABLE public.banka_subesi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    banka_id integer NOT NULL,
    sube_kodu integer NOT NULL,
    sube_adi character varying(64) NOT NULL,
    sube_il_id integer NOT NULL
);
     DROP TABLE public.banka_subesi;
       public         postgres    false    8            $           1259    478014    banka_subesi_id_seq    SEQUENCE     |   CREATE SEQUENCE public.banka_subesi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.banka_subesi_id_seq;
       public       postgres    false    291    8            T           0    0    banka_subesi_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.banka_subesi_id_seq OWNED BY public.banka_subesi.id;
            public       postgres    false    292            U           0    0    SEQUENCE banka_subesi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.banka_subesi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.banka_subesi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.banka_subesi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.banka_subesi_id_seq TO PUBLIC;
            public       postgres    false    292            %           1259    478016    barkod_hazirlik_dosya_turu    TABLE     �   CREATE TABLE public.barkod_hazirlik_dosya_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(32)
);
 .   DROP TABLE public.barkod_hazirlik_dosya_turu;
       public         postgres    false    8            &           1259    478020 !   barkod_hazirlik_dosya_turu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq;
       public       postgres    false    8    293            V           0    0 !   barkod_hazirlik_dosya_turu_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq OWNED BY public.barkod_hazirlik_dosya_turu.id;
            public       postgres    false    294            W           0    0 *   SEQUENCE barkod_hazirlik_dosya_turu_id_seq    ACL     2  REVOKE ALL ON SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.barkod_hazirlik_dosya_turu_id_seq TO PUBLIC;
            public       postgres    false    294            '           1259    478022    barkod_serino_turu    TABLE     �   CREATE TABLE public.barkod_serino_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(4),
    aciklama character varying(32)
);
 &   DROP TABLE public.barkod_serino_turu;
       public         postgres    false    8            (           1259    478026    barkod_serino_turu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.barkod_serino_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.barkod_serino_turu_id_seq;
       public       postgres    false    8    295            X           0    0    barkod_serino_turu_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.barkod_serino_turu_id_seq OWNED BY public.barkod_serino_turu.id;
            public       postgres    false    296            Y           0    0 "   SEQUENCE barkod_serino_turu_id_seq    ACL       REVOKE ALL ON SEQUENCE public.barkod_serino_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.barkod_serino_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.barkod_serino_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.barkod_serino_turu_id_seq TO PUBLIC;
            public       postgres    false    296            )           1259    478028    barkod_tezgah    TABLE     �   CREATE TABLE public.barkod_tezgah (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tezgah_adi character varying(32) NOT NULL,
    ambar_id integer NOT NULL
);
 !   DROP TABLE public.barkod_tezgah;
       public         postgres    false    8            *           1259    478032    barkod_tezgah_id_seq    SEQUENCE     }   CREATE SEQUENCE public.barkod_tezgah_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.barkod_tezgah_id_seq;
       public       postgres    false    8    297            Z           0    0    barkod_tezgah_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.barkod_tezgah_id_seq OWNED BY public.barkod_tezgah.id;
            public       postgres    false    298            [           0    0    SEQUENCE barkod_tezgah_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.barkod_tezgah_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.barkod_tezgah_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.barkod_tezgah_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.barkod_tezgah_id_seq TO PUBLIC;
            public       postgres    false    298            +           1259    478034    bolge    TABLE     8  CREATE TABLE public.bolge (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    bolge_adi character varying(24) NOT NULL,
    bolge_turu_id integer,
    hedef_ocak double precision DEFAULT 0 NOT NULL,
    hedef_subat double precision DEFAULT 0 NOT NULL,
    hedef_mart double precision DEFAULT 0 NOT NULL,
    hedef_nisan double precision DEFAULT 0 NOT NULL,
    hedef_mayis double precision DEFAULT 0 NOT NULL,
    hedef_haziran double precision DEFAULT 0 NOT NULL,
    hedef_temmuz double precision DEFAULT 0 NOT NULL,
    hedef_agustos double precision DEFAULT 0 NOT NULL,
    hedef_eylul double precision DEFAULT 0 NOT NULL,
    hedef_ekim double precision DEFAULT 0 NOT NULL,
    hedef_kasim double precision DEFAULT 0 NOT NULL,
    hedef_aralik double precision DEFAULT 0 NOT NULL,
    hedef_mamul_ocak double precision DEFAULT 0 NOT NULL,
    hedef_mamul_subat double precision DEFAULT 0 NOT NULL,
    hedef_mamul_mart double precision DEFAULT 0 NOT NULL,
    hedef_mamul_nisan double precision DEFAULT 0 NOT NULL,
    hedef_mamul_mayis double precision DEFAULT 0 NOT NULL,
    hedef_mamul_haziran double precision DEFAULT 0 NOT NULL,
    hedef_mamul_temmuz double precision DEFAULT 0 NOT NULL,
    hedef_mamul_agustos double precision DEFAULT 0 NOT NULL,
    hedef_mamul_eylul double precision DEFAULT 0 NOT NULL,
    hedef_mamul_ekim double precision DEFAULT 0 NOT NULL,
    hedef_mamul_kasim double precision DEFAULT 0 NOT NULL,
    hedef_mamul_aralik double precision DEFAULT 0 NOT NULL,
    gecen_ocak double precision DEFAULT 0 NOT NULL,
    gecen_subat double precision DEFAULT 0 NOT NULL,
    gecen_mart double precision DEFAULT 0 NOT NULL,
    gecen_nisan double precision DEFAULT 0 NOT NULL,
    gecen_mayis double precision DEFAULT 0 NOT NULL,
    gecen_haziran double precision DEFAULT 0 NOT NULL,
    gecen_temmuz double precision DEFAULT 0 NOT NULL,
    gecen_agustos double precision DEFAULT 0 NOT NULL,
    gecen_eylul double precision DEFAULT 0 NOT NULL,
    gecen_ekim double precision DEFAULT 0 NOT NULL,
    gecen_kasim double precision DEFAULT 0 NOT NULL,
    gecen_aralik double precision DEFAULT 0 NOT NULL,
    gecen_mamul_ocak double precision DEFAULT 0 NOT NULL,
    gecen_mamul_subat double precision DEFAULT 0 NOT NULL,
    gecen_mamul_mart double precision DEFAULT 0 NOT NULL,
    gecen_mamul_nisan double precision DEFAULT 0 NOT NULL,
    gecen_mamul_mayis double precision DEFAULT 0 NOT NULL,
    gecen_mamul_haziran double precision DEFAULT 0 NOT NULL,
    gecen_mamul_temmuz double precision DEFAULT 0 NOT NULL,
    gecen_mamul_agustos double precision DEFAULT 0 NOT NULL,
    gecen_mamul_eylul double precision DEFAULT 0 NOT NULL,
    gecen_mamul_ekim double precision DEFAULT 0 NOT NULL,
    gecen_mamul_kasim double precision DEFAULT 0 NOT NULL,
    gecen_mamul_aralik double precision DEFAULT 0 NOT NULL
);
    DROP TABLE public.bolge;
       public         postgres    false    8            ,           1259    478086    bolge_id_seq    SEQUENCE     u   CREATE SEQUENCE public.bolge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.bolge_id_seq;
       public       postgres    false    8    299            \           0    0    bolge_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.bolge_id_seq OWNED BY public.bolge.id;
            public       postgres    false    300            -           1259    478088 
   bolge_turu    TABLE     �   CREATE TABLE public.bolge_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tur character varying(32) NOT NULL
);
    DROP TABLE public.bolge_turu;
       public         postgres    false    8            ]           0    0    TABLE bolge_turu    ACL     �   REVOKE ALL ON TABLE public.bolge_turu FROM PUBLIC;
REVOKE ALL ON TABLE public.bolge_turu FROM postgres;
GRANT ALL ON TABLE public.bolge_turu TO postgres;
            public       postgres    false    301            .           1259    478092    bolge_turu_id_seq    SEQUENCE     z   CREATE SEQUENCE public.bolge_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.bolge_turu_id_seq;
       public       postgres    false    301    8            ^           0    0    bolge_turu_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.bolge_turu_id_seq OWNED BY public.bolge_turu.id;
            public       postgres    false    302            _           0    0    SEQUENCE bolge_turu_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.bolge_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.bolge_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.bolge_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.bolge_turu_id_seq TO PUBLIC;
            public       postgres    false    302            /           1259    478094    cins_ailesi    TABLE     �   CREATE TABLE public.cins_ailesi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    aile character varying(16) NOT NULL
);
    DROP TABLE public.cins_ailesi;
       public         postgres    false    8            0           1259    478098    cins_ailesi_id_seq    SEQUENCE     {   CREATE SEQUENCE public.cins_ailesi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cins_ailesi_id_seq;
       public       postgres    false    8    303            `           0    0    cins_ailesi_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cins_ailesi_id_seq OWNED BY public.cins_ailesi.id;
            public       postgres    false    304            a           0    0    SEQUENCE cins_ailesi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.cins_ailesi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.cins_ailesi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.cins_ailesi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.cins_ailesi_id_seq TO PUBLIC;
            public       postgres    false    304            1           1259    478100    cins_ozelligi    TABLE     �  CREATE TABLE public.cins_ozelligi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    cins_aile_id integer NOT NULL,
    cins character varying(32) NOT NULL,
    aciklama character varying(128),
    string1 character varying(24),
    string2 character varying(24),
    string3 character varying(24),
    string4 character varying(24),
    string5 character varying(24),
    string6 character varying(24),
    string7 character varying(24),
    string8 character varying(24),
    string9 character varying(24),
    string10 character varying(16),
    string11 character varying(16),
    string12 character varying(16),
    is_serino_icerir boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.cins_ozelligi;
       public         postgres    false    8            2           1259    478105    cins_ozelligi_id_seq    SEQUENCE     }   CREATE SEQUENCE public.cins_ozelligi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cins_ozelligi_id_seq;
       public       postgres    false    305    8            b           0    0    cins_ozelligi_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.cins_ozelligi_id_seq OWNED BY public.cins_ozelligi.id;
            public       postgres    false    306            c           0    0    SEQUENCE cins_ozelligi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.cins_ozelligi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.cins_ozelligi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.cins_ozelligi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.cins_ozelligi_id_seq TO PUBLIC;
            public       postgres    false    306            3           1259    478107    cnf_employee_section    TABLE     �   CREATE TABLE public.cnf_employee_section (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    section character varying(32)
);
 (   DROP TABLE public.cnf_employee_section;
       public         postgres    false    8            4           1259    478111    cnf_employee_section_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cnf_employee_section_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cnf_employee_section_id_seq;
       public       postgres    false    307    8            d           0    0    cnf_employee_section_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.cnf_employee_section_id_seq OWNED BY public.cnf_employee_section.id;
            public       postgres    false    308            5           1259    478113 
   doviz_kuru    TABLE     �   CREATE TABLE public.doviz_kuru (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tarih date NOT NULL,
    para_birimi character varying(3) NOT NULL,
    kur double precision NOT NULL
);
    DROP TABLE public.doviz_kuru;
       public         postgres    false    8            6           1259    478117    doviz_kuru_id_seq    SEQUENCE     z   CREATE SEQUENCE public.doviz_kuru_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.doviz_kuru_id_seq;
       public       postgres    false    309    8            e           0    0    doviz_kuru_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.doviz_kuru_id_seq OWNED BY public.doviz_kuru.id;
            public       postgres    false    310            f           0    0    SEQUENCE doviz_kuru_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.doviz_kuru_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.doviz_kuru_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.doviz_kuru_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.doviz_kuru_id_seq TO PUBLIC;
            public       postgres    false    310            7           1259    478119    hesap_grubu    TABLE     �   CREATE TABLE public.hesap_grubu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    grup character varying(16) NOT NULL
);
    DROP TABLE public.hesap_grubu;
       public         postgres    false    8            g           0    0    TABLE hesap_grubu    ACL     �   REVOKE ALL ON TABLE public.hesap_grubu FROM PUBLIC;
REVOKE ALL ON TABLE public.hesap_grubu FROM postgres;
GRANT ALL ON TABLE public.hesap_grubu TO postgres;
            public       postgres    false    311            8           1259    478123    hesap_grubu_id_seq    SEQUENCE     {   CREATE SEQUENCE public.hesap_grubu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hesap_grubu_id_seq;
       public       postgres    false    311    8            h           0    0    hesap_grubu_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.hesap_grubu_id_seq OWNED BY public.hesap_grubu.id;
            public       postgres    false    312            i           0    0    SEQUENCE hesap_grubu_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.hesap_grubu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.hesap_grubu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.hesap_grubu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.hesap_grubu_id_seq TO PUBLIC;
            public       postgres    false    312            �           1259    699376    hesap_karti    TABLE     �  CREATE TABLE public.hesap_karti (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    hesap_kodu character varying(32) NOT NULL,
    hesap_ismi character varying(128) NOT NULL,
    muhasebe_kodu character varying(32),
    hesap_tipi_id integer NOT NULL,
    hesap_grubu_id integer NOT NULL,
    bolge_id integer,
    temsilci_grubu_id integer,
    mukellef_tipi_id integer,
    musteri_temsilcisi_id integer,
    adres_id integer,
    mukellef_adi character varying(32),
    mukellef_ikinci_adi character varying(32),
    mukellef_soyadi character varying(32),
    vergi_dairesi character varying(64),
    vergi_no character varying(32),
    para_birimi character varying(3),
    iban character varying(64),
    iban_para character varying(3),
    nace_kodu character varying(32),
    is_efatura_hesabi boolean DEFAULT false NOT NULL,
    efatura_pk_name character varying(64),
    yetkili1 character varying(64),
    yetkili1_tel character varying(32),
    yetkili2 character varying(64),
    yetkili2_tel character varying(32),
    yetkili3 character varying(64),
    yetkili3_tel character varying(32),
    faks character varying(32),
    muhasebe_telefon character varying(32),
    muhasebe_eposta character varying(128),
    muhasebe_yetkili character varying(32),
    ozel_bilgi character varying(512),
    odeme_vade_gun_sayisi integer,
    is_acik_hesap boolean DEFAULT false NOT NULL,
    kredi_limiti double precision,
    hesap_iskonto double precision
);
    DROP TABLE public.hesap_karti;
       public         postgres    false    8            �           1259    699374    hesap_karti_id_seq    SEQUENCE     {   CREATE SEQUENCE public.hesap_karti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hesap_karti_id_seq;
       public       postgres    false    411    8            j           0    0    hesap_karti_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.hesap_karti_id_seq OWNED BY public.hesap_karti.id;
            public       postgres    false    410            9           1259    478136    hesap_plani    TABLE       CREATE TABLE public.hesap_plani (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    plan_kodu_varsayilan character varying(16) NOT NULL,
    aciklama character varying(128),
    plan_kodu character varying(16),
    seviye_sayisi smallint
);
    DROP TABLE public.hesap_plani;
       public         postgres    false    8            :           1259    478140    hesap_plani_id_seq    SEQUENCE     {   CREATE SEQUENCE public.hesap_plani_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hesap_plani_id_seq;
       public       postgres    false    8    313            k           0    0    hesap_plani_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.hesap_plani_id_seq OWNED BY public.hesap_plani.id;
            public       postgres    false    314            ;           1259    478142    medeni_durum    TABLE     �   CREATE TABLE public.medeni_durum (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    durum character varying(16) NOT NULL
);
     DROP TABLE public.medeni_durum;
       public         postgres    false    8            l           0    0    TABLE medeni_durum    COMMENT     F   COMMENT ON TABLE public.medeni_durum IS 'Medeni Durumu (Evli-Bekar)';
            public       postgres    false    315            <           1259    478146    medeni_durum_id_seq    SEQUENCE     |   CREATE SEQUENCE public.medeni_durum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.medeni_durum_id_seq;
       public       postgres    false    8    315            m           0    0    medeni_durum_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.medeni_durum_id_seq OWNED BY public.medeni_durum.id;
            public       postgres    false    316            n           0    0    SEQUENCE medeni_durum_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.medeni_durum_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.medeni_durum_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.medeni_durum_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.medeni_durum_id_seq TO PUBLIC;
            public       postgres    false    316            =           1259    478148    muhasebe_hesap_plani    TABLE     ?  CREATE TABLE public.muhasebe_hesap_plani (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tek_duzen_kodu character varying(3) NOT NULL,
    plan_kodu character varying(3),
    aciklama character varying(128) NOT NULL,
    seviye_sayisi smallint,
    is_active boolean DEFAULT true NOT NULL
);
 (   DROP TABLE public.muhasebe_hesap_plani;
       public         postgres    false    8            o           0    0    TABLE muhasebe_hesap_plani    ACL     �   REVOKE ALL ON TABLE public.muhasebe_hesap_plani FROM PUBLIC;
REVOKE ALL ON TABLE public.muhasebe_hesap_plani FROM postgres;
GRANT ALL ON TABLE public.muhasebe_hesap_plani TO postgres;
            public       postgres    false    317            >           1259    478153    muhasebe_hesap_plani_id_seq    SEQUENCE     �   CREATE SEQUENCE public.muhasebe_hesap_plani_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.muhasebe_hesap_plani_id_seq;
       public       postgres    false    8    317            p           0    0    muhasebe_hesap_plani_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.muhasebe_hesap_plani_id_seq OWNED BY public.muhasebe_hesap_plani.id;
            public       postgres    false    318            q           0    0 $   SEQUENCE muhasebe_hesap_plani_id_seq    ACL       REVOKE ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.muhasebe_hesap_plani_id_seq TO PUBLIC;
            public       postgres    false    318            ?           1259    478155    musteri_temsilci_grubu    TABLE     �  CREATE TABLE public.musteri_temsilci_grubu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    temsilci_grup_adi character varying(32) NOT NULL,
    gecmis_ocak double precision DEFAULT 0 NOT NULL,
    gecmis_subat double precision DEFAULT 0 NOT NULL,
    gecmis_mart double precision DEFAULT 0 NOT NULL,
    gecmis_nisan double precision DEFAULT 0 NOT NULL,
    gecmis_mayis double precision DEFAULT 0 NOT NULL,
    gecmis_haziran double precision DEFAULT 0 NOT NULL,
    gecmis_temmuz double precision DEFAULT 0 NOT NULL,
    gecmis_agustos double precision DEFAULT 0 NOT NULL,
    gecmis_eylul double precision DEFAULT 0 NOT NULL,
    gecmis_ekim double precision DEFAULT 0 NOT NULL,
    gecmis_kasim double precision DEFAULT 0 NOT NULL,
    gecmis_aralik double precision DEFAULT 0 NOT NULL,
    hedef_ocak double precision DEFAULT 0 NOT NULL,
    hedef_subat double precision DEFAULT 0 NOT NULL,
    hedef_mart double precision DEFAULT 0 NOT NULL,
    hedef_nisan double precision DEFAULT 0 NOT NULL,
    hedef_mayis double precision DEFAULT 0 NOT NULL,
    hedef_haziran double precision DEFAULT 0 NOT NULL,
    hedef_temmuz double precision DEFAULT 0 NOT NULL,
    hedef_agustos double precision DEFAULT 0 NOT NULL,
    hedef_eylul double precision DEFAULT 0 NOT NULL,
    hedef_ekim double precision DEFAULT 0 NOT NULL,
    hedef_kasim double precision DEFAULT 0 NOT NULL,
    hedef_aralik double precision DEFAULT 0 NOT NULL
);
 *   DROP TABLE public.musteri_temsilci_grubu;
       public         postgres    false    8            @           1259    478183    musteri_temsilci_grubu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.musteri_temsilci_grubu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.musteri_temsilci_grubu_id_seq;
       public       postgres    false    319    8            r           0    0    musteri_temsilci_grubu_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.musteri_temsilci_grubu_id_seq OWNED BY public.musteri_temsilci_grubu.id;
            public       postgres    false    320            A           1259    478185    olcu_birimi    TABLE       CREATE TABLE public.olcu_birimi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    birim character varying(16) NOT NULL,
    efatura_birim character varying(3),
    birim_aciklama character varying(64),
    is_float_tip boolean DEFAULT false NOT NULL
);
    DROP TABLE public.olcu_birimi;
       public         postgres    false    8            B           1259    478190    olcu_birimi_id_seq    SEQUENCE     {   CREATE SEQUENCE public.olcu_birimi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.olcu_birimi_id_seq;
       public       postgres    false    321    8            s           0    0    olcu_birimi_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.olcu_birimi_id_seq OWNED BY public.olcu_birimi.id;
            public       postgres    false    322            t           0    0    SEQUENCE olcu_birimi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.olcu_birimi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.olcu_birimi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.olcu_birimi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.olcu_birimi_id_seq TO PUBLIC;
            public       postgres    false    322            C           1259    478192    para_birimi    TABLE     �   CREATE TABLE public.para_birimi (
    id integer NOT NULL,
    kod character varying(3) NOT NULL,
    sembol character varying(3) NOT NULL,
    aciklama character varying(128),
    is_varsayilan boolean DEFAULT false NOT NULL
);
    DROP TABLE public.para_birimi;
       public         postgres    false    8            u           0    0    TABLE para_birimi    ACL     �   REVOKE ALL ON TABLE public.para_birimi FROM PUBLIC;
REVOKE ALL ON TABLE public.para_birimi FROM postgres;
GRANT ALL ON TABLE public.para_birimi TO postgres;
            public       postgres    false    323            D           1259    478196    para_birimi_id_seq    SEQUENCE     {   CREATE SEQUENCE public.para_birimi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.para_birimi_id_seq;
       public       postgres    false    8    323            v           0    0    para_birimi_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.para_birimi_id_seq OWNED BY public.para_birimi.id;
            public       postgres    false    324            w           0    0    SEQUENCE para_birimi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.para_birimi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.para_birimi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.para_birimi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.para_birimi_id_seq TO PUBLIC;
            public       postgres    false    324            E           1259    478198    personel_ayrilma_nedeni_tipi    TABLE     �   CREATE TABLE public.personel_ayrilma_nedeni_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(32)
);
 0   DROP TABLE public.personel_ayrilma_nedeni_tipi;
       public         postgres    false    8            x           0    0 "   TABLE personel_ayrilma_nedeni_tipi    ACL     �   REVOKE ALL ON TABLE public.personel_ayrilma_nedeni_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_ayrilma_nedeni_tipi FROM postgres;
GRANT ALL ON TABLE public.personel_ayrilma_nedeni_tipi TO postgres;
            public       postgres    false    325            F           1259    478202 #   personel_ayrilma_nedeni_tipi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq;
       public       postgres    false    8    325            y           0    0 #   personel_ayrilma_nedeni_tipi_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq OWNED BY public.personel_ayrilma_nedeni_tipi.id;
            public       postgres    false    326            z           0    0 ,   SEQUENCE personel_ayrilma_nedeni_tipi_id_seq    ACL     :  REVOKE ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_ayrilma_nedeni_tipi_id_seq TO PUBLIC;
            public       postgres    false    326            G           1259    478204    personel_calisma_gecmisi    TABLE     �  CREATE TABLE public.personel_calisma_gecmisi (
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
 ,   DROP TABLE public.personel_calisma_gecmisi;
       public         postgres    false    8            {           0    0    TABLE personel_calisma_gecmisi    ACL     �   REVOKE ALL ON TABLE public.personel_calisma_gecmisi FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_calisma_gecmisi FROM postgres;
GRANT ALL ON TABLE public.personel_calisma_gecmisi TO postgres;
            public       postgres    false    327            H           1259    478208    personel_calisma_gecmisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personel_calisma_gecmisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.personel_calisma_gecmisi_id_seq;
       public       postgres    false    8    327            |           0    0    personel_calisma_gecmisi_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.personel_calisma_gecmisi_id_seq OWNED BY public.personel_calisma_gecmisi.id;
            public       postgres    false    328            }           0    0 (   SEQUENCE personel_calisma_gecmisi_id_seq    ACL     *  REVOKE ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_calisma_gecmisi_id_seq TO PUBLIC;
            public       postgres    false    328            I           1259    478210    personel_dil_bilgisi    TABLE     �   CREATE TABLE public.personel_dil_bilgisi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    dil_id integer,
    okuma_seviyesi_id integer,
    yazma_seviyesi_id integer,
    konusma_seviyesi_id integer,
    personel_id integer
);
 (   DROP TABLE public.personel_dil_bilgisi;
       public         postgres    false    8            J           1259    478214    personel_dil_bilgisi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personel_dil_bilgisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.personel_dil_bilgisi_id_seq;
       public       postgres    false    8    329            ~           0    0    personel_dil_bilgisi_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.personel_dil_bilgisi_id_seq OWNED BY public.personel_dil_bilgisi.id;
            public       postgres    false    330                       0    0 $   SEQUENCE personel_dil_bilgisi_id_seq    ACL       REVOKE ALL ON SEQUENCE public.personel_dil_bilgisi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_dil_bilgisi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_dil_bilgisi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_dil_bilgisi_id_seq TO PUBLIC;
            public       postgres    false    330            K           1259    478216    personel_karti    TABLE     o  CREATE TABLE public.personel_karti (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    personel_ad character varying(32) NOT NULL,
    personel_soyad character varying(32) NOT NULL,
    telefon1 character varying(24),
    telefon2 character varying(24),
    personel_tipi_id integer NOT NULL,
    bolum_id integer,
    birim_id integer NOT NULL,
    gorev_id integer NOT NULL,
    mail_adresi character varying(64),
    dogum_tarihi date NOT NULL,
    kan_grubu character varying(8),
    cinsiyet_id integer NOT NULL,
    askerlik_durum_id integer,
    medeni_durum_id integer NOT NULL,
    cocuk_sayisi integer DEFAULT 0,
    yakin_ad_soyad character varying(48),
    yakin_telefon character varying(24),
    ayakkabi_no integer,
    elbise_bedeni character varying(8),
    genel_not character varying(256),
    servis_id integer,
    personel_gecmisi_id integer,
    ozel_not character varying(256),
    brut_maas double precision DEFAULT 0 NOT NULL,
    ikramiye_sayisi integer,
    ikramiye_miktar double precision,
    tc_kimlik_no text,
    adres_id integer
);
 "   DROP TABLE public.personel_karti;
       public         postgres    false    8            L           1259    478226    personel_karti_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.personel_karti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.personel_karti_id_seq;
       public       postgres    false    8    331            �           0    0    personel_karti_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.personel_karti_id_seq OWNED BY public.personel_karti.id;
            public       postgres    false    332            M           1259    478228    personel_pdks_kart    TABLE     �   CREATE TABLE public.personel_pdks_kart (
    id integer NOT NULL,
    kart_id character varying(8),
    personel_no integer NOT NULL,
    kart_no integer NOT NULL,
    is_active boolean
);
 &   DROP TABLE public.personel_pdks_kart;
       public         postgres    false    8            N           1259    478231    personel_pdks_kart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personel_pdks_kart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.personel_pdks_kart_id_seq;
       public       postgres    false    8    333            �           0    0    personel_pdks_kart_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.personel_pdks_kart_id_seq OWNED BY public.personel_pdks_kart.id;
            public       postgres    false    334            O           1259    478233    personel_tasima_servis    TABLE     �   CREATE TABLE public.personel_tasima_servis (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    servis_no smallint NOT NULL,
    servis_adi character varying(32) NOT NULL,
    rota character varying[]
);
 *   DROP TABLE public.personel_tasima_servis;
       public         postgres    false    8            �           0    0    TABLE personel_tasima_servis    ACL     �   REVOKE ALL ON TABLE public.personel_tasima_servis FROM PUBLIC;
REVOKE ALL ON TABLE public.personel_tasima_servis FROM postgres;
GRANT ALL ON TABLE public.personel_tasima_servis TO postgres;
            public       postgres    false    335            P           1259    478240    personel_tasima_servis_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personel_tasima_servis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.personel_tasima_servis_id_seq;
       public       postgres    false    335    8            �           0    0    personel_tasima_servis_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.personel_tasima_servis_id_seq OWNED BY public.personel_tasima_servis.id;
            public       postgres    false    336            �           0    0 &   SEQUENCE personel_tasima_servis_id_seq    ACL     "  REVOKE ALL ON SEQUENCE public.personel_tasima_servis_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.personel_tasima_servis_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.personel_tasima_servis_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.personel_tasima_servis_id_seq TO PUBLIC;
            public       postgres    false    336            Q           1259    478242    quality_form_mail_reciever    TABLE     �   CREATE TABLE public.quality_form_mail_reciever (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    mail_adresi character varying(128) NOT NULL
);
 .   DROP TABLE public.quality_form_mail_reciever;
       public         postgres    false    8            R           1259    478246 !   quality_form_mail_reciever_id_seq    SEQUENCE     �   CREATE SEQUENCE public.quality_form_mail_reciever_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.quality_form_mail_reciever_id_seq;
       public       postgres    false    8    337            �           0    0 !   quality_form_mail_reciever_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.quality_form_mail_reciever_id_seq OWNED BY public.quality_form_mail_reciever.id;
            public       postgres    false    338            �           0    0 *   SEQUENCE quality_form_mail_reciever_id_seq    ACL     2  REVOKE ALL ON SEQUENCE public.quality_form_mail_reciever_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.quality_form_mail_reciever_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.quality_form_mail_reciever_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.quality_form_mail_reciever_id_seq TO PUBLIC;
            public       postgres    false    338            S           1259    478248    recete    TABLE     B  CREATE TABLE public.recete (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    mamul_stok_kodu character varying(32) NOT NULL,
    ornek_uretim_miktari double precision NOT NULL,
    fire_orani double precision,
    aciklama character varying(128),
    recete_adi character varying(128) NOT NULL
);
    DROP TABLE public.recete;
       public         postgres    false    8            �           0    0    TABLE recete    ACL     �   REVOKE ALL ON TABLE public.recete FROM PUBLIC;
REVOKE ALL ON TABLE public.recete FROM postgres;
GRANT ALL ON TABLE public.recete TO postgres;
            public       postgres    false    339            T           1259    478252    recete_hammadde    TABLE       CREATE TABLE public.recete_hammadde (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer NOT NULL,
    stok_kodu character varying(32) NOT NULL,
    miktar double precision NOT NULL,
    fire_orani double precision,
    recete_id integer
);
 #   DROP TABLE public.recete_hammadde;
       public         postgres    false    8            �           0    0    TABLE recete_hammadde    ACL     �   REVOKE ALL ON TABLE public.recete_hammadde FROM PUBLIC;
REVOKE ALL ON TABLE public.recete_hammadde FROM postgres;
GRANT ALL ON TABLE public.recete_hammadde TO postgres;
            public       postgres    false    340            U           1259    478256    recete_hammadde_id_seq    SEQUENCE        CREATE SEQUENCE public.recete_hammadde_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.recete_hammadde_id_seq;
       public       postgres    false    340    8            �           0    0    recete_hammadde_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.recete_hammadde_id_seq OWNED BY public.recete_hammadde.id;
            public       postgres    false    341            �           0    0    SEQUENCE recete_hammadde_id_seq    ACL       REVOKE ALL ON SEQUENCE public.recete_hammadde_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.recete_hammadde_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.recete_hammadde_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.recete_hammadde_id_seq TO PUBLIC;
            public       postgres    false    341            V           1259    478258    recete_id_seq    SEQUENCE     v   CREATE SEQUENCE public.recete_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.recete_id_seq;
       public       postgres    false    339    8            �           0    0    recete_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.recete_id_seq OWNED BY public.recete.id;
            public       postgres    false    342            �           0    0    SEQUENCE recete_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.recete_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.recete_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.recete_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.recete_id_seq TO PUBLIC;
            public       postgres    false    342            W           1259    478260    satis_fatura    TABLE       CREATE TABLE public.satis_fatura (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    fatura_no character varying(16),
    fatura_tarihi timestamp without time zone,
    teklif_id integer,
    siparis_id integer,
    irsaliye_id integer
);
     DROP TABLE public.satis_fatura;
       public         postgres    false    8            �           0    0    TABLE satis_fatura    ACL     �   REVOKE ALL ON TABLE public.satis_fatura FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_fatura FROM postgres;
GRANT ALL ON TABLE public.satis_fatura TO postgres;
            public       postgres    false    343            X           1259    478264    satis_fatura_detay    TABLE     �   CREATE TABLE public.satis_fatura_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer,
    teklif_detay_id integer,
    siparis_detay_id integer,
    irsaliye_detay_id integer
);
 &   DROP TABLE public.satis_fatura_detay;
       public         postgres    false    8            �           0    0    TABLE satis_fatura_detay    ACL     �   REVOKE ALL ON TABLE public.satis_fatura_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_fatura_detay FROM postgres;
GRANT ALL ON TABLE public.satis_fatura_detay TO postgres;
            public       postgres    false    344            Y           1259    478268    satis_fatura_detay_id_seq    SEQUENCE     �   CREATE SEQUENCE public.satis_fatura_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.satis_fatura_detay_id_seq;
       public       postgres    false    8    344            �           0    0    satis_fatura_detay_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.satis_fatura_detay_id_seq OWNED BY public.satis_fatura_detay.id;
            public       postgres    false    345            �           0    0 "   SEQUENCE satis_fatura_detay_id_seq    ACL       REVOKE ALL ON SEQUENCE public.satis_fatura_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_fatura_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_detay_id_seq TO PUBLIC;
            public       postgres    false    345            Z           1259    478270    satis_fatura_id_seq    SEQUENCE     |   CREATE SEQUENCE public.satis_fatura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.satis_fatura_id_seq;
       public       postgres    false    8    343            �           0    0    satis_fatura_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.satis_fatura_id_seq OWNED BY public.satis_fatura.id;
            public       postgres    false    346            �           0    0    SEQUENCE satis_fatura_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.satis_fatura_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_fatura_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_fatura_id_seq TO PUBLIC;
            public       postgres    false    346            [           1259    478272    satis_irsaliye    TABLE     
  CREATE TABLE public.satis_irsaliye (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    irsaliye_no character varying(16),
    irsaliye_tarihi timestamp without time zone,
    teklif_id integer,
    siparis_id integer,
    fatura_id integer
);
 "   DROP TABLE public.satis_irsaliye;
       public         postgres    false    8            �           0    0    TABLE satis_irsaliye    ACL     �   REVOKE ALL ON TABLE public.satis_irsaliye FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_irsaliye FROM postgres;
GRANT ALL ON TABLE public.satis_irsaliye TO postgres;
            public       postgres    false    347            \           1259    478276    satis_irsaliye_detay    TABLE     �   CREATE TABLE public.satis_irsaliye_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer,
    teklif_detay_id integer,
    siparis_detay_id integer,
    fatura_detay_id integer
);
 (   DROP TABLE public.satis_irsaliye_detay;
       public         postgres    false    8            �           0    0    TABLE satis_irsaliye_detay    ACL     �   REVOKE ALL ON TABLE public.satis_irsaliye_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_irsaliye_detay FROM postgres;
GRANT ALL ON TABLE public.satis_irsaliye_detay TO postgres;
            public       postgres    false    348            ]           1259    478280    satis_irsaliye_detay_id_seq    SEQUENCE     �   CREATE SEQUENCE public.satis_irsaliye_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.satis_irsaliye_detay_id_seq;
       public       postgres    false    8    348            �           0    0    satis_irsaliye_detay_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.satis_irsaliye_detay_id_seq OWNED BY public.satis_irsaliye_detay.id;
            public       postgres    false    349            �           0    0 $   SEQUENCE satis_irsaliye_detay_id_seq    ACL       REVOKE ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_detay_id_seq TO PUBLIC;
            public       postgres    false    349            ^           1259    478282    satis_irsaliye_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.satis_irsaliye_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.satis_irsaliye_id_seq;
       public       postgres    false    347    8            �           0    0    satis_irsaliye_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.satis_irsaliye_id_seq OWNED BY public.satis_irsaliye.id;
            public       postgres    false    350            �           0    0    SEQUENCE satis_irsaliye_id_seq    ACL       REVOKE ALL ON SEQUENCE public.satis_irsaliye_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_irsaliye_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_irsaliye_id_seq TO PUBLIC;
            public       postgres    false    350            _           1259    478284    satis_siparis    TABLE       CREATE TABLE public.satis_siparis (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    siparis_no character varying(16),
    siparis_tarihi timestamp without time zone,
    teklif_id integer,
    irsaliye_id integer,
    fatura_id integer
);
 !   DROP TABLE public.satis_siparis;
       public         postgres    false    8            �           0    0    TABLE satis_siparis    ACL     �   REVOKE ALL ON TABLE public.satis_siparis FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_siparis FROM postgres;
GRANT ALL ON TABLE public.satis_siparis TO postgres;
            public       postgres    false    351            `           1259    478288    satis_siparis_detay    TABLE     �   CREATE TABLE public.satis_siparis_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer,
    teklif_detay_id integer,
    irsaliye_detay_id integer,
    fatura_detay_id integer
);
 '   DROP TABLE public.satis_siparis_detay;
       public         postgres    false    8            �           0    0    TABLE satis_siparis_detay    ACL     �   REVOKE ALL ON TABLE public.satis_siparis_detay FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_siparis_detay FROM postgres;
GRANT ALL ON TABLE public.satis_siparis_detay TO postgres;
            public       postgres    false    352            a           1259    478292    satis_siparis_detay_id_seq    SEQUENCE     �   CREATE SEQUENCE public.satis_siparis_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.satis_siparis_detay_id_seq;
       public       postgres    false    8    352            �           0    0    satis_siparis_detay_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.satis_siparis_detay_id_seq OWNED BY public.satis_siparis_detay.id;
            public       postgres    false    353            �           0    0 #   SEQUENCE satis_siparis_detay_id_seq    ACL       REVOKE ALL ON SEQUENCE public.satis_siparis_detay_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_siparis_detay_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_detay_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_detay_id_seq TO PUBLIC;
            public       postgres    false    353            b           1259    478294    satis_siparis_id_seq    SEQUENCE     }   CREATE SEQUENCE public.satis_siparis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.satis_siparis_id_seq;
       public       postgres    false    351    8            �           0    0    satis_siparis_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.satis_siparis_id_seq OWNED BY public.satis_siparis.id;
            public       postgres    false    354            �           0    0    SEQUENCE satis_siparis_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.satis_siparis_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_siparis_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_siparis_id_seq TO PUBLIC;
            public       postgres    false    354            c           1259    478296    satis_teklif    TABLE     �  CREATE TABLE public.satis_teklif (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    siparis_id integer,
    irsaliye_id integer,
    fatura_id integer,
    is_siparislesti boolean NOT NULL,
    is_taslak boolean DEFAULT false NOT NULL,
    is_efatura boolean DEFAULT false NOT NULL,
    tutar double precision DEFAULT 0 NOT NULL,
    iskonto_tutar double precision DEFAULT 0 NOT NULL,
    ara_toplam double precision DEFAULT 0 NOT NULL,
    genel_iskonto_tutar double precision DEFAULT 0 NOT NULL,
    kdv_tutar double precision DEFAULT 0 NOT NULL,
    genel_toplam double precision DEFAULT 0 NOT NULL,
    islem_tipi_id integer,
    teklif_no character varying(16),
    teklif_tarihi timestamp without time zone,
    teslim_tarihi timestamp without time zone,
    gecerlilik_tarihi timestamp without time zone,
    musteri_kodu character varying(16),
    musteri_adi character varying(128),
    adres_musteri character varying(128),
    sehir_musteri character varying(32),
    posta_kodu character varying(16),
    vergi_dairesi character varying(32),
    vergi_no character varying(32),
    musteri_temsilcisi_id integer,
    teklif_tipi_id integer,
    adres_sevkiyat character varying(128),
    sehir_sevkiyat character varying(32),
    muhattap_ad character varying(32),
    muhattap_soyad character varying(32),
    odeme_vadesi character varying(32),
    referans character varying(128),
    teslimat_suresi character varying(32),
    teklif_durum_id integer,
    sevk_tarihi timestamp without time zone,
    vade_gun_sayisi integer,
    fatura_sevk_tarihi character varying(64),
    para_birimi character varying(3) NOT NULL,
    dolar_kur double precision DEFAULT 1,
    euro_kur double precision DEFAULT 1,
    odeme_baslangic_donemi_id integer,
    teslim_sarti_id integer,
    gonderim_sekli_id integer,
    gonderim_sekli_detay character varying(128),
    odeme_sekli_id integer,
    aciklama character varying(128),
    proforma_no integer,
    arayan_kisi_id integer,
    arama_tarihi timestamp without time zone,
    sonraki_aksiyon_tarihi timestamp without time zone,
    aksiyon_notu character varying(128),
    tevkifat_kodu character varying(3),
    tevkifat_pay integer,
    tevkifat_payda integer,
    ihrac_kayit_kodu character varying(3)
);
     DROP TABLE public.satis_teklif;
       public         postgres    false    8            �           0    0    TABLE satis_teklif    ACL     �   REVOKE ALL ON TABLE public.satis_teklif FROM PUBLIC;
REVOKE ALL ON TABLE public.satis_teklif FROM postgres;
GRANT ALL ON TABLE public.satis_teklif TO postgres;
            public       postgres    false    355            d           1259    478313    satis_teklif_detay    TABLE       CREATE TABLE public.satis_teklif_detay (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    header_id integer,
    siparis_detay_id integer,
    irsaliye_detay_id integer,
    fatura_detay_id integer,
    stok_kodu character varying(32),
    stok_aciklama character varying(128),
    aciklama character varying(128),
    referans character varying(128),
    miktar double precision NOT NULL,
    olcu_birimi character varying(8),
    iskonto_orani double precision DEFAULT 0,
    fiyat double precision DEFAULT 0,
    net_fiyat double precision DEFAULT 0 NOT NULL,
    tutar double precision DEFAULT 0 NOT NULL,
    iskonto_tutar double precision DEFAULT 0 NOT NULL,
    net_tutar double precision DEFAULT 0 NOT NULL,
    kdv_orani integer DEFAULT 0,
    kdv_tutar double precision DEFAULT 0 NOT NULL,
    toplam_tutar double precision DEFAULT 0 NOT NULL,
    vade_gun double precision DEFAULT 0,
    is_ana_urun boolean DEFAULT false NOT NULL,
    ana_urun_id integer,
    referans_ana_urun_id integer,
    transfer_hesap_kodu character varying(16),
    kdv_transfer_hesap_kodu character varying(16),
    vergi_kodu character varying(4),
    vergi_muafiyet_kodu character varying(4),
    diger_vergi_kodu character varying(4),
    gtip_no character varying(16)
);
 &   DROP TABLE public.satis_teklif_detay;
       public         postgres    false    8            e           1259    478331    satis_teklif_detay_id_seq    SEQUENCE     �   CREATE SEQUENCE public.satis_teklif_detay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.satis_teklif_detay_id_seq;
       public       postgres    false    356    8            �           0    0    satis_teklif_detay_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.satis_teklif_detay_id_seq OWNED BY public.satis_teklif_detay.id;
            public       postgres    false    357            f           1259    478333    satis_teklif_id_seq    SEQUENCE     |   CREATE SEQUENCE public.satis_teklif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.satis_teklif_id_seq;
       public       postgres    false    355    8            �           0    0    satis_teklif_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.satis_teklif_id_seq OWNED BY public.satis_teklif.id;
            public       postgres    false    358            �           0    0    SEQUENCE satis_teklif_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.satis_teklif_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.satis_teklif_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.satis_teklif_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.satis_teklif_id_seq TO PUBLIC;
            public       postgres    false    358            g           1259    478335    sehir    TABLE     �   CREATE TABLE public.sehir (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    sehir_adi character varying(32) NOT NULL,
    plaka_kodu integer,
    ulke_id integer
);
    DROP TABLE public.sehir;
       public         postgres    false    8            �           0    0    TABLE sehir    ACL     �   REVOKE ALL ON TABLE public.sehir FROM PUBLIC;
REVOKE ALL ON TABLE public.sehir FROM postgres;
GRANT ALL ON TABLE public.sehir TO postgres;
            public       postgres    false    359            h           1259    478339    sehir_id_seq    SEQUENCE     u   CREATE SEQUENCE public.sehir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.sehir_id_seq;
       public       postgres    false    8    359            �           0    0    sehir_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.sehir_id_seq OWNED BY public.sehir.id;
            public       postgres    false    360            �           0    0    SEQUENCE sehir_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.sehir_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sehir_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sehir_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sehir_id_seq TO PUBLIC;
            public       postgres    false    360            i           1259    478341 
   stok_grubu    TABLE     �  CREATE TABLE public.stok_grubu (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    grup character varying(32) NOT NULL,
    alis_hesabi character varying(16),
    satis_hesabi character varying(16),
    hammadde_hesabi character varying(16),
    mamul_hesabi character varying(16),
    kdv_orani_id integer NOT NULL,
    tur_id integer,
    is_iskonto_aktif boolean DEFAULT false NOT NULL,
    iskonto_satis double precision DEFAULT 0 NOT NULL,
    iskonto_mudur double precision DEFAULT 0 NOT NULL,
    is_satis_fiyatini_kullan boolean DEFAULT false NOT NULL,
    yari_mamul_hesabi character varying(16),
    is_maliyet_analiz_farkli_db boolean DEFAULT false NOT NULL
);
    DROP TABLE public.stok_grubu;
       public         postgres    false    8            j           1259    478350    stok_grubu_id_seq    SEQUENCE     z   CREATE SEQUENCE public.stok_grubu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.stok_grubu_id_seq;
       public       postgres    false    361    8            �           0    0    stok_grubu_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.stok_grubu_id_seq OWNED BY public.stok_grubu.id;
            public       postgres    false    362            �           0    0    SEQUENCE stok_grubu_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.stok_grubu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_grubu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_grubu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_grubu_id_seq TO PUBLIC;
            public       postgres    false    362            k           1259    478352    stok_grubu_turu    TABLE     �   CREATE TABLE public.stok_grubu_turu (
    id integer NOT NULL,
    validity boolean DEFAULT true,
    tur character varying(32) NOT NULL
);
 #   DROP TABLE public.stok_grubu_turu;
       public         postgres    false    8            l           1259    478356    stok_grubu_turu_id_seq    SEQUENCE        CREATE SEQUENCE public.stok_grubu_turu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.stok_grubu_turu_id_seq;
       public       postgres    false    363    8            �           0    0    stok_grubu_turu_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.stok_grubu_turu_id_seq OWNED BY public.stok_grubu_turu.id;
            public       postgres    false    364            �           0    0    SEQUENCE stok_grubu_turu_id_seq    ACL       REVOKE ALL ON SEQUENCE public.stok_grubu_turu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_grubu_turu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_grubu_turu_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_grubu_turu_id_seq TO PUBLIC;
            public       postgres    false    364            m           1259    478358    stok_hareketi    TABLE     �  CREATE TABLE public.stok_hareketi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    stok_kodu character varying(32) NOT NULL,
    miktar double precision NOT NULL,
    tutar double precision NOT NULL,
    giris_cikis_tip_id integer NOT NULL,
    alan_ambar character varying(32),
    veren_ambar character varying(32),
    tarih timestamp without time zone NOT NULL,
    is_donem_basi_hareket boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.stok_hareketi;
       public         postgres    false    8            n           1259    478363    stok_hareketi_id_seq    SEQUENCE     }   CREATE SEQUENCE public.stok_hareketi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.stok_hareketi_id_seq;
       public       postgres    false    365    8            �           0    0    stok_hareketi_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.stok_hareketi_id_seq OWNED BY public.stok_hareketi.id;
            public       postgres    false    366            �           0    0    SEQUENCE stok_hareketi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.stok_hareketi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_hareketi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_hareketi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_hareketi_id_seq TO PUBLIC;
            public       postgres    false    366            o           1259    478365 
   stok_karti    TABLE     @  CREATE TABLE public.stok_karti (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    stok_kodu character varying(32) NOT NULL,
    stok_adi character varying(128) NOT NULL,
    stok_grubu_id integer NOT NULL,
    olcu_birimi_id integer NOT NULL,
    alis_iskonto double precision,
    satis_iskonto double precision,
    yetkili_iskonto double precision,
    stok_tipi_id integer DEFAULT public.get_default_stok_tipi() NOT NULL,
    ham_alis_fiyat double precision DEFAULT 0 NOT NULL,
    ham_alis_para_birim character varying(3) DEFAULT public.get_default_para_birimi() NOT NULL,
    alis_fiyat double precision NOT NULL,
    alis_para_birim character varying(3) DEFAULT public.get_default_para_birimi() NOT NULL,
    satis_fiyat double precision NOT NULL,
    satis_para_birim character varying(3) DEFAULT public.get_default_para_birimi() NOT NULL,
    ihrac_fiyat double precision DEFAULT 0 NOT NULL,
    ihrac_para_birim character varying(3) DEFAULT public.get_default_para_birimi() NOT NULL,
    ortalama_maliyet double precision DEFAULT 0,
    varsayilan_recete_id integer,
    en double precision,
    boy double precision,
    yukseklik double precision,
    mensei_id integer,
    gtip_no character varying(16),
    diib_urun_tanimi character varying(64),
    en_az_stok_seviyesi double precision,
    tanim character varying(384),
    ozel_kod character varying(16),
    marka character varying(32),
    agirlik double precision,
    kapasite double precision,
    cins_id integer,
    string_degisken1 character varying(32),
    string_degisken2 character varying(32),
    string_degisken3 character varying(32),
    string_degisken4 character varying(32),
    string_degisken5 character varying(32),
    string_degisken6 character varying(32),
    integer_degisken1 integer,
    integer_degisken2 integer,
    integer_degisken3 integer,
    double_degisken1 double precision,
    double_degisken2 double precision,
    double_degisken3 double precision,
    is_satilabilir boolean DEFAULT true NOT NULL,
    is_ana_urun boolean DEFAULT false NOT NULL,
    is_yari_mamul boolean DEFAULT false NOT NULL,
    is_otomatik_uretim_urunu boolean DEFAULT false NOT NULL,
    is_ozet_urun boolean DEFAULT false NOT NULL,
    lot_parti_miktari double precision,
    paket_miktari integer,
    seri_no_turu character varying(4),
    is_harici_seri_no_icerir boolean DEFAULT false NOT NULL,
    harici_serino_stok_kodu_id integer,
    tasiyici_paket_id integer,
    onceki_donem_cikan_miktar double precision,
    temin_suresi integer,
    stock_name character varying(128),
    en_string_degisken1 character varying(32),
    en_string_degisken2 character varying(32),
    en_string_degisken3 character varying(32),
    en_string_degisken4 character varying(32),
    en_string_degisken5 character varying(32),
    en_string_degisken6 character varying(32)
);
    DROP TABLE public.stok_karti;
       public         postgres    false    509    505    505    505    505    8            p           1259    478386    stok_karti_id_seq    SEQUENCE     z   CREATE SEQUENCE public.stok_karti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.stok_karti_id_seq;
       public       postgres    false    8    367            �           0    0    stok_karti_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.stok_karti_id_seq OWNED BY public.stok_karti.id;
            public       postgres    false    368            �           0    0    SEQUENCE stok_karti_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.stok_karti_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_karti_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_karti_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_karti_id_seq TO PUBLIC;
            public       postgres    false    368            q           1259    478388 	   stok_tipi    TABLE     �   CREATE TABLE public.stok_tipi (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    tip character varying(16) NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    is_stok_hareketi_yap boolean DEFAULT false NOT NULL
);
    DROP TABLE public.stok_tipi;
       public         postgres    false    8            �           0    0    TABLE stok_tipi    ACL     �   REVOKE ALL ON TABLE public.stok_tipi FROM PUBLIC;
REVOKE ALL ON TABLE public.stok_tipi FROM postgres;
GRANT ALL ON TABLE public.stok_tipi TO postgres;
            public       postgres    false    369            r           1259    478394    stok_tipi_id_seq    SEQUENCE     y   CREATE SEQUENCE public.stok_tipi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.stok_tipi_id_seq;
       public       postgres    false    369    8            �           0    0    stok_tipi_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.stok_tipi_id_seq OWNED BY public.stok_tipi.id;
            public       postgres    false    370            �           0    0    SEQUENCE stok_tipi_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.stok_tipi_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.stok_tipi_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.stok_tipi_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.stok_tipi_id_seq TO PUBLIC;
            public       postgres    false    370            s           1259    478396    sys_application_settings    TABLE     �  CREATE TABLE public.sys_application_settings (
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
    form_rengi integer,
    donem integer DEFAULT 2014 NOT NULL,
    mukellef_tipi character varying(16),
    tam_adres character varying(160),
    ticaret_sicil_no character varying(24),
    ilce character varying(32),
    mahalle character varying(40),
    cadde character varying(40),
    sokak character varying(40),
    posta_kodu character varying(7),
    bina character varying(40),
    kapi_no character varying(6),
    ulke_id integer,
    sehir_id integer,
    sistem_dili character varying(16) NOT NULL,
    mail_sunucu_adres character varying(32),
    mail_sunucu_kullanici character varying(32),
    mail_sunucu_sifre character varying(16),
    mail_sunucu_port integer,
    grid_color_1 integer DEFAULT 13171168 NOT NULL,
    grid_color_2 integer DEFAULT 7467153 NOT NULL,
    grid_color_active integer DEFAULT 14605509 NOT NULL,
    edefter_gonderilen_son date,
    crypt_key character varying(16)
);
 ,   DROP TABLE public.sys_application_settings;
       public         postgres    false    8            t           1259    478407    sys_application_settings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_application_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.sys_application_settings_id_seq;
       public       postgres    false    371    8            �           0    0    sys_application_settings_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.sys_application_settings_id_seq OWNED BY public.sys_application_settings.id;
            public       postgres    false    372            �           0    0 (   SEQUENCE sys_application_settings_id_seq    ACL     *  REVOKE ALL ON SEQUENCE public.sys_application_settings_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_application_settings_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_application_settings_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_application_settings_id_seq TO PUBLIC;
            public       postgres    false    372            u           1259    478409    sys_application_settings_other    TABLE     �  CREATE TABLE public.sys_application_settings_other (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    is_edefter_aktif boolean DEFAULT false NOT NULL,
    mail_sender_address character varying(32),
    mail_sender_username character varying(32),
    mail_sender_password character varying(16),
    mail_sender_port integer,
    varsayilan_satis_cari_kod character varying(16),
    varsayilan_alis_cari_kod character varying(16),
    is_bolum_ambarda_uretim_yap boolean DEFAULT false NOT NULL,
    is_uretim_muhasebe_kaydi_olustursun boolean DEFAULT true NOT NULL,
    is_stok_satimda_negatife_dusebilir boolean DEFAULT false NOT NULL,
    is_mal_satis_sayilarini_goster boolean DEFAULT false NOT NULL,
    is_pcb_uretim boolean DEFAULT false NOT NULL,
    is_proforma_no_goster boolean DEFAULT false NOT NULL,
    is_satis_takip boolean DEFAULT false NOT NULL,
    is_hammadde_girise_gore_sirala boolean DEFAULT false NOT NULL,
    is_uretim_entegrasyon_hammadde_kullanim_hesabi_iscilikle boolean DEFAULT false NOT NULL,
    is_tahsilat_listesi_virmanli boolean DEFAULT false NOT NULL,
    is_ortalama_vade_0_ise_sevkiyata_izin_verme boolean DEFAULT false NOT NULL,
    is_sipariste_teslim_tarihi_yazdir boolean DEFAULT false NOT NULL,
    is_teklif_ayrintilarini_goster boolean DEFAULT false NOT NULL,
    is_fatura_irsaliye_no_0_ile_baslasin boolean DEFAULT false NOT NULL,
    is_excel_ekli_irsaliye_yazdirma boolean DEFAULT false NOT NULL,
    is_ambarlararasi_transfer_numara_otomatik_gelsin boolean DEFAULT false NOT NULL,
    is_ambarlararasi_transfer_onayli_calissin boolean DEFAULT false NOT NULL,
    is_alis_teklif_alis_sipariste_ham_alis_fiyatini_kullan boolean DEFAULT false NOT NULL,
    is_tahsilat_listesine_120_bulut_hesabini_dahil_etme boolean DEFAULT false NOT NULL,
    is_satis_listesi_varsayilan_filtre_mamul_hammadde boolean DEFAULT false NOT NULL,
    is_recete_maliyet_analizi_baska_db_kullanarak_yap boolean DEFAULT false NOT NULL,
    is_efatura_aktif boolean DEFAULT false NOT NULL,
    is_stok_transfer_fiyati_kullanici_degistirebilir boolean DEFAULT false NOT NULL,
    is_hesaplar_rapolarda_cikmasin boolean DEFAULT false NOT NULL,
    is_siparisi_baska_programa_otomatik_kayit_yap boolean DEFAULT false NOT NULL,
    is_active_uretim_takip boolean DEFAULT false NOT NULL,
    is_pano_programina_otomatik_kayit boolean DEFAULT false NOT NULL,
    is_nakit_akista_farkli_db_kullan boolean DEFAULT false NOT NULL,
    is_ihrac_fiyati_yerine_satis_fiyatini_kullan boolean DEFAULT false NOT NULL,
    is_statik_iskonto_orani_kullan boolean DEFAULT false NOT NULL,
    is_eirsaliye_aktif boolean DEFAULT false NOT NULL,
    is_stok_recete_adi_birlikte_guncellensin boolean DEFAULT false NOT NULL,
    is_kur_bilgisini_1_olarak_kullan boolean DEFAULT false NOT NULL,
    is_genel_kdv_orani_kullan boolean DEFAULT false NOT NULL,
    xslt_sablon_adi character varying(32),
    genel_iskonto_gecerlilik_tarihi date,
    en_fazla_fatura_satir_sayisi integer DEFAULT 0 NOT NULL,
    en_fazla_e_fatura_satir_sayisi integer DEFAULT 0 NOT NULL,
    en_fazla_irsaliye_satir_sayisi integer DEFAULT 0 NOT NULL,
    en_fazla_e_irsaliye_satir_sayisi integer DEFAULT 0 NOT NULL,
    siparis_kopyalanacak_kaynak_cari_kod character varying(16),
    siparis_kopyalanacak_hedef_cari_kod character varying(16),
    maliyet_analizi_iskonto_orani double precision,
    genel_kdv_orani double precision DEFAULT 18 NOT NULL,
    path_teklif_hesaplama_conf character varying(255),
    path_proforma_file character varying(255),
    path_mal_stok_seviyesi_eord_rapor character varying(255),
    path_update character varying(255),
    path_stok_karti_resim character varying(255),
    path_proforma_pdf_kayit character varying(255)
);
 2   DROP TABLE public.sys_application_settings_other;
       public         postgres    false    8            v           1259    478456 %   sys_application_settings_other_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_application_settings_other_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.sys_application_settings_other_id_seq;
       public       postgres    false    8    373            �           0    0 %   sys_application_settings_other_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.sys_application_settings_other_id_seq OWNED BY public.sys_application_settings_other.id;
            public       postgres    false    374            �           0    0 .   SEQUENCE sys_application_settings_other_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.sys_application_settings_other_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_application_settings_other_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_application_settings_other_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_application_settings_other_id_seq TO PUBLIC;
            public       postgres    false    374            w           1259    478458    sys_grid_col_color    TABLE     �  CREATE TABLE public.sys_grid_col_color (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    min_value double precision DEFAULT 0 NOT NULL,
    min_color integer DEFAULT 0 NOT NULL,
    max_value double precision DEFAULT 0 NOT NULL,
    max_color integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public.sys_grid_col_color;
       public         postgres    false    8            �           0    0    TABLE sys_grid_col_color    ACL     �   REVOKE ALL ON TABLE public.sys_grid_col_color FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_grid_col_color FROM postgres;
GRANT ALL ON TABLE public.sys_grid_col_color TO postgres;
            public       postgres    false    375            x           1259    478469    sys_grid_col_color_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_grid_col_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.sys_grid_col_color_id_seq;
       public       postgres    false    375    8            �           0    0    sys_grid_col_color_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.sys_grid_col_color_id_seq OWNED BY public.sys_grid_col_color.id;
            public       postgres    false    376            �           0    0 "   SEQUENCE sys_grid_col_color_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_grid_col_color_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_grid_col_color_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_grid_col_color_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_grid_col_color_id_seq TO PUBLIC;
            public       postgres    false    376            y           1259    478471    sys_grid_col_percent    TABLE     �  CREATE TABLE public.sys_grid_col_percent (
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
 (   DROP TABLE public.sys_grid_col_percent;
       public         postgres    false    8            �           0    0    TABLE sys_grid_col_percent    ACL     �   REVOKE ALL ON TABLE public.sys_grid_col_percent FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_grid_col_percent FROM postgres;
GRANT ALL ON TABLE public.sys_grid_col_percent TO postgres;
            public       postgres    false    377            z           1259    478483    sys_grid_col_percent_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_grid_col_percent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.sys_grid_col_percent_id_seq;
       public       postgres    false    8    377            �           0    0    sys_grid_col_percent_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sys_grid_col_percent_id_seq OWNED BY public.sys_grid_col_percent.id;
            public       postgres    false    378            �           0    0 $   SEQUENCE sys_grid_col_percent_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_grid_col_percent_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_grid_col_percent_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_grid_col_percent_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_grid_col_percent_id_seq TO PUBLIC;
            public       postgres    false    378            {           1259    478485    sys_grid_col_width    TABLE        CREATE TABLE public.sys_grid_col_width (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    column_width integer DEFAULT 0 NOT NULL,
    sequence_no integer DEFAULT 1 NOT NULL
);
 &   DROP TABLE public.sys_grid_col_width;
       public         postgres    false    8            �           0    0    TABLE sys_grid_col_width    ACL     �   REVOKE ALL ON TABLE public.sys_grid_col_width FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_grid_col_width FROM postgres;
GRANT ALL ON TABLE public.sys_grid_col_width TO postgres;
            public       postgres    false    379            |           1259    478494    sys_grid_col_width_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_grid_col_width_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.sys_grid_col_width_id_seq;
       public       postgres    false    379    8            �           0    0    sys_grid_col_width_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.sys_grid_col_width_id_seq OWNED BY public.sys_grid_col_width.id;
            public       postgres    false    380            �           0    0 "   SEQUENCE sys_grid_col_width_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_grid_col_width_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_grid_col_width_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_grid_col_width_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_grid_col_width_id_seq TO PUBLIC;
            public       postgres    false    380            }           1259    478496    sys_grid_default_order_filter    TABLE     �   CREATE TABLE public.sys_grid_default_order_filter (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    key character varying(32),
    value character varying,
    is_order boolean DEFAULT false NOT NULL
);
 1   DROP TABLE public.sys_grid_default_order_filter;
       public         postgres    false    8            ~           1259    478504 $   sys_grid_default_order_filter_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_grid_default_order_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.sys_grid_default_order_filter_id_seq;
       public       postgres    false    8    381            �           0    0 $   sys_grid_default_order_filter_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.sys_grid_default_order_filter_id_seq OWNED BY public.sys_grid_default_order_filter.id;
            public       postgres    false    382            �           0    0 -   SEQUENCE sys_grid_default_order_filter_id_seq    ACL     >  REVOKE ALL ON SEQUENCE public.sys_grid_default_order_filter_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_grid_default_order_filter_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_grid_default_order_filter_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_grid_default_order_filter_id_seq TO PUBLIC;
            public       postgres    false    382                       1259    478506    sys_lang    TABLE     �   CREATE TABLE public.sys_lang (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    language character varying(16)
);
    DROP TABLE public.sys_lang;
       public         postgres    false    8            �           0    0    TABLE sys_lang    ACL     �   REVOKE ALL ON TABLE public.sys_lang FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_lang FROM postgres;
GRANT ALL ON TABLE public.sys_lang TO postgres;
            public       postgres    false    383            �           1259    478510    sys_lang_data_content    TABLE        CREATE TABLE public.sys_lang_data_content (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    lang character varying(16) NOT NULL,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    row_id integer NOT NULL,
    value text
);
 )   DROP TABLE public.sys_lang_data_content;
       public         postgres    false    8            �           1259    478517    sys_lang_data_content_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_lang_data_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sys_lang_data_content_id_seq;
       public       postgres    false    384    8            �           0    0    sys_lang_data_content_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_lang_data_content_id_seq OWNED BY public.sys_lang_data_content.id;
            public       postgres    false    385            �           0    0 %   SEQUENCE sys_lang_data_content_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_lang_data_content_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_lang_data_content_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_lang_data_content_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_lang_data_content_id_seq TO PUBLIC;
            public       postgres    false    385            �           1259    478519    sys_lang_gui_content    TABLE     b  CREATE TABLE public.sys_lang_gui_content (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    lang character varying(16) NOT NULL,
    code character varying(64) NOT NULL,
    value text,
    is_factory_setting boolean DEFAULT false NOT NULL,
    content_type character varying(32) NOT NULL,
    table_name character varying(64)
);
 (   DROP TABLE public.sys_lang_gui_content;
       public         postgres    false    8            �           1259    478527    sys_lang_gui_content_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_lang_gui_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.sys_lang_gui_content_id_seq;
       public       postgres    false    386    8            �           0    0    sys_lang_gui_content_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sys_lang_gui_content_id_seq OWNED BY public.sys_lang_gui_content.id;
            public       postgres    false    387            �           0    0 $   SEQUENCE sys_lang_gui_content_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_lang_gui_content_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_lang_gui_content_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_lang_gui_content_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_lang_gui_content_id_seq TO PUBLIC;
            public       postgres    false    387            �           1259    478529    sys_lang_id_seq    SEQUENCE     x   CREATE SEQUENCE public.sys_lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sys_lang_id_seq;
       public       postgres    false    383    8            �           0    0    sys_lang_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sys_lang_id_seq OWNED BY public.sys_lang.id;
            public       postgres    false    388            �           0    0    SEQUENCE sys_lang_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.sys_lang_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_lang_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_lang_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_lang_id_seq TO PUBLIC;
            public       postgres    false    388            �           1259    478531    sys_multi_lang_data_table_list    TABLE     �   CREATE TABLE public.sys_multi_lang_data_table_list (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying DEFAULT 128 NOT NULL
);
 2   DROP TABLE public.sys_multi_lang_data_table_list;
       public         postgres    false    8            �           1259    478539 %   sys_multi_lang_data_table_list_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_multi_lang_data_table_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.sys_multi_lang_data_table_list_id_seq;
       public       postgres    false    8    389            �           0    0 %   sys_multi_lang_data_table_list_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.sys_multi_lang_data_table_list_id_seq OWNED BY public.sys_multi_lang_data_table_list.id;
            public       postgres    false    390            �           0    0 .   SEQUENCE sys_multi_lang_data_table_list_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.sys_multi_lang_data_table_list_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_multi_lang_data_table_list_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_multi_lang_data_table_list_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_multi_lang_data_table_list_id_seq TO PUBLIC;
            public       postgres    false    390            �           1259    478541    sys_permission_source    TABLE     �   CREATE TABLE public.sys_permission_source (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    source_code character varying(16),
    source_name character varying(64),
    source_group_id integer
);
 )   DROP TABLE public.sys_permission_source;
       public         postgres    false    8            �           0    0    TABLE sys_permission_source    ACL     �   REVOKE ALL ON TABLE public.sys_permission_source FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_permission_source FROM postgres;
GRANT ALL ON TABLE public.sys_permission_source TO postgres;
            public       postgres    false    391            �           1259    478545    sys_permission_source_group    TABLE     �   CREATE TABLE public.sys_permission_source_group (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    source_group character varying(64)
);
 /   DROP TABLE public.sys_permission_source_group;
       public         postgres    false    8            �           0    0 !   TABLE sys_permission_source_group    ACL     �   REVOKE ALL ON TABLE public.sys_permission_source_group FROM PUBLIC;
REVOKE ALL ON TABLE public.sys_permission_source_group FROM postgres;
GRANT ALL ON TABLE public.sys_permission_source_group TO postgres;
            public       postgres    false    392            �           1259    478549 "   sys_permission_source_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_permission_source_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.sys_permission_source_group_id_seq;
       public       postgres    false    8    392            �           0    0 "   sys_permission_source_group_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.sys_permission_source_group_id_seq OWNED BY public.sys_permission_source_group.id;
            public       postgres    false    393            �           0    0 +   SEQUENCE sys_permission_source_group_id_seq    ACL     6  REVOKE ALL ON SEQUENCE public.sys_permission_source_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_permission_source_group_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_group_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_group_id_seq TO PUBLIC;
            public       postgres    false    393            �           1259    478551    sys_permission_source_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_permission_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sys_permission_source_id_seq;
       public       postgres    false    8    391            �           0    0    sys_permission_source_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_permission_source_id_seq OWNED BY public.sys_permission_source.id;
            public       postgres    false    394            �           0    0 %   SEQUENCE sys_permission_source_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_permission_source_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_permission_source_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_permission_source_id_seq TO PUBLIC;
            public       postgres    false    394            �           1259    478553    sys_quality_form_number    TABLE     �   CREATE TABLE public.sys_quality_form_number (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    table_name character varying NOT NULL,
    form_no character varying(16) NOT NULL,
    is_input_form boolean
);
 +   DROP TABLE public.sys_quality_form_number;
       public         postgres    false    8            �           1259    478560    sys_quality_form_number_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_quality_form_number_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.sys_quality_form_number_id_seq;
       public       postgres    false    395    8            �           0    0    sys_quality_form_number_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.sys_quality_form_number_id_seq OWNED BY public.sys_quality_form_number.id;
            public       postgres    false    396            �           0    0 '   SEQUENCE sys_quality_form_number_id_seq    ACL     &  REVOKE ALL ON SEQUENCE public.sys_quality_form_number_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_quality_form_number_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_quality_form_number_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_quality_form_number_id_seq TO PUBLIC;
            public       postgres    false    396            �           1259    478562    sys_user    TABLE     �  CREATE TABLE public.sys_user (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    user_name character varying(32) NOT NULL,
    user_password text NOT NULL,
    is_active_user boolean DEFAULT false NOT NULL,
    is_online boolean DEFAULT false NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    is_super_user boolean DEFAULT false NOT NULL,
    ip_address character varying(32) DEFAULT '127.0.0.1'::character varying NOT NULL,
    mac_address character varying(32),
    email_address character varying(64),
    app_version text,
    personel_bilgisi_id integer NOT NULL,
    invoice_no_serie character varying(1),
    dispatch_no_serie character varying(1),
    default_qrcode_size integer DEFAULT '-1'::integer NOT NULL
);
    DROP TABLE public.sys_user;
       public         postgres    false    8            �           1259    478575    sys_user_access_right    TABLE     �  CREATE TABLE public.sys_user_access_right (
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
 )   DROP TABLE public.sys_user_access_right;
       public         postgres    false    8            �           1259    478584    sys_user_access_right_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_user_access_right_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sys_user_access_right_id_seq;
       public       postgres    false    398    8            �           0    0    sys_user_access_right_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_user_access_right_id_seq OWNED BY public.sys_user_access_right.id;
            public       postgres    false    399            �           0    0 %   SEQUENCE sys_user_access_right_id_seq    ACL       REVOKE ALL ON SEQUENCE public.sys_user_access_right_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_user_access_right_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_user_access_right_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_user_access_right_id_seq TO PUBLIC;
            public       postgres    false    399            �           1259    478586    sys_user_id_seq    SEQUENCE     x   CREATE SEQUENCE public.sys_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sys_user_id_seq;
       public       postgres    false    397    8            �           0    0    sys_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sys_user_id_seq OWNED BY public.sys_user.id;
            public       postgres    false    400            �           0    0    SEQUENCE sys_user_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.sys_user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_user_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_user_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_user_id_seq TO PUBLIC;
            public       postgres    false    400            �           1259    478588    sys_user_mac_address_exception    TABLE     �   CREATE TABLE public.sys_user_mac_address_exception (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    user_name character varying(32) NOT NULL,
    ip_address character varying(32) NOT NULL
);
 2   DROP TABLE public.sys_user_mac_address_exception;
       public         postgres    false    8            �           1259    478592 %   sys_user_mac_address_exception_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_user_mac_address_exception_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.sys_user_mac_address_exception_id_seq;
       public       postgres    false    401    8            �           0    0 %   sys_user_mac_address_exception_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.sys_user_mac_address_exception_id_seq OWNED BY public.sys_user_mac_address_exception.id;
            public       postgres    false    402            �           0    0 .   SEQUENCE sys_user_mac_address_exception_id_seq    ACL     B  REVOKE ALL ON SEQUENCE public.sys_user_mac_address_exception_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.sys_user_mac_address_exception_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.sys_user_mac_address_exception_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.sys_user_mac_address_exception_id_seq TO PUBLIC;
            public       postgres    false    402            �           1259    478594    sys_view_tables    VIEW     5  CREATE VIEW public.sys_view_tables AS
 SELECT initcap(replace((tables.table_name)::text, '_'::text, ' '::text)) AS table_name,
    (tables.table_type)::text AS table_type
   FROM information_schema.tables
  WHERE ((tables.table_schema)::text = 'public'::text)
  ORDER BY tables.table_type, tables.table_name;
 "   DROP VIEW public.sys_view_tables;
       public       postgres    false    8            �           1259    478598    sys_view_columns    VIEW     �  CREATE VIEW public.sys_view_columns AS
 SELECT initcap(replace((columns.table_name)::text, '_'::text, ' '::text)) AS table_name,
    initcap(replace((columns.column_name)::text, '_'::text, ' '::text)) AS column_name,
    columns.is_nullable,
    (columns.data_type)::text AS data_type,
    (columns.character_maximum_length)::integer AS character_maximum_length,
    (columns.ordinal_position)::integer AS ordinal_position,
    vt.table_type
   FROM (information_schema.columns
     JOIN public.sys_view_tables vt ON ((( SELECT lower(replace(vt.table_name, ' '::text, '_'::text)) AS lower) = (columns.table_name)::text)))
  ORDER BY vt.table_type, columns.table_name, columns.ordinal_position;
 #   DROP VIEW public.sys_view_columns;
       public       postgres    false    403    403    8            �           1259    478603    sys_view_databases    VIEW     6  CREATE VIEW public.sys_view_databases AS
 SELECT pg_database.datname AS database_name,
    pg_shdescription.description AS aciklama
   FROM (pg_shdescription
     JOIN pg_database ON ((pg_shdescription.objoid = pg_database.oid)))
  WHERE ((1 = 1) AND (pg_shdescription.description = 'THS ERP Systems'::text));
 %   DROP VIEW public.sys_view_databases;
       public       postgres    false    8            �           1259    478607    ulke    TABLE     8  CREATE TABLE public.ulke (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    ulke_kodu character varying(2) NOT NULL,
    ulke_adi character varying(128) NOT NULL,
    iso_year integer,
    iso_cctld_code character varying(3),
    is_avrupa_birligi_uyesi boolean DEFAULT false NOT NULL
);
    DROP TABLE public.ulke;
       public         postgres    false    8            �           0    0 
   TABLE ulke    ACL     �   REVOKE ALL ON TABLE public.ulke FROM PUBLIC;
REVOKE ALL ON TABLE public.ulke FROM postgres;
GRANT ALL ON TABLE public.ulke TO postgres;
            public       postgres    false    406            �           1259    478612    ulke_id_seq    SEQUENCE     t   CREATE SEQUENCE public.ulke_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.ulke_id_seq;
       public       postgres    false    8    406            �           0    0    ulke_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.ulke_id_seq OWNED BY public.ulke.id;
            public       postgres    false    407            �           0    0    SEQUENCE ulke_id_seq    ACL     �   REVOKE ALL ON SEQUENCE public.ulke_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.ulke_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.ulke_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.ulke_id_seq TO PUBLIC;
            public       postgres    false    407            �           1259    478614    urun_kabul_red_nedeni    TABLE     �   CREATE TABLE public.urun_kabul_red_nedeni (
    id integer NOT NULL,
    validity boolean DEFAULT true NOT NULL,
    deger character varying(64) NOT NULL
);
 )   DROP TABLE public.urun_kabul_red_nedeni;
       public         postgres    false    8            �           0    0    TABLE urun_kabul_red_nedeni    ACL     �   REVOKE ALL ON TABLE public.urun_kabul_red_nedeni FROM PUBLIC;
REVOKE ALL ON TABLE public.urun_kabul_red_nedeni FROM postgres;
GRANT ALL ON TABLE public.urun_kabul_red_nedeni TO postgres;
            public       postgres    false    408            �           1259    478618    urun_kabul_red_nedeni_id_seq    SEQUENCE     �   CREATE SEQUENCE public.urun_kabul_red_nedeni_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.urun_kabul_red_nedeni_id_seq;
       public       postgres    false    408    8            �           0    0    urun_kabul_red_nedeni_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.urun_kabul_red_nedeni_id_seq OWNED BY public.urun_kabul_red_nedeni.id;
            public       postgres    false    409            �           0    0 %   SEQUENCE urun_kabul_red_nedeni_id_seq    ACL       REVOKE ALL ON SEQUENCE public.urun_kabul_red_nedeni_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public.urun_kabul_red_nedeni_id_seq FROM postgres;
GRANT ALL ON SEQUENCE public.urun_kabul_red_nedeni_id_seq TO postgres;
GRANT ALL ON SEQUENCE public.urun_kabul_red_nedeni_id_seq TO PUBLIC;
            public       postgres    false    409            .           2604    478620    id    DEFAULT     d   ALTER TABLE ONLY public.adres ALTER COLUMN id SET DEFAULT nextval('public.adres_id_seq'::regclass);
 7   ALTER TABLE public.adres ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    184    183            7           2604    478621    id    DEFAULT     p   ALTER TABLE ONLY public.alis_teklif ALTER COLUMN id SET DEFAULT nextval('public.alis_teklif_id_seq'::regclass);
 =   ALTER TABLE public.alis_teklif ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    188    185            9           2604    478622    id    DEFAULT     |   ALTER TABLE ONLY public.alis_teklif_detay ALTER COLUMN id SET DEFAULT nextval('public.alis_teklif_detay_id_seq'::regclass);
 C   ALTER TABLE public.alis_teklif_detay ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    187    186            >           2604    478624    id    DEFAULT     d   ALTER TABLE ONLY public.ambar ALTER COLUMN id SET DEFAULT nextval('public.ambar_id_seq'::regclass);
 7   ALTER TABLE public.ambar ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    190    189            @           2604    478625    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_barkod_hazirlik_dosya_turu ALTER COLUMN id SET DEFAULT nextval('public.ayar_barkod_hazirlik_dosya_turu_id_seq'::regclass);
 Q   ALTER TABLE public.ayar_barkod_hazirlik_dosya_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    192    191            B           2604    478626    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_barkod_serino_turu ALTER COLUMN id SET DEFAULT nextval('public.ayar_barkod_serino_turu_id_seq'::regclass);
 I   ALTER TABLE public.ayar_barkod_serino_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    194    193            D           2604    478627    id    DEFAULT     ~   ALTER TABLE ONLY public.ayar_barkod_tezgah ALTER COLUMN id SET DEFAULT nextval('public.ayar_barkod_tezgah_id_seq'::regclass);
 D   ALTER TABLE public.ayar_barkod_tezgah ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    196    195            F           2604    478628    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_barkod_urun_turu ALTER COLUMN id SET DEFAULT nextval('public.ayar_barkod_urun_turu_id_seq'::regclass);
 G   ALTER TABLE public.ayar_barkod_urun_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    198    197            H           2604    478629    id    DEFAULT     z   ALTER TABLE ONLY public.ayar_bordro_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_bordro_tipi_id_seq'::regclass);
 B   ALTER TABLE public.ayar_bordro_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    200    199            J           2604    478630    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_cek_senet_cash_edici_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_cek_senet_cash_edici_tipi_id_seq'::regclass);
 P   ALTER TABLE public.ayar_cek_senet_cash_edici_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    202    201            L           2604    478631    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_cek_senet_tahsil_odeme_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_cek_senet_tahsil_odeme_tipi_id_seq'::regclass);
 R   ALTER TABLE public.ayar_cek_senet_tahsil_odeme_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    204    203            N           2604    478632    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_cek_senet_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_cek_senet_tipi_id_seq'::regclass);
 E   ALTER TABLE public.ayar_cek_senet_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    206    205            Y           2604    478633    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_diger_database_bilgisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_diger_database_bilgisi_id_seq'::regclass);
 M   ALTER TABLE public.ayar_diger_database_bilgisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    208    207            [           2604    478634    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_edefter_donem_raporu ALTER COLUMN id SET DEFAULT nextval('public.ayar_edefter_donem_raporu_id_seq'::regclass);
 K   ALTER TABLE public.ayar_edefter_donem_raporu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    210    209            ]           2604    478635    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_alici_bilgisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_alici_bilgisi_id_seq'::regclass);
 L   ALTER TABLE public.ayar_efatura_alici_bilgisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    212    211            _           2604    478636    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_cinsi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_evrak_cinsi_id_seq'::regclass);
 J   ALTER TABLE public.ayar_efatura_evrak_cinsi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    214    213            a           2604    478637    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_evrak_tipi_id_seq'::regclass);
 I   ALTER TABLE public.ayar_efatura_evrak_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    218    215            c           2604    478638    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_evrak_tipi_cinsi_id_seq'::regclass);
 O   ALTER TABLE public.ayar_efatura_evrak_tipi_cinsi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    217    216            e           2604    478639    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_fatura_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_fatura_tipi_id_seq'::regclass);
 J   ALTER TABLE public.ayar_efatura_fatura_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    220    219            g           2604    478640    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_gonderici_bilgisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_gonderici_bilgisi_id_seq'::regclass);
 P   ALTER TABLE public.ayar_efatura_gonderici_bilgisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    222    221            j           2604    478641    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_gonderim_sekli ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_gonderim_sekli_id_seq'::regclass);
 M   ALTER TABLE public.ayar_efatura_gonderim_sekli ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    224    223            l           2604    478642    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_ihrac_kayitli_fatura_sebebi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq'::regclass);
 Z   ALTER TABLE public.ayar_efatura_ihrac_kayitli_fatura_sebebi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    226    225            n           2604    478643    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_iletisim_kanali_id_seq'::regclass);
 N   ALTER TABLE public.ayar_efatura_iletisim_kanali ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    228    227            q           2604    478644    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_istisna_kodu ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_istisna_kodu_id_seq'::regclass);
 K   ALTER TABLE public.ayar_efatura_istisna_kodu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    230    229            s           2604    478645    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_kimlik_semalari_id_seq'::regclass);
 N   ALTER TABLE public.ayar_efatura_kimlik_semalari ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    232    231            w           2604    478646    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_odeme_sekli ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_odeme_sekli_id_seq'::regclass);
 J   ALTER TABLE public.ayar_efatura_odeme_sekli ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    234    233            z           2604    478647    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_paket_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_paket_tipi_id_seq'::regclass);
 I   ALTER TABLE public.ayar_efatura_paket_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    236    235            |           2604    478648    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_response_code ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_response_code_id_seq'::regclass);
 L   ALTER TABLE public.ayar_efatura_response_code ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    238    237            ~           2604    478649    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_senaryo_tipi_id_seq'::regclass);
 K   ALTER TABLE public.ayar_efatura_senaryo_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    240    239            �           2604    478650    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_teslim_sarti ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_teslim_sarti_id_seq'::regclass);
 K   ALTER TABLE public.ayar_efatura_teslim_sarti ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    242    241            �           2604    478651    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_tevkifat_kodu_id_seq'::regclass);
 L   ALTER TABLE public.ayar_efatura_tevkifat_kodu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    244    243            �           2604    478652    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_efatura_vergi_kodu ALTER COLUMN id SET DEFAULT nextval('public.ayar_efatura_vergi_kodu_id_seq'::regclass);
 I   ALTER TABLE public.ayar_efatura_vergi_kodu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    246    245            �           2604    478653    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_fatura_no_serisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_fatura_no_serisi_id_seq'::regclass);
 G   ALTER TABLE public.ayar_fatura_no_serisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    248    247            �           2604    478654    id    DEFAULT     x   ALTER TABLE ONLY public.ayar_firma_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_firma_tipi_id_seq'::regclass);
 A   ALTER TABLE public.ayar_firma_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    250    249            �           2604    478655    id    DEFAULT     x   ALTER TABLE ONLY public.ayar_firma_turu ALTER COLUMN id SET DEFAULT nextval('public.ayar_firma_turu_id_seq'::regclass);
 A   ALTER TABLE public.ayar_firma_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    252    251            �           2604    478656    id    DEFAULT     t   ALTER TABLE ONLY public.ayar_fis_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_fis_tipi_id_seq'::regclass);
 ?   ALTER TABLE public.ayar_fis_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    254    253            �           2604    478657    id    DEFAULT     ~   ALTER TABLE ONLY public.ayar_genel_ayarlar ALTER COLUMN id SET DEFAULT nextval('public.ayar_genel_ayarlar_id_seq'::regclass);
 D   ALTER TABLE public.ayar_genel_ayarlar ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    256    255            �           2604    478658    id    DEFAULT     z   ALTER TABLE ONLY public.ayar_hane_sayisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_hane_sayisi_id_seq'::regclass);
 B   ALTER TABLE public.ayar_hane_sayisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    258    257            �           2604    478659    id    DEFAULT     x   ALTER TABLE ONLY public.ayar_hesap_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_hesap_tipi_id_seq'::regclass);
 A   ALTER TABLE public.ayar_hesap_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    260    259            �           2604    478660    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_irsaliye_fatura_no_serisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_irsaliye_fatura_no_serisi_id_seq'::regclass);
 P   ALTER TABLE public.ayar_irsaliye_fatura_no_serisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    262    261            �           2604    478661    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi ALTER COLUMN id SET DEFAULT nextval('public.ayar_irsaliye_no_serisi_id_seq'::regclass);
 I   ALTER TABLE public.ayar_irsaliye_no_serisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    264    263            �           2604    478662    id    DEFAULT     x   ALTER TABLE ONLY public.ayar_modul_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_modul_tipi_id_seq'::regclass);
 A   ALTER TABLE public.ayar_modul_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    266    265            �           2604    478663    id    DEFAULT     ~   ALTER TABLE ONLY public.ayar_mukellef_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_mukellef_tipi_id_seq'::regclass);
 D   ALTER TABLE public.ayar_mukellef_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    268    267            �           2604    478664    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_musteri_firma_turu ALTER COLUMN id SET DEFAULT nextval('public.ayar_musteri_firma_turu_id_seq'::regclass);
 I   ALTER TABLE public.ayar_musteri_firma_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    270    269            �           2604    478665    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_odeme_baslangic_donemi ALTER COLUMN id SET DEFAULT nextval('public.ayar_odeme_baslangic_donemi_id_seq'::regclass);
 M   ALTER TABLE public.ayar_odeme_baslangic_donemi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    272    271            �           2604    478666    id    DEFAULT     z   ALTER TABLE ONLY public.ayar_odeme_sekli ALTER COLUMN id SET DEFAULT nextval('public.ayar_odeme_sekli_id_seq'::regclass);
 B   ALTER TABLE public.ayar_odeme_sekli ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    274    273            �           2604    793023    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_askerlik_durumu ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_askerlik_durumu_id_seq'::regclass);
 J   ALTER TABLE public.ayar_prs_askerlik_durumu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    412    413    413                       2604    821961    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_ayrilma_nedeni ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_ayrilma_nedeni_id_seq'::regclass);
 I   ALTER TABLE public.ayar_prs_ayrilma_nedeni ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    447    448    448                       2604    820771    id    DEFAULT     v   ALTER TABLE ONLY public.ayar_prs_birim ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_birim_id_seq'::regclass);
 @   ALTER TABLE public.ayar_prs_birim ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    445    446    446                       2604    820750    id    DEFAULT     v   ALTER TABLE ONLY public.ayar_prs_bolum ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_bolum_id_seq'::regclass);
 @   ALTER TABLE public.ayar_prs_bolum ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    444    443    444                       2604    820724    id    DEFAULT     |   ALTER TABLE ONLY public.ayar_prs_cinsiyet ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_cinsiyet_id_seq'::regclass);
 C   ALTER TABLE public.ayar_prs_cinsiyet ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    442    441    442            
           2604    820686    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_egitim_durumu ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_egitim_durumu_id_seq'::regclass);
 H   ALTER TABLE public.ayar_prs_egitim_durumu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    436    435    436            	           2604    820676    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_ehliyet_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_ehliyet_tipi_id_seq'::regclass);
 G   ALTER TABLE public.ayar_prs_ehliyet_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    434    433    434                       2604    820661    id    DEFAULT     v   ALTER TABLE ONLY public.ayar_prs_gorev ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_gorev_id_seq'::regclass);
 @   ALTER TABLE public.ayar_prs_gorev ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    432    431    432                       2604    812292    id    DEFAULT     ~   ALTER TABLE ONLY public.ayar_prs_izin_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_izin_tipi_id_seq'::regclass);
 D   ALTER TABLE public.ayar_prs_izin_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    429    428    429                       2604    801410    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_medeni_durum ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_medeni_durum_id_seq'::regclass);
 G   ALTER TABLE public.ayar_prs_medeni_durum ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    427    426    427                       2604    801400    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_mektup_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_mektup_tipi_id_seq'::regclass);
 F   ALTER TABLE public.ayar_prs_mektup_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    424    425    425                       2604    801390    id    DEFAULT     |   ALTER TABLE ONLY public.ayar_prs_myk_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_myk_tipi_id_seq'::regclass);
 C   ALTER TABLE public.ayar_prs_myk_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    423    422    423            �           2604    793033    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_personel_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_personel_tipi_id_seq'::regclass);
 H   ALTER TABLE public.ayar_prs_personel_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    415    414    415                       2604    801366    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_rapor_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_rapor_tipi_id_seq'::regclass);
 E   ALTER TABLE public.ayar_prs_rapor_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    418    419    419                       2604    801376    id    DEFAULT     |   ALTER TABLE ONLY public.ayar_prs_src_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_src_tipi_id_seq'::regclass);
 C   ALTER TABLE public.ayar_prs_src_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    420    421    421            �           2604    794530    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_tatil_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_tatil_tipi_id_seq'::regclass);
 E   ALTER TABLE public.ayar_prs_tatil_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    417    416    417                       2604    820706    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_yabanci_dil ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_yabanci_dil_id_seq'::regclass);
 F   ALTER TABLE public.ayar_prs_yabanci_dil ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    440    439    440                       2604    820696    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_prs_yabanci_dil_seviyesi ALTER COLUMN id SET DEFAULT nextval('public.ayar_prs_yabanci_dil_seviyesi_id_seq'::regclass);
 O   ALTER TABLE public.ayar_prs_yabanci_dil_seviyesi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    438    437    438            �           2604    478686    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_sabit_degisken ALTER COLUMN id SET DEFAULT nextval('public.ayar_sabit_degisken_id_seq'::regclass);
 E   ALTER TABLE public.ayar_sabit_degisken ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    276    275            �           2604    478687    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_sevkiyat_hazirlama_durumu ALTER COLUMN id SET DEFAULT nextval('public.ayar_sevkiyat_hazirlama_durumu_id_seq'::regclass);
 P   ALTER TABLE public.ayar_sevkiyat_hazirlama_durumu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    278    277            �           2604    478688    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_stok_hareket_ayari ALTER COLUMN id SET DEFAULT nextval('public.ayar_stok_hareket_ayari_id_seq'::regclass);
 I   ALTER TABLE public.ayar_stok_hareket_ayari ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    280    279            �           2604    478689    id    DEFAULT     �   ALTER TABLE ONLY public.ayar_stok_hareket_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_stok_hareket_tipi_id_seq'::regclass);
 H   ALTER TABLE public.ayar_stok_hareket_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    282    281            �           2604    478690    id    DEFAULT     |   ALTER TABLE ONLY public.ayar_teklif_durum ALTER COLUMN id SET DEFAULT nextval('public.ayar_teklif_durum_id_seq'::regclass);
 C   ALTER TABLE public.ayar_teklif_durum ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    284    283            �           2604    478691    id    DEFAULT     z   ALTER TABLE ONLY public.ayar_teklif_tipi ALTER COLUMN id SET DEFAULT nextval('public.ayar_teklif_tipi_id_seq'::regclass);
 B   ALTER TABLE public.ayar_teklif_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    286    285            �           2604    478692    id    DEFAULT     z   ALTER TABLE ONLY public.ayar_vergi_orani ALTER COLUMN id SET DEFAULT nextval('public.ayar_vergi_orani_id_seq'::regclass);
 B   ALTER TABLE public.ayar_vergi_orani ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    288    287            �           2604    478693    id    DEFAULT     d   ALTER TABLE ONLY public.banka ALTER COLUMN id SET DEFAULT nextval('public.banka_id_seq'::regclass);
 7   ALTER TABLE public.banka ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    290    289            �           2604    478694    id    DEFAULT     r   ALTER TABLE ONLY public.banka_subesi ALTER COLUMN id SET DEFAULT nextval('public.banka_subesi_id_seq'::regclass);
 >   ALTER TABLE public.banka_subesi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    292    291            �           2604    478695    id    DEFAULT     �   ALTER TABLE ONLY public.barkod_hazirlik_dosya_turu ALTER COLUMN id SET DEFAULT nextval('public.barkod_hazirlik_dosya_turu_id_seq'::regclass);
 L   ALTER TABLE public.barkod_hazirlik_dosya_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    294    293            �           2604    478696    id    DEFAULT     ~   ALTER TABLE ONLY public.barkod_serino_turu ALTER COLUMN id SET DEFAULT nextval('public.barkod_serino_turu_id_seq'::regclass);
 D   ALTER TABLE public.barkod_serino_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    296    295            �           2604    478697    id    DEFAULT     t   ALTER TABLE ONLY public.barkod_tezgah ALTER COLUMN id SET DEFAULT nextval('public.barkod_tezgah_id_seq'::regclass);
 ?   ALTER TABLE public.barkod_tezgah ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    298    297            �           2604    478698    id    DEFAULT     d   ALTER TABLE ONLY public.bolge ALTER COLUMN id SET DEFAULT nextval('public.bolge_id_seq'::regclass);
 7   ALTER TABLE public.bolge ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    300    299                       2604    478699    id    DEFAULT     n   ALTER TABLE ONLY public.bolge_turu ALTER COLUMN id SET DEFAULT nextval('public.bolge_turu_id_seq'::regclass);
 <   ALTER TABLE public.bolge_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    302    301                       2604    478700    id    DEFAULT     p   ALTER TABLE ONLY public.cins_ailesi ALTER COLUMN id SET DEFAULT nextval('public.cins_ailesi_id_seq'::regclass);
 =   ALTER TABLE public.cins_ailesi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    304    303                       2604    478701    id    DEFAULT     t   ALTER TABLE ONLY public.cins_ozelligi ALTER COLUMN id SET DEFAULT nextval('public.cins_ozelligi_id_seq'::regclass);
 ?   ALTER TABLE public.cins_ozelligi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    306    305                       2604    478702    id    DEFAULT     �   ALTER TABLE ONLY public.cnf_employee_section ALTER COLUMN id SET DEFAULT nextval('public.cnf_employee_section_id_seq'::regclass);
 F   ALTER TABLE public.cnf_employee_section ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    308    307            
           2604    478703    id    DEFAULT     n   ALTER TABLE ONLY public.doviz_kuru ALTER COLUMN id SET DEFAULT nextval('public.doviz_kuru_id_seq'::regclass);
 <   ALTER TABLE public.doviz_kuru ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    310    309                       2604    478704    id    DEFAULT     p   ALTER TABLE ONLY public.hesap_grubu ALTER COLUMN id SET DEFAULT nextval('public.hesap_grubu_id_seq'::regclass);
 =   ALTER TABLE public.hesap_grubu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    312    311            �           2604    699379    id    DEFAULT     p   ALTER TABLE ONLY public.hesap_karti ALTER COLUMN id SET DEFAULT nextval('public.hesap_karti_id_seq'::regclass);
 =   ALTER TABLE public.hesap_karti ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    411    410    411                       2604    478706    id    DEFAULT     p   ALTER TABLE ONLY public.hesap_plani ALTER COLUMN id SET DEFAULT nextval('public.hesap_plani_id_seq'::regclass);
 =   ALTER TABLE public.hesap_plani ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    314    313                       2604    478707    id    DEFAULT     r   ALTER TABLE ONLY public.medeni_durum ALTER COLUMN id SET DEFAULT nextval('public.medeni_durum_id_seq'::regclass);
 >   ALTER TABLE public.medeni_durum ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    316    315                       2604    478708    id    DEFAULT     �   ALTER TABLE ONLY public.muhasebe_hesap_plani ALTER COLUMN id SET DEFAULT nextval('public.muhasebe_hesap_plani_id_seq'::regclass);
 F   ALTER TABLE public.muhasebe_hesap_plani ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    318    317            -           2604    478709    id    DEFAULT     �   ALTER TABLE ONLY public.musteri_temsilci_grubu ALTER COLUMN id SET DEFAULT nextval('public.musteri_temsilci_grubu_id_seq'::regclass);
 H   ALTER TABLE public.musteri_temsilci_grubu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    320    319            0           2604    478710    id    DEFAULT     p   ALTER TABLE ONLY public.olcu_birimi ALTER COLUMN id SET DEFAULT nextval('public.olcu_birimi_id_seq'::regclass);
 =   ALTER TABLE public.olcu_birimi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    322    321            2           2604    478711    id    DEFAULT     p   ALTER TABLE ONLY public.para_birimi ALTER COLUMN id SET DEFAULT nextval('public.para_birimi_id_seq'::regclass);
 =   ALTER TABLE public.para_birimi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    324    323            4           2604    478712    id    DEFAULT     �   ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi ALTER COLUMN id SET DEFAULT nextval('public.personel_ayrilma_nedeni_tipi_id_seq'::regclass);
 N   ALTER TABLE public.personel_ayrilma_nedeni_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    326    325            6           2604    478713    id    DEFAULT     �   ALTER TABLE ONLY public.personel_calisma_gecmisi ALTER COLUMN id SET DEFAULT nextval('public.personel_calisma_gecmisi_id_seq'::regclass);
 J   ALTER TABLE public.personel_calisma_gecmisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    328    327            8           2604    478714    id    DEFAULT     �   ALTER TABLE ONLY public.personel_dil_bilgisi ALTER COLUMN id SET DEFAULT nextval('public.personel_dil_bilgisi_id_seq'::regclass);
 F   ALTER TABLE public.personel_dil_bilgisi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    330    329            =           2604    478715    id    DEFAULT     v   ALTER TABLE ONLY public.personel_karti ALTER COLUMN id SET DEFAULT nextval('public.personel_karti_id_seq'::regclass);
 @   ALTER TABLE public.personel_karti ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    332    331            >           2604    478716    id    DEFAULT     ~   ALTER TABLE ONLY public.personel_pdks_kart ALTER COLUMN id SET DEFAULT nextval('public.personel_pdks_kart_id_seq'::regclass);
 D   ALTER TABLE public.personel_pdks_kart ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    334    333            @           2604    478717    id    DEFAULT     �   ALTER TABLE ONLY public.personel_tasima_servis ALTER COLUMN id SET DEFAULT nextval('public.personel_tasima_servis_id_seq'::regclass);
 H   ALTER TABLE public.personel_tasima_servis ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    336    335            B           2604    478718    id    DEFAULT     �   ALTER TABLE ONLY public.quality_form_mail_reciever ALTER COLUMN id SET DEFAULT nextval('public.quality_form_mail_reciever_id_seq'::regclass);
 L   ALTER TABLE public.quality_form_mail_reciever ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    338    337            D           2604    478719    id    DEFAULT     f   ALTER TABLE ONLY public.recete ALTER COLUMN id SET DEFAULT nextval('public.recete_id_seq'::regclass);
 8   ALTER TABLE public.recete ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    342    339            F           2604    478720    id    DEFAULT     x   ALTER TABLE ONLY public.recete_hammadde ALTER COLUMN id SET DEFAULT nextval('public.recete_hammadde_id_seq'::regclass);
 A   ALTER TABLE public.recete_hammadde ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    341    340            H           2604    478721    id    DEFAULT     r   ALTER TABLE ONLY public.satis_fatura ALTER COLUMN id SET DEFAULT nextval('public.satis_fatura_id_seq'::regclass);
 >   ALTER TABLE public.satis_fatura ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    346    343            J           2604    478722    id    DEFAULT     ~   ALTER TABLE ONLY public.satis_fatura_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_fatura_detay_id_seq'::regclass);
 D   ALTER TABLE public.satis_fatura_detay ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    345    344            L           2604    478723    id    DEFAULT     v   ALTER TABLE ONLY public.satis_irsaliye ALTER COLUMN id SET DEFAULT nextval('public.satis_irsaliye_id_seq'::regclass);
 @   ALTER TABLE public.satis_irsaliye ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    350    347            N           2604    478724    id    DEFAULT     �   ALTER TABLE ONLY public.satis_irsaliye_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_irsaliye_detay_id_seq'::regclass);
 F   ALTER TABLE public.satis_irsaliye_detay ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    349    348            P           2604    478725    id    DEFAULT     t   ALTER TABLE ONLY public.satis_siparis ALTER COLUMN id SET DEFAULT nextval('public.satis_siparis_id_seq'::regclass);
 ?   ALTER TABLE public.satis_siparis ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    354    351            R           2604    478726    id    DEFAULT     �   ALTER TABLE ONLY public.satis_siparis_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_siparis_detay_id_seq'::regclass);
 E   ALTER TABLE public.satis_siparis_detay ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    353    352            ^           2604    478727    id    DEFAULT     r   ALTER TABLE ONLY public.satis_teklif ALTER COLUMN id SET DEFAULT nextval('public.satis_teklif_id_seq'::regclass);
 >   ALTER TABLE public.satis_teklif ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    358    355            k           2604    478728    id    DEFAULT     ~   ALTER TABLE ONLY public.satis_teklif_detay ALTER COLUMN id SET DEFAULT nextval('public.satis_teklif_detay_id_seq'::regclass);
 D   ALTER TABLE public.satis_teklif_detay ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    357    356            m           2604    478729    id    DEFAULT     d   ALTER TABLE ONLY public.sehir ALTER COLUMN id SET DEFAULT nextval('public.sehir_id_seq'::regclass);
 7   ALTER TABLE public.sehir ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    360    359            t           2604    478730    id    DEFAULT     n   ALTER TABLE ONLY public.stok_grubu ALTER COLUMN id SET DEFAULT nextval('public.stok_grubu_id_seq'::regclass);
 <   ALTER TABLE public.stok_grubu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    362    361            v           2604    478731    id    DEFAULT     x   ALTER TABLE ONLY public.stok_grubu_turu ALTER COLUMN id SET DEFAULT nextval('public.stok_grubu_turu_id_seq'::regclass);
 A   ALTER TABLE public.stok_grubu_turu ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    364    363            y           2604    478732    id    DEFAULT     t   ALTER TABLE ONLY public.stok_hareketi ALTER COLUMN id SET DEFAULT nextval('public.stok_hareketi_id_seq'::regclass);
 ?   ALTER TABLE public.stok_hareketi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    366    365            �           2604    478733    id    DEFAULT     n   ALTER TABLE ONLY public.stok_karti ALTER COLUMN id SET DEFAULT nextval('public.stok_karti_id_seq'::regclass);
 <   ALTER TABLE public.stok_karti ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    368    367            �           2604    478734    id    DEFAULT     l   ALTER TABLE ONLY public.stok_tipi ALTER COLUMN id SET DEFAULT nextval('public.stok_tipi_id_seq'::regclass);
 ;   ALTER TABLE public.stok_tipi ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    370    369            �           2604    478735    id    DEFAULT     �   ALTER TABLE ONLY public.sys_application_settings ALTER COLUMN id SET DEFAULT nextval('public.sys_application_settings_id_seq'::regclass);
 J   ALTER TABLE public.sys_application_settings ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    372    371            �           2604    478736    id    DEFAULT     �   ALTER TABLE ONLY public.sys_application_settings_other ALTER COLUMN id SET DEFAULT nextval('public.sys_application_settings_other_id_seq'::regclass);
 P   ALTER TABLE public.sys_application_settings_other ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    374    373            �           2604    478737    id    DEFAULT     ~   ALTER TABLE ONLY public.sys_grid_col_color ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_col_color_id_seq'::regclass);
 D   ALTER TABLE public.sys_grid_col_color ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    376    375            �           2604    478738    id    DEFAULT     �   ALTER TABLE ONLY public.sys_grid_col_percent ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_col_percent_id_seq'::regclass);
 F   ALTER TABLE public.sys_grid_col_percent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    378    377            �           2604    478739    id    DEFAULT     ~   ALTER TABLE ONLY public.sys_grid_col_width ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_col_width_id_seq'::regclass);
 D   ALTER TABLE public.sys_grid_col_width ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    380    379            �           2604    478740    id    DEFAULT     �   ALTER TABLE ONLY public.sys_grid_default_order_filter ALTER COLUMN id SET DEFAULT nextval('public.sys_grid_default_order_filter_id_seq'::regclass);
 O   ALTER TABLE public.sys_grid_default_order_filter ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    382    381            �           2604    478741    id    DEFAULT     j   ALTER TABLE ONLY public.sys_lang ALTER COLUMN id SET DEFAULT nextval('public.sys_lang_id_seq'::regclass);
 :   ALTER TABLE public.sys_lang ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    388    383            �           2604    478742    id    DEFAULT     �   ALTER TABLE ONLY public.sys_lang_data_content ALTER COLUMN id SET DEFAULT nextval('public.sys_lang_data_content_id_seq'::regclass);
 G   ALTER TABLE public.sys_lang_data_content ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    385    384            �           2604    478743    id    DEFAULT     �   ALTER TABLE ONLY public.sys_lang_gui_content ALTER COLUMN id SET DEFAULT nextval('public.sys_lang_gui_content_id_seq'::regclass);
 F   ALTER TABLE public.sys_lang_gui_content ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    387    386            �           2604    478744    id    DEFAULT     �   ALTER TABLE ONLY public.sys_multi_lang_data_table_list ALTER COLUMN id SET DEFAULT nextval('public.sys_multi_lang_data_table_list_id_seq'::regclass);
 P   ALTER TABLE public.sys_multi_lang_data_table_list ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    390    389            �           2604    478745    id    DEFAULT     �   ALTER TABLE ONLY public.sys_permission_source ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_source_id_seq'::regclass);
 G   ALTER TABLE public.sys_permission_source ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    394    391            �           2604    478746    id    DEFAULT     �   ALTER TABLE ONLY public.sys_permission_source_group ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_source_group_id_seq'::regclass);
 M   ALTER TABLE public.sys_permission_source_group ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    393    392            �           2604    478747    id    DEFAULT     �   ALTER TABLE ONLY public.sys_quality_form_number ALTER COLUMN id SET DEFAULT nextval('public.sys_quality_form_number_id_seq'::regclass);
 I   ALTER TABLE public.sys_quality_form_number ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    396    395            �           2604    478748    id    DEFAULT     j   ALTER TABLE ONLY public.sys_user ALTER COLUMN id SET DEFAULT nextval('public.sys_user_id_seq'::regclass);
 :   ALTER TABLE public.sys_user ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    400    397            �           2604    478749    id    DEFAULT     �   ALTER TABLE ONLY public.sys_user_access_right ALTER COLUMN id SET DEFAULT nextval('public.sys_user_access_right_id_seq'::regclass);
 G   ALTER TABLE public.sys_user_access_right ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    399    398            �           2604    478750    id    DEFAULT     �   ALTER TABLE ONLY public.sys_user_mac_address_exception ALTER COLUMN id SET DEFAULT nextval('public.sys_user_mac_address_exception_id_seq'::regclass);
 P   ALTER TABLE public.sys_user_mac_address_exception ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    402    401            �           2604    478751    id    DEFAULT     b   ALTER TABLE ONLY public.ulke ALTER COLUMN id SET DEFAULT nextval('public.ulke_id_seq'::regclass);
 6   ALTER TABLE public.ulke ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    407    406            �           2604    478752    id    DEFAULT     �   ALTER TABLE ONLY public.urun_kabul_red_nedeni ALTER COLUMN id SET DEFAULT nextval('public.urun_kabul_red_nedeni_id_seq'::regclass);
 G   ALTER TABLE public.urun_kabul_red_nedeni ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    409    408            �          0    477486    adres 
   TABLE DATA               �   COPY public.adres (id, ulke_id, sehir_id, ilce, mahalle, cadde, sokak, bina, kapi_no, posta_kutusu, posta_kodu, web_sitesi, eposta_adresi) FROM stdin;
    public       postgres    false    183   ��      �           0    0    adres_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.adres_id_seq', 25, true);
            public       postgres    false    184            �          0    477494    alis_teklif 
   TABLE DATA                 COPY public.alis_teklif (id, validity, teklif_no, teklif_tarihi, cari_kod, firma, vergi_dairesi, vergi_no, aciklama, referans, teslim_tarihi, son_gecerlilik_tarihi, para_birimi, odeme_baslangic_donemi, toplam_tutar, toplam_iskonto_tutar, toplam_kdv_tutar, genel_toplam, musteri_temsilcisi_id, ulke, sehir, adres, posta_kodu, yurtici_ihracat, ortalama_opsiyon, fatura_tipi, tevkifat_kodu, ihrac_kayit_kodu, tevkifat_pay, tevkifat_payda, genel_iskonto_orani, genel_iskonto_tutar, is_e_fatura, siparislesti) FROM stdin;
    public       postgres    false    185   ��      �          0    477508    alis_teklif_detay 
   TABLE DATA               D   COPY public.alis_teklif_detay (id, validity, header_id) FROM stdin;
    public       postgres    false    186   ��      �           0    0    alis_teklif_detay_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.alis_teklif_detay_id_seq', 1, false);
            public       postgres    false    187            �           0    0    alis_teklif_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.alis_teklif_id_seq', 6, true);
            public       postgres    false    188            �          0    477522    ambar 
   TABLE DATA               �   COPY public.ambar (id, validity, ambar_adi, is_varsayilan_hammadde_ambari, is_varsayilan_uretim_ambari, is_varsayilan_satis_ambari) FROM stdin;
    public       postgres    false    189   ��      �           0    0    ambar_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.ambar_id_seq', 2, true);
            public       postgres    false    190            �          0    477531    ayar_barkod_hazirlik_dosya_turu 
   TABLE DATA               L   COPY public.ayar_barkod_hazirlik_dosya_turu (id, validity, tur) FROM stdin;
    public       postgres    false    191   1�      �           0    0 &   ayar_barkod_hazirlik_dosya_turu_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.ayar_barkod_hazirlik_dosya_turu_id_seq', 3, true);
            public       postgres    false    192            �          0    477537    ayar_barkod_serino_turu 
   TABLE DATA               N   COPY public.ayar_barkod_serino_turu (id, validity, tur, aciklama) FROM stdin;
    public       postgres    false    193   ��      �           0    0    ayar_barkod_serino_turu_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.ayar_barkod_serino_turu_id_seq', 3, true);
            public       postgres    false    194            �          0    477543    ayar_barkod_tezgah 
   TABLE DATA               P   COPY public.ayar_barkod_tezgah (id, validity, tezgah_adi, ambar_id) FROM stdin;
    public       postgres    false    195   ��      �           0    0    ayar_barkod_tezgah_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ayar_barkod_tezgah_id_seq', 1, true);
            public       postgres    false    196            �          0    477549    ayar_barkod_urun_turu 
   TABLE DATA               B   COPY public.ayar_barkod_urun_turu (id, validity, tur) FROM stdin;
    public       postgres    false    197   ��      �           0    0    ayar_barkod_urun_turu_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.ayar_barkod_urun_turu_id_seq', 2, true);
            public       postgres    false    198            �          0    477555    ayar_bordro_tipi 
   TABLE DATA               ?   COPY public.ayar_bordro_tipi (id, validity, deger) FROM stdin;
    public       postgres    false    199   �      �           0    0    ayar_bordro_tipi_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.ayar_bordro_tipi_id_seq', 1, false);
            public       postgres    false    200            �          0    477561    ayar_cek_senet_cash_edici_tipi 
   TABLE DATA               M   COPY public.ayar_cek_senet_cash_edici_tipi (id, validity, deger) FROM stdin;
    public       postgres    false    201   6�      �           0    0 %   ayar_cek_senet_cash_edici_tipi_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.ayar_cek_senet_cash_edici_tipi_id_seq', 1, false);
            public       postgres    false    202            �          0    477567     ayar_cek_senet_tahsil_odeme_tipi 
   TABLE DATA               O   COPY public.ayar_cek_senet_tahsil_odeme_tipi (id, validity, deger) FROM stdin;
    public       postgres    false    203   S�      �           0    0 '   ayar_cek_senet_tahsil_odeme_tipi_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.ayar_cek_senet_tahsil_odeme_tipi_id_seq', 1, false);
            public       postgres    false    204            �          0    477573    ayar_cek_senet_tipi 
   TABLE DATA               B   COPY public.ayar_cek_senet_tipi (id, validity, deger) FROM stdin;
    public       postgres    false    205   p�      �           0    0    ayar_cek_senet_tipi_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.ayar_cek_senet_tipi_id_seq', 1, false);
            public       postgres    false    206            �          0    477579    ayar_diger_database_bilgisi 
   TABLE DATA               ;  COPY public.ayar_diger_database_bilgisi (id, validity, db_name, host_name, db_user, db_pass, db_port, firma_adi, is_aybey_teklif_hesapla, is_bulut_teklif_hesapla, is_maliyet_analiz, is_siparis_kopyala, is_otomatik_doviz_kaydet, is_staff_personel_bilgisi, is_uretim_takip, is_pano_uretim, is_nakit_akis) FROM stdin;
    public       postgres    false    207   ��      �           0    0 "   ayar_diger_database_bilgisi_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.ayar_diger_database_bilgisi_id_seq', 1, false);
            public       postgres    false    208            �          0    477594    ayar_edefter_donem_raporu 
   TABLE DATA               �   COPY public.ayar_edefter_donem_raporu (id, validity, rapor_baslangic_donemi, rapor_bitis_donemi, rapor_alma_tarihi, yevmiye_no_baslangic, yevmiye_no_bitis) FROM stdin;
    public       postgres    false    209   ��      �           0    0     ayar_edefter_donem_raporu_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.ayar_edefter_donem_raporu_id_seq', 1, false);
            public       postgres    false    210            �          0    477600    ayar_efatura_alici_bilgisi 
   TABLE DATA               �   COPY public.ayar_efatura_alici_bilgisi (id, validity, alias, title, type_, first_creation_time, alias_creation_time, register_time, identifier) FROM stdin;
    public       postgres    false    211   ��      �           0    0 !   ayar_efatura_alici_bilgisi_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.ayar_efatura_alici_bilgisi_id_seq', 1, false);
            public       postgres    false    212            �          0    477609    ayar_efatura_evrak_cinsi 
   TABLE DATA               M   COPY public.ayar_efatura_evrak_cinsi (id, validity, evrak_cinsi) FROM stdin;
    public       postgres    false    213   ��      �           0    0    ayar_efatura_evrak_cinsi_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.ayar_efatura_evrak_cinsi_id_seq', 1, false);
            public       postgres    false    214            �          0    477615    ayar_efatura_evrak_tipi 
   TABLE DATA               K   COPY public.ayar_efatura_evrak_tipi (id, validity, evrak_tipi) FROM stdin;
    public       postgres    false    215   �      �          0    477619    ayar_efatura_evrak_tipi_cinsi 
   TABLE DATA               d   COPY public.ayar_efatura_evrak_tipi_cinsi (id, validity, evrak_tipi_id, evrak_cinsi_id) FROM stdin;
    public       postgres    false    216   �      �           0    0 $   ayar_efatura_evrak_tipi_cinsi_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.ayar_efatura_evrak_tipi_cinsi_id_seq', 1, false);
            public       postgres    false    217            �           0    0    ayar_efatura_evrak_tipi_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_efatura_evrak_tipi_id_seq', 1, false);
            public       postgres    false    218            �          0    477627    ayar_efatura_fatura_tipi 
   TABLE DATA               E   COPY public.ayar_efatura_fatura_tipi (id, validity, tip) FROM stdin;
    public       postgres    false    219   ;�      �           0    0    ayar_efatura_fatura_tipi_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_efatura_fatura_tipi_id_seq', 7, true);
            public       postgres    false    220            �          0    477633    ayar_efatura_gonderici_bilgisi 
   TABLE DATA               �   COPY public.ayar_efatura_gonderici_bilgisi (id, validity, alias, title, type_, first_creation_time, alias_creation_time, register_time, identifier) FROM stdin;
    public       postgres    false    221   ��      �           0    0 %   ayar_efatura_gonderici_bilgisi_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.ayar_efatura_gonderici_bilgisi_id_seq', 1, false);
            public       postgres    false    222            �          0    477642    ayar_efatura_gonderim_sekli 
   TABLE DATA               f   COPY public.ayar_efatura_gonderim_sekli (id, validity, kod, kod_adi, aciklama, is_active) FROM stdin;
    public       postgres    false    223   ��      �           0    0 "   ayar_efatura_gonderim_sekli_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.ayar_efatura_gonderim_sekli_id_seq', 1, false);
            public       postgres    false    224            �          0    477652 (   ayar_efatura_ihrac_kayitli_fatura_sebebi 
   TABLE DATA               _   COPY public.ayar_efatura_ihrac_kayitli_fatura_sebebi (id, validity, kod, aciklama) FROM stdin;
    public       postgres    false    225   ��      �           0    0 /   ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.ayar_efatura_ihrac_kayitli_fatura_sebebi_id_seq', 1, false);
            public       postgres    false    226            �          0    477658    ayar_efatura_iletisim_kanali 
   TABLE DATA               S   COPY public.ayar_efatura_iletisim_kanali (id, validity, kod, aciklama) FROM stdin;
    public       postgres    false    227   ��      �           0    0 #   ayar_efatura_iletisim_kanali_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.ayar_efatura_iletisim_kanali_id_seq', 92, true);
            public       postgres    false    228            �          0    477667    ayar_efatura_istisna_kodu 
   TABLE DATA               o   COPY public.ayar_efatura_istisna_kodu (id, validity, kod, aciklama, is_tam_istisna, fatura_tip_id) FROM stdin;
    public       postgres    false    229   ��      �           0    0     ayar_efatura_istisna_kodu_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.ayar_efatura_istisna_kodu_id_seq', 65, true);
            public       postgres    false    230            �          0    477677    ayar_efatura_kimlik_semalari 
   TABLE DATA               U   COPY public.ayar_efatura_kimlik_semalari (id, validity, deger, aciklama) FROM stdin;
    public       postgres    false    231   �      �           0    0 #   ayar_efatura_kimlik_semalari_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.ayar_efatura_kimlik_semalari_id_seq', 17, true);
            public       postgres    false    232            �          0    477683    ayar_efatura_odeme_sekli 
   TABLE DATA               s   COPY public.ayar_efatura_odeme_sekli (id, validity, kod, odeme_sekli, aciklama, is_efatura, is_active) FROM stdin;
    public       postgres    false    233   �      �           0    0    ayar_efatura_odeme_sekli_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.ayar_efatura_odeme_sekli_id_seq', 1, false);
            public       postgres    false    234            �          0    477694    ayar_efatura_paket_tipi 
   TABLE DATA               d   COPY public.ayar_efatura_paket_tipi (id, validity, kod, paket_adi, aciklama, is_active) FROM stdin;
    public       postgres    false    235   �      �           0    0    ayar_efatura_paket_tipi_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_efatura_paket_tipi_id_seq', 1, false);
            public       postgres    false    236            �          0    477704    ayar_efatura_response_code 
   TABLE DATA               I   COPY public.ayar_efatura_response_code (id, validity, deger) FROM stdin;
    public       postgres    false    237         �           0    0 !   ayar_efatura_response_code_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.ayar_efatura_response_code_id_seq', 3, true);
            public       postgres    false    238            �          0    477710    ayar_efatura_senaryo_tipi 
   TABLE DATA               P   COPY public.ayar_efatura_senaryo_tipi (id, validity, tip, aciklama) FROM stdin;
    public       postgres    false    239   P      �           0    0     ayar_efatura_senaryo_tipi_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.ayar_efatura_senaryo_tipi_id_seq', 5, true);
            public       postgres    false    240            �          0    477716    ayar_efatura_teslim_sarti 
   TABLE DATA               g   COPY public.ayar_efatura_teslim_sarti (id, validity, kod, aciklama, is_efatura, is_active) FROM stdin;
    public       postgres    false    241   �      �           0    0     ayar_efatura_teslim_sarti_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.ayar_efatura_teslim_sarti_id_seq', 1, false);
            public       postgres    false    242            �          0    477724    ayar_efatura_tevkifat_kodu 
   TABLE DATA               `   COPY public.ayar_efatura_tevkifat_kodu (id, validity, kodu, adi, orani, pay, payda) FROM stdin;
    public       postgres    false    243   
      �           0    0 !   ayar_efatura_tevkifat_kodu_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.ayar_efatura_tevkifat_kodu_id_seq', 1, false);
            public       postgres    false    244            �          0    477730    ayar_efatura_vergi_kodu 
   TABLE DATA               ^   COPY public.ayar_efatura_vergi_kodu (id, validity, kodu, adi, kisaltma, tevkifat) FROM stdin;
    public       postgres    false    245   �      �           0    0    ayar_efatura_vergi_kodu_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_efatura_vergi_kodu_id_seq', 27, true);
            public       postgres    false    246            �          0    477737    ayar_fatura_no_serisi 
   TABLE DATA               T   COPY public.ayar_fatura_no_serisi (id, validity, fatura_seri_id, deger) FROM stdin;
    public       postgres    false    247   q      �           0    0    ayar_fatura_no_serisi_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.ayar_fatura_no_serisi_id_seq', 1, false);
            public       postgres    false    248            �          0    477743    ayar_firma_tipi 
   TABLE DATA               R   COPY public.ayar_firma_tipi (id, validity, firma_turu_id, firma_tipi) FROM stdin;
    public       postgres    false    249   �      �           0    0    ayar_firma_tipi_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ayar_firma_tipi_id_seq', 6, true);
            public       postgres    false    250            �          0    477749    ayar_firma_turu 
   TABLE DATA               <   COPY public.ayar_firma_turu (id, validity, tur) FROM stdin;
    public       postgres    false    251   �      �           0    0    ayar_firma_turu_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ayar_firma_turu_id_seq', 3, true);
            public       postgres    false    252            �          0    477755    ayar_fis_tipi 
   TABLE DATA               <   COPY public.ayar_fis_tipi (id, validity, deger) FROM stdin;
    public       postgres    false    253                     0    0    ayar_fis_tipi_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.ayar_fis_tipi_id_seq', 1, false);
            public       postgres    false    254            �          0    477761    ayar_genel_ayarlar 
   TABLE DATA               t   COPY public.ayar_genel_ayarlar (id, validity, donem, unvan, vergi_no, tc_no, firma_tipi, diger_ayarlar) FROM stdin;
    public       postgres    false    255   5                 0    0    ayar_genel_ayarlar_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ayar_genel_ayarlar_id_seq', 1, true);
            public       postgres    false    256            �          0    477770    ayar_hane_sayisi 
   TABLE DATA               �   COPY public.ayar_hane_sayisi (id, validity, hesap_bakiye, alis_miktar, alis_fiyat, alis_tutar, satis_miktar, satis_fiyat, satis_tutar, stok_miktar, stok_fiyat) FROM stdin;
    public       postgres    false    257   �                 0    0    ayar_hane_sayisi_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.ayar_hane_sayisi_id_seq', 1, true);
            public       postgres    false    258            �          0    477785    ayar_hesap_tipi 
   TABLE DATA               C   COPY public.ayar_hesap_tipi (id, validity, hesap_tipi) FROM stdin;
    public       postgres    false    259   �                 0    0    ayar_hesap_tipi_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ayar_hesap_tipi_id_seq', 3, true);
            public       postgres    false    260            �          0    477791    ayar_irsaliye_fatura_no_serisi 
   TABLE DATA               e   COPY public.ayar_irsaliye_fatura_no_serisi (id, validity, deger, is_fatura, is_irsaliye) FROM stdin;
    public       postgres    false    261                    0    0 %   ayar_irsaliye_fatura_no_serisi_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.ayar_irsaliye_fatura_no_serisi_id_seq', 1, false);
            public       postgres    false    262            �          0    477799    ayar_irsaliye_no_serisi 
   TABLE DATA               X   COPY public.ayar_irsaliye_no_serisi (id, validity, irsaliye_seri_id, deger) FROM stdin;
    public       postgres    false    263                     0    0    ayar_irsaliye_no_serisi_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_irsaliye_no_serisi_id_seq', 1, false);
            public       postgres    false    264            �          0    477805    ayar_modul_tipi 
   TABLE DATA               >   COPY public.ayar_modul_tipi (id, validity, deger) FROM stdin;
    public       postgres    false    265   =                 0    0    ayar_modul_tipi_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ayar_modul_tipi_id_seq', 4, true);
            public       postgres    false    266            �          0    477811    ayar_mukellef_tipi 
   TABLE DATA               M   COPY public.ayar_mukellef_tipi (id, validity, deger, is_default) FROM stdin;
    public       postgres    false    267   �                 0    0    ayar_mukellef_tipi_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ayar_mukellef_tipi_id_seq', 2, true);
            public       postgres    false    268                       0    477818    ayar_musteri_firma_turu 
   TABLE DATA               F   COPY public.ayar_musteri_firma_turu (id, validity, deger) FROM stdin;
    public       postgres    false    269   �                 0    0    ayar_musteri_firma_turu_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_musteri_firma_turu_id_seq', 1, false);
            public       postgres    false    270                      0    477824    ayar_odeme_baslangic_donemi 
   TABLE DATA               _   COPY public.ayar_odeme_baslangic_donemi (id, validity, deger, aciklama, is_active) FROM stdin;
    public       postgres    false    271   �      	           0    0 "   ayar_odeme_baslangic_donemi_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.ayar_odeme_baslangic_donemi_id_seq', 8, true);
            public       postgres    false    272                      0    477831    ayar_odeme_sekli 
   TABLE DATA               k   COPY public.ayar_odeme_sekli (id, validity, kod, odeme_sekli, aciklama, is_efatura, is_active) FROM stdin;
    public       postgres    false    273   P      
           0    0    ayar_odeme_sekli_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.ayar_odeme_sekli_id_seq', 1, false);
            public       postgres    false    274            �          0    793020    ayar_prs_askerlik_durumu 
   TABLE DATA               G   COPY public.ayar_prs_askerlik_durumu (id, askerlik_durumu) FROM stdin;
    public       postgres    false    413   m                 0    0    ayar_prs_askerlik_durumu_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ayar_prs_askerlik_durumu_id_seq', 4, true);
            public       postgres    false    412            �          0    821958    ayar_prs_ayrilma_nedeni 
   TABLE DATA               E   COPY public.ayar_prs_ayrilma_nedeni (id, ayrilma_nedeni) FROM stdin;
    public       postgres    false    448   �                 0    0    ayar_prs_ayrilma_nedeni_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.ayar_prs_ayrilma_nedeni_id_seq', 4, true);
            public       postgres    false    447            �          0    820768    ayar_prs_birim 
   TABLE DATA               =   COPY public.ayar_prs_birim (id, bolum_id, birim) FROM stdin;
    public       postgres    false    446                     0    0    ayar_prs_birim_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ayar_prs_birim_id_seq', 11, true);
            public       postgres    false    445            �          0    820747    ayar_prs_bolum 
   TABLE DATA               3   COPY public.ayar_prs_bolum (id, bolum) FROM stdin;
    public       postgres    false    444   �                 0    0    ayar_prs_bolum_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.ayar_prs_bolum_id_seq', 6, true);
            public       postgres    false    443            �          0    820721    ayar_prs_cinsiyet 
   TABLE DATA               A   COPY public.ayar_prs_cinsiyet (id, cinsiyet, is_man) FROM stdin;
    public       postgres    false    442                    0    0    ayar_prs_cinsiyet_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.ayar_prs_cinsiyet_id_seq', 2, true);
            public       postgres    false    441            �          0    820683    ayar_prs_egitim_durumu 
   TABLE DATA               C   COPY public.ayar_prs_egitim_durumu (id, egitim_durumu) FROM stdin;
    public       postgres    false    436   C                 0    0    ayar_prs_egitim_durumu_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.ayar_prs_egitim_durumu_id_seq', 1, false);
            public       postgres    false    435            �          0    820673    ayar_prs_ehliyet_tipi 
   TABLE DATA               A   COPY public.ayar_prs_ehliyet_tipi (id, ehliyet_tipi) FROM stdin;
    public       postgres    false    434   `                 0    0    ayar_prs_ehliyet_tipi_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.ayar_prs_ehliyet_tipi_id_seq', 17, true);
            public       postgres    false    433            �          0    820658    ayar_prs_gorev 
   TABLE DATA               3   COPY public.ayar_prs_gorev (id, gorev) FROM stdin;
    public       postgres    false    432   �                 0    0    ayar_prs_gorev_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.ayar_prs_gorev_id_seq', 4, true);
            public       postgres    false    431            �          0    812289    ayar_prs_izin_tipi 
   TABLE DATA               ;   COPY public.ayar_prs_izin_tipi (id, izin_tipi) FROM stdin;
    public       postgres    false    429   �                 0    0    ayar_prs_izin_tipi_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ayar_prs_izin_tipi_id_seq', 2, true);
            public       postgres    false    428                       0    0    ayar_prs_kan_grubu_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.ayar_prs_kan_grubu_id_seq', 8, false);
            public       postgres    false    430            �          0    801407    ayar_prs_medeni_durum 
   TABLE DATA               M   COPY public.ayar_prs_medeni_durum (id, medeni_durum, is_married) FROM stdin;
    public       postgres    false    427   /                 0    0    ayar_prs_medeni_durum_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.ayar_prs_medeni_durum_id_seq', 2, true);
            public       postgres    false    426            �          0    801397    ayar_prs_mektup_tipi 
   TABLE DATA               ?   COPY public.ayar_prs_mektup_tipi (id, mektup_tipi) FROM stdin;
    public       postgres    false    425   `                 0    0    ayar_prs_mektup_tipi_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.ayar_prs_mektup_tipi_id_seq', 2, true);
            public       postgres    false    424            �          0    801387    ayar_prs_myk_tipi 
   TABLE DATA               9   COPY public.ayar_prs_myk_tipi (id, myk_tipi) FROM stdin;
    public       postgres    false    423   �                 0    0    ayar_prs_myk_tipi_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.ayar_prs_myk_tipi_id_seq', 1, true);
            public       postgres    false    422            �          0    793030    ayar_prs_personel_tipi 
   TABLE DATA               N   COPY public.ayar_prs_personel_tipi (id, personel_tipi, is_active) FROM stdin;
    public       postgres    false    415   �                 0    0    ayar_prs_personel_tipi_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.ayar_prs_personel_tipi_id_seq', 2, true);
            public       postgres    false    414            �          0    801363    ayar_prs_rapor_tipi 
   TABLE DATA               =   COPY public.ayar_prs_rapor_tipi (id, rapor_tipi) FROM stdin;
    public       postgres    false    419   �                 0    0    ayar_prs_rapor_tipi_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.ayar_prs_rapor_tipi_id_seq', 3, true);
            public       postgres    false    418            �          0    801373    ayar_prs_src_tipi 
   TABLE DATA               9   COPY public.ayar_prs_src_tipi (id, src_tipi) FROM stdin;
    public       postgres    false    421   <                 0    0    ayar_prs_src_tipi_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.ayar_prs_src_tipi_id_seq', 4, true);
            public       postgres    false    420            �          0    794527    ayar_prs_tatil_tipi 
   TABLE DATA               M   COPY public.ayar_prs_tatil_tipi (id, tatil_tipi, is_resmi_tatil) FROM stdin;
    public       postgres    false    417   o                 0    0    ayar_prs_tatil_tipi_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.ayar_prs_tatil_tipi_id_seq', 8, true);
            public       postgres    false    416            �          0    820703    ayar_prs_yabanci_dil 
   TABLE DATA               ?   COPY public.ayar_prs_yabanci_dil (id, yabanci_dil) FROM stdin;
    public       postgres    false    440   �                 0    0    ayar_prs_yabanci_dil_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.ayar_prs_yabanci_dil_id_seq', 1, false);
            public       postgres    false    439            �          0    820693    ayar_prs_yabanci_dil_seviyesi 
   TABLE DATA               Q   COPY public.ayar_prs_yabanci_dil_seviyesi (id, yabanci_dil_seviyesi) FROM stdin;
    public       postgres    false    438                    0    0 $   ayar_prs_yabanci_dil_seviyesi_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.ayar_prs_yabanci_dil_seviyesi_id_seq', 1, false);
            public       postgres    false    437                      0    477958    ayar_sabit_degisken 
   TABLE DATA               8   COPY public.ayar_sabit_degisken (id, deger) FROM stdin;
    public       postgres    false    275   /                 0    0    ayar_sabit_degisken_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.ayar_sabit_degisken_id_seq', 2, true);
            public       postgres    false    276                      0    477964    ayar_sevkiyat_hazirlama_durumu 
   TABLE DATA               M   COPY public.ayar_sevkiyat_hazirlama_durumu (id, validity, deger) FROM stdin;
    public       postgres    false    277   d                 0    0 %   ayar_sevkiyat_hazirlama_durumu_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.ayar_sevkiyat_hazirlama_durumu_id_seq', 1, false);
            public       postgres    false    278            
          0    477970    ayar_stok_hareket_ayari 
   TABLE DATA               Y   COPY public.ayar_stok_hareket_ayari (id, validity, giris_ayari, cikis_ayari) FROM stdin;
    public       postgres    false    279   �                  0    0    ayar_stok_hareket_ayari_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.ayar_stok_hareket_ayari_id_seq', 1, true);
            public       postgres    false    280                      0    477976    ayar_stok_hareket_tipi 
   TABLE DATA               O   COPY public.ayar_stok_hareket_tipi (id, validity, deger, is_input) FROM stdin;
    public       postgres    false    281   �      !           0    0    ayar_stok_hareket_tipi_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.ayar_stok_hareket_tipi_id_seq', 10, true);
            public       postgres    false    282                      0    477983    ayar_teklif_durum 
   TABLE DATA               U   COPY public.ayar_teklif_durum (id, validity, deger, aciklama, is_active) FROM stdin;
    public       postgres    false    283   �      "           0    0    ayar_teklif_durum_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.ayar_teklif_durum_id_seq', 11, true);
            public       postgres    false    284                      0    477990    ayar_teklif_tipi 
   TABLE DATA               T   COPY public.ayar_teklif_tipi (id, validity, deger, aciklama, is_active) FROM stdin;
    public       postgres    false    285   D      #           0    0    ayar_teklif_tipi_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.ayar_teklif_tipi_id_seq', 2, true);
            public       postgres    false    286                      0    477997    ayar_vergi_orani 
   TABLE DATA               �   COPY public.ayar_vergi_orani (id, validity, vergi_orani, satis_vergi_hesap_kodu, satis_iade_vergi_hesap_kodu, alis_vergi_hesap_kodu, alis_iade_vergi_hesap_kodu) FROM stdin;
    public       postgres    false    287   �      $           0    0    ayar_vergi_orani_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.ayar_vergi_orani_id_seq', 9, true);
            public       postgres    false    288                      0    478003    banka 
   TABLE DATA               I   COPY public.banka (id, validity, adi, swift_kodu, is_active) FROM stdin;
    public       postgres    false    289   �      %           0    0    banka_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.banka_id_seq', 1, true);
            public       postgres    false    290                      0    478010    banka_subesi 
   TABLE DATA               _   COPY public.banka_subesi (id, validity, banka_id, sube_kodu, sube_adi, sube_il_id) FROM stdin;
    public       postgres    false    291   �      &           0    0    banka_subesi_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.banka_subesi_id_seq', 3, true);
            public       postgres    false    292                      0    478016    barkod_hazirlik_dosya_turu 
   TABLE DATA               G   COPY public.barkod_hazirlik_dosya_turu (id, validity, tur) FROM stdin;
    public       postgres    false    293   3      '           0    0 !   barkod_hazirlik_dosya_turu_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.barkod_hazirlik_dosya_turu_id_seq', 1, false);
            public       postgres    false    294                      0    478022    barkod_serino_turu 
   TABLE DATA               I   COPY public.barkod_serino_turu (id, validity, tur, aciklama) FROM stdin;
    public       postgres    false    295   P      (           0    0    barkod_serino_turu_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.barkod_serino_turu_id_seq', 1, false);
            public       postgres    false    296                      0    478028    barkod_tezgah 
   TABLE DATA               K   COPY public.barkod_tezgah (id, validity, tezgah_adi, ambar_id) FROM stdin;
    public       postgres    false    297   m      )           0    0    barkod_tezgah_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.barkod_tezgah_id_seq', 1, false);
            public       postgres    false    298                      0    478034    bolge 
   TABLE DATA               S  COPY public.bolge (id, validity, bolge_adi, bolge_turu_id, hedef_ocak, hedef_subat, hedef_mart, hedef_nisan, hedef_mayis, hedef_haziran, hedef_temmuz, hedef_agustos, hedef_eylul, hedef_ekim, hedef_kasim, hedef_aralik, hedef_mamul_ocak, hedef_mamul_subat, hedef_mamul_mart, hedef_mamul_nisan, hedef_mamul_mayis, hedef_mamul_haziran, hedef_mamul_temmuz, hedef_mamul_agustos, hedef_mamul_eylul, hedef_mamul_ekim, hedef_mamul_kasim, hedef_mamul_aralik, gecen_ocak, gecen_subat, gecen_mart, gecen_nisan, gecen_mayis, gecen_haziran, gecen_temmuz, gecen_agustos, gecen_eylul, gecen_ekim, gecen_kasim, gecen_aralik, gecen_mamul_ocak, gecen_mamul_subat, gecen_mamul_mart, gecen_mamul_nisan, gecen_mamul_mayis, gecen_mamul_haziran, gecen_mamul_temmuz, gecen_mamul_agustos, gecen_mamul_eylul, gecen_mamul_ekim, gecen_mamul_kasim, gecen_mamul_aralik) FROM stdin;
    public       postgres    false    299   �      *           0    0    bolge_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.bolge_id_seq', 2, true);
            public       postgres    false    300                       0    478088 
   bolge_turu 
   TABLE DATA               7   COPY public.bolge_turu (id, validity, tur) FROM stdin;
    public       postgres    false    301   �      +           0    0    bolge_turu_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.bolge_turu_id_seq', 2, true);
            public       postgres    false    302            "          0    478094    cins_ailesi 
   TABLE DATA               9   COPY public.cins_ailesi (id, validity, aile) FROM stdin;
    public       postgres    false    303   �      ,           0    0    cins_ailesi_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cins_ailesi_id_seq', 15, true);
            public       postgres    false    304            $          0    478100    cins_ozelligi 
   TABLE DATA               �   COPY public.cins_ozelligi (id, validity, cins_aile_id, cins, aciklama, string1, string2, string3, string4, string5, string6, string7, string8, string9, string10, string11, string12, is_serino_icerir) FROM stdin;
    public       postgres    false    305   %       -           0    0    cins_ozelligi_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cins_ozelligi_id_seq', 69, true);
            public       postgres    false    306            &          0    478107    cnf_employee_section 
   TABLE DATA               E   COPY public.cnf_employee_section (id, validity, section) FROM stdin;
    public       postgres    false    307   �       .           0    0    cnf_employee_section_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.cnf_employee_section_id_seq', 1, false);
            public       postgres    false    308            (          0    478113 
   doviz_kuru 
   TABLE DATA               K   COPY public.doviz_kuru (id, validity, tarih, para_birimi, kur) FROM stdin;
    public       postgres    false    309   �       /           0    0    doviz_kuru_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.doviz_kuru_id_seq', 38, true);
            public       postgres    false    310            *          0    478119    hesap_grubu 
   TABLE DATA               9   COPY public.hesap_grubu (id, validity, grup) FROM stdin;
    public       postgres    false    311   �       0           0    0    hesap_grubu_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.hesap_grubu_id_seq', 3, true);
            public       postgres    false    312            �          0    699376    hesap_karti 
   TABLE DATA               5  COPY public.hesap_karti (id, validity, hesap_kodu, hesap_ismi, muhasebe_kodu, hesap_tipi_id, hesap_grubu_id, bolge_id, temsilci_grubu_id, mukellef_tipi_id, musteri_temsilcisi_id, adres_id, mukellef_adi, mukellef_ikinci_adi, mukellef_soyadi, vergi_dairesi, vergi_no, para_birimi, iban, iban_para, nace_kodu, is_efatura_hesabi, efatura_pk_name, yetkili1, yetkili1_tel, yetkili2, yetkili2_tel, yetkili3, yetkili3_tel, faks, muhasebe_telefon, muhasebe_eposta, muhasebe_yetkili, ozel_bilgi, odeme_vade_gun_sayisi, is_acik_hesap, kredi_limiti, hesap_iskonto) FROM stdin;
    public       postgres    false    411   !      1           0    0    hesap_karti_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.hesap_karti_id_seq', 1, false);
            public       postgres    false    410            ,          0    478136    hesap_plani 
   TABLE DATA               m   COPY public.hesap_plani (id, validity, plan_kodu_varsayilan, aciklama, plan_kodu, seviye_sayisi) FROM stdin;
    public       postgres    false    313   0!      2           0    0    hesap_plani_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.hesap_plani_id_seq', 401, true);
            public       postgres    false    314            .          0    478142    medeni_durum 
   TABLE DATA               ;   COPY public.medeni_durum (id, validity, durum) FROM stdin;
    public       postgres    false    315   �.      3           0    0    medeni_durum_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.medeni_durum_id_seq', 1, false);
            public       postgres    false    316            0          0    478148    muhasebe_hesap_plani 
   TABLE DATA               {   COPY public.muhasebe_hesap_plani (id, validity, tek_duzen_kodu, plan_kodu, aciklama, seviye_sayisi, is_active) FROM stdin;
    public       postgres    false    317   �.      4           0    0    muhasebe_hesap_plani_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.muhasebe_hesap_plani_id_seq', 3, true);
            public       postgres    false    318            2          0    478155    musteri_temsilci_grubu 
   TABLE DATA               �  COPY public.musteri_temsilci_grubu (id, validity, temsilci_grup_adi, gecmis_ocak, gecmis_subat, gecmis_mart, gecmis_nisan, gecmis_mayis, gecmis_haziran, gecmis_temmuz, gecmis_agustos, gecmis_eylul, gecmis_ekim, gecmis_kasim, gecmis_aralik, hedef_ocak, hedef_subat, hedef_mart, hedef_nisan, hedef_mayis, hedef_haziran, hedef_temmuz, hedef_agustos, hedef_eylul, hedef_ekim, hedef_kasim, hedef_aralik) FROM stdin;
    public       postgres    false    319   '/      5           0    0    musteri_temsilci_grubu_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.musteri_temsilci_grubu_id_seq', 4, true);
            public       postgres    false    320            4          0    478185    olcu_birimi 
   TABLE DATA               g   COPY public.olcu_birimi (id, validity, birim, efatura_birim, birim_aciklama, is_float_tip) FROM stdin;
    public       postgres    false    321   n/      6           0    0    olcu_birimi_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.olcu_birimi_id_seq', 3, true);
            public       postgres    false    322            6          0    478192    para_birimi 
   TABLE DATA               O   COPY public.para_birimi (id, kod, sembol, aciklama, is_varsayilan) FROM stdin;
    public       postgres    false    323   �/      7           0    0    para_birimi_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.para_birimi_id_seq', 3, true);
            public       postgres    false    324            8          0    478198    personel_ayrilma_nedeni_tipi 
   TABLE DATA               I   COPY public.personel_ayrilma_nedeni_tipi (id, validity, tip) FROM stdin;
    public       postgres    false    325   &0      8           0    0 #   personel_ayrilma_nedeni_tipi_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.personel_ayrilma_nedeni_tipi_id_seq', 4, true);
            public       postgres    false    326            :          0    478204    personel_calisma_gecmisi 
   TABLE DATA               �   COPY public.personel_calisma_gecmisi (id, validity, personel_id, personel_birim, personel_gorev, ise_giris_tarihi, isten_cikis_tarihi, ayrilma_nedeni_tipi, ayrilma_nedeni_aciklama) FROM stdin;
    public       postgres    false    327   �0      9           0    0    personel_calisma_gecmisi_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.personel_calisma_gecmisi_id_seq', 1, false);
            public       postgres    false    328            <          0    478210    personel_dil_bilgisi 
   TABLE DATA               �   COPY public.personel_dil_bilgisi (id, validity, dil_id, okuma_seviyesi_id, yazma_seviyesi_id, konusma_seviyesi_id, personel_id) FROM stdin;
    public       postgres    false    329   �0      :           0    0    personel_dil_bilgisi_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.personel_dil_bilgisi_id_seq', 1, false);
            public       postgres    false    330            >          0    478216    personel_karti 
   TABLE DATA               �  COPY public.personel_karti (id, validity, is_active, personel_ad, personel_soyad, telefon1, telefon2, personel_tipi_id, bolum_id, birim_id, gorev_id, mail_adresi, dogum_tarihi, kan_grubu, cinsiyet_id, askerlik_durum_id, medeni_durum_id, cocuk_sayisi, yakin_ad_soyad, yakin_telefon, ayakkabi_no, elbise_bedeni, genel_not, servis_id, personel_gecmisi_id, ozel_not, brut_maas, ikramiye_sayisi, ikramiye_miktar, tc_kimlik_no, adres_id) FROM stdin;
    public       postgres    false    331   �0      ;           0    0    personel_karti_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.personel_karti_id_seq', 25, true);
            public       postgres    false    332            @          0    478228    personel_pdks_kart 
   TABLE DATA               Z   COPY public.personel_pdks_kart (id, kart_id, personel_no, kart_no, is_active) FROM stdin;
    public       postgres    false    333   �0      <           0    0    personel_pdks_kart_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.personel_pdks_kart_id_seq', 1, false);
            public       postgres    false    334            B          0    478233    personel_tasima_servis 
   TABLE DATA               [   COPY public.personel_tasima_servis (id, validity, servis_no, servis_adi, rota) FROM stdin;
    public       postgres    false    335   1      =           0    0    personel_tasima_servis_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.personel_tasima_servis_id_seq', 3, true);
            public       postgres    false    336            D          0    478242    quality_form_mail_reciever 
   TABLE DATA               O   COPY public.quality_form_mail_reciever (id, validity, mail_adresi) FROM stdin;
    public       postgres    false    337   c1      >           0    0 !   quality_form_mail_reciever_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.quality_form_mail_reciever_id_seq', 1, true);
            public       postgres    false    338            F          0    478248    recete 
   TABLE DATA               w   COPY public.recete (id, validity, mamul_stok_kodu, ornek_uretim_miktari, fire_orani, aciklama, recete_adi) FROM stdin;
    public       postgres    false    339   �1      G          0    478252    recete_hammadde 
   TABLE DATA               l   COPY public.recete_hammadde (id, validity, header_id, stok_kodu, miktar, fire_orani, recete_id) FROM stdin;
    public       postgres    false    340   �1      ?           0    0    recete_hammadde_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.recete_hammadde_id_seq', 1, false);
            public       postgres    false    341            @           0    0    recete_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.recete_id_seq', 1, false);
            public       postgres    false    342            J          0    478260    satis_fatura 
   TABLE DATA               r   COPY public.satis_fatura (id, validity, fatura_no, fatura_tarihi, teklif_id, siparis_id, irsaliye_id) FROM stdin;
    public       postgres    false    343   �1      K          0    478264    satis_fatura_detay 
   TABLE DATA               {   COPY public.satis_fatura_detay (id, validity, header_id, teklif_detay_id, siparis_detay_id, irsaliye_detay_id) FROM stdin;
    public       postgres    false    344   �1      A           0    0    satis_fatura_detay_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.satis_fatura_detay_id_seq', 1, false);
            public       postgres    false    345            B           0    0    satis_fatura_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.satis_fatura_id_seq', 1, false);
            public       postgres    false    346            N          0    478272    satis_irsaliye 
   TABLE DATA               v   COPY public.satis_irsaliye (id, validity, irsaliye_no, irsaliye_tarihi, teklif_id, siparis_id, fatura_id) FROM stdin;
    public       postgres    false    347   2      O          0    478276    satis_irsaliye_detay 
   TABLE DATA               {   COPY public.satis_irsaliye_detay (id, validity, header_id, teklif_detay_id, siparis_detay_id, fatura_detay_id) FROM stdin;
    public       postgres    false    348   22      C           0    0    satis_irsaliye_detay_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.satis_irsaliye_detay_id_seq', 1, false);
            public       postgres    false    349            D           0    0    satis_irsaliye_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.satis_irsaliye_id_seq', 1, false);
            public       postgres    false    350            R          0    478284    satis_siparis 
   TABLE DATA               t   COPY public.satis_siparis (id, validity, siparis_no, siparis_tarihi, teklif_id, irsaliye_id, fatura_id) FROM stdin;
    public       postgres    false    351   O2      S          0    478288    satis_siparis_detay 
   TABLE DATA               {   COPY public.satis_siparis_detay (id, validity, header_id, teklif_detay_id, irsaliye_detay_id, fatura_detay_id) FROM stdin;
    public       postgres    false    352   l2      E           0    0    satis_siparis_detay_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.satis_siparis_detay_id_seq', 1, false);
            public       postgres    false    353            F           0    0    satis_siparis_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.satis_siparis_id_seq', 1, false);
            public       postgres    false    354            V          0    478296    satis_teklif 
   TABLE DATA               j  COPY public.satis_teklif (id, validity, siparis_id, irsaliye_id, fatura_id, is_siparislesti, is_taslak, is_efatura, tutar, iskonto_tutar, ara_toplam, genel_iskonto_tutar, kdv_tutar, genel_toplam, islem_tipi_id, teklif_no, teklif_tarihi, teslim_tarihi, gecerlilik_tarihi, musteri_kodu, musteri_adi, adres_musteri, sehir_musteri, posta_kodu, vergi_dairesi, vergi_no, musteri_temsilcisi_id, teklif_tipi_id, adres_sevkiyat, sehir_sevkiyat, muhattap_ad, muhattap_soyad, odeme_vadesi, referans, teslimat_suresi, teklif_durum_id, sevk_tarihi, vade_gun_sayisi, fatura_sevk_tarihi, para_birimi, dolar_kur, euro_kur, odeme_baslangic_donemi_id, teslim_sarti_id, gonderim_sekli_id, gonderim_sekli_detay, odeme_sekli_id, aciklama, proforma_no, arayan_kisi_id, arama_tarihi, sonraki_aksiyon_tarihi, aksiyon_notu, tevkifat_kodu, tevkifat_pay, tevkifat_payda, ihrac_kayit_kodu) FROM stdin;
    public       postgres    false    355   �2      W          0    478313    satis_teklif_detay 
   TABLE DATA               �  COPY public.satis_teklif_detay (id, validity, header_id, siparis_detay_id, irsaliye_detay_id, fatura_detay_id, stok_kodu, stok_aciklama, aciklama, referans, miktar, olcu_birimi, iskonto_orani, fiyat, net_fiyat, tutar, iskonto_tutar, net_tutar, kdv_orani, kdv_tutar, toplam_tutar, vade_gun, is_ana_urun, ana_urun_id, referans_ana_urun_id, transfer_hesap_kodu, kdv_transfer_hesap_kodu, vergi_kodu, vergi_muafiyet_kodu, diger_vergi_kodu, gtip_no) FROM stdin;
    public       postgres    false    356   �2      G           0    0    satis_teklif_detay_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.satis_teklif_detay_id_seq', 4, true);
            public       postgres    false    357            H           0    0    satis_teklif_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.satis_teklif_id_seq', 6, true);
            public       postgres    false    358            Z          0    478335    sehir 
   TABLE DATA               M   COPY public.sehir (id, validity, sehir_adi, plaka_kodu, ulke_id) FROM stdin;
    public       postgres    false    359   �3      I           0    0    sehir_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.sehir_id_seq', 18, true);
            public       postgres    false    360            \          0    478341 
   stok_grubu 
   TABLE DATA                 COPY public.stok_grubu (id, validity, grup, alis_hesabi, satis_hesabi, hammadde_hesabi, mamul_hesabi, kdv_orani_id, tur_id, is_iskonto_aktif, iskonto_satis, iskonto_mudur, is_satis_fiyatini_kullan, yari_mamul_hesabi, is_maliyet_analiz_farkli_db) FROM stdin;
    public       postgres    false    361   _4      J           0    0    stok_grubu_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.stok_grubu_id_seq', 890, true);
            public       postgres    false    362            ^          0    478352    stok_grubu_turu 
   TABLE DATA               <   COPY public.stok_grubu_turu (id, validity, tur) FROM stdin;
    public       postgres    false    363   �9      K           0    0    stok_grubu_turu_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.stok_grubu_turu_id_seq', 29, true);
            public       postgres    false    364            `          0    478358    stok_hareketi 
   TABLE DATA               �   COPY public.stok_hareketi (id, validity, stok_kodu, miktar, tutar, giris_cikis_tip_id, alan_ambar, veren_ambar, tarih, is_donem_basi_hareket) FROM stdin;
    public       postgres    false    365   H:      L           0    0    stok_hareketi_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.stok_hareketi_id_seq', 5001, true);
            public       postgres    false    366            b          0    478365 
   stok_karti 
   TABLE DATA               (  COPY public.stok_karti (id, validity, stok_kodu, stok_adi, stok_grubu_id, olcu_birimi_id, alis_iskonto, satis_iskonto, yetkili_iskonto, stok_tipi_id, ham_alis_fiyat, ham_alis_para_birim, alis_fiyat, alis_para_birim, satis_fiyat, satis_para_birim, ihrac_fiyat, ihrac_para_birim, ortalama_maliyet, varsayilan_recete_id, en, boy, yukseklik, mensei_id, gtip_no, diib_urun_tanimi, en_az_stok_seviyesi, tanim, ozel_kod, marka, agirlik, kapasite, cins_id, string_degisken1, string_degisken2, string_degisken3, string_degisken4, string_degisken5, string_degisken6, integer_degisken1, integer_degisken2, integer_degisken3, double_degisken1, double_degisken2, double_degisken3, is_satilabilir, is_ana_urun, is_yari_mamul, is_otomatik_uretim_urunu, is_ozet_urun, lot_parti_miktari, paket_miktari, seri_no_turu, is_harici_seri_no_icerir, harici_serino_stok_kodu_id, tasiyici_paket_id, onceki_donem_cikan_miktar, temin_suresi, stock_name, en_string_degisken1, en_string_degisken2, en_string_degisken3, en_string_degisken4, en_string_degisken5, en_string_degisken6) FROM stdin;
    public       postgres    false    367   q�      M           0    0    stok_karti_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.stok_karti_id_seq', 43324, true);
            public       postgres    false    368            d          0    478388 	   stok_tipi 
   TABLE DATA               X   COPY public.stok_tipi (id, validity, tip, is_default, is_stok_hareketi_yap) FROM stdin;
    public       postgres    false    369   �      N           0    0    stok_tipi_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.stok_tipi_id_seq', 12, true);
            public       postgres    false    370            f          0    478396    sys_application_settings 
   TABLE DATA               �  COPY public.sys_application_settings (id, validity, logo, unvan, tel1, tel2, tel3, tel4, tel5, fax1, fax2, mersis_no, web_sitesi, eposta_adresi, vergi_dairesi, vergi_no, form_rengi, donem, mukellef_tipi, tam_adres, ticaret_sicil_no, ilce, mahalle, cadde, sokak, posta_kodu, bina, kapi_no, ulke_id, sehir_id, sistem_dili, mail_sunucu_adres, mail_sunucu_kullanici, mail_sunucu_sifre, mail_sunucu_port, grid_color_1, grid_color_2, grid_color_active, edefter_gonderilen_son, crypt_key) FROM stdin;
    public       postgres    false    371   R�      O           0    0    sys_application_settings_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.sys_application_settings_id_seq', 1, true);
            public       postgres    false    372            h          0    478409    sys_application_settings_other 
   TABLE DATA               q  COPY public.sys_application_settings_other (id, validity, is_edefter_aktif, mail_sender_address, mail_sender_username, mail_sender_password, mail_sender_port, varsayilan_satis_cari_kod, varsayilan_alis_cari_kod, is_bolum_ambarda_uretim_yap, is_uretim_muhasebe_kaydi_olustursun, is_stok_satimda_negatife_dusebilir, is_mal_satis_sayilarini_goster, is_pcb_uretim, is_proforma_no_goster, is_satis_takip, is_hammadde_girise_gore_sirala, is_uretim_entegrasyon_hammadde_kullanim_hesabi_iscilikle, is_tahsilat_listesi_virmanli, is_ortalama_vade_0_ise_sevkiyata_izin_verme, is_sipariste_teslim_tarihi_yazdir, is_teklif_ayrintilarini_goster, is_fatura_irsaliye_no_0_ile_baslasin, is_excel_ekli_irsaliye_yazdirma, is_ambarlararasi_transfer_numara_otomatik_gelsin, is_ambarlararasi_transfer_onayli_calissin, is_alis_teklif_alis_sipariste_ham_alis_fiyatini_kullan, is_tahsilat_listesine_120_bulut_hesabini_dahil_etme, is_satis_listesi_varsayilan_filtre_mamul_hammadde, is_recete_maliyet_analizi_baska_db_kullanarak_yap, is_efatura_aktif, is_stok_transfer_fiyati_kullanici_degistirebilir, is_hesaplar_rapolarda_cikmasin, is_siparisi_baska_programa_otomatik_kayit_yap, is_active_uretim_takip, is_pano_programina_otomatik_kayit, is_nakit_akista_farkli_db_kullan, is_ihrac_fiyati_yerine_satis_fiyatini_kullan, is_statik_iskonto_orani_kullan, is_eirsaliye_aktif, is_stok_recete_adi_birlikte_guncellensin, is_kur_bilgisini_1_olarak_kullan, is_genel_kdv_orani_kullan, xslt_sablon_adi, genel_iskonto_gecerlilik_tarihi, en_fazla_fatura_satir_sayisi, en_fazla_e_fatura_satir_sayisi, en_fazla_irsaliye_satir_sayisi, en_fazla_e_irsaliye_satir_sayisi, siparis_kopyalanacak_kaynak_cari_kod, siparis_kopyalanacak_hedef_cari_kod, maliyet_analizi_iskonto_orani, genel_kdv_orani, path_teklif_hesaplama_conf, path_proforma_file, path_mal_stok_seviyesi_eord_rapor, path_update, path_stok_karti_resim, path_proforma_pdf_kayit) FROM stdin;
    public       postgres    false    373   ��      P           0    0 %   sys_application_settings_other_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.sys_application_settings_other_id_seq', 1, false);
            public       postgres    false    374            j          0    478458    sys_grid_col_color 
   TABLE DATA                  COPY public.sys_grid_col_color (id, validity, table_name, column_name, min_value, min_color, max_value, max_color) FROM stdin;
    public       postgres    false    375   ݲ      Q           0    0    sys_grid_col_color_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.sys_grid_col_color_id_seq', 4, true);
            public       postgres    false    376            l          0    478471    sys_grid_col_percent 
   TABLE DATA               �   COPY public.sys_grid_col_percent (id, validity, table_name, column_name, max_value, color_bar, color_bar_back, color_bar_text, color_bar_text_active) FROM stdin;
    public       postgres    false    377   ��      R           0    0    sys_grid_col_percent_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.sys_grid_col_percent_id_seq', 1, true);
            public       postgres    false    378            n          0    478485    sys_grid_col_width 
   TABLE DATA               n   COPY public.sys_grid_col_width (id, validity, table_name, column_name, column_width, sequence_no) FROM stdin;
    public       postgres    false    379   �      S           0    0    sys_grid_col_width_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.sys_grid_col_width_id_seq', 287, true);
            public       postgres    false    380            p          0    478496    sys_grid_default_order_filter 
   TABLE DATA               [   COPY public.sys_grid_default_order_filter (id, validity, key, value, is_order) FROM stdin;
    public       postgres    false    381   U�      T           0    0 $   sys_grid_default_order_filter_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sys_grid_default_order_filter_id_seq', 12, true);
            public       postgres    false    382            r          0    478506    sys_lang 
   TABLE DATA               :   COPY public.sys_lang (id, validity, language) FROM stdin;
    public       postgres    false    383   �      s          0    478510    sys_lang_data_content 
   TABLE DATA               k   COPY public.sys_lang_data_content (id, validity, lang, table_name, column_name, row_id, value) FROM stdin;
    public       postgres    false    384   e�      U           0    0    sys_lang_data_content_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sys_lang_data_content_id_seq', 42, true);
            public       postgres    false    385            u          0    478519    sys_lang_gui_content 
   TABLE DATA               }   COPY public.sys_lang_gui_content (id, validity, lang, code, value, is_factory_setting, content_type, table_name) FROM stdin;
    public       postgres    false    386   ��      V           0    0    sys_lang_gui_content_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sys_lang_gui_content_id_seq', 668, true);
            public       postgres    false    387            W           0    0    sys_lang_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sys_lang_id_seq', 4, true);
            public       postgres    false    388            x          0    478531    sys_multi_lang_data_table_list 
   TABLE DATA               R   COPY public.sys_multi_lang_data_table_list (id, validity, table_name) FROM stdin;
    public       postgres    false    389   ��      X           0    0 %   sys_multi_lang_data_table_list_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.sys_multi_lang_data_table_list_id_seq', 17, true);
            public       postgres    false    390            z          0    478541    sys_permission_source 
   TABLE DATA               h   COPY public.sys_permission_source (id, validity, source_code, source_name, source_group_id) FROM stdin;
    public       postgres    false    391   ��      {          0    478545    sys_permission_source_group 
   TABLE DATA               Q   COPY public.sys_permission_source_group (id, validity, source_group) FROM stdin;
    public       postgres    false    392   v�      Y           0    0 "   sys_permission_source_group_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.sys_permission_source_group_id_seq', 6, true);
            public       postgres    false    393            Z           0    0    sys_permission_source_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sys_permission_source_id_seq', 24, true);
            public       postgres    false    394            ~          0    478553    sys_quality_form_number 
   TABLE DATA               c   COPY public.sys_quality_form_number (id, validity, table_name, form_no, is_input_form) FROM stdin;
    public       postgres    false    395   ��      [           0    0    sys_quality_form_number_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.sys_quality_form_number_id_seq', 4, true);
            public       postgres    false    396            �          0    478562    sys_user 
   TABLE DATA                 COPY public.sys_user (id, validity, user_name, user_password, is_active_user, is_online, is_admin, is_super_user, ip_address, mac_address, email_address, app_version, personel_bilgisi_id, invoice_no_serie, dispatch_no_serie, default_qrcode_size) FROM stdin;
    public       postgres    false    397   $�      �          0    478575    sys_user_access_right 
   TABLE DATA               �   COPY public.sys_user_access_right (id, validity, source_code, is_read, is_add_record, is_update, is_delete, is_special, user_name) FROM stdin;
    public       postgres    false    398   ��      \           0    0    sys_user_access_right_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sys_user_access_right_id_seq', 7, true);
            public       postgres    false    399            ]           0    0    sys_user_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sys_user_id_seq', 1, true);
            public       postgres    false    400            �          0    478588    sys_user_mac_address_exception 
   TABLE DATA               ]   COPY public.sys_user_mac_address_exception (id, validity, user_name, ip_address) FROM stdin;
    public       postgres    false    401   ��      ^           0    0 %   sys_user_mac_address_exception_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sys_user_mac_address_exception_id_seq', 1, true);
            public       postgres    false    402            �          0    478607    ulke 
   TABLE DATA               t   COPY public.ulke (id, validity, ulke_kodu, ulke_adi, iso_year, iso_cctld_code, is_avrupa_birligi_uyesi) FROM stdin;
    public       postgres    false    406   �      _           0    0    ulke_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.ulke_id_seq', 3, true);
            public       postgres    false    407            �          0    478614    urun_kabul_red_nedeni 
   TABLE DATA               D   COPY public.urun_kabul_red_nedeni (id, validity, deger) FROM stdin;
    public       postgres    false    408   u�      `           0    0    urun_kabul_red_nedeni_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.urun_kabul_red_nedeni_id_seq', 7, true);
            public       postgres    false    409                       2606    478755 
   adres_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_pkey;
       public         postgres    false    183    183                       2606    478757    alis_teklif_detay_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.alis_teklif_detay
    ADD CONSTRAINT alis_teklif_detay_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.alis_teklif_detay DROP CONSTRAINT alis_teklif_detay_pkey;
       public         postgres    false    186    186                       2606    478759    alis_teklif_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.alis_teklif
    ADD CONSTRAINT alis_teklif_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.alis_teklif DROP CONSTRAINT alis_teklif_pkey;
       public         postgres    false    185    185                       2606    478771    ambar_ambar_adi_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.ambar
    ADD CONSTRAINT ambar_ambar_adi_key UNIQUE (ambar_adi);
 C   ALTER TABLE ONLY public.ambar DROP CONSTRAINT ambar_ambar_adi_key;
       public         postgres    false    189    189                       2606    478773 
   ambar_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.ambar
    ADD CONSTRAINT ambar_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.ambar DROP CONSTRAINT ambar_pkey;
       public         postgres    false    189    189                       2606    478775 $   ayar_barkod_hazirlik_dosya_turu_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_barkod_hazirlik_dosya_turu
    ADD CONSTRAINT ayar_barkod_hazirlik_dosya_turu_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.ayar_barkod_hazirlik_dosya_turu DROP CONSTRAINT ayar_barkod_hazirlik_dosya_turu_pkey;
       public         postgres    false    191    191                       2606    478777 '   ayar_barkod_hazirlik_dosya_turu_tur_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_barkod_hazirlik_dosya_turu
    ADD CONSTRAINT ayar_barkod_hazirlik_dosya_turu_tur_key UNIQUE (tur);
 q   ALTER TABLE ONLY public.ayar_barkod_hazirlik_dosya_turu DROP CONSTRAINT ayar_barkod_hazirlik_dosya_turu_tur_key;
       public         postgres    false    191    191            !           2606    478779    ayar_barkod_serino_turu_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_barkod_serino_turu
    ADD CONSTRAINT ayar_barkod_serino_turu_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_barkod_serino_turu DROP CONSTRAINT ayar_barkod_serino_turu_pkey;
       public         postgres    false    193    193            #           2606    478781    ayar_barkod_serino_turu_tur_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.ayar_barkod_serino_turu
    ADD CONSTRAINT ayar_barkod_serino_turu_tur_key UNIQUE (tur);
 a   ALTER TABLE ONLY public.ayar_barkod_serino_turu DROP CONSTRAINT ayar_barkod_serino_turu_tur_key;
       public         postgres    false    193    193            %           2606    478783    ayar_barkod_tezgah_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.ayar_barkod_tezgah
    ADD CONSTRAINT ayar_barkod_tezgah_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.ayar_barkod_tezgah DROP CONSTRAINT ayar_barkod_tezgah_pkey;
       public         postgres    false    195    195            '           2606    478785 *   ayar_barkod_tezgah_tezgah_adi_ambar_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_barkod_tezgah
    ADD CONSTRAINT ayar_barkod_tezgah_tezgah_adi_ambar_id_key UNIQUE (tezgah_adi, ambar_id);
 g   ALTER TABLE ONLY public.ayar_barkod_tezgah DROP CONSTRAINT ayar_barkod_tezgah_tezgah_adi_ambar_id_key;
       public         postgres    false    195    195    195            )           2606    478787    ayar_barkod_urun_turu_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.ayar_barkod_urun_turu
    ADD CONSTRAINT ayar_barkod_urun_turu_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.ayar_barkod_urun_turu DROP CONSTRAINT ayar_barkod_urun_turu_pkey;
       public         postgres    false    197    197            +           2606    478789    ayar_barkod_urun_turu_tur_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.ayar_barkod_urun_turu
    ADD CONSTRAINT ayar_barkod_urun_turu_tur_key UNIQUE (tur);
 ]   ALTER TABLE ONLY public.ayar_barkod_urun_turu DROP CONSTRAINT ayar_barkod_urun_turu_tur_key;
       public         postgres    false    197    197            -           2606    478791    ayar_bordro_tipi_deger_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.ayar_bordro_tipi
    ADD CONSTRAINT ayar_bordro_tipi_deger_key UNIQUE (deger);
 U   ALTER TABLE ONLY public.ayar_bordro_tipi DROP CONSTRAINT ayar_bordro_tipi_deger_key;
       public         postgres    false    199    199            /           2606    478793    ayar_bordro_tipi_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.ayar_bordro_tipi
    ADD CONSTRAINT ayar_bordro_tipi_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.ayar_bordro_tipi DROP CONSTRAINT ayar_bordro_tipi_pkey;
       public         postgres    false    199    199            1           2606    478795 (   ayar_cek_senet_cash_edici_tipi_deger_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_cek_senet_cash_edici_tipi
    ADD CONSTRAINT ayar_cek_senet_cash_edici_tipi_deger_key UNIQUE (deger);
 q   ALTER TABLE ONLY public.ayar_cek_senet_cash_edici_tipi DROP CONSTRAINT ayar_cek_senet_cash_edici_tipi_deger_key;
       public         postgres    false    201    201            3           2606    478797 #   ayar_cek_senet_cash_edici_tipi_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_cek_senet_cash_edici_tipi
    ADD CONSTRAINT ayar_cek_senet_cash_edici_tipi_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.ayar_cek_senet_cash_edici_tipi DROP CONSTRAINT ayar_cek_senet_cash_edici_tipi_pkey;
       public         postgres    false    201    201            5           2606    478799 *   ayar_cek_senet_tahsil_odeme_tipi_deger_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_cek_senet_tahsil_odeme_tipi
    ADD CONSTRAINT ayar_cek_senet_tahsil_odeme_tipi_deger_key UNIQUE (deger);
 u   ALTER TABLE ONLY public.ayar_cek_senet_tahsil_odeme_tipi DROP CONSTRAINT ayar_cek_senet_tahsil_odeme_tipi_deger_key;
       public         postgres    false    203    203            7           2606    478801 %   ayar_cek_senet_tahsil_odeme_tipi_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_cek_senet_tahsil_odeme_tipi
    ADD CONSTRAINT ayar_cek_senet_tahsil_odeme_tipi_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.ayar_cek_senet_tahsil_odeme_tipi DROP CONSTRAINT ayar_cek_senet_tahsil_odeme_tipi_pkey;
       public         postgres    false    203    203            9           2606    478803    ayar_cek_senet_tipi_deger_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.ayar_cek_senet_tipi
    ADD CONSTRAINT ayar_cek_senet_tipi_deger_key UNIQUE (deger);
 [   ALTER TABLE ONLY public.ayar_cek_senet_tipi DROP CONSTRAINT ayar_cek_senet_tipi_deger_key;
       public         postgres    false    205    205            ;           2606    478805    ayar_cek_senet_tipi_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.ayar_cek_senet_tipi
    ADD CONSTRAINT ayar_cek_senet_tipi_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.ayar_cek_senet_tipi DROP CONSTRAINT ayar_cek_senet_tipi_pkey;
       public         postgres    false    205    205            =           2606    478807 1   ayar_diger_database_bilgisi_db_name_host_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_diger_database_bilgisi
    ADD CONSTRAINT ayar_diger_database_bilgisi_db_name_host_name_key UNIQUE (db_name, host_name);
 w   ALTER TABLE ONLY public.ayar_diger_database_bilgisi DROP CONSTRAINT ayar_diger_database_bilgisi_db_name_host_name_key;
       public         postgres    false    207    207    207            ?           2606    478809     ayar_diger_database_bilgisi_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.ayar_diger_database_bilgisi
    ADD CONSTRAINT ayar_diger_database_bilgisi_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.ayar_diger_database_bilgisi DROP CONSTRAINT ayar_diger_database_bilgisi_pkey;
       public         postgres    false    207    207            A           2606    478811    ayar_edefter_donem_raporu_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.ayar_edefter_donem_raporu
    ADD CONSTRAINT ayar_edefter_donem_raporu_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.ayar_edefter_donem_raporu DROP CONSTRAINT ayar_edefter_donem_raporu_pkey;
       public         postgres    false    209    209            C           2606    478813 ?   ayar_edefter_donem_raporu_rapor_baslangic_donemi_rapor_biti_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_edefter_donem_raporu
    ADD CONSTRAINT ayar_edefter_donem_raporu_rapor_baslangic_donemi_rapor_biti_key UNIQUE (rapor_baslangic_donemi, rapor_bitis_donemi);
 �   ALTER TABLE ONLY public.ayar_edefter_donem_raporu DROP CONSTRAINT ayar_edefter_donem_raporu_rapor_baslangic_donemi_rapor_biti_key;
       public         postgres    false    209    209    209            E           2606    478815    ayar_efatura_alici_bilgisi_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.ayar_efatura_alici_bilgisi
    ADD CONSTRAINT ayar_efatura_alici_bilgisi_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.ayar_efatura_alici_bilgisi DROP CONSTRAINT ayar_efatura_alici_bilgisi_pkey;
       public         postgres    false    211    211            G           2606    478817 (   ayar_efatura_evrak_cinsi_evrak_cinsi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_cinsi
    ADD CONSTRAINT ayar_efatura_evrak_cinsi_evrak_cinsi_key UNIQUE (evrak_cinsi);
 k   ALTER TABLE ONLY public.ayar_efatura_evrak_cinsi DROP CONSTRAINT ayar_efatura_evrak_cinsi_evrak_cinsi_key;
       public         postgres    false    213    213            I           2606    478819    ayar_efatura_evrak_cinsi_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.ayar_efatura_evrak_cinsi
    ADD CONSTRAINT ayar_efatura_evrak_cinsi_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.ayar_efatura_evrak_cinsi DROP CONSTRAINT ayar_efatura_evrak_cinsi_pkey;
       public         postgres    false    213    213            O           2606    478821 >   ayar_efatura_evrak_tipi_cinsi_evrak_tipi_id_evrak_cinsi_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi
    ADD CONSTRAINT ayar_efatura_evrak_tipi_cinsi_evrak_tipi_id_evrak_cinsi_id_key UNIQUE (evrak_tipi_id, evrak_cinsi_id);
 �   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi DROP CONSTRAINT ayar_efatura_evrak_tipi_cinsi_evrak_tipi_id_evrak_cinsi_id_key;
       public         postgres    false    216    216    216            Q           2606    478823 "   ayar_efatura_evrak_tipi_cinsi_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi
    ADD CONSTRAINT ayar_efatura_evrak_tipi_cinsi_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi DROP CONSTRAINT ayar_efatura_evrak_tipi_cinsi_pkey;
       public         postgres    false    216    216            K           2606    478825 &   ayar_efatura_evrak_tipi_evrak_tipi_key 
   CONSTRAINT        ALTER TABLE ONLY public.ayar_efatura_evrak_tipi
    ADD CONSTRAINT ayar_efatura_evrak_tipi_evrak_tipi_key UNIQUE (evrak_tipi);
 h   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi DROP CONSTRAINT ayar_efatura_evrak_tipi_evrak_tipi_key;
       public         postgres    false    215    215            M           2606    478827    ayar_efatura_evrak_tipi_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi
    ADD CONSTRAINT ayar_efatura_evrak_tipi_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi DROP CONSTRAINT ayar_efatura_evrak_tipi_pkey;
       public         postgres    false    215    215            S           2606    478829    ayar_efatura_fatura_tipi_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.ayar_efatura_fatura_tipi
    ADD CONSTRAINT ayar_efatura_fatura_tipi_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.ayar_efatura_fatura_tipi DROP CONSTRAINT ayar_efatura_fatura_tipi_pkey;
       public         postgres    false    219    219            U           2606    478831     ayar_efatura_fatura_tipi_tip_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.ayar_efatura_fatura_tipi
    ADD CONSTRAINT ayar_efatura_fatura_tipi_tip_key UNIQUE (tip);
 c   ALTER TABLE ONLY public.ayar_efatura_fatura_tipi DROP CONSTRAINT ayar_efatura_fatura_tipi_tip_key;
       public         postgres    false    219    219            W           2606    478833 #   ayar_efatura_gonderici_bilgisi_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_gonderici_bilgisi
    ADD CONSTRAINT ayar_efatura_gonderici_bilgisi_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.ayar_efatura_gonderici_bilgisi DROP CONSTRAINT ayar_efatura_gonderici_bilgisi_pkey;
       public         postgres    false    221    221            Y           2606    478835 #   ayar_efatura_gonderim_sekli_kod_key 
   CONSTRAINT     y   ALTER TABLE ONLY public.ayar_efatura_gonderim_sekli
    ADD CONSTRAINT ayar_efatura_gonderim_sekli_kod_key UNIQUE (kod);
 i   ALTER TABLE ONLY public.ayar_efatura_gonderim_sekli DROP CONSTRAINT ayar_efatura_gonderim_sekli_kod_key;
       public         postgres    false    223    223            [           2606    478837     ayar_efatura_gonderim_sekli_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.ayar_efatura_gonderim_sekli
    ADD CONSTRAINT ayar_efatura_gonderim_sekli_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.ayar_efatura_gonderim_sekli DROP CONSTRAINT ayar_efatura_gonderim_sekli_pkey;
       public         postgres    false    223    223            ]           2606    478839 0   ayar_efatura_ihrac_kayitli_fatura_sebebi_kod_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_ihrac_kayitli_fatura_sebebi
    ADD CONSTRAINT ayar_efatura_ihrac_kayitli_fatura_sebebi_kod_key UNIQUE (kod);
 �   ALTER TABLE ONLY public.ayar_efatura_ihrac_kayitli_fatura_sebebi DROP CONSTRAINT ayar_efatura_ihrac_kayitli_fatura_sebebi_kod_key;
       public         postgres    false    225    225            _           2606    478841 -   ayar_efatura_ihrac_kayitli_fatura_sebebi_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_ihrac_kayitli_fatura_sebebi
    ADD CONSTRAINT ayar_efatura_ihrac_kayitli_fatura_sebebi_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.ayar_efatura_ihrac_kayitli_fatura_sebebi DROP CONSTRAINT ayar_efatura_ihrac_kayitli_fatura_sebebi_pkey;
       public         postgres    false    225    225            a           2606    478843 $   ayar_efatura_iletisim_kanali_kod_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali
    ADD CONSTRAINT ayar_efatura_iletisim_kanali_kod_key UNIQUE (kod);
 k   ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali DROP CONSTRAINT ayar_efatura_iletisim_kanali_kod_key;
       public         postgres    false    227    227            c           2606    478845 !   ayar_efatura_iletisim_kanali_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali
    ADD CONSTRAINT ayar_efatura_iletisim_kanali_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.ayar_efatura_iletisim_kanali DROP CONSTRAINT ayar_efatura_iletisim_kanali_pkey;
       public         postgres    false    227    227            e           2606    478847    ayar_efatura_istisna_kodu_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.ayar_efatura_istisna_kodu
    ADD CONSTRAINT ayar_efatura_istisna_kodu_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.ayar_efatura_istisna_kodu DROP CONSTRAINT ayar_efatura_istisna_kodu_pkey;
       public         postgres    false    229    229            g           2606    478849 &   ayar_efatura_kimlik_semalari_deger_key 
   CONSTRAINT        ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari
    ADD CONSTRAINT ayar_efatura_kimlik_semalari_deger_key UNIQUE (deger);
 m   ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari DROP CONSTRAINT ayar_efatura_kimlik_semalari_deger_key;
       public         postgres    false    231    231            i           2606    478851 !   ayar_efatura_kimlik_semalari_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari
    ADD CONSTRAINT ayar_efatura_kimlik_semalari_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.ayar_efatura_kimlik_semalari DROP CONSTRAINT ayar_efatura_kimlik_semalari_pkey;
       public         postgres    false    231    231            k           2606    478853 (   ayar_efatura_odeme_sekli_odeme_sekli_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_odeme_sekli
    ADD CONSTRAINT ayar_efatura_odeme_sekli_odeme_sekli_key UNIQUE (odeme_sekli);
 k   ALTER TABLE ONLY public.ayar_efatura_odeme_sekli DROP CONSTRAINT ayar_efatura_odeme_sekli_odeme_sekli_key;
       public         postgres    false    233    233            m           2606    478855    ayar_efatura_odeme_sekli_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.ayar_efatura_odeme_sekli
    ADD CONSTRAINT ayar_efatura_odeme_sekli_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.ayar_efatura_odeme_sekli DROP CONSTRAINT ayar_efatura_odeme_sekli_pkey;
       public         postgres    false    233    233            o           2606    478857    ayar_efatura_paket_tipi_kod_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.ayar_efatura_paket_tipi
    ADD CONSTRAINT ayar_efatura_paket_tipi_kod_key UNIQUE (kod);
 a   ALTER TABLE ONLY public.ayar_efatura_paket_tipi DROP CONSTRAINT ayar_efatura_paket_tipi_kod_key;
       public         postgres    false    235    235            q           2606    478859    ayar_efatura_paket_tipi_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_efatura_paket_tipi
    ADD CONSTRAINT ayar_efatura_paket_tipi_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_efatura_paket_tipi DROP CONSTRAINT ayar_efatura_paket_tipi_pkey;
       public         postgres    false    235    235            s           2606    478861 $   ayar_efatura_response_code_deger_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.ayar_efatura_response_code
    ADD CONSTRAINT ayar_efatura_response_code_deger_key UNIQUE (deger);
 i   ALTER TABLE ONLY public.ayar_efatura_response_code DROP CONSTRAINT ayar_efatura_response_code_deger_key;
       public         postgres    false    237    237            u           2606    478863    ayar_efatura_response_code_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.ayar_efatura_response_code
    ADD CONSTRAINT ayar_efatura_response_code_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.ayar_efatura_response_code DROP CONSTRAINT ayar_efatura_response_code_pkey;
       public         postgres    false    237    237            w           2606    478865    ayar_efatura_senaryo_tipi_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi
    ADD CONSTRAINT ayar_efatura_senaryo_tipi_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi DROP CONSTRAINT ayar_efatura_senaryo_tipi_pkey;
       public         postgres    false    239    239            y           2606    478867 !   ayar_efatura_senaryo_tipi_tip_key 
   CONSTRAINT     u   ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi
    ADD CONSTRAINT ayar_efatura_senaryo_tipi_tip_key UNIQUE (tip);
 e   ALTER TABLE ONLY public.ayar_efatura_senaryo_tipi DROP CONSTRAINT ayar_efatura_senaryo_tipi_tip_key;
       public         postgres    false    239    239            {           2606    478869 !   ayar_efatura_teslim_sarti_kod_key 
   CONSTRAINT     u   ALTER TABLE ONLY public.ayar_efatura_teslim_sarti
    ADD CONSTRAINT ayar_efatura_teslim_sarti_kod_key UNIQUE (kod);
 e   ALTER TABLE ONLY public.ayar_efatura_teslim_sarti DROP CONSTRAINT ayar_efatura_teslim_sarti_kod_key;
       public         postgres    false    241    241            }           2606    478871    ayar_efatura_teslim_sarti_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.ayar_efatura_teslim_sarti
    ADD CONSTRAINT ayar_efatura_teslim_sarti_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.ayar_efatura_teslim_sarti DROP CONSTRAINT ayar_efatura_teslim_sarti_pkey;
       public         postgres    false    241    241                       2606    478873 -   ayar_efatura_tevkifat_kodu_kodu_pay_payda_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu
    ADD CONSTRAINT ayar_efatura_tevkifat_kodu_kodu_pay_payda_key UNIQUE (kodu, pay, payda);
 r   ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu DROP CONSTRAINT ayar_efatura_tevkifat_kodu_kodu_pay_payda_key;
       public         postgres    false    243    243    243    243            �           2606    478875    ayar_efatura_tevkifat_kodu_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu
    ADD CONSTRAINT ayar_efatura_tevkifat_kodu_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.ayar_efatura_tevkifat_kodu DROP CONSTRAINT ayar_efatura_tevkifat_kodu_pkey;
       public         postgres    false    243    243            �           2606    478877 .   ayar_fatura_no_serisi_fatura_seri_id_deger_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_fatura_no_serisi
    ADD CONSTRAINT ayar_fatura_no_serisi_fatura_seri_id_deger_key UNIQUE (fatura_seri_id, deger);
 n   ALTER TABLE ONLY public.ayar_fatura_no_serisi DROP CONSTRAINT ayar_fatura_no_serisi_fatura_seri_id_deger_key;
       public         postgres    false    247    247    247            �           2606    478879    ayar_fatura_no_serisi_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.ayar_fatura_no_serisi
    ADD CONSTRAINT ayar_fatura_no_serisi_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.ayar_fatura_no_serisi DROP CONSTRAINT ayar_fatura_no_serisi_pkey;
       public         postgres    false    247    247            �           2606    478881    ayar_firma_tipi_firma_tipi_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.ayar_firma_tipi
    ADD CONSTRAINT ayar_firma_tipi_firma_tipi_key UNIQUE (firma_tipi);
 X   ALTER TABLE ONLY public.ayar_firma_tipi DROP CONSTRAINT ayar_firma_tipi_firma_tipi_key;
       public         postgres    false    249    249            �           2606    478883    ayar_firma_tipi_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.ayar_firma_tipi
    ADD CONSTRAINT ayar_firma_tipi_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.ayar_firma_tipi DROP CONSTRAINT ayar_firma_tipi_pkey;
       public         postgres    false    249    249            �           2606    478885    ayar_firma_turu_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.ayar_firma_turu
    ADD CONSTRAINT ayar_firma_turu_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.ayar_firma_turu DROP CONSTRAINT ayar_firma_turu_pkey;
       public         postgres    false    251    251            �           2606    478887    ayar_firma_turu_tur_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.ayar_firma_turu
    ADD CONSTRAINT ayar_firma_turu_tur_key UNIQUE (tur);
 Q   ALTER TABLE ONLY public.ayar_firma_turu DROP CONSTRAINT ayar_firma_turu_tur_key;
       public         postgres    false    251    251            �           2606    478889    ayar_fis_tipi_deger_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.ayar_fis_tipi
    ADD CONSTRAINT ayar_fis_tipi_deger_key UNIQUE (deger);
 O   ALTER TABLE ONLY public.ayar_fis_tipi DROP CONSTRAINT ayar_fis_tipi_deger_key;
       public         postgres    false    253    253            �           2606    478891    ayar_fis_tipi_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.ayar_fis_tipi
    ADD CONSTRAINT ayar_fis_tipi_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.ayar_fis_tipi DROP CONSTRAINT ayar_fis_tipi_pkey;
       public         postgres    false    253    253            �           2606    478893    ayar_genel_ayarlar_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.ayar_genel_ayarlar
    ADD CONSTRAINT ayar_genel_ayarlar_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.ayar_genel_ayarlar DROP CONSTRAINT ayar_genel_ayarlar_pkey;
       public         postgres    false    255    255            �           2606    478895 '   ayar_genel_ayarlar_tc_no_firma_tipi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_genel_ayarlar
    ADD CONSTRAINT ayar_genel_ayarlar_tc_no_firma_tipi_key UNIQUE (tc_no, firma_tipi);
 d   ALTER TABLE ONLY public.ayar_genel_ayarlar DROP CONSTRAINT ayar_genel_ayarlar_tc_no_firma_tipi_key;
       public         postgres    false    255    255    255            �           2606    478897 *   ayar_genel_ayarlar_vergi_no_firma_tipi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_genel_ayarlar
    ADD CONSTRAINT ayar_genel_ayarlar_vergi_no_firma_tipi_key UNIQUE (vergi_no, firma_tipi);
 g   ALTER TABLE ONLY public.ayar_genel_ayarlar DROP CONSTRAINT ayar_genel_ayarlar_vergi_no_firma_tipi_key;
       public         postgres    false    255    255    255            �           2606    478899    ayar_hane_sayisi_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.ayar_hane_sayisi
    ADD CONSTRAINT ayar_hane_sayisi_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.ayar_hane_sayisi DROP CONSTRAINT ayar_hane_sayisi_pkey;
       public         postgres    false    257    257            �           2606    478901    ayar_hane_sayisi_ukey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_hane_sayisi
    ADD CONSTRAINT ayar_hane_sayisi_ukey UNIQUE (hesap_bakiye, alis_miktar, alis_fiyat, alis_tutar, satis_miktar, satis_fiyat, satis_tutar, stok_miktar, stok_fiyat);
 P   ALTER TABLE ONLY public.ayar_hane_sayisi DROP CONSTRAINT ayar_hane_sayisi_ukey;
       public         postgres    false    257    257    257    257    257    257    257    257    257    257            �           2606    699373    ayar_hesap_tipi_hesap_tipi_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.ayar_hesap_tipi
    ADD CONSTRAINT ayar_hesap_tipi_hesap_tipi_key UNIQUE (hesap_tipi);
 X   ALTER TABLE ONLY public.ayar_hesap_tipi DROP CONSTRAINT ayar_hesap_tipi_hesap_tipi_key;
       public         postgres    false    259    259            �           2606    478905    ayar_hesap_tipi_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.ayar_hesap_tipi
    ADD CONSTRAINT ayar_hesap_tipi_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.ayar_hesap_tipi DROP CONSTRAINT ayar_hesap_tipi_pkey;
       public         postgres    false    259    259            �           2606    478907 (   ayar_irsaliye_fatura_no_serisi_deger_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_irsaliye_fatura_no_serisi
    ADD CONSTRAINT ayar_irsaliye_fatura_no_serisi_deger_key UNIQUE (deger);
 q   ALTER TABLE ONLY public.ayar_irsaliye_fatura_no_serisi DROP CONSTRAINT ayar_irsaliye_fatura_no_serisi_deger_key;
       public         postgres    false    261    261            �           2606    478909 #   ayar_irsaliye_fatura_no_serisi_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_irsaliye_fatura_no_serisi
    ADD CONSTRAINT ayar_irsaliye_fatura_no_serisi_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.ayar_irsaliye_fatura_no_serisi DROP CONSTRAINT ayar_irsaliye_fatura_no_serisi_pkey;
       public         postgres    false    261    261            �           2606    478911 2   ayar_irsaliye_no_serisi_irsaliye_seri_id_deger_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi
    ADD CONSTRAINT ayar_irsaliye_no_serisi_irsaliye_seri_id_deger_key UNIQUE (irsaliye_seri_id, deger);
 t   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi DROP CONSTRAINT ayar_irsaliye_no_serisi_irsaliye_seri_id_deger_key;
       public         postgres    false    263    263    263            �           2606    478913    ayar_irsaliye_no_serisi_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi
    ADD CONSTRAINT ayar_irsaliye_no_serisi_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi DROP CONSTRAINT ayar_irsaliye_no_serisi_pkey;
       public         postgres    false    263    263            �           2606    478915    ayar_modul_tipi_deger_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.ayar_modul_tipi
    ADD CONSTRAINT ayar_modul_tipi_deger_key UNIQUE (deger);
 S   ALTER TABLE ONLY public.ayar_modul_tipi DROP CONSTRAINT ayar_modul_tipi_deger_key;
       public         postgres    false    265    265            �           2606    478917    ayar_modul_tipi_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.ayar_modul_tipi
    ADD CONSTRAINT ayar_modul_tipi_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.ayar_modul_tipi DROP CONSTRAINT ayar_modul_tipi_pkey;
       public         postgres    false    265    265            �           2606    478919    ayar_mukellef_tipi_deger_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.ayar_mukellef_tipi
    ADD CONSTRAINT ayar_mukellef_tipi_deger_key UNIQUE (deger);
 Y   ALTER TABLE ONLY public.ayar_mukellef_tipi DROP CONSTRAINT ayar_mukellef_tipi_deger_key;
       public         postgres    false    267    267            �           2606    478921    ayar_mukellef_tipi_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.ayar_mukellef_tipi
    ADD CONSTRAINT ayar_mukellef_tipi_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.ayar_mukellef_tipi DROP CONSTRAINT ayar_mukellef_tipi_pkey;
       public         postgres    false    267    267            �           2606    478923 !   ayar_musteri_firma_turu_deger_key 
   CONSTRAINT     u   ALTER TABLE ONLY public.ayar_musteri_firma_turu
    ADD CONSTRAINT ayar_musteri_firma_turu_deger_key UNIQUE (deger);
 c   ALTER TABLE ONLY public.ayar_musteri_firma_turu DROP CONSTRAINT ayar_musteri_firma_turu_deger_key;
       public         postgres    false    269    269            �           2606    478925    ayar_musteri_firma_turu_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_musteri_firma_turu
    ADD CONSTRAINT ayar_musteri_firma_turu_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_musteri_firma_turu DROP CONSTRAINT ayar_musteri_firma_turu_pkey;
       public         postgres    false    269    269            �           2606    478927 %   ayar_odeme_baslangic_donemi_deger_key 
   CONSTRAINT     }   ALTER TABLE ONLY public.ayar_odeme_baslangic_donemi
    ADD CONSTRAINT ayar_odeme_baslangic_donemi_deger_key UNIQUE (deger);
 k   ALTER TABLE ONLY public.ayar_odeme_baslangic_donemi DROP CONSTRAINT ayar_odeme_baslangic_donemi_deger_key;
       public         postgres    false    271    271            �           2606    478929     ayar_odeme_baslangic_donemi_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.ayar_odeme_baslangic_donemi
    ADD CONSTRAINT ayar_odeme_baslangic_donemi_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.ayar_odeme_baslangic_donemi DROP CONSTRAINT ayar_odeme_baslangic_donemi_pkey;
       public         postgres    false    271    271            �           2606    478931     ayar_odeme_sekli_odeme_sekli_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.ayar_odeme_sekli
    ADD CONSTRAINT ayar_odeme_sekli_odeme_sekli_key UNIQUE (odeme_sekli);
 [   ALTER TABLE ONLY public.ayar_odeme_sekli DROP CONSTRAINT ayar_odeme_sekli_odeme_sekli_key;
       public         postgres    false    273    273            �           2606    478933    ayar_odeme_sekli_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.ayar_odeme_sekli
    ADD CONSTRAINT ayar_odeme_sekli_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.ayar_odeme_sekli DROP CONSTRAINT ayar_odeme_sekli_pkey;
       public         postgres    false    273    273            �           2606    793027 ,   ayar_prs_askerlik_durumu_askerlik_durumu_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_prs_askerlik_durumu
    ADD CONSTRAINT ayar_prs_askerlik_durumu_askerlik_durumu_key UNIQUE (askerlik_durumu);
 o   ALTER TABLE ONLY public.ayar_prs_askerlik_durumu DROP CONSTRAINT ayar_prs_askerlik_durumu_askerlik_durumu_key;
       public         postgres    false    413    413            �           2606    793025    ayar_prs_askerlik_durumu_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.ayar_prs_askerlik_durumu
    ADD CONSTRAINT ayar_prs_askerlik_durumu_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.ayar_prs_askerlik_durumu DROP CONSTRAINT ayar_prs_askerlik_durumu_pkey;
       public         postgres    false    413    413            �           2606    821965 *   ayar_prs_ayrilma_nedeni_ayrilma_nedeni_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_prs_ayrilma_nedeni
    ADD CONSTRAINT ayar_prs_ayrilma_nedeni_ayrilma_nedeni_key UNIQUE (ayrilma_nedeni);
 l   ALTER TABLE ONLY public.ayar_prs_ayrilma_nedeni DROP CONSTRAINT ayar_prs_ayrilma_nedeni_ayrilma_nedeni_key;
       public         postgres    false    448    448            �           2606    821963    ayar_prs_ayrilma_nedeni_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_prs_ayrilma_nedeni
    ADD CONSTRAINT ayar_prs_ayrilma_nedeni_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_prs_ayrilma_nedeni DROP CONSTRAINT ayar_prs_ayrilma_nedeni_pkey;
       public         postgres    false    448    448            �           2606    820775 !   ayar_prs_birim_bolum_id_birim_key 
   CONSTRAINT     v   ALTER TABLE ONLY public.ayar_prs_birim
    ADD CONSTRAINT ayar_prs_birim_bolum_id_birim_key UNIQUE (bolum_id, birim);
 Z   ALTER TABLE ONLY public.ayar_prs_birim DROP CONSTRAINT ayar_prs_birim_bolum_id_birim_key;
       public         postgres    false    446    446    446            �           2606    820773    ayar_prs_birim_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.ayar_prs_birim
    ADD CONSTRAINT ayar_prs_birim_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.ayar_prs_birim DROP CONSTRAINT ayar_prs_birim_pkey;
       public         postgres    false    446    446            �           2606    820754    ayar_prs_bolum_bolum_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.ayar_prs_bolum
    ADD CONSTRAINT ayar_prs_bolum_bolum_key UNIQUE (bolum);
 Q   ALTER TABLE ONLY public.ayar_prs_bolum DROP CONSTRAINT ayar_prs_bolum_bolum_key;
       public         postgres    false    444    444            �           2606    820752    ayar_prs_bolum_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.ayar_prs_bolum
    ADD CONSTRAINT ayar_prs_bolum_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.ayar_prs_bolum DROP CONSTRAINT ayar_prs_bolum_pkey;
       public         postgres    false    444    444            �           2606    820728    ayar_prs_cinsiyet_cinsiyet_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.ayar_prs_cinsiyet
    ADD CONSTRAINT ayar_prs_cinsiyet_cinsiyet_key UNIQUE (cinsiyet);
 Z   ALTER TABLE ONLY public.ayar_prs_cinsiyet DROP CONSTRAINT ayar_prs_cinsiyet_cinsiyet_key;
       public         postgres    false    442    442            �           2606    820726    ayar_prs_cinsiyet_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ayar_prs_cinsiyet
    ADD CONSTRAINT ayar_prs_cinsiyet_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.ayar_prs_cinsiyet DROP CONSTRAINT ayar_prs_cinsiyet_pkey;
       public         postgres    false    442    442            �           2606    820690 (   ayar_prs_egitim_durumu_egitim_durumu_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_prs_egitim_durumu
    ADD CONSTRAINT ayar_prs_egitim_durumu_egitim_durumu_key UNIQUE (egitim_durumu);
 i   ALTER TABLE ONLY public.ayar_prs_egitim_durumu DROP CONSTRAINT ayar_prs_egitim_durumu_egitim_durumu_key;
       public         postgres    false    436    436            �           2606    820688    ayar_prs_egitim_durumu_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.ayar_prs_egitim_durumu
    ADD CONSTRAINT ayar_prs_egitim_durumu_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.ayar_prs_egitim_durumu DROP CONSTRAINT ayar_prs_egitim_durumu_pkey;
       public         postgres    false    436    436            �           2606    820680 &   ayar_prs_ehliyet_tipi_ehliyet_tipi_key 
   CONSTRAINT        ALTER TABLE ONLY public.ayar_prs_ehliyet_tipi
    ADD CONSTRAINT ayar_prs_ehliyet_tipi_ehliyet_tipi_key UNIQUE (ehliyet_tipi);
 f   ALTER TABLE ONLY public.ayar_prs_ehliyet_tipi DROP CONSTRAINT ayar_prs_ehliyet_tipi_ehliyet_tipi_key;
       public         postgres    false    434    434            �           2606    820678    ayar_prs_ehliyet_tipi_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.ayar_prs_ehliyet_tipi
    ADD CONSTRAINT ayar_prs_ehliyet_tipi_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.ayar_prs_ehliyet_tipi DROP CONSTRAINT ayar_prs_ehliyet_tipi_pkey;
       public         postgres    false    434    434            �           2606    820665    ayar_prs_gorev_gorev_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.ayar_prs_gorev
    ADD CONSTRAINT ayar_prs_gorev_gorev_key UNIQUE (gorev);
 Q   ALTER TABLE ONLY public.ayar_prs_gorev DROP CONSTRAINT ayar_prs_gorev_gorev_key;
       public         postgres    false    432    432            �           2606    820663    ayar_prs_gorev_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.ayar_prs_gorev
    ADD CONSTRAINT ayar_prs_gorev_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.ayar_prs_gorev DROP CONSTRAINT ayar_prs_gorev_pkey;
       public         postgres    false    432    432            �           2606    812296     ayar_prs_izin_tipi_izin_tipi_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.ayar_prs_izin_tipi
    ADD CONSTRAINT ayar_prs_izin_tipi_izin_tipi_key UNIQUE (izin_tipi);
 ]   ALTER TABLE ONLY public.ayar_prs_izin_tipi DROP CONSTRAINT ayar_prs_izin_tipi_izin_tipi_key;
       public         postgres    false    429    429            �           2606    812294    ayar_prs_izin_tipi_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.ayar_prs_izin_tipi
    ADD CONSTRAINT ayar_prs_izin_tipi_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.ayar_prs_izin_tipi DROP CONSTRAINT ayar_prs_izin_tipi_pkey;
       public         postgres    false    429    429            �           2606    801414 &   ayar_prs_medeni_durum_medeni_durum_key 
   CONSTRAINT        ALTER TABLE ONLY public.ayar_prs_medeni_durum
    ADD CONSTRAINT ayar_prs_medeni_durum_medeni_durum_key UNIQUE (medeni_durum);
 f   ALTER TABLE ONLY public.ayar_prs_medeni_durum DROP CONSTRAINT ayar_prs_medeni_durum_medeni_durum_key;
       public         postgres    false    427    427            �           2606    801412    ayar_prs_medeni_durum_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.ayar_prs_medeni_durum
    ADD CONSTRAINT ayar_prs_medeni_durum_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.ayar_prs_medeni_durum DROP CONSTRAINT ayar_prs_medeni_durum_pkey;
       public         postgres    false    427    427            �           2606    801404 $   ayar_prs_mektup_tipi_mektup_tipi_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.ayar_prs_mektup_tipi
    ADD CONSTRAINT ayar_prs_mektup_tipi_mektup_tipi_key UNIQUE (mektup_tipi);
 c   ALTER TABLE ONLY public.ayar_prs_mektup_tipi DROP CONSTRAINT ayar_prs_mektup_tipi_mektup_tipi_key;
       public         postgres    false    425    425            �           2606    801402    ayar_prs_mektup_tipi_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.ayar_prs_mektup_tipi
    ADD CONSTRAINT ayar_prs_mektup_tipi_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.ayar_prs_mektup_tipi DROP CONSTRAINT ayar_prs_mektup_tipi_pkey;
       public         postgres    false    425    425            �           2606    832200    ayar_prs_myk_tipi_myk_tipi_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.ayar_prs_myk_tipi
    ADD CONSTRAINT ayar_prs_myk_tipi_myk_tipi_key UNIQUE (myk_tipi);
 Z   ALTER TABLE ONLY public.ayar_prs_myk_tipi DROP CONSTRAINT ayar_prs_myk_tipi_myk_tipi_key;
       public         postgres    false    423    423            �           2606    801392    ayar_prs_myk_tipi_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ayar_prs_myk_tipi
    ADD CONSTRAINT ayar_prs_myk_tipi_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.ayar_prs_myk_tipi DROP CONSTRAINT ayar_prs_myk_tipi_pkey;
       public         postgres    false    423    423            �           2606    801384 (   ayar_prs_personel_tipi_personel_tipi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_prs_personel_tipi
    ADD CONSTRAINT ayar_prs_personel_tipi_personel_tipi_key UNIQUE (personel_tipi);
 i   ALTER TABLE ONLY public.ayar_prs_personel_tipi DROP CONSTRAINT ayar_prs_personel_tipi_personel_tipi_key;
       public         postgres    false    415    415            �           2606    794522    ayar_prs_personel_tipi_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.ayar_prs_personel_tipi
    ADD CONSTRAINT ayar_prs_personel_tipi_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.ayar_prs_personel_tipi DROP CONSTRAINT ayar_prs_personel_tipi_pkey;
       public         postgres    false    415    415            �           2606    801368    ayar_prs_rapor_tipi_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.ayar_prs_rapor_tipi
    ADD CONSTRAINT ayar_prs_rapor_tipi_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.ayar_prs_rapor_tipi DROP CONSTRAINT ayar_prs_rapor_tipi_pkey;
       public         postgres    false    419    419            �           2606    801370 "   ayar_prs_rapor_tipi_rapor_tipi_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.ayar_prs_rapor_tipi
    ADD CONSTRAINT ayar_prs_rapor_tipi_rapor_tipi_key UNIQUE (rapor_tipi);
 `   ALTER TABLE ONLY public.ayar_prs_rapor_tipi DROP CONSTRAINT ayar_prs_rapor_tipi_rapor_tipi_key;
       public         postgres    false    419    419            �           2606    801378    ayar_prs_src_tipi_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ayar_prs_src_tipi
    ADD CONSTRAINT ayar_prs_src_tipi_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.ayar_prs_src_tipi DROP CONSTRAINT ayar_prs_src_tipi_pkey;
       public         postgres    false    421    421            �           2606    801380    ayar_prs_src_tipi_src_tipi_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.ayar_prs_src_tipi
    ADD CONSTRAINT ayar_prs_src_tipi_src_tipi_key UNIQUE (src_tipi);
 Z   ALTER TABLE ONLY public.ayar_prs_src_tipi DROP CONSTRAINT ayar_prs_src_tipi_src_tipi_key;
       public         postgres    false    421    421            �           2606    794533    ayar_prs_tatil_tipi_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.ayar_prs_tatil_tipi
    ADD CONSTRAINT ayar_prs_tatil_tipi_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.ayar_prs_tatil_tipi DROP CONSTRAINT ayar_prs_tatil_tipi_pkey;
       public         postgres    false    417    417            �           2606    801382 "   ayar_prs_tatil_tipi_tatil_tipi_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.ayar_prs_tatil_tipi
    ADD CONSTRAINT ayar_prs_tatil_tipi_tatil_tipi_key UNIQUE (tatil_tipi);
 `   ALTER TABLE ONLY public.ayar_prs_tatil_tipi DROP CONSTRAINT ayar_prs_tatil_tipi_tatil_tipi_key;
       public         postgres    false    417    417            �           2606    820708    ayar_prs_yabanci_dil_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.ayar_prs_yabanci_dil
    ADD CONSTRAINT ayar_prs_yabanci_dil_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.ayar_prs_yabanci_dil DROP CONSTRAINT ayar_prs_yabanci_dil_pkey;
       public         postgres    false    440    440            �           2606    820698 "   ayar_prs_yabanci_dil_seviyesi_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.ayar_prs_yabanci_dil_seviyesi
    ADD CONSTRAINT ayar_prs_yabanci_dil_seviyesi_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.ayar_prs_yabanci_dil_seviyesi DROP CONSTRAINT ayar_prs_yabanci_dil_seviyesi_pkey;
       public         postgres    false    438    438            �           2606    820700 6   ayar_prs_yabanci_dil_seviyesi_yabanci_dil_seviyesi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_prs_yabanci_dil_seviyesi
    ADD CONSTRAINT ayar_prs_yabanci_dil_seviyesi_yabanci_dil_seviyesi_key UNIQUE (yabanci_dil_seviyesi);
 ~   ALTER TABLE ONLY public.ayar_prs_yabanci_dil_seviyesi DROP CONSTRAINT ayar_prs_yabanci_dil_seviyesi_yabanci_dil_seviyesi_key;
       public         postgres    false    438    438            �           2606    820710 $   ayar_prs_yabanci_dil_yabanci_dil_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.ayar_prs_yabanci_dil
    ADD CONSTRAINT ayar_prs_yabanci_dil_yabanci_dil_key UNIQUE (yabanci_dil);
 c   ALTER TABLE ONLY public.ayar_prs_yabanci_dil DROP CONSTRAINT ayar_prs_yabanci_dil_yabanci_dil_key;
       public         postgres    false    440    440            �           2606    479011    ayar_sabit_degisken_deger_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.ayar_sabit_degisken
    ADD CONSTRAINT ayar_sabit_degisken_deger_key UNIQUE (deger);
 [   ALTER TABLE ONLY public.ayar_sabit_degisken DROP CONSTRAINT ayar_sabit_degisken_deger_key;
       public         postgres    false    275    275            �           2606    479013    ayar_sabit_degisken_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.ayar_sabit_degisken
    ADD CONSTRAINT ayar_sabit_degisken_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.ayar_sabit_degisken DROP CONSTRAINT ayar_sabit_degisken_pkey;
       public         postgres    false    275    275            �           2606    479015 (   ayar_sevkiyat_hazirlama_durumu_deger_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_sevkiyat_hazirlama_durumu
    ADD CONSTRAINT ayar_sevkiyat_hazirlama_durumu_deger_key UNIQUE (deger);
 q   ALTER TABLE ONLY public.ayar_sevkiyat_hazirlama_durumu DROP CONSTRAINT ayar_sevkiyat_hazirlama_durumu_deger_key;
       public         postgres    false    277    277            �           2606    479017 #   ayar_sevkiyat_hazirlama_durumu_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ayar_sevkiyat_hazirlama_durumu
    ADD CONSTRAINT ayar_sevkiyat_hazirlama_durumu_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.ayar_sevkiyat_hazirlama_durumu DROP CONSTRAINT ayar_sevkiyat_hazirlama_durumu_pkey;
       public         postgres    false    277    277            �           2606    479019    ayar_stok_hareket_ayari_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.ayar_stok_hareket_ayari
    ADD CONSTRAINT ayar_stok_hareket_ayari_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.ayar_stok_hareket_ayari DROP CONSTRAINT ayar_stok_hareket_ayari_pkey;
       public         postgres    false    279    279            �           2606    479021     ayar_stok_hareket_tipi_deger_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.ayar_stok_hareket_tipi
    ADD CONSTRAINT ayar_stok_hareket_tipi_deger_key UNIQUE (deger);
 a   ALTER TABLE ONLY public.ayar_stok_hareket_tipi DROP CONSTRAINT ayar_stok_hareket_tipi_deger_key;
       public         postgres    false    281    281            �           2606    479023 #   ayar_stok_hareket_tipi_is_input_key 
   CONSTRAINT     y   ALTER TABLE ONLY public.ayar_stok_hareket_tipi
    ADD CONSTRAINT ayar_stok_hareket_tipi_is_input_key UNIQUE (is_input);
 d   ALTER TABLE ONLY public.ayar_stok_hareket_tipi DROP CONSTRAINT ayar_stok_hareket_tipi_is_input_key;
       public         postgres    false    281    281            �           2606    479025    ayar_stok_hareket_tipi_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.ayar_stok_hareket_tipi
    ADD CONSTRAINT ayar_stok_hareket_tipi_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.ayar_stok_hareket_tipi DROP CONSTRAINT ayar_stok_hareket_tipi_pkey;
       public         postgres    false    281    281            �           2606    479027    ayar_teklif_durum_deger_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.ayar_teklif_durum
    ADD CONSTRAINT ayar_teklif_durum_deger_key UNIQUE (deger);
 W   ALTER TABLE ONLY public.ayar_teklif_durum DROP CONSTRAINT ayar_teklif_durum_deger_key;
       public         postgres    false    283    283            �           2606    479029    ayar_teklif_durum_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ayar_teklif_durum
    ADD CONSTRAINT ayar_teklif_durum_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.ayar_teklif_durum DROP CONSTRAINT ayar_teklif_durum_pkey;
       public         postgres    false    283    283            �           2606    479031    ayar_teklif_tipi_deger_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.ayar_teklif_tipi
    ADD CONSTRAINT ayar_teklif_tipi_deger_key UNIQUE (deger);
 U   ALTER TABLE ONLY public.ayar_teklif_tipi DROP CONSTRAINT ayar_teklif_tipi_deger_key;
       public         postgres    false    285    285            �           2606    479033    ayar_teklif_tipi_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.ayar_teklif_tipi
    ADD CONSTRAINT ayar_teklif_tipi_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.ayar_teklif_tipi DROP CONSTRAINT ayar_teklif_tipi_pkey;
       public         postgres    false    285    285            �           2606    479035    ayar_vergi_orani_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.ayar_vergi_orani
    ADD CONSTRAINT ayar_vergi_orani_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.ayar_vergi_orani DROP CONSTRAINT ayar_vergi_orani_pkey;
       public         postgres    false    287    287            �           2606    479037     ayar_vergi_orani_vergi_orani_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.ayar_vergi_orani
    ADD CONSTRAINT ayar_vergi_orani_vergi_orani_key UNIQUE (vergi_orani);
 [   ALTER TABLE ONLY public.ayar_vergi_orani DROP CONSTRAINT ayar_vergi_orani_vergi_orani_key;
       public         postgres    false    287    287            �           2606    479039    banka_adi_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.banka
    ADD CONSTRAINT banka_adi_key UNIQUE (adi);
 =   ALTER TABLE ONLY public.banka DROP CONSTRAINT banka_adi_key;
       public         postgres    false    289    289            �           2606    479041 
   banka_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.banka
    ADD CONSTRAINT banka_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.banka DROP CONSTRAINT banka_pkey;
       public         postgres    false    289    289            �           2606    479043    banka_subesi_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.banka_subesi
    ADD CONSTRAINT banka_subesi_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.banka_subesi DROP CONSTRAINT banka_subesi_pkey;
       public         postgres    false    291    291            �           2606    479045    barkod_hazirlik_dosya_turu_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.barkod_hazirlik_dosya_turu
    ADD CONSTRAINT barkod_hazirlik_dosya_turu_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.barkod_hazirlik_dosya_turu DROP CONSTRAINT barkod_hazirlik_dosya_turu_pkey;
       public         postgres    false    293    293            �           2606    479047 "   barkod_hazirlik_dosya_turu_tur_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.barkod_hazirlik_dosya_turu
    ADD CONSTRAINT barkod_hazirlik_dosya_turu_tur_key UNIQUE (tur);
 g   ALTER TABLE ONLY public.barkod_hazirlik_dosya_turu DROP CONSTRAINT barkod_hazirlik_dosya_turu_tur_key;
       public         postgres    false    293    293            �           2606    479049    barkod_serino_turu_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.barkod_serino_turu
    ADD CONSTRAINT barkod_serino_turu_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.barkod_serino_turu DROP CONSTRAINT barkod_serino_turu_pkey;
       public         postgres    false    295    295            �           2606    479051    barkod_serino_turu_tur_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.barkod_serino_turu
    ADD CONSTRAINT barkod_serino_turu_tur_key UNIQUE (tur);
 W   ALTER TABLE ONLY public.barkod_serino_turu DROP CONSTRAINT barkod_serino_turu_tur_key;
       public         postgres    false    295    295            �           2606    479053    barkod_tezgah_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.barkod_tezgah
    ADD CONSTRAINT barkod_tezgah_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.barkod_tezgah DROP CONSTRAINT barkod_tezgah_pkey;
       public         postgres    false    297    297            �           2606    479055 %   barkod_tezgah_tezgah_adi_ambar_id_key 
   CONSTRAINT     ~   ALTER TABLE ONLY public.barkod_tezgah
    ADD CONSTRAINT barkod_tezgah_tezgah_adi_ambar_id_key UNIQUE (tezgah_adi, ambar_id);
 ]   ALTER TABLE ONLY public.barkod_tezgah DROP CONSTRAINT barkod_tezgah_tezgah_adi_ambar_id_key;
       public         postgres    false    297    297    297            �           2606    479057    bolge_bolge_adi_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT bolge_bolge_adi_key UNIQUE (bolge_adi);
 C   ALTER TABLE ONLY public.bolge DROP CONSTRAINT bolge_bolge_adi_key;
       public         postgres    false    299    299            �           2606    479059 
   bolge_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT bolge_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.bolge DROP CONSTRAINT bolge_pkey;
       public         postgres    false    299    299            �           2606    479061    bolge_turu_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.bolge_turu
    ADD CONSTRAINT bolge_turu_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.bolge_turu DROP CONSTRAINT bolge_turu_pkey;
       public         postgres    false    301    301            �           2606    479063    bolge_turu_tur_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.bolge_turu
    ADD CONSTRAINT bolge_turu_tur_key UNIQUE (tur);
 G   ALTER TABLE ONLY public.bolge_turu DROP CONSTRAINT bolge_turu_tur_key;
       public         postgres    false    301    301            �           2606    479065    cins_ailesi_aile_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.cins_ailesi
    ADD CONSTRAINT cins_ailesi_aile_key UNIQUE (aile);
 J   ALTER TABLE ONLY public.cins_ailesi DROP CONSTRAINT cins_ailesi_aile_key;
       public         postgres    false    303    303            �           2606    479067    cins_ailesi_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cins_ailesi
    ADD CONSTRAINT cins_ailesi_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cins_ailesi DROP CONSTRAINT cins_ailesi_pkey;
       public         postgres    false    303    303            �           2606    479069    cins_ozelligi_cins_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.cins_ozelligi
    ADD CONSTRAINT cins_ozelligi_cins_key UNIQUE (cins);
 N   ALTER TABLE ONLY public.cins_ozelligi DROP CONSTRAINT cins_ozelligi_cins_key;
       public         postgres    false    305    305            �           2606    479071    cins_ozelligi_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.cins_ozelligi
    ADD CONSTRAINT cins_ozelligi_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cins_ozelligi DROP CONSTRAINT cins_ozelligi_pkey;
       public         postgres    false    305    305            �           2606    479073    cnf_employee_section_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.cnf_employee_section
    ADD CONSTRAINT cnf_employee_section_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.cnf_employee_section DROP CONSTRAINT cnf_employee_section_pkey;
       public         postgres    false    307    307                       2606    479075     cnf_employee_section_section_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.cnf_employee_section
    ADD CONSTRAINT cnf_employee_section_section_key UNIQUE (section);
 _   ALTER TABLE ONLY public.cnf_employee_section DROP CONSTRAINT cnf_employee_section_section_key;
       public         postgres    false    307    307                       2606    479077    doviz_kuru_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.doviz_kuru
    ADD CONSTRAINT doviz_kuru_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.doviz_kuru DROP CONSTRAINT doviz_kuru_pkey;
       public         postgres    false    309    309                       2606    479079     doviz_kuru_tarih_para_birimi_key 
   CONSTRAINT     t   ALTER TABLE ONLY public.doviz_kuru
    ADD CONSTRAINT doviz_kuru_tarih_para_birimi_key UNIQUE (tarih, para_birimi);
 U   ALTER TABLE ONLY public.doviz_kuru DROP CONSTRAINT doviz_kuru_tarih_para_birimi_key;
       public         postgres    false    309    309    309            �           2606    479081    efatura_vergi_kodu_kodu_key 
   CONSTRAINT     n   ALTER TABLE ONLY public.ayar_efatura_vergi_kodu
    ADD CONSTRAINT efatura_vergi_kodu_kodu_key UNIQUE (kodu);
 ]   ALTER TABLE ONLY public.ayar_efatura_vergi_kodu DROP CONSTRAINT efatura_vergi_kodu_kodu_key;
       public         postgres    false    245    245            �           2606    479083    efatura_vergi_kodu_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ayar_efatura_vergi_kodu
    ADD CONSTRAINT efatura_vergi_kodu_pkey PRIMARY KEY (id);
 Y   ALTER TABLE ONLY public.ayar_efatura_vergi_kodu DROP CONSTRAINT efatura_vergi_kodu_pkey;
       public         postgres    false    245    245                       2606    479085    hesap_grubu_grup_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.hesap_grubu
    ADD CONSTRAINT hesap_grubu_grup_key UNIQUE (grup);
 J   ALTER TABLE ONLY public.hesap_grubu DROP CONSTRAINT hesap_grubu_grup_key;
       public         postgres    false    311    311            	           2606    479087    hesap_grubu_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hesap_grubu
    ADD CONSTRAINT hesap_grubu_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.hesap_grubu DROP CONSTRAINT hesap_grubu_pkey;
       public         postgres    false    311    311            �           2606    699389    hesap_karti_hesap_kodu_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.hesap_karti
    ADD CONSTRAINT hesap_karti_hesap_kodu_key UNIQUE (hesap_kodu);
 P   ALTER TABLE ONLY public.hesap_karti DROP CONSTRAINT hesap_karti_hesap_kodu_key;
       public         postgres    false    411    411            �           2606    699387    hesap_karti_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hesap_karti
    ADD CONSTRAINT hesap_karti_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.hesap_karti DROP CONSTRAINT hesap_karti_pkey;
       public         postgres    false    411    411                       2606    479093    hesap_plani_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hesap_plani
    ADD CONSTRAINT hesap_plani_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.hesap_plani DROP CONSTRAINT hesap_plani_pkey;
       public         postgres    false    313    313                       2606    479095 $   hesap_plani_plan_kodu_varsayilan_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.hesap_plani
    ADD CONSTRAINT hesap_plani_plan_kodu_varsayilan_key UNIQUE (plan_kodu_varsayilan);
 Z   ALTER TABLE ONLY public.hesap_plani DROP CONSTRAINT hesap_plani_plan_kodu_varsayilan_key;
       public         postgres    false    313    313                       2606    479097    medeni_durum_durum_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.medeni_durum
    ADD CONSTRAINT medeni_durum_durum_key UNIQUE (durum);
 M   ALTER TABLE ONLY public.medeni_durum DROP CONSTRAINT medeni_durum_durum_key;
       public         postgres    false    315    315                       2606    479099    medeni_durum_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.medeni_durum
    ADD CONSTRAINT medeni_durum_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.medeni_durum DROP CONSTRAINT medeni_durum_pkey;
       public         postgres    false    315    315                       2606    479101    muhasebe_hesap_plani_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.muhasebe_hesap_plani
    ADD CONSTRAINT muhasebe_hesap_plani_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.muhasebe_hesap_plani DROP CONSTRAINT muhasebe_hesap_plani_pkey;
       public         postgres    false    317    317                       2606    479103 "   muhasebe_hesap_plani_plan_kodu_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.muhasebe_hesap_plani
    ADD CONSTRAINT muhasebe_hesap_plani_plan_kodu_key UNIQUE (plan_kodu);
 a   ALTER TABLE ONLY public.muhasebe_hesap_plani DROP CONSTRAINT muhasebe_hesap_plani_plan_kodu_key;
       public         postgres    false    317    317                       2606    479105 '   muhasebe_hesap_plani_tek_duzen_kodu_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.muhasebe_hesap_plani
    ADD CONSTRAINT muhasebe_hesap_plani_tek_duzen_kodu_key UNIQUE (tek_duzen_kodu);
 f   ALTER TABLE ONLY public.muhasebe_hesap_plani DROP CONSTRAINT muhasebe_hesap_plani_tek_duzen_kodu_key;
       public         postgres    false    317    317                       2606    479107    musteri_temsilci_grubu_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.musteri_temsilci_grubu
    ADD CONSTRAINT musteri_temsilci_grubu_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.musteri_temsilci_grubu DROP CONSTRAINT musteri_temsilci_grubu_pkey;
       public         postgres    false    319    319                       2606    479109 ,   musteri_temsilci_grubu_temsilci_grup_adi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.musteri_temsilci_grubu
    ADD CONSTRAINT musteri_temsilci_grubu_temsilci_grup_adi_key UNIQUE (temsilci_grup_adi);
 m   ALTER TABLE ONLY public.musteri_temsilci_grubu DROP CONSTRAINT musteri_temsilci_grubu_temsilci_grup_adi_key;
       public         postgres    false    319    319                       2606    479111    olcu_birimi_birim_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.olcu_birimi
    ADD CONSTRAINT olcu_birimi_birim_key UNIQUE (birim);
 K   ALTER TABLE ONLY public.olcu_birimi DROP CONSTRAINT olcu_birimi_birim_key;
       public         postgres    false    321    321                       2606    479113    olcu_birimi_efatura_birim_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.olcu_birimi
    ADD CONSTRAINT olcu_birimi_efatura_birim_key UNIQUE (efatura_birim);
 S   ALTER TABLE ONLY public.olcu_birimi DROP CONSTRAINT olcu_birimi_efatura_birim_key;
       public         postgres    false    321    321            !           2606    479115    olcu_birimi_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.olcu_birimi
    ADD CONSTRAINT olcu_birimi_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.olcu_birimi DROP CONSTRAINT olcu_birimi_pkey;
       public         postgres    false    321    321            #           2606    479117    para_birimi_kod_ukey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.para_birimi
    ADD CONSTRAINT para_birimi_kod_ukey UNIQUE (kod);
 J   ALTER TABLE ONLY public.para_birimi DROP CONSTRAINT para_birimi_kod_ukey;
       public         postgres    false    323    323            %           2606    479119    para_birimi_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.para_birimi
    ADD CONSTRAINT para_birimi_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.para_birimi DROP CONSTRAINT para_birimi_pkey;
       public         postgres    false    323    323            '           2606    479121 !   personel_ayrilma_nedeni_tipi_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi
    ADD CONSTRAINT personel_ayrilma_nedeni_tipi_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi DROP CONSTRAINT personel_ayrilma_nedeni_tipi_pkey;
       public         postgres    false    325    325            )           2606    479123 $   personel_ayrilma_nedeni_tipi_tip_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi
    ADD CONSTRAINT personel_ayrilma_nedeni_tipi_tip_key UNIQUE (tip);
 k   ALTER TABLE ONLY public.personel_ayrilma_nedeni_tipi DROP CONSTRAINT personel_ayrilma_nedeni_tipi_tip_key;
       public         postgres    false    325    325            +           2606    479125    personel_calisma_gecmisi_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.personel_calisma_gecmisi
    ADD CONSTRAINT personel_calisma_gecmisi_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.personel_calisma_gecmisi DROP CONSTRAINT personel_calisma_gecmisi_pkey;
       public         postgres    false    327    327            -           2606    479127 +   personel_dil_bilgisi_dil_id_personel_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.personel_dil_bilgisi
    ADD CONSTRAINT personel_dil_bilgisi_dil_id_personel_id_key UNIQUE (dil_id, personel_id);
 j   ALTER TABLE ONLY public.personel_dil_bilgisi DROP CONSTRAINT personel_dil_bilgisi_dil_id_personel_id_key;
       public         postgres    false    329    329    329            /           2606    479129    personel_dil_bilgisi_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.personel_dil_bilgisi
    ADD CONSTRAINT personel_dil_bilgisi_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.personel_dil_bilgisi DROP CONSTRAINT personel_dil_bilgisi_pkey;
       public         postgres    false    329    329            1           2606    479131    personel_karti_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.personel_karti
    ADD CONSTRAINT personel_karti_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.personel_karti DROP CONSTRAINT personel_karti_pkey;
       public         postgres    false    331    331            3           2606    479133    personel_pdks_kart_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.personel_pdks_kart
    ADD CONSTRAINT personel_pdks_kart_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.personel_pdks_kart DROP CONSTRAINT personel_pdks_kart_pkey;
       public         postgres    false    333    333            5           2606    479135    personel_servis_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.personel_tasima_servis
    ADD CONSTRAINT personel_servis_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.personel_tasima_servis DROP CONSTRAINT personel_servis_pkey;
       public         postgres    false    335    335            7           2606    479137 $   personel_tasima_servis_servis_no_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.personel_tasima_servis
    ADD CONSTRAINT personel_tasima_servis_servis_no_key UNIQUE (servis_no);
 e   ALTER TABLE ONLY public.personel_tasima_servis DROP CONSTRAINT personel_tasima_servis_servis_no_key;
       public         postgres    false    335    335            9           2606    479139 *   quality_form_mail_reciever_mail_adresi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.quality_form_mail_reciever
    ADD CONSTRAINT quality_form_mail_reciever_mail_adresi_key UNIQUE (mail_adresi);
 o   ALTER TABLE ONLY public.quality_form_mail_reciever DROP CONSTRAINT quality_form_mail_reciever_mail_adresi_key;
       public         postgres    false    337    337            ;           2606    479141    quality_form_mail_reciever_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.quality_form_mail_reciever
    ADD CONSTRAINT quality_form_mail_reciever_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.quality_form_mail_reciever DROP CONSTRAINT quality_form_mail_reciever_pkey;
       public         postgres    false    337    337            A           2606    479143    recete_hammadde_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.recete_hammadde DROP CONSTRAINT recete_hammadde_pkey;
       public         postgres    false    340    340            C           2606    479145 '   recete_hammadde_stok_kodu_header_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_stok_kodu_header_id_key UNIQUE (stok_kodu, header_id);
 a   ALTER TABLE ONLY public.recete_hammadde DROP CONSTRAINT recete_hammadde_stok_kodu_header_id_key;
       public         postgres    false    340    340    340            =           2606    479147    recete_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.recete DROP CONSTRAINT recete_pkey;
       public         postgres    false    339    339            ?           2606    479149    recete_recete_adi_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_recete_adi_key UNIQUE (recete_adi);
 F   ALTER TABLE ONLY public.recete DROP CONSTRAINT recete_recete_adi_key;
       public         postgres    false    339    339            G           2606    479151    satis_fatura_detay_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.satis_fatura_detay
    ADD CONSTRAINT satis_fatura_detay_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.satis_fatura_detay DROP CONSTRAINT satis_fatura_detay_pkey;
       public         postgres    false    344    344            E           2606    479153    satis_fatura_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.satis_fatura
    ADD CONSTRAINT satis_fatura_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.satis_fatura DROP CONSTRAINT satis_fatura_pkey;
       public         postgres    false    343    343            K           2606    479155    satis_irsaliye_detay_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.satis_irsaliye_detay
    ADD CONSTRAINT satis_irsaliye_detay_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.satis_irsaliye_detay DROP CONSTRAINT satis_irsaliye_detay_pkey;
       public         postgres    false    348    348            I           2606    479157    satis_irsaliye_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.satis_irsaliye
    ADD CONSTRAINT satis_irsaliye_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.satis_irsaliye DROP CONSTRAINT satis_irsaliye_pkey;
       public         postgres    false    347    347            O           2606    479159    satis_siparis_detay_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.satis_siparis_detay
    ADD CONSTRAINT satis_siparis_detay_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.satis_siparis_detay DROP CONSTRAINT satis_siparis_detay_pkey;
       public         postgres    false    352    352            M           2606    479161    satis_siparis_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.satis_siparis
    ADD CONSTRAINT satis_siparis_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.satis_siparis DROP CONSTRAINT satis_siparis_pkey;
       public         postgres    false    351    351            S           2606    479163    satis_teklif_detay_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.satis_teklif_detay
    ADD CONSTRAINT satis_teklif_detay_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.satis_teklif_detay DROP CONSTRAINT satis_teklif_detay_pkey;
       public         postgres    false    356    356            Q           2606    479165    satis_teklif_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_pkey;
       public         postgres    false    355    355            U           2606    479167 
   sehir_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.sehir DROP CONSTRAINT sehir_pkey;
       public         postgres    false    359    359            W           2606    479169    stok_grubu_grup_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.stok_grubu
    ADD CONSTRAINT stok_grubu_grup_key UNIQUE (grup);
 H   ALTER TABLE ONLY public.stok_grubu DROP CONSTRAINT stok_grubu_grup_key;
       public         postgres    false    361    361            Y           2606    479171    stok_grubu_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.stok_grubu
    ADD CONSTRAINT stok_grubu_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.stok_grubu DROP CONSTRAINT stok_grubu_pkey;
       public         postgres    false    361    361            [           2606    479173    stok_grubu_turu_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.stok_grubu_turu
    ADD CONSTRAINT stok_grubu_turu_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.stok_grubu_turu DROP CONSTRAINT stok_grubu_turu_pkey;
       public         postgres    false    363    363            ]           2606    479175    stok_grubu_turu_tur_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.stok_grubu_turu
    ADD CONSTRAINT stok_grubu_turu_tur_key UNIQUE (tur);
 Q   ALTER TABLE ONLY public.stok_grubu_turu DROP CONSTRAINT stok_grubu_turu_tur_key;
       public         postgres    false    363    363            _           2606    479177    stok_hareketi_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.stok_hareketi
    ADD CONSTRAINT stok_hareketi_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.stok_hareketi DROP CONSTRAINT stok_hareketi_pkey;
       public         postgres    false    365    365            a           2606    479179    stok_karti_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.stok_karti
    ADD CONSTRAINT stok_karti_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.stok_karti DROP CONSTRAINT stok_karti_pkey;
       public         postgres    false    367    367            c           2606    479181    stok_karti_stok_kodu_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.stok_karti
    ADD CONSTRAINT stok_karti_stok_kodu_key UNIQUE (stok_kodu);
 M   ALTER TABLE ONLY public.stok_karti DROP CONSTRAINT stok_karti_stok_kodu_key;
       public         postgres    false    367    367            e           2606    479183    stok_tipi_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.stok_tipi DROP CONSTRAINT stok_tipi_pkey;
       public         postgres    false    369    369            g           2606    479185    stok_tipi_tip_is_default_key 
   CONSTRAINT     l   ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_tip_is_default_key UNIQUE (tip, is_default);
 P   ALTER TABLE ONLY public.stok_tipi DROP CONSTRAINT stok_tipi_tip_is_default_key;
       public         postgres    false    369    369    369            i           2606    479187    stok_tipi_tip_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_tip_key UNIQUE (tip);
 E   ALTER TABLE ONLY public.stok_tipi DROP CONSTRAINT stok_tipi_tip_key;
       public         postgres    false    369    369            m           2606    479189 #   sys_application_settings_other_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_application_settings_other
    ADD CONSTRAINT sys_application_settings_other_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.sys_application_settings_other DROP CONSTRAINT sys_application_settings_other_pkey;
       public         postgres    false    373    373            k           2606    479191    sys_application_settings_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.sys_application_settings
    ADD CONSTRAINT sys_application_settings_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.sys_application_settings DROP CONSTRAINT sys_application_settings_pkey;
       public         postgres    false    371    371            o           2606    479193    sys_grid_col_color_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.sys_grid_col_color
    ADD CONSTRAINT sys_grid_col_color_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.sys_grid_col_color DROP CONSTRAINT sys_grid_col_color_pkey;
       public         postgres    false    375    375            q           2606    479195 -   sys_grid_col_color_table_name_column_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_grid_col_color
    ADD CONSTRAINT sys_grid_col_color_table_name_column_name_key UNIQUE (table_name, column_name);
 j   ALTER TABLE ONLY public.sys_grid_col_color DROP CONSTRAINT sys_grid_col_color_table_name_column_name_key;
       public         postgres    false    375    375    375            s           2606    479197    sys_grid_col_percent_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sys_grid_col_percent
    ADD CONSTRAINT sys_grid_col_percent_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sys_grid_col_percent DROP CONSTRAINT sys_grid_col_percent_pkey;
       public         postgres    false    377    377            u           2606    479199 /   sys_grid_col_percent_table_name_column_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_grid_col_percent
    ADD CONSTRAINT sys_grid_col_percent_table_name_column_name_key UNIQUE (table_name, column_name);
 n   ALTER TABLE ONLY public.sys_grid_col_percent DROP CONSTRAINT sys_grid_col_percent_table_name_column_name_key;
       public         postgres    false    377    377    377            w           2606    479201    sys_grid_col_width_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.sys_grid_col_width
    ADD CONSTRAINT sys_grid_col_width_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.sys_grid_col_width DROP CONSTRAINT sys_grid_col_width_pkey;
       public         postgres    false    379    379            y           2606    479203 -   sys_grid_col_width_table_name_column_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_grid_col_width
    ADD CONSTRAINT sys_grid_col_width_table_name_column_name_key UNIQUE (table_name, column_name);
 j   ALTER TABLE ONLY public.sys_grid_col_width DROP CONSTRAINT sys_grid_col_width_table_name_column_name_key;
       public         postgres    false    379    379    379            {           2606    479205 -   sys_grid_col_width_table_name_sequence_no_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_grid_col_width
    ADD CONSTRAINT sys_grid_col_width_table_name_sequence_no_key UNIQUE (table_name, sequence_no);
 j   ALTER TABLE ONLY public.sys_grid_col_width DROP CONSTRAINT sys_grid_col_width_table_name_sequence_no_key;
       public         postgres    false    379    379    379            }           2606    479207 .   sys_grid_default_order_filter_key_is_order_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_grid_default_order_filter
    ADD CONSTRAINT sys_grid_default_order_filter_key_is_order_key UNIQUE (key, is_order);
 v   ALTER TABLE ONLY public.sys_grid_default_order_filter DROP CONSTRAINT sys_grid_default_order_filter_key_is_order_key;
       public         postgres    false    381    381    381                       2606    479209 "   sys_grid_default_order_filter_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sys_grid_default_order_filter
    ADD CONSTRAINT sys_grid_default_order_filter_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.sys_grid_default_order_filter DROP CONSTRAINT sys_grid_default_order_filter_pkey;
       public         postgres    false    381    381            �           2606    479211 <   sys_lang_data_content_lang_table_name_column_name_row_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_lang_data_content
    ADD CONSTRAINT sys_lang_data_content_lang_table_name_column_name_row_id_key UNIQUE (lang, table_name, column_name, row_id);
 |   ALTER TABLE ONLY public.sys_lang_data_content DROP CONSTRAINT sys_lang_data_content_lang_table_name_column_name_row_id_key;
       public         postgres    false    384    384    384    384    384            �           2606    479213    sys_lang_data_content_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sys_lang_data_content
    ADD CONSTRAINT sys_lang_data_content_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sys_lang_data_content DROP CONSTRAINT sys_lang_data_content_pkey;
       public         postgres    false    384    384            �           2606    479215 :   sys_lang_gui_content_lang_code_content_type_table_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_lang_gui_content
    ADD CONSTRAINT sys_lang_gui_content_lang_code_content_type_table_name_key UNIQUE (lang, code, content_type, table_name);
 y   ALTER TABLE ONLY public.sys_lang_gui_content DROP CONSTRAINT sys_lang_gui_content_lang_code_content_type_table_name_key;
       public         postgres    false    386    386    386    386    386            �           2606    479217    sys_lang_gui_content_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sys_lang_gui_content
    ADD CONSTRAINT sys_lang_gui_content_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sys_lang_gui_content DROP CONSTRAINT sys_lang_gui_content_pkey;
       public         postgres    false    386    386            �           2606    479219    sys_lang_language_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.sys_lang
    ADD CONSTRAINT sys_lang_language_key UNIQUE (language);
 H   ALTER TABLE ONLY public.sys_lang DROP CONSTRAINT sys_lang_language_key;
       public         postgres    false    383    383            �           2606    479221    sys_lang_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sys_lang
    ADD CONSTRAINT sys_lang_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sys_lang DROP CONSTRAINT sys_lang_pkey;
       public         postgres    false    383    383            �           2606    479223 #   sys_multi_lang_data_table_list_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_multi_lang_data_table_list
    ADD CONSTRAINT sys_multi_lang_data_table_list_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.sys_multi_lang_data_table_list DROP CONSTRAINT sys_multi_lang_data_table_list_pkey;
       public         postgres    false    389    389            �           2606    479225 -   sys_multi_lang_data_table_list_table_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_multi_lang_data_table_list
    ADD CONSTRAINT sys_multi_lang_data_table_list_table_name_key UNIQUE (table_name);
 v   ALTER TABLE ONLY public.sys_multi_lang_data_table_list DROP CONSTRAINT sys_multi_lang_data_table_list_table_name_key;
       public         postgres    false    389    389            �           2606    479227 #   sys_permission_source_group_id_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.sys_permission_source_group
    ADD CONSTRAINT sys_permission_source_group_id_pkey PRIMARY KEY (id);
 i   ALTER TABLE ONLY public.sys_permission_source_group DROP CONSTRAINT sys_permission_source_group_id_pkey;
       public         postgres    false    392    392            �           2606    479229 -   sys_permission_source_group_source_group_ukey 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_permission_source_group
    ADD CONSTRAINT sys_permission_source_group_source_group_ukey UNIQUE (source_group);
 s   ALTER TABLE ONLY public.sys_permission_source_group DROP CONSTRAINT sys_permission_source_group_source_group_ukey;
       public         postgres    false    392    392            �           2606    479231    sys_permission_source_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT sys_permission_source_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sys_permission_source DROP CONSTRAINT sys_permission_source_pkey;
       public         postgres    false    391    391            �           2606    479233 %   sys_permission_source_source_code_key 
   CONSTRAINT     }   ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT sys_permission_source_source_code_key UNIQUE (source_code);
 e   ALTER TABLE ONLY public.sys_permission_source DROP CONSTRAINT sys_permission_source_source_code_key;
       public         postgres    false    391    391            �           2606    479235    sys_quality_form_number_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.sys_quality_form_number
    ADD CONSTRAINT sys_quality_form_number_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.sys_quality_form_number DROP CONSTRAINT sys_quality_form_number_pkey;
       public         postgres    false    395    395            �           2606    479237 4   sys_quality_form_number_table_name_is_input_form_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_quality_form_number
    ADD CONSTRAINT sys_quality_form_number_table_name_is_input_form_key UNIQUE (table_name, is_input_form);
 v   ALTER TABLE ONLY public.sys_quality_form_number DROP CONSTRAINT sys_quality_form_number_table_name_is_input_form_key;
       public         postgres    false    395    395    395            �           2606    479239    sys_user_access_right_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sys_user_access_right DROP CONSTRAINT sys_user_access_right_pkey;
       public         postgres    false    398    398            �           2606    479241 /   sys_user_access_right_source_code_user_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_source_code_user_name_key UNIQUE (source_code, user_name);
 o   ALTER TABLE ONLY public.sys_user_access_right DROP CONSTRAINT sys_user_access_right_source_code_user_name_key;
       public         postgres    false    398    398    398            �           2606    479243 #   sys_user_mac_address_exception_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_user_mac_address_exception
    ADD CONSTRAINT sys_user_mac_address_exception_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.sys_user_mac_address_exception DROP CONSTRAINT sys_user_mac_address_exception_pkey;
       public         postgres    false    401    401            �           2606    479245 7   sys_user_mac_address_exception_user_name_ip_address_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.sys_user_mac_address_exception
    ADD CONSTRAINT sys_user_mac_address_exception_user_name_ip_address_key UNIQUE (user_name, ip_address);
 �   ALTER TABLE ONLY public.sys_user_mac_address_exception DROP CONSTRAINT sys_user_mac_address_exception_user_name_ip_address_key;
       public         postgres    false    401    401    401            �           2606    479247    sys_user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sys_user DROP CONSTRAINT sys_user_pkey;
       public         postgres    false    397    397            �           2606    479249    sys_user_user_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_user_name_key UNIQUE (user_name);
 I   ALTER TABLE ONLY public.sys_user DROP CONSTRAINT sys_user_user_name_key;
       public         postgres    false    397    397            �           2606    479251 	   ulke_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.ulke DROP CONSTRAINT ulke_pkey;
       public         postgres    false    406    406            �           2606    479253    ulke_ulke_adi_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_ulke_adi_key UNIQUE (ulke_adi);
 @   ALTER TABLE ONLY public.ulke DROP CONSTRAINT ulke_ulke_adi_key;
       public         postgres    false    406    406            �           2606    479255    ulke_ulke_kodu_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_ulke_kodu_key UNIQUE (ulke_kodu);
 A   ALTER TABLE ONLY public.ulke DROP CONSTRAINT ulke_ulke_kodu_key;
       public         postgres    false    406    406            �           2606    479257    urun_kabul_red_nedeni_deger_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.urun_kabul_red_nedeni
    ADD CONSTRAINT urun_kabul_red_nedeni_deger_key UNIQUE (deger);
 _   ALTER TABLE ONLY public.urun_kabul_red_nedeni DROP CONSTRAINT urun_kabul_red_nedeni_deger_key;
       public         postgres    false    408    408            �           2606    479259    urun_kabul_red_nedeni_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.urun_kabul_red_nedeni
    ADD CONSTRAINT urun_kabul_red_nedeni_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.urun_kabul_red_nedeni DROP CONSTRAINT urun_kabul_red_nedeni_pkey;
       public         postgres    false    408    408            .           2620    479260    audit    TRIGGER     }   CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.cins_ozelligi FOR EACH ROW EXECUTE PROCEDURE public.audit();
 ,   DROP TRIGGER audit ON public.cins_ozelligi;
       public       postgres    false    502    305            1           2620    479261    audit    TRIGGER     �   CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.urun_kabul_red_nedeni FOR EACH ROW EXECUTE PROCEDURE public.audit();
 4   DROP TRIGGER audit ON public.urun_kabul_red_nedeni;
       public       postgres    false    502    408            /           2620    479262    audit    TRIGGER        CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.stok_grubu_turu FOR EACH ROW EXECUTE PROCEDURE public.audit();
 .   DROP TRIGGER audit ON public.stok_grubu_turu;
       public       postgres    false    502    363            )           2620    479263    audit    TRIGGER     �   CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.ayar_barkod_hazirlik_dosya_turu FOR EACH ROW EXECUTE PROCEDURE public.audit();
 >   DROP TRIGGER audit ON public.ayar_barkod_hazirlik_dosya_turu;
       public       postgres    false    191    502            +           2620    479264    audit    TRIGGER     �   CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.ayar_barkod_tezgah FOR EACH ROW EXECUTE PROCEDURE public.audit();
 1   DROP TRIGGER audit ON public.ayar_barkod_tezgah;
       public       postgres    false    195    502            ,           2620    479265    audit    TRIGGER     �   CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.ayar_barkod_urun_turu FOR EACH ROW EXECUTE PROCEDURE public.audit();
 4   DROP TRIGGER audit ON public.ayar_barkod_urun_turu;
       public       postgres    false    197    502            *           2620    479266    audit    TRIGGER     �   CREATE TRIGGER audit AFTER INSERT OR DELETE OR UPDATE ON public.ayar_barkod_serino_turu FOR EACH ROW EXECUTE PROCEDURE public.audit();
 6   DROP TRIGGER audit ON public.ayar_barkod_serino_turu;
       public       postgres    false    502    193            -           2620    479270    delete_table_lang_content    TRIGGER     �   CREATE TRIGGER delete_table_lang_content AFTER DELETE ON public.ayar_stok_hareket_tipi FOR EACH ROW EXECUTE PROCEDURE public.delete_table_lang_content();
 I   DROP TRIGGER delete_table_lang_content ON public.ayar_stok_hareket_tipi;
       public       postgres    false    504    281            2           2620    820666    delete_table_lang_content    TRIGGER     �   CREATE TRIGGER delete_table_lang_content AFTER DELETE ON public.ayar_prs_gorev FOR EACH ROW EXECUTE PROCEDURE public.delete_table_lang_content();
 A   DROP TRIGGER delete_table_lang_content ON public.ayar_prs_gorev;
       public       postgres    false    432    504            3           2620    820755    delete_table_lang_content    TRIGGER     �   CREATE TRIGGER delete_table_lang_content AFTER DELETE ON public.ayar_prs_bolum FOR EACH ROW EXECUTE PROCEDURE public.delete_table_lang_content();
 A   DROP TRIGGER delete_table_lang_content ON public.ayar_prs_bolum;
       public       postgres    false    504    444            4           2620    820781    delete_table_lang_content    TRIGGER     �   CREATE TRIGGER delete_table_lang_content AFTER DELETE ON public.ayar_prs_birim FOR EACH ROW EXECUTE PROCEDURE public.delete_table_lang_content();
 A   DROP TRIGGER delete_table_lang_content ON public.ayar_prs_birim;
       public       postgres    false    504    446            0           2620    479271    sys_grid_col_width_table_notify    TRIGGER     �   CREATE TRIGGER sys_grid_col_width_table_notify AFTER INSERT OR DELETE OR UPDATE ON public.sys_grid_col_width FOR EACH ROW EXECUTE PROCEDURE public.table_notify();
 K   DROP TRIGGER sys_grid_col_width_table_notify ON public.sys_grid_col_width;
       public       postgres    false    511    379            �           2606    479272    adres_sehir_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_sehir_id_fkey FOREIGN KEY (sehir_id) REFERENCES public.sehir(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 C   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_sehir_id_fkey;
       public       postgres    false    359    3669    183            �           2606    479277    adres_ulke_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_ulke_id_fkey FOREIGN KEY (ulke_id) REFERENCES public.ulke(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 B   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_ulke_id_fkey;
       public       postgres    false    183    3753    406                        2606    479282     alis_teklif_detay_header_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.alis_teklif_detay
    ADD CONSTRAINT alis_teklif_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.alis_teklif(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.alis_teklif_detay DROP CONSTRAINT alis_teklif_detay_header_id_fkey;
       public       postgres    false    186    185    3349                       2606    479292     ayar_barkod_tezgah_ambar_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_barkod_tezgah
    ADD CONSTRAINT ayar_barkod_tezgah_ambar_id_fkey FOREIGN KEY (ambar_id) REFERENCES public.ambar(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public.ayar_barkod_tezgah DROP CONSTRAINT ayar_barkod_tezgah_ambar_id_fkey;
       public       postgres    false    195    3355    189                       2606    479297 1   ayar_efatura_evrak_tipi_cinsi_evrak_cinsi_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi
    ADD CONSTRAINT ayar_efatura_evrak_tipi_cinsi_evrak_cinsi_id_fkey FOREIGN KEY (evrak_cinsi_id) REFERENCES public.ayar_efatura_evrak_cinsi(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 y   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi DROP CONSTRAINT ayar_efatura_evrak_tipi_cinsi_evrak_cinsi_id_fkey;
       public       postgres    false    213    3401    216                       2606    479302 0   ayar_efatura_evrak_tipi_cinsi_evrak_tipi_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi
    ADD CONSTRAINT ayar_efatura_evrak_tipi_cinsi_evrak_tipi_id_fkey FOREIGN KEY (evrak_tipi_id) REFERENCES public.ayar_efatura_evrak_tipi(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 x   ALTER TABLE ONLY public.ayar_efatura_evrak_tipi_cinsi DROP CONSTRAINT ayar_efatura_evrak_tipi_cinsi_evrak_tipi_id_fkey;
       public       postgres    false    3405    215    216                       2606    479307 ,   ayar_efatura_istisna_kodu_fatura_tip_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_efatura_istisna_kodu
    ADD CONSTRAINT ayar_efatura_istisna_kodu_fatura_tip_id_fkey FOREIGN KEY (fatura_tip_id) REFERENCES public.ayar_efatura_fatura_tipi(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 p   ALTER TABLE ONLY public.ayar_efatura_istisna_kodu DROP CONSTRAINT ayar_efatura_istisna_kodu_fatura_tip_id_fkey;
       public       postgres    false    3411    219    229                       2606    479312 )   ayar_fatura_no_serisi_fatura_seri_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_fatura_no_serisi
    ADD CONSTRAINT ayar_fatura_no_serisi_fatura_seri_id_fkey FOREIGN KEY (fatura_seri_id) REFERENCES public.ayar_irsaliye_fatura_no_serisi(id) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.ayar_fatura_no_serisi DROP CONSTRAINT ayar_fatura_no_serisi_fatura_seri_id_fkey;
       public       postgres    false    247    3495    261                       2606    479317 "   ayar_firma_tipi_firma_turu_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_firma_tipi
    ADD CONSTRAINT ayar_firma_tipi_firma_turu_id_fkey FOREIGN KEY (firma_turu_id) REFERENCES public.ayar_firma_turu(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 \   ALTER TABLE ONLY public.ayar_firma_tipi DROP CONSTRAINT ayar_firma_tipi_firma_turu_id_fkey;
       public       postgres    false    249    251    3471                       2606    479322 -   ayar_irsaliye_no_serisi_irsaliye_seri_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi
    ADD CONSTRAINT ayar_irsaliye_no_serisi_irsaliye_seri_id_fkey FOREIGN KEY (irsaliye_seri_id) REFERENCES public.ayar_irsaliye_fatura_no_serisi(id) ON UPDATE CASCADE ON DELETE CASCADE;
 o   ALTER TABLE ONLY public.ayar_irsaliye_no_serisi DROP CONSTRAINT ayar_irsaliye_no_serisi_irsaliye_seri_id_fkey;
       public       postgres    false    261    3495    263            (           2606    820776    ayar_prs_birim_bolum_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_prs_birim
    ADD CONSTRAINT ayar_prs_birim_bolum_id_fkey FOREIGN KEY (bolum_id) REFERENCES public.ayar_prs_bolum(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public.ayar_prs_birim DROP CONSTRAINT ayar_prs_birim_bolum_id_fkey;
       public       postgres    false    3829    446    444                       2606    479332 (   ayar_stok_hareket_ayari_cikis_ayari_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_stok_hareket_ayari
    ADD CONSTRAINT ayar_stok_hareket_ayari_cikis_ayari_fkey FOREIGN KEY (cikis_ayari) REFERENCES public.ayar_modul_tipi(deger) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.ayar_stok_hareket_ayari DROP CONSTRAINT ayar_stok_hareket_ayari_cikis_ayari_fkey;
       public       postgres    false    265    3501    279            	           2606    479337 (   ayar_stok_hareket_ayari_giris_ayari_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ayar_stok_hareket_ayari
    ADD CONSTRAINT ayar_stok_hareket_ayari_giris_ayari_fkey FOREIGN KEY (giris_ayari) REFERENCES public.ayar_modul_tipi(deger) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.ayar_stok_hareket_ayari DROP CONSTRAINT ayar_stok_hareket_ayari_giris_ayari_fkey;
       public       postgres    false    279    3501    265            
           2606    479342    banka_subesi_banka_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.banka_subesi
    ADD CONSTRAINT banka_subesi_banka_id_fkey FOREIGN KEY (banka_id) REFERENCES public.banka(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.banka_subesi DROP CONSTRAINT banka_subesi_banka_id_fkey;
       public       postgres    false    291    289    3551                       2606    479347    banka_subesi_sube_il_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.banka_subesi
    ADD CONSTRAINT banka_subesi_sube_il_id_fkey FOREIGN KEY (sube_il_id) REFERENCES public.sehir(id) ON UPDATE CASCADE;
 S   ALTER TABLE ONLY public.banka_subesi DROP CONSTRAINT banka_subesi_sube_il_id_fkey;
       public       postgres    false    359    3669    291                       2606    479352    barkod_tezgah_ambar_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.barkod_tezgah
    ADD CONSTRAINT barkod_tezgah_ambar_id_fkey FOREIGN KEY (ambar_id) REFERENCES public.ambar(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.barkod_tezgah DROP CONSTRAINT barkod_tezgah_ambar_id_fkey;
       public       postgres    false    297    189    3355                       2606    479357    cins_ozelligi_cins_aile_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cins_ozelligi
    ADD CONSTRAINT cins_ozelligi_cins_aile_id_fkey FOREIGN KEY (cins_aile_id) REFERENCES public.cins_ailesi(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public.cins_ozelligi DROP CONSTRAINT cins_ozelligi_cins_aile_id_fkey;
       public       postgres    false    305    303    3577                       2606    479362    doviz_kuru_para_birimi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.doviz_kuru
    ADD CONSTRAINT doviz_kuru_para_birimi_fkey FOREIGN KEY (para_birimi) REFERENCES public.para_birimi(kod) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public.doviz_kuru DROP CONSTRAINT doviz_kuru_para_birimi_fkey;
       public       postgres    false    3619    309    323                       2606    891026    personel_karti_adres_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.personel_karti
    ADD CONSTRAINT personel_karti_adres_id_fkey FOREIGN KEY (adres_id) REFERENCES public.adres(id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.personel_karti DROP CONSTRAINT personel_karti_adres_id_fkey;
       public       postgres    false    3347    331    183                       2606    479367    recete_hammadde_header_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.recete(id) ON UPDATE RESTRICT ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.recete_hammadde DROP CONSTRAINT recete_hammadde_header_id_fkey;
       public       postgres    false    339    340    3645                       2606    479372    recete_hammadde_recete_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.recete_hammadde
    ADD CONSTRAINT recete_hammadde_recete_id_fkey FOREIGN KEY (recete_id) REFERENCES public.recete(id) ON UPDATE CASCADE ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.recete_hammadde DROP CONSTRAINT recete_hammadde_recete_id_fkey;
       public       postgres    false    339    340    3645                       2606    479377 !   satis_fatura_detay_header_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_fatura_detay
    ADD CONSTRAINT satis_fatura_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_fatura(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.satis_fatura_detay DROP CONSTRAINT satis_fatura_detay_header_id_fkey;
       public       postgres    false    343    344    3653                       2606    479382 #   satis_irsaliye_detay_header_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_irsaliye_detay
    ADD CONSTRAINT satis_irsaliye_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_irsaliye(id) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.satis_irsaliye_detay DROP CONSTRAINT satis_irsaliye_detay_header_id_fkey;
       public       postgres    false    348    3657    347                       2606    479387 "   satis_siparis_detay_header_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_siparis_detay
    ADD CONSTRAINT satis_siparis_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_siparis(id) ON UPDATE CASCADE ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.satis_siparis_detay DROP CONSTRAINT satis_siparis_detay_header_id_fkey;
       public       postgres    false    352    351    3661                       2606    479392 !   satis_teklif_detay_header_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif_detay
    ADD CONSTRAINT satis_teklif_detay_header_id_fkey FOREIGN KEY (header_id) REFERENCES public.satis_teklif(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.satis_teklif_detay DROP CONSTRAINT satis_teklif_detay_header_id_fkey;
       public       postgres    false    355    356    3665                       2606    479397    satis_teklif_fatura_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_fatura_id_fkey FOREIGN KEY (fatura_id) REFERENCES public.satis_fatura(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_fatura_id_fkey;
       public       postgres    false    343    355    3653                       2606    479402 #   satis_teklif_gonderim_sekli_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_gonderim_sekli_id_fkey FOREIGN KEY (gonderim_sekli_id) REFERENCES public.ayar_efatura_gonderim_sekli(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Z   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_gonderim_sekli_id_fkey;
       public       postgres    false    3419    355    223                       2606    479407 "   satis_teklif_ihrac_kayit_kodu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_ihrac_kayit_kodu_fkey FOREIGN KEY (ihrac_kayit_kodu) REFERENCES public.ayar_efatura_ihrac_kayitli_fatura_sebebi(kod) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_ihrac_kayit_kodu_fkey;
       public       postgres    false    225    3421    355                       2606    479412    satis_teklif_irsaliye_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_irsaliye_id_fkey FOREIGN KEY (irsaliye_id) REFERENCES public.satis_irsaliye(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 T   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_irsaliye_id_fkey;
       public       postgres    false    355    347    3657                       2606    479417    satis_teklif_islem_tipi_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_islem_tipi_id_fkey FOREIGN KEY (islem_tipi_id) REFERENCES public.ayar_efatura_fatura_tipi(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_islem_tipi_id_fkey;
       public       postgres    false    219    355    3411                       2606    479422     satis_teklif_odeme_sekli_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_odeme_sekli_id_fkey FOREIGN KEY (odeme_sekli_id) REFERENCES public.ayar_efatura_odeme_sekli(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_odeme_sekli_id_fkey;
       public       postgres    false    233    355    3437                       2606    479427    satis_teklif_para_birimi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_para_birimi_fkey FOREIGN KEY (para_birimi) REFERENCES public.para_birimi(kod) ON UPDATE CASCADE ON DELETE RESTRICT;
 T   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_para_birimi_fkey;
       public       postgres    false    3619    323    355                       2606    479432    satis_teklif_siparis_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_siparis_id_fkey FOREIGN KEY (siparis_id) REFERENCES public.satis_siparis(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_siparis_id_fkey;
       public       postgres    false    351    355    3661                       2606    479437 !   satis_teklif_teklif_durum_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_teklif_durum_id_fkey FOREIGN KEY (teklif_durum_id) REFERENCES public.ayar_teklif_durum(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_teklif_durum_id_fkey;
       public       postgres    false    3539    355    283                       2606    479442 !   satis_teklif_teslim_sarti_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.satis_teklif
    ADD CONSTRAINT satis_teklif_teslim_sarti_id_fkey FOREIGN KEY (teslim_sarti_id) REFERENCES public.ayar_efatura_teslim_sarti(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.satis_teklif DROP CONSTRAINT satis_teklif_teslim_sarti_id_fkey;
       public       postgres    false    355    3453    241                        2606    479447    sehir_ulke_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_ulke_id_fkey FOREIGN KEY (ulke_id) REFERENCES public.ulke(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 B   ALTER TABLE ONLY public.sehir DROP CONSTRAINT sehir_ulke_id_fkey;
       public       postgres    false    359    3753    406            !           2606    479452    stok_tipi_tip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.stok_tipi
    ADD CONSTRAINT stok_tipi_tip_fkey FOREIGN KEY (tip) REFERENCES public.stok_tipi(tip) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.stok_tipi DROP CONSTRAINT stok_tipi_tip_fkey;
       public       postgres    false    369    3689    369            "           2606    479457 -   sys_application_settings_system_language_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sys_application_settings
    ADD CONSTRAINT sys_application_settings_system_language_fkey FOREIGN KEY (sistem_dili) REFERENCES public.sys_lang(language) ON UPDATE CASCADE ON DELETE RESTRICT;
 p   ALTER TABLE ONLY public.sys_application_settings DROP CONSTRAINT sys_application_settings_system_language_fkey;
       public       postgres    false    383    371    3713            #           2606    479462    sys_lang_gui_content_lang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sys_lang_gui_content
    ADD CONSTRAINT sys_lang_gui_content_lang_fkey FOREIGN KEY (lang) REFERENCES public.sys_lang(language) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public.sys_lang_gui_content DROP CONSTRAINT sys_lang_gui_content_lang_fkey;
       public       postgres    false    386    3713    383            $           2606    479467 6   sys_permission_source_sys_permission_source_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sys_permission_source
    ADD CONSTRAINT sys_permission_source_sys_permission_source_group_fkey FOREIGN KEY (source_group_id) REFERENCES public.sys_permission_source_group(id) ON UPDATE CASCADE ON DELETE CASCADE;
 v   ALTER TABLE ONLY public.sys_permission_source DROP CONSTRAINT sys_permission_source_sys_permission_source_group_fkey;
       public       postgres    false    392    391    3733            %           2606    479472 &   sys_user_access_right_source_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_source_code_fkey FOREIGN KEY (source_code) REFERENCES public.sys_permission_source(source_code) ON UPDATE CASCADE ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.sys_user_access_right DROP CONSTRAINT sys_user_access_right_source_code_fkey;
       public       postgres    false    3731    391    398            &           2606    479477 "   sys_user_access_right_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sys_user_access_right
    ADD CONSTRAINT sys_user_access_right_user_id_fkey FOREIGN KEY (user_name) REFERENCES public.sys_user(user_name) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.sys_user_access_right DROP CONSTRAINT sys_user_access_right_user_id_fkey;
       public       postgres    false    397    398    3743            '           2606    479482 -   sys_user_mac_address_exception_user_name_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sys_user_mac_address_exception
    ADD CONSTRAINT sys_user_mac_address_exception_user_name_fkey FOREIGN KEY (user_name) REFERENCES public.sys_user(user_name) ON UPDATE CASCADE ON DELETE CASCADE;
 v   ALTER TABLE ONLY public.sys_user_mac_address_exception DROP CONSTRAINT sys_user_mac_address_exception_user_name_fkey;
       public       postgres    false    3743    401    397            �      x������ � �      �      x������ � �      �      x������ � �      �   )   x�3�,�tq�Ri�i\F@���)��oG� P(F��� �	      �   E   x�3�,�tr>�!D��1�3���[��?8�1ؓ�(�������rd�#��G'L�=... 
�      �      x�3�,�400s�ttQ�v
����� 8v      �       x�3�,��vvQ���q��4����� E�      �   $   x�3�,��u�=<Ǉ���p��utqq����� r��      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   O   x��K
�0�u�0���o4�!Q!�cx��U��\�J�`��AÕd�bj��?o>��wja��V,\o�,x; ?>�      �      x������ � �      �      x������ � �      �      x������ � �      �   �  x�}T�n�0<s�bOEr1�9�6�(�m�blzQ$:&bI-E7�_�#�a�2u�m��ݝ١�3,��X�j����T[���0������6c-���3�MX$>	lJ�����S��Lj�m+u��Z�P��Nbv;�8���sWH�8����]j�����e0r'��i���J������7��#x�Hݺ3�����6�U�o�~�����	zâ�+T��߶]k���l�j�y�v��I�#<�#��=����A[L��䘳� �A6��ń�1V;�B�m��3ݙ��v��;A2����ku��X��{�VOx���OQ���>��;q��b0<;ò���{�t��o���0K��G�N�ܮ����C���{�{e�6��K�<j�c����9^	�5O�$h�c�������c'�"�},����(��H4�l��>.���7��|:cS��x2����v0ZU���|�悹���7+�0�,�P} �C�-�{	1�F,�zc/��D)�YVV��[�9���Rkb�vTB2����I�"�}RR�bj3��:WT�����^�u��ኞU����=xE�7�}�P6>�+JRi���Jb�H���/�Q��J,�])�si�b���eCHb��6)0�X��E�9_�^�s�t��g<O_�g�H�w���Z#�90ec��Z��ʂ�.S\�F�%� �Y����k\/���Ʉ� �'��rU      �   �  x��Y�RI]�_�K������m���a�#�Y���H׋ȪRDiջ��^�4Ko��+v?�_2���zH`�^LL��mD�}�=�>�u��u��'NW�Q��7b������u,�c9Y߉K�p��+e"�_n#G�tf����$�ߓ�B�o��]����Q�iV�H\I3]߱��g�ٖ����4��LH�+}���u(��@�[Y��8-LGҬ����9�! F�d}�D�����8�!t_/c���ȝX߱	=6�oM�:��X.��|�8�g��\�p�D\�,��E�L���ӄ�5k賆�Հs��B͎D�3�c{k���t+�Y���96:�](6�L�=�W_�Rѽ�B�,䐄�ߑ6�z��UW�Rm���k���]��$lY��$V�$��#+	eJ�q��ɥ8+d#�<�m�:���&�1��D�(��H��Y���m�nR�h�)�
/�������)� ���E����8YW���EQ"��B�5�V#�Pf�������S�^�#[�������^�$F�)��y�I���S�I9�N�D6�Pp��ӊcy=+�e�^�l��R7�dJ�r���pSK�ǣФI�[#���F�g����]�T/��@��֜��xq��PD	hڜN��3�Q���^gҘb�d_LIA�����"&�ЊH�a2g�P�0;%���2+�D��)p������58i=��[0�Q�C*N��fu��$7�&ev!z�YO4 B�R\)C2����3]K\ �\�/�YN��d��H.�&m�#�s����K�pM/~>#=�-��B�`��D�\�X\�q�˪�(Ů��8��6��ΥW�e�E�s�aL�q�{�*T^�����L5' 3�-��B% ����_��[)��R^_��s;��X���
� ��R�I��(h��p&V�hj3�fYc���Fb R��fUa�P&�0�4�x�L�H�V	���z�sV3����X�~#V;��%���D/��:�|�B�e*L������rq����(+{�A��ַ�!��!�+���t��d�5�A�rH�BX���Q+9�a$J�����>s����C��.@2���悰N��Ɠ�Vj��i��1��G�����TڂՐ0J����9+��I�+�Z�뻙U[�(aiT�c�D� eb/]!=ЋX��@3��sn+V���J���D/T���NuI�OXQ�N$�F�U"�TD��d��Iw��b���PBt�O�������8�=ͦpf�����EX�eW�C0�0�x.�;�z��-�Q���]a]K(�	0OA���m�9$p�N[y��,�h�\Z�:)�	x��%�:��M�#�t���D<�P�L���=tA�:tN"�k�x�>���b@���3���)Ue�P�ɘ)���h>�2��& ���}�!+"�_p�0�ME�:�D&>DEF�h�.���s�۬��n<~��ov�_�:�0�~>a�GG�k�`

\��E?88p $'�Jg�+j�^Q3a�����kh�����H��G��$xlZ�+m)[	BZ�2�~l�c�
\�.6��E9E��i�(����G?tu���EzaeɈ(�Q��⭕Lo���e��:m6�e����o�\O�����V:��{�q�@n�b���D&�)y#�R�Ug�F��rۚnNdi4���r��v]�	�Kp-B���?��L�"��fOP�<�!u� t�ÑC>�WG�ض}�Oթ��G��E����h&اGC�W��+֦L����)S1{Գ�ClUũ�˩���
�`9�	]�#�U��>);�TI��x`A������8x��J�O[�FS[Y�Ϫ�jRM;�A����W�C<�"��޺ؘp���lA��H`����*l]6'Bc�؃�g�{ۋ�4�����NhP��B�^� �Ou�v�ٞě1�v���ɇ˽���?�������c{�^L�P����(��wl�M�|��W��z湚�2D��  �M���]�}d%\L��<c��h��������I��x�Rl��=��9�O�xb�r�)���~
0i4�#�7�o4pߕ�g��T��e�r�/�E��QJ#oo?�����=DV�ט���v`�2FDx�RK��a�}�&�t�,�S�^�w�3\iL�������Xl�c*xԒ��,�f�>c��3L�i�r�����qg��$���
^���~�Ij� ���C͜�Τs#[��g`a���#��P��=��=�i��G�l�/�Pp�?���5������A�?������JC�X��Pm�N񬖗�T:{�+�"�~���4q�n#;O)��R���jTk��y��È��c���R=܎����D��X2�:"�k�������	�v=�����<���x��.�^�k��1'�qAE>r���"��fI�j��ؽj�QJ����Fǀ��L�!%b���I깞&�oEf@�x�?�v���̥�`�'�N��36̵��?���DH�1`�bgt�+4�报*1o!�$��%)���!��?�/�wi��t4�����9X�9�.���`cۍo�Vؖ���~5�\q�0��|��er㺕;�z���(�ii��T��;��7���:�87�n�1��nD��0M�X�������������ls�b�I������R�u7z�
"GŔC)���@�08m��ȼ�&�^7�����&%�kq������1�Y����1_7��Giw$H��opc矻�49#�6��Aa�x��\I��;Qme���v�௒���{��i
R�3�-=�ql�w)Q�
����J�����z+��&%�<�:�f�]��0�����şsI@σ�X�ՌT�>@��D}/�̀A�}����E��#>�봇����q����w�^p�̛�oy]��?����9������ag�/��Fm��9�kژ�K{�/]��{�����Ì��"C�"�o}���2n7�΂�f"���G}��T�r��̎�7x1�T������wyΑSI5�\zKf��B�,$��2��il;Ds~���QV�]�Q���<��&5{9�e2u��2�V5���i��������,�t���#�w�sQ$�z�S��k��:����W9R�Z���G,���E�ՙ"%`�L&�Ѓs�*!PFS��y���&�,c�1޴���I�d��Z�*�31k���]��ƫ�O��p�սN�ΜV�gQ��
�_���Di�V(�<�� �>K�w�O �%�P�.%��O�F���K�(��%j�P485�F��P����&}�_�]�/`}�*FN�j�ڟ�D���0���7��j�9\���a�D.U�����u;�n�2������Λ�>�<�T�y��_4��U�:���J��X�Q��-W���:����*�(�4�8���0=I�:,�2֑�RN-i���X�z[QVo��.��wй�E�4���T��_�����N]��Hgh9\f��t�ܘ�7xucFVH怛%��<�O�taa�:�6]5�gF�֭�u�~v����/�W�Q      �     x�m��m�0��PD!�c��+��/���@9���p�����\��|�^3u�U\���X��S5�4�9ռN�%��Ѡ#��=h�>&��s���|�?�!Z� �������G�h��!�� I����[f%��Z�w��b(���<������ig���q#��I�v��F���M�ہ��f}����E�>��aJ���Vu�H�M\�sW�Q�؅� ��K2�xe{N]�W�p��r�Ș�ܝRf�.a�4�����j��yS��Y݋�      �      x������ � �      �      x������ � �      �   %   x�3�,��vt
��2��\]�������+W� o1L      �   �   x���M
1�u{��@�� �1P�΢�1<�x���̽���rt�{�#[�p/��3$��RP��JŐ�OƨrU	Z����y�22t��φ"0-HŒ�vstf�P�J[:ɴ����-�q@���[���^�|�o��K�i&      �      x������ � �      �   �  x��VKr�6]ӧ�2����Y˖	KHP���*�A��	f��J�3p�Uv���-��lSɦE��{�������0����
�6/�\���U�բ~��m��1^��gR:�g�*�a�-߽/ڦ �gFm��>��ڕ�j�j�]��	��Wq<�_������~=$�_��k<��(�%�,�c��9��@�d��cA4Xi�=X�p��N.l�R%��3՜�FB5�
2mcA�u�3y�ǖ܂^�L����)j�5�a�d2QPZr����&,a��"amu����� ��(A�;��D�[�e�ն��b*ӈ����p@*�}{�~&���i��;�+`m������Ey�G��K���L;(sA�G�T!!%�(@��e�*l�T ι|���X�����d=��%ch=�˹�fsm<��)c'��uʀ_(F�5�`mF�iG�y:{���vQ���H�w���8�8�֥S���a-/[n�-m3;PN�<|�N�2�ґ���y>����<��ϻ��xDi��-��0c�� ���^oP ���8������Րb�B���^yq���Pĕv���CY����6�IT<�8Ə�B��L��ň6H�z�~�s ���dO�aƙ��RG�@����g��v{�ȋ��t�X,�G\�.%�7)�k�F|;/L8�\�����=F?dO��'�,4�ѐٔG��ݱyѕ��"�<ж���V"�sx8��Ag��8�eMd ��_Y¡�6�[�h�gTuJ�z���n�q;�$R�W4�va���/�7t�g�'*���V�)񊊂�T�)������qM�B��I�yd>�'����$j]V�*���ױ{�$2.y�����_ו��´�Tq�d�$����ݿ̛d���+����_��~{������b      �   �  x��UKn�0]ӧ�ZA�$�c�QT��AQbt���AV���;H�W��R��HR$��ޛg�\�?l��L7�1�㖞Ε�dhxPd���xQ���,�K͇ǣP�')�xѼ�/�x�߬h��
H�pn��ΆG��e��
v�X���,fZ�7M�;�	�q�������6�U���~B�Ó���t� �9!��fx�wm�
�%YM��Y�4�,z�^Hp3�]&lG�$�;�B����D����cW��j�\v
%�t��TB�3���>����t���Y'� �i��ϤJ:��d�S����:�LY)�虪8t��N
g5���2�J)_����k��I}�w:���+�őp?��b��~hB���b�M^��K����s���&q�]��/�n&& C9o�g�O�3E7$I��Qf]��|v�4`6,�Ӝ�tW�����
(�G��5�[�o����̽TL����t-����A�f�B��9{S�r���YH�-�R�i��⨫@M�O䟚����>7 Y�	D��q�![��5?�����9pS��Nb�ƴğ7)���E8]G��!mc�D-�/l�<_����gy�	��/��˘5�P���e�����٦����#���a�ۖ�|�r�,�7�٣[VhpTxN���9�F���$�mW	в1��U������;Z,m�m#      �      x������ � �      �   G   x�3�,�4�tt9��������q�9����*�����2�8}�l��\]�L�|G??�W� l�2      �   #   x�3�,�<:���3���v�u�t����� n��      �      x������ � �      �   _  x�]Q�n�0<�W �#y5�T�pjB���)Z�$�D�EU���G��Uh��3�;�Y��4Ǝ�0VAl˷��l�O�����s�}h��Sxi7�6x�����@5-"��-�_��F�*j�쭛�!%��חVQ�{��D\��" J M1ZZ�k�@�:&D��/*�P8����<��pƔ#�����W��d�k�H��v��ok�Q=*��O���9��r2�f����ԉ��;��1���Zx�;*��x���qrȁ0;)s%48�*��5Mc�*5��@8D/���K�x�tv��+tl�� 	a���<$������g +Q^Q��)Z�
�{�4�8��i      �      x�3�,�4�4B# 4bN�=... 4��      �   !   x�3�,�t�s�2�A�\�@:�ߏ+F��� V��      �      x������ � �      �      x������ � �      �   >   x�3�,�q��9�����>�!�1�Ȇ�󸌁�#������\&@��cHh�#W� K��      �      x�3�,�q���L�22À��=... K�7             x������ � �         i   x�3�,�p=:��?�?�.#�������9~>��x+��z+nw���e���X$M�Zu�t,�@ț"��aUc��F���:s�CpXd��ق&����  �I�            x������ � �      �   0   x�3�t��2Ѿ�.�\Ɯ���n\&�!��G6�������� �@
�      �   c   x�3�tq�s�uU><'�5���#��sr�Sps�8�������@T�1��!G6�9r�p�$ �89�y��8�)n��v���u�����  �,T      �   m   x����0���p(F|�qQV�����C"��������B�6�c�7�E�Jr˧r5u�3)�6zf�l�������<�%ޢ�AWR)��y�?YG����
��	�̢�      �   e   x�3�t:������#���q��2���pvur�2�
9��p;P>�1���<.����	2�<��/��O��1�����1ȓ�(��77�+F��� �'�      �   !   x�3��vt���L�2�t�v��,����� D��      �      x������ � �      �   L   x�Ļ� D�xo15��4���C'��ԃM�俠hP5�]����W��օ�n���Y͸�%\��n�� ��      �   3   x�3�t�q�u��2��=<�����Ȇ`.cΣ�\ݸL@b.��q��qqq .��      �       x�3�������2��u�rr����� D�      �   !   x�3�tr�v�L�2�t�9����+F��� Mz�      �      x�3�qu
:���ˈ34�1ȓ+F��� M�      �      x�3�tw�Rp�	�T�v��s������ @L�      �   %   x�3��u;�A!��ۑ��ˈ��5�1
ƍ���� �=�      �   9   x�3�t���Rr�
�2���U8<���5��.c�H��_�c�'W� ��      �   #   x�3�rV0�2�F\�`ژ�L�p��qqq �}�      �   v   x�3�r�u�r�Spr�2=9K��8�C��P��9|#=��lN#KW�#|�C}=B��l�tARl�ih	Wm�id��wdC���g�����xtH����B���oh����� d�$�      �      x������ � �      �      x������ � �         %   x�3�vt:�!�ˈ���ȼ#���v������ ��	p            x������ � �      
      x�3�,�<�!(���ȆHW$&W� ��
�         (   x�3�,�<����ytg�!��~dCБ@n	W� ���         M   x�3�,�tr<:��1��ϑ3Ə���(vdC@���oh �8�ptT�(���X�ގ��Pn� 2��         <   x�3�,�tw�s���
!��>G6�q�pe�]C ��c��_��iA0%G6 ��qqq �g�         "   x�3�,����#.#��!��1HE$F��� {/%         -   x�3�,�twr�9�A�����1ؓ3$�����ݐ��+F��� ��	         $   x�3�,�4�41626��v��srv�4����� N�1            x������ � �            x������ � �            x������ � �         &   x�3�,��u"GNCN�B.#�m��t�)F��� 1M�          %   x�3�,�
9��p��\FP����y�\1z\\\ �	?      "       x�34�,�t>��/X���WC�=... ]$�      $   M   x�3��,�44�t>��/�B)8n���q�u�t2�t2�t2�t2�t2�t2�t2�t��t�J 1P�Ј3�+F��� 
�Q      &      x������ � �      (   )   x�3�,�420��50"��`N=#cS0����� �B�      *   +   x�3�,�t��t��q�2r�C�<c �����ĉ���� �
      �      x������ � �      ,   o  x��[Mo�H=+���] �����8� F&�8����#Θ�H@���4s�u|ٓo��׾zb�M���/J"V��UW=>*��ʑ;���R�~�a�p�	�sG��ۻ\����d6O
s9�eot��k��{5���<�ݜO���m�d��:K|���_�4N.�&��t{۷�f{W8����������ަ�e�'yRJ sY�;��v�̝�d�f�G}�%��le'�|��nO'[�V;��rzy�+�W��wI>[�ۻu�5��v�cPm�9��?�n�g���:g�x���!�[�a��yc��M�	�'@��z�M���u��$Y�y�jn�>�G:nt��d:��=�:oR��Rci�3�����}2��'�^XW�ir��I˅$�c�!P٬�'�(�*���Kۭ�2#��ɇ?6��W��%Ey[&�'����EI�)�sb�Z���p["R�Ӥǐ��*O���rvQ�w���$j�CR,y2�J8QXU�p�n�r��D@,U��c������8��s@4���_��NO�	>�7�Ƃ(b5r�p1[͛c'�`�{B���i-�pu:�˅�����Sg@L�iJ�<���ql^}���;GHP���qpA;z�:���+�՚��}..�l ]�NsH��x�Q?`���1�}��11��G8���d�Z��UZ:ߧS����d�x����l5k-�����i�H�6Ϧ_�5"�@4�����u��ĞI�u���
E�:�9$r�Ɩ~I����4D*x�zL,�>D]�����\�%��K�d�3��l��9SO�'�t�?.Uթ6�{���`%E����#�W�|��qm>
i�w�|1đm>�����r$�z�t�ɘF�w�K���ģ��<!n�t�	q|ZW��o�B��n�;�U&�{��mqB��6&�A�X��	�+2�Fi}u��/�5dLx۩����<�O]f̊���c�"���я-��:�����ς�.��<V��iL1ɏ�߉������7���W����1+H�6+��^`#����,�l�&ɭ��B0�O�.�@,����˗X�,�	�]z�ojCô Y�i��+�+D�����e���&��Pʼ1�m8�X�e�٢(�e�1Q��P�}͖:+��~�����n�%eh�no�\�-���b�ap��?pZ~70�H���U����H>o��s<u�y��c`�0a}���z����=a5��\g�è���H�YH�K40�M�K(���� �[�f:�g�1�w����G7L�zC�}ĩ����_�=["L��%�Ssk[�.���X\M�<N���q�!`�����go�*ģ��<������B��2]kP�6��!��5��WdNW�����r�Tz�2zY�>e�"�Q�O �oz�x�a�4E5�D��:���Z�B'�2��$�\�x�(6_��SPQ�s��2���r��+�_�'�f}\:�nV���0�z�(�\_K~Գe�c/�z0F{�A�GS�1N���ʷ�ϧ_0�J$7J���d�ڇ�����h<j4
��wPą�|�ʊ��0�5n��}�
��4��{Td�!]���GF���]�a����6*�!�QlQ^�'�쭜Z�����X�=��t�� ���$���c��8��!S�P�c�HH�q���'x����C�򊊷�6�cL���1�q��\&x��[EA�E!�3�#��L�X�L�X9�L�XZ�L�X��L�X��L�X��<�W)|�&����KaJ��ex�X�1n����Og����qT�ȟ�e
2��*��cO�Oɺ2;�R}_��:��Λ�z.s�n���c���<X��xD�&s�6|�ٻ��y�b���D��N[!sAe��-���H-��4��7l�Xl��{o�F��o(�=�3�۽�SE���"+-�2����2`a� �@X�&K}�-�ѣئ��)�4r�.)fɍ����e"��;|ﲹ1���cgkQ�����it�/u�� �s�鍪�?H�����B������Qh�[�kǠv̭��b����'R-jo����7�0բ���R-�m� բ��G�(���R-�i�cT�
��jQ'��Z��c�/�"E����������u����oM��"d��G	�+��NI5�j磢�>��{u.�P�ST�| щ�M*��������Ǖ��`�%�Z�0vĻ����C�MQ*��J�4_���bY�W&u�(
b��y�_w�E�5GWQ p���_���0[[�h,/;��s���/0v?7�D�,���BL�-X��ׯ��m#4jUR`��a������y
mNGE@���ǫ���"�v��q8��:��/m3cE�]Yr�E���RmF�(�����š}x������ҋ�^���q��~@Bwd�0ݱk0��BY�b�X%�f�5u8?,�XQ*Q�4:��"hu�<���}�E�Э��G�Ôւ|Z��ʈqYkH+*_�[�˲��$����҂͛r3����Ƹ����cB��x��`����4UuE���{j^�%K[n
���L�Gk�륐�>_�������)�2�7%�����?)��oJ�Q�ު��n�$�8��7��*���l����"�ZV߇E�Z�Э+�=��5!��=jVgq��R�
�P��e�^t�b�~42$����]�u��\s#|K4/t'&�j^_U�kT���9�
�u!���*�NK���ש�i�A��^#�tճb��
�ν�	S��	2f��[!���å6C�zv�YŮ�6OxąXF�
r����Y�|JVa�ي��E@i*�l����bZl��v"��Q�
'�5t"��uH=K!�`w� 3�,��}}º?�E��'k�(���U��s�z�VT�¸��J�DچH�[]�er)���s��{N�Nn��0P�{>R5F�iZ$3���>տU���=���a��{���{�I׺���cDGu��]:+1�۞RN�gm���H4��W���N乇L�F�'���d�!��S��<��q��/��KD��i���hscƢP���X5[�:�l���מ��(�t�׿ټ7�T�"p�!�3}��D�sWք/�Udh��0/c���!��t�0��eAN%�5ˢ���<��Rܣ|LA)��y,J'���"t��9�qdɄO �ëg�����r�ƃ��رx"w�nx�����S7���b1�6v�e��Β�tE��dp5�" ��ԓ�^Q��}r_�7�,�������O=�,��d��!�Fd�ɕ<,��f��F����ݹk6)sE�O#޴"�(lE���K�G�G		�m	NQʊ������_�s�������"�ݕ�Y��|JWb�5���O�~����JVMY      .      x������ � �      0   K   x�3�,�4���t9<���O!�1�����1$V�e�6 �=�<�\\��s�q�J�����1�"���� �&      2   7   x�3�,�t
P0�4400 �0&��2�9��"'��Op���`L�L�'�b���� >@�      4   .   x�3�,�ttq����0Ҹ��b��`td���{��/g	W� �      6   j   x�3�v�T�t�u:����O����1ȓ3�˘�54��Q�Nǰ�� G�#�|�l82��� � ����G6 Ur�� ��9<'�[�.�1ؓ��+F���  #�      8   Z   x�3�,�<�!8��7G.# ������U!�� ��#���B������sr�Sqrt��sq�S 	B�� �nw��<:���=... ��&      :      x������ � �      <      x������ � �      >      x������ � �      @      x������ � �      B   O   x�3�,�4�p�s9��[������X����T���T����Ԭ���Ȉ�5��/��Ǔ3Ə�(b������qqq �H�      D   .   x�3�,�LK-�H,���I�,��5��0sH�M���K������� ��      F      x������ � �      G      x������ � �      J      x������ � �      K      x������ � �      N      x������ � �      O      x������ � �      R      x������ � �      S      x������ � �      V   Z   x�3�,��404@��@�642�5�5�<���[����B\��l@(@�DJMK-J�+K"Ɇ�����������B,��W� �,q      W   �   x�}O;�0��S��c'!-��B'枠�!z����P˖�{�H��g��&B�de�N�b���{i���k����	�W�����&�p��E9D��bWʩ-����}o'g)�f��x�0]�Grx9�ʫ4\�gc19>��Gq&�9@���R�bqƘ7N�A�      Z   �   x�5�A�@Eם�; �@#�$�cB�1����r0[��{�;�#�`[�I�z�r@wQU�u�X��*�t	
}�)v���Wĳ�9�A~qDC�P���*Z����0�^!���0ŉ �m5$ʆ�"7����6��<��C��y��`iSw��)i��rr�}��4�      \   u  x��X[n�:�NW�������I�_��HQ`����Cw0_A֐=���%%�N3QGh`2�)�G�4'��+V����"q��$�x��⇮h��\����?_Ҝ*�pv��`5��یג��J��'>�e6=�Ѐ`�
V�U�~�g��#c���j�
�A�*���(�Y�z�1�7���*xż��Y��A�ק�:J��{��@��_�i������Y���Z�3o��.5o��E��ɂ�ى	Xf�S�����?"�F��/R�bw��*��������3��4*���GV���b��t���2^e�v&d�(vȩ���ۥam����	,�����`�p(B���*��x��kXs�!9�G����EPt6��h yUv���nD�E��&H1>b���yI�(v$��׼���ʸJgi��	�
���V�� �Y�- �x��x����uf$Rx�7�{%?
��3��	W\:"�Po�x:��,�Cm8� 8�L��c�?��|�m�r�i�-���ٲ7�~�:��I�9[H��S,'�����KE�l�d�&<T��q<�e��`��Ε�&ğjA�L˪zw�$�i�/Y̪���:��b�o�A��J�&�拢q�I�S��
�fҰ��Ҟ�L���+;���J��J��G�+K2��(��l 7 \��1�v���Y�I�:�(��B? hA A*Vԝ��B5^l:C�p�v���Z�+�
b��� FS����BG�Bl,`�ε��)wVc�k�� �+N�We���Pm�j�t�
pe����l�O�5��=dȜ�<��0'~�(��҇�rF���r6K���L��2Tq�'��n1�K�VB�=�qd~�h�a/Y�Q�8O��U%XF��Zs�d�'�(N~:�"dA�.�9����\�>n�����0H^˝O��(P�ittC�=�S[�?��b���I_+�2 Ʀ�.�5�1��U-��޺��f�T�α�i����-	�t�^ՉC�����I��E�/����cɍ������)�S�x�J�$�&����	�gm�3m�g�j�A��eNu�	U�����%Ȏ��p���s�w-��U�(�`'����x��Ʉ�n ٱ�Yov��d�{qw'��b/׎֑мÕߘ�fi]E�tß�q�Ȇ^�^p>)S�0}0��N�O,Ԡ�_�P�����I[>K;
�����.H1ے�t�Y��T�n��jrh��<�̺�U��}���}ĲG\�pl��_A�5��W��wj�zc�O{�P� ڄ��eM����`ή�#��	7����o�}�@*�.[3�<�l�B
��XN3d�a���d��L�x(dH��v��]^��$UP���`������LUos      ^   T   x�ǻ�0�:o
�/-�D�D�1�y���Q���lZ@C�iL��}�ǘ@S��#��f�o���+�Vg5ݸ��� �W'E      `      x���Q�,KNl�/�`��%�G�`|3��mV��K�KM�ԩ�+3������������'_�[������=���?���^k�����������������ݞ��wϿ��r��k݆;������
�����Z��:��������zh9|u�����<|���)�#�}�������m���7�O)^�ҋ2��RE��k*�O�6_���Ky��ׄ/emZ��	������_;|��W��:����/^��w�v������_;|��W��ݯ��ͫ���	_��տ}�넯~��߾�u�W�y�o��:�߼���~��{$����_O��7����_O��7����_O��7����_O������_O��������ë�����ë�����ë�����ë�����ë�����ë�����ë�����ë������W��ݯ/|�7�����P_�������������|����Y��x��/܀����~�_�[מ��Jo>���|[^�l��6ޯ��-�l�m�_+�e��6ޯ��=8�����jv؃�x�V�{p؃�x�ѥ�R��6ޯ�^�{p�QS���6ޯ��{p��J���=���k�����F~����=���k�7��=���k�W��=���k�w��=����L/�{p��Jo�{p��J��{p�>����F~P�=���k�7=���k�W=���k�w=x}%H/�/{p��Jo�/{p��J��/{p��J�/{p�|�×=���k�7×=���k�W×=��/3���_�_]s�����������������������������F.T��cn��Z��cn��Z��cn��Z��cn#W�������~�������~����E�6}|����~f7�'VzW�H�RUz]\?a�_�����Z�֪J/���6�J�\Ji۪J������^����O����+��.-��Wz]\zU_��O���J1��_����WDU�����f���',Ǣܪ
��f���ƦpSv,&�/�RU�:-W�	�\c�j�
v�������z�?]�e`��U1�5����U1�5���ު���Boy��k�2���ު��q��7Hnzy_�4S���W�˗��^ᗀ.�T���%���0��["�K��M�Dp�f�u3��/^��Jo�K�WI�����%�K3U�~	�Ҭ��W�%�K3U��~	��/Ʒ*���opZU�	�Ҭ�V���% L3U�M	�/�*��/�`��J��K0�f�U>��/a��Jo�KPX �V��%0L3U��	�,|�^�� 1�T�X��Ԩ*�K�(�����K��f!���K��f�ҿ,Ac��[��@��f���Lu�W�c����J �,�r���"�Lu�W�d����J�������K8Y@�VǷWe����B�-)����*�L3���UhY�VǷW�e���o��4S�^Ři�:ۀ���k�:���4�Lu|{=~��Qu|{o�����*�,Xv��۫�3�TǷW�g���o�b�4S�^���nu|{������*M3���U�f��۫P��୎o��ߜ�:��
H�Lu|{������*,-y��۫�4�TǷW�i���o���4S�^��?ou|{������*PM3���U��f�����1���o�"�4S�^�i�:���[�Lu|{�����U��f��۫ 6�TǷW1�%�}�$��
c,����*��ı�ķW��%�}�$����ox�T��^��7�fOz{-��^�-}����Io�%�]��}�Rx*�]��s����	h�LMz{-�W��[��^K�fj��k���LMz{-�W��Io�%�*�k��k-�=r�&����+�Ԥ��{�����Zb��޷&����+�Ԥ��{�����Zb�4S��^K�U�����{������~m��O�Zm	ܕ�����{#m�&~/��Lw�����i��Z�+o���S�7��]�wץ[�7ֲ·&~o��\w�5����[��Io��7��]oMz{-�W���֤��{�����Zb�4S��^����VMz{-�W�j�֤��{�����Zb�4S��^K�fj��k���1�&����+�Ԥ��{�����Zb�4S��^K�U���ݹ����^i�&����������Zb�4S��^K�U�d�ݺ����^i�&����+��ķW�W�K��M�D�U��һw�-{�����U�fjǷW�W���^�^��[;��n�c�v|{{�����U�fjǷW�W���w�ƷW�W���^�^i�v|{{�����U�U�<��;��W���^�^i�v|{{�������?G��۫�+�Ԏo�b�4S;�����L���*��_|����U�fjǷW�W���^�^i�v|{{կY>�n��+���?�-y�jǷ��{T;����ꗺ�v|{{�����U�fjǷW�W���^�^�+�[;�����L���*�J3��۫�+�Ԏo�b������^�^i�v|{}�!�W��۫�+�Ԏo�b������^�^i�v|{{�����U�fjǷW�W�2�֎o�b�4S;�����L���*�J3��۫ث~�k�����㦟j�����#�~��Io�-�J3u��k���L����b�4S'����+��Io�-�J3u��k���L����b�4S'����+��Io�-�J3u��k���L�����N^���^[�fꤷ�{��:����^i�Nz{m�W����^[�fꤷ�{��:����^i�Nz{m�W����^[�fꤷ�{��:����c/�Io�-�J3u��k���L����b�4S'����+��Io�-�J3u��k���L���b�4S'~Ɓr�Sx�A��?�'��Y��v�����=�U'~�z�Sx�A��?��'�:����~p���?�xB���tK���p뤷���x­��^[�fꤷ�{��:����^i�Nz{m�W����^{�h�Q����b�4S'����+��Io�-�J3u��k���L���*�J3u�۫�+���^�^i����*�J3�ķW�W��'�����L=��u�!*[�ķW�W��'�����L=��U�f�o�b�4SO|{{��z�۫�+���^�^i����*�J3�ķW�W��'�����L=����q;G�ķW�W��'�����L=��U�f�o�b�4SO|{{��z�۫�+���^�^i����*�Js�	閈���zC�L&m	�y�9������^�^i����*�J3�ķW�W��'�����L=��U�f�o�b�4SO|{{��z�۫�+���^�^i����]�������tK^?��U=��U�f�o�b�4SO|{{��z�۫�+���^�^i����*�J3�ķW���{^�ķW���{^�ķW���{^�ķW���{^����ao��Io�������7������=�붥��{��n[�%#�:z�k߶��ob�����mK�'�J3����{��z��눽�L���u�^i����:b�4Soz{�W��7�����ꍟ!�J3����{��z��눽�L���u�^i����:b�4Soz{�W��7����+�ԛ�^G�f�Mo�#�J3����{=:�nIz{��C$K����{��z��눽�L���u�^i����:b�4Soz{�W��7����+�ԛ�^G�f�Mo�#�J3����{��z��눽�L���uڏm՛�^G�f�Mo�#�J3����{��z��눽�L���u�^i����b�4So�Z?�v���7~�F�{^ym�<Z?�����H��������ci����=�vTo�lZ?�����z���������?����=����9�~P-�y��ƷW?������K�D�f�o�b�4S_|{{����۫�+���^�^i���������۫�+���^�^i����*�J3�ŷW�W��/�����L}��U�f�o�b�4S_|{{����۫�+���^�^i����z�����۫�+���^�^i����*�J3�ŷW�W��/�����L}��U�f�o�b�4S_|{{����۫�+���^�^i���������o�b�4S_|{{����۫�+���^�^i����*�J3�ŷW�W��/�����L}��U�f    �o�b�4S_|{{�������迪/�����L}��U�f�o�b�4S_|{{����۫�+���^�^i����*�J3�ŷW�W��/�����L}�eA[�/7-X��ض�n��[�ظ �J�֓tc��+�[�ҍ�¯to=K7�/��ҭψ�b� ,�[OӍ-"�to=�561�ҽ����� K�>��K��[�����-
K��5+���eE�Rݾt_�a����~�Uv��Mݾt_Db�n_�/B�tS��f�X,����/��n�X��ۗ�h,���K�E8�n����"K�>��K��[@�n����Rֺ�����"$K7u��}��[�.����-(K7�~�v��nI�ؗ�b��e�n_�/�t���j�f�n_�/"�tS�^n��,���-@ڗۭOP����n��Zu��}����}���M�_z���t�3���h�n_�/"�tS�/�!Z��ۗ�-����/��nAZ��ۗ�(-���K�E��n����2�G�?��K��[��nj�һ�����}���Mݾt_�j��'a�uW��n����b�O(�zz}�/V���[Ƭ�|��Mc�tS��aӾ���Z�q�O9�U+��Y;�s
$��V��������c<�@���k�*��,���ҭ��&�-pK7�b����Z��l��M��J��n��'�c3����Z��lk�jņ�-|K7�bK���[���Me[ �njŶ�-�K7�bc�¥�Z��l��ҭOm��-�K7�b{�ť�Z��l��M��b��q����c��~�6|T+��m�\��ͶP.�Ԋ�f[,�n}2=6�m�\���Ͷh.�Ԋg[8�njŖ�-�K�>�ζ�.�Ԋmg[D�nj�Ƴ-�K7�b��~��|����|�u�Vl?ۢ�tS+6�ma]��[ж�.���lB��tS+��m�]��Ѷ����ؗ��+���<�%��
�n=Ѐ}�ﻢ�[O4`_����Y���V,I;?kT��i[Ҏ���C���#�{�TL<�}���=� Oz�=�G�5�R���.�ԊUiG|�nj�Z�#�K7�b��ߥ[�m��^G|�nj�f�#�K7�b��YV�.Պ�^G|�n=)"�{�]��۽��.�Ԋ�^G|�nj�~�#�K��M���.�Ԋ_G|�njŊ�#�K7�b��ߥ[OÈ%_G|��#�Wz�=e]s�V��:�t�����ߥ������.�ǲ�t_�w�>�}���#�K���+���]��ďX�u�w�>~���#�K7�b��ߥ�Z����ҭg��¯�V|�j�Ư#�K7�b��ߥ�Z����ҭ���ү#�K7�b��ߥ�Z�����M���u�w��sTb��ߥ�Z�����M�X�u�w�V��:c-���-�����M���u�w�V��:�tS+��]����X v�w�Vl ;�tS+V��]��;���.�z:M,;�tS+���]��k���.�Ԋ=`G|�n='��]������.�ԊU`G|�nj�.�#�K�������.�Ԋm`G|�nj�:�#�K7�b�ߥ[����`G|�nj�F�#�K7�b%�ߥ�Z���ҭ��R�#�K7�b+�ߥ�Z����M��v�w��s�b1�ߥ�Z����M�Xv�w�V�;�t�IJ����M��v�w�V�;�tS+���]���Xv�w�Vl;�tS+V��]��;�.�zZT,	;�tS+���]��k�.�Ԋ=aG|�n=�*��]����.�ԊUaG|�njŮ�#�K�����.�ԊmaG|�njź�#�K7�b_�ߥ[����aG|�nj�ư#�K7�be�#�K7�bg�#�K���K��]��[��]��k��]��{��]����X����M������M�X����M�����ҭ'���G|�nj���G|�nj���G|�nj���G|�n=K-�=�tS+6�=�tS+V�=�tS+v�=�t��m�D�ߥ�Z�E�ߥ�Z�F�ߥ�Z�G�ߥ[ϋ�Eb��.�ԊMb��.�ԊUb��.�Ԋ]b��.�zB],{�w�Vl{�w�V�{�w�V�{�w��3�b��#�K7�b��#�K7�b��#�K7�b��#�K���K��]��[��]��k��]��{��]��ܿX,����M��,����M�X-����M��-���ҭ'�r�G|�nj�v�G|�nj�z�G|�nj�~�G|�n=�0�=�tS+6�=�tS+V�=�tS+v�=�t�i��d�ߥ�Z�e�ߥ�Z�f�ߥ�Z�g�ߥ[�o�Ec��.�ԊMc��.�ԊUc��.�Ԋ]c��.�zbd,{�w�Vl{�w�V�{�w�V�{�w��3*c��#�K7�b��#�K7�b��#�K7�b��#�K���K��]��[��]��k��]��{��]���X<����M��<����M�X=����M��=���ҭ'��G|�nj���G|�nj���G|�nj���G|�n=k4�=�tS����/<�+��]��;��]��t�XB����M��B����M�XC����M��C���ҭ��"�G|�nj�&�G|�nj�*�G|�nj�.�G|�n=�5��=�tS+��=�tS+֑=�tS+��=�t뙱���ߥ�Z���ߥ�Z����}�H\�%���>z&.��w�w=�}��⻏��˾���W|��cqٗ�������\�XL���z0�/ܗW|�Փq��p_^��W��m��}y�w_=w���ߥ�Z���ߥ�Z���ߥ�Z���ߥ[���e��.�Ԋe��.�Ԋe��.�Ԋe��.�z�p,){�w�Vl){�w�V�){�w�V�){�w���cQ�+�K7�bS�+�K7�bU�+�K7�bW�+�K�����^�]����^�]����^�]����^�]���XX����M��X����M�XY����M��Y���ҭ�F�ҲW|�nj�ֲW|�nj�ڲW|�nj�޲W|�n=�:���tS+6���tS+V���tS+v���t��ر��ߥ�Z���ߥ�Z���ߥ�Z���ߥ[��f��.�Ԋf��.�Ԋf��.�Ԋf��.�z�w,1{�w�Vl1{�w�V�1{�w�V�1{�w����c��+�K7�b��+�K7�b��+�K7�b��+�K��p��^�]����^�]����^�]����^�]��L�Xh����M��h����M�Xi����M��i���ҭ���R�W|�nj�V�W|�nj�Z�W|�nj�^�W|�n=7>���tS+6���tS+V���tS+v���t�I����ߥ�Z���ߥ�Z���ߥ�Z���ߥ[�Əg��.�Ԋg��.�Ԋg��.�Ԋg��.�z,9{�w�Vl9{�w�V�9{�w�V�9{�w����c��+�K7�b��+�K7�b��+�K7�b��+�K�����ߥ�Z���ߥ�Z���ߥ�Z���ߥ[��Xx����M��x����M�Xy����M��y����-�B,={�w�Vl={�w�V�={�w�V�={�w��!���tS+6���tS+V�}�tS+v�}�t���>�]����>�]����>�]����>�]�媈h��.�Ԋh��.�Ԋh��.�Ԋh��.ݲc��O|�nj��O|�nj��O|�nj��O|�n�8b�'�K7�b�'�K7�b�'�K7�b�'�K� ��ߥ�Z��ߥ�Z��ߥ�Z��ߥ[ΑX�����M�؈����M�X�����M�؉����-�I,E��w�VlE��w�V�E��w�V�E��w�W%�}�tS+6�}�tS+V�}�tS+v�}�t����>�]����>�]����>�]����>�]�厉i��.�Ԋi��.�Ԋi��.�Ԋi��.ݲ�Ē�O|�njŖ�O|�njŚ�O|�njŞ�O|�n�qbQ�'�K7�bS�'�K7�bU�'�K7�bW�'�K��<�,�ߥ�Z�-�ߥ�Z�.�ߥ�Z�/�ߥ[�X�����M�ؘ����M�X�����M�ؙ����-�P,M��w�VlM��w�V�M��w�V�M��w��(�}�tS+6�}�tS+V�}�tS+v�}�tˬ��>�]����>�]����>�]����>�]��r�j��.�Ԋj��.�Ԋj��.��    �j��.ݲG��O|�nj��O|�nj��O|�nj��O|�n��b��'�K7�b��'�K7�b��'�K7�b��'�K�Y�L�ߥ�Z�M�ߥ�Z�N�ߥ�Z�O�ߥ[N�X�����M�ب����M�X�����M�ة����-X,U��w�VlU��w�V�U��w�V�U��w�w,�}�tS+6�}�tS+V�}⻟�j�K|����Uc_�����'���w�w?��ؗ��+3��jł����جFT�X�UM��Q�f�o�֟�-6��ɦ�vT,[�Ƿ[�Q�oMF7�nG�ʵ{�q�����5����8*���[_G��5����98���.o��k��lrѩu9*�����&)�۔ދe�Sk;*V����&��x]b�<xjݎ��l���I:��6�wdY���8*ֲ���&I�؆��&�Z?G�r���m�?�_�~6�Ժ+��qo�m�`li��O���X�v�{��i+�)�;�����X�v�{�$kc�cc�܃j}K��qo��m�6��h���9*V��Vo��m�y��m��u9*����&�ۚmJ�Բ&��k��qo�$n�)�Mnr.�u;*�����&�ܚmJ��26��qT�t�ǽM��%�������Q����z��OY��M�H�.G�z�{��$���bÛ\�jmGŒ�{��$�۰M�[�J�nGŪ�{��$��Gcۛ<�j}��qo�to�6�w��m��mئ���M@g}���orl�u9*�����&����d�Tk;*V����& �~f�8�=պ���qo�>��]p����qT���ǽM�uTl��[T���b)�m�6�?Ei�^8�Iպ���qo�)G�v8yM�ڎ�q������DŎ8YQպk��qo�Z?�cS���j}���qo?ˉ�}q2���sT�����&����5N>W�.G��{������'�Z�Q�>��6�u�rrɪu;*����ަ�8*���D���Q�J��6=��b��<�j��n������V씓W��Q�V��6���,'��Z�Q�\��6qG#*��������X1w�{� ܺ�Ŗ9�{��8*����&n�DŮ9���9*���Vo�[7��8'w�Z��b��=�m�>JT읓yX���X=w�{� ߺ���9y�պ��qo�w;�d=V��XCw�{���Q��N�d�~��et�Uۤ�7Q��N�e�.G�J�{��Z���J'_�Z�Q����nG�n:ٞպ����ǭ�O��V��XRw�n}{�d�V��XUw[�M�p�=%���S���XXwO{���JT쬓�Z���X[w�{�`���Ql��#[��Q����6���_'öZG�
�{�۴�?Qwl���[���b��m�6՟�b����j]��uv�����O��Wk;*�����&6���k'��Z��b��=�m����N^r�>��w����?/DŎ;Y���9*���Vo,\�Mwr��u9*�����&����dTWk;*V����&X���[��cW�vT,��ǽM}��dsW��Xw�{������<����9*���Vo��)�+���$���X�w�{������Oz���b!�=�m�� Q�O{�nG�Z�{��͈�xk��3AQ���6�ݗ�؏��Y8+����6���PbK�Zf�LPT,ʻ�����|�bW�Zf�LPT����u��2g��bi����&~�{��2g��bu����&X�xQl�[�,�	��z�����7�b��Zf�LPT�ѻǽM�pQ�ؤ��Y8���qo?U��}zk��3AQ�R��6����b��Zf�LPT,ֻǽM�,'*v�e�E�z���m����ņ�����X�w�{��A{��2g��b��=�m���ƶ�����X�w�{���;��2g��b��=�m���>�潵���X�w[�Mܖ���{k��3AQ����6���<c�Zf�LPT,�ǽM�ш�]|k��3AQ����6��EZc#�Zf�LPT,�ǽM����|k��3AQ���z�`�⻱�o-�p&(*����&�DŎ�����X�w�{�`�ʱ�o-�p&(*�����&n�Dž�����X�w�{�`�bٱ�o�Y8��n��I���ݷ�,�	���}�x���V��3AQ����nG��Uf�LPT����G�6�Uf�LPT,���?�����~����X�w[�M�p�� 6��2g��b��=�m�+Q��o�Y8+��qo,\���-����X�w�{�x5��]����X�w�{�`���Hl�[e�E�ҿ��mb��������X�w�{�`��}Ll�[e�E��{����; W��3AQ���6���[����,�	��e�����?/D�>�Uf�LPT����&X�~�[W��3AQ���6񧔨���,�	�������	��xņ�Uf�LPT,	�ǽM|o *��2g��bU�=�m����l�-p�Y8o����HD���Uf�LPT��ǽM�p�v/6�2g��by�=�m�� Q�?p�Y8+�qo,\�S�-�����X$x�{���KT�\e�E�:���m���7��Qp�Y8K�qo�󉊽�����X-x�{�`���il\e�Eł�{���O�b��*�p&(*����&X�~k�W��3AQ�l�z���FT�\e�E���{����c��*�p&(*���&~��W��3AQ�~��6�����@��,�	��%�������D��Uf�LPT�"���&X�~/�W��3AQ����6q� *v�2g��b-�=�m����p�Y8�	�qo��b?�*�p&(j�p�p&(*��2g��bQ�m�6q["*v�2g��b]�=�m�����p�Y8K�qow4�bo�*�p&(*V���&X����W��3AQ����6q3$*v�2g��b��m�6���.��d��,�	��e������(Q��p�Y8+�qo,\�툭�����Xlx�{���W��3AQ����6������p��,�	��%��Uۤ��{W��3AQ���o���b��j�p&(*��ۭ��y��,�	����������|��,�	��������Q��p�Y8+o��	������f�LPT,B�ǽM�s%*v!�6g��b�=�m���B�q�Y8K�qo�&Q�q�Y8��qo,\�O�툫���X�x[�M�Q�#q�Y8k�qo,\M�����X�x�{��\�b_�j�p&(*V&���&X�ދ[W��3AQ�8��6�煨؝��,�	��������;�b��j�p&(*�(���&��{W��3AQ�J��6�����ئ��,�	���������D�N��f�LPT�U�ǽM�p��-6+�6g��b��m�6���د��,�	������	���Ŗ��f�LPT,Z�ǽM|$*v-�6g��b��=�m���}�qq�Y8K�qo�}��������X�x[�M�p��0�/�6g��b�=�m�{>Q��q�Y8k�qo,\�b�M�����X�x�{��ICT�c\m�E�J�{���{'c+�j�p&(*3�Vo?߈�݌����X�x�{�`�z�flh\m�EŒ�{���OU�bO�j�p&(*V5���&X��'�W��3AQ����6񳜨�ٸ�,�	�������׻Scs�j�p&(*�7���&nD����f�LPT�p�ǽM�p�'6�8�6g��b��=�m��BT�r\m�E�:�{���;qc��j�p&(*�:�Vo�%�b��j�p&(*V;���&X����W��3AQ����6qG#*v<�6g��b��=�m���]Ǳ�q�Y8��qo7C�b��j�p&(*V>�Vo,\�u�������X�x�{����W��3AQ����6����� ��,�	��%�����[0Q�r�Y8� �qo,\��m�k���Xy[�Mz78Q�r�Y8k!��vk9*6C�1g��b9�=��:����k���Xy�?n=��-�k���Xy�n}�"ט�3AQ�.�z�`�z�|l�\c�E���{���?W�bo��p&(*VG���&X�ޯ�#ט�3AQ�@��6�j;$ט�3AQ�F��    6���)��$��,�	��e������$ט�3AQ�R��6���ل�*��,�	��Œ�����%*vK�1g��b��=�m����ar�Y8K&�qo^��=�k���X5y[�M�p}#�M�1g��b��=�m�O)Q�sr�Y8k'�qo,\���͓k���X>y�{���@T�\c�E�
�{���gNb��p&(*Q�Voߑ��]�k���XGy�{�`���Kl�\c�E�R�{����A�b/��p&(*VS���&X�>_�)ט�3AQ����6�ݗ��Q��,�	��5����קzbS��p&(*�U���&���*ט�3AQ����6���Y��Z��,�	��ŕ�����4D���5f�LPT���ǽM�p}�)6X�1g��b��m�6���c��,�	��U����	��M�6�5f�LPT,��ǽM�T%*vZ�1g��b��=�m����Z��r�Y8�-�qo?ˉ���k���Xqy[�M�p}F,�\�1g��b��=�m�AT�\c�Eź�{���'�b���p&(*�^���&�-D���5f�LPT���ǽM�p}.�_�1g��b�m�6q["*v`�1g��b�=�m���Sx�	s�Y8�0�qow4�b��p&(*Vb���&X�>�[1ט�3AQ���6q3$*vc�1g��b=�m�6�����ؐ��,�	��%������(Q�'s�Y8�2�qo,\�s�m�k���X�y�{��;3ט�3AQ�6��6�����ܜ����ܝ�����L�sw�6g��sw�6g��sw�6g��sw�6�'A��ݙ�,�	��ݙ�,�	��ݙ�,�	��ݙ�,\�?%:wgn�p&(nk�Mf�LPt���f�LPt���f���+ѹ;s��3Aѹ;s��3Aѹ;s��3Aѹ;s��볶D���m�E���m�E���m�E���m�O���3�Y8��3�Y8��3�Y8��3�Y�>WLt���f�LPt���f�LPt���f�LPt���f��43ѹ;s��3Aѹ;s��3Aѹ;s��3Aѹ;s���3�D���m�E���m�E���m�E���m�On��3�Y8��3�Y8��3�Y8��3�Y�>/Nt���f�LPt���f�LPt���f�LPt���f���:ѹ;s��3Aѹ;s��3Aѹ;s��3Aѹ;s����D���m�E���m�E���m�E���m�O���3�Y8��3�Y8�/E���m�E���m�� ��3�Y8��3�Y8��3�Y8��3�Y��>@t���f�LPt���f�LPt���f�LPt���f�z�ѹ;s��3Aѹ;s��3Aѹ;s��3Aѹ;s���ID���m�E���m�E���m�E���m��;��3�Y8��3�Y8��3�Y8��3�Y��*At���f�LPt���f�LPt���f�LPt���f�z�ѹ;s��3Aѹ;s��3Aѹ;s��3Aѹ;s���	D���m�E���m�E���m�E���m��v��3�Y8��3�Y8��3�Y8��3�Y��Bt���f�LPt���f�LPt���f�LPt���f�zF	ѹ;s��3Aѹ;s��3Aѹ;�3Aѹ;���(D���c�E���c�E���c�E���c����3�Y8��3�Y8��3�Y8��3�Y��Ct��<f�LPt��<f�LPt��<f�LPt��<f�z�ѹ;�3Aѹ;�3Aѹ;�3Aѹ;��7D���c�E���c�E���c�E���c�����3�Y8��3�Y8��3�Y8��3�Y���Ct��<f�LPt��<f�LPt��<f�LPt��<f�z�ѹ;�3Aѹ;�3Aѹ;�3Aѹ;��IFD���c�E���c�E���c�E���c��'��3�Y8��3�Y8��3�Y8��3�Y���Dt��<f�LPt��<f�LPt��<f�LPt��<f�zVѹ;�3Aѹ;�3Aѹ;�3Aѹ;��	UD���c�E���c�E���c�E���c��b��3�Y8��3�Y8��3�Y8��3�Y���Et��<f�LPt��<f�LPt��<f�LPt��<f�zѹ;�3Aѹ;�3Aѹ;�3Aѹ;���cD���c�E���c�E���c�E���c����3�Y8��3�Y8��3�Y8��3�Y���Ft��<f�LPt��<f�LPt��<f�LPt��<f�z�ѹ;�3Aѹ;�3Aѹ;�3Aѹ;��rD���c�E���c�E���c�E���c�����3�Y8��3�Y8��3�Y8��3�Y���Gt��<f�LPt��<f�LPt��<f�LPt��<f�zfѹ;�3Aѹ;�3Aѹ;�3Aѹ;��I�D���c�E���c�E����,�	��ݙ�Y��OHt��|���ܝ���3Aѹ;�1g��sw�c��"��3�p&(:wg>f�LPt��|���ܝ����Y�D����,�	��ݙ�Y8��3�p&(:wg>f�z$ѹ;�1g��sw�c�E����,�	��ݙ�Y��;It��|���ܝ���3Aѹ;�1g��sw�c��]��3�p&(:wg>f�LPt��|���ܝ�����D����,�	��ݙ�Y8��3�p&(:wg>f�z�'ѹ;�1g��sw�c�E����,�	��ݙ�Y��'Jt��|���ܝ���3Aѹ;�1g��sw�c�����3�p&(:wg>f�LPt��|���ܝ����٩D����,�	��ݙ�Y8��3�p&(:wg>f�zb+ѹ;�1g��sw�c�E����,�	��ݙ�Y��Kt��|���ܝ���3Aѹ;�1g��sw�c�����3�p&(:wg>f�LPt��|���ܝ���뙸D����,�	��ݙ�Y8��3�p&(:wg>f�z/ѹ;�1g��sw�c�E����,�	��ݙ�Y���Kt��|���ܝ���3Aѹ;�1g��sw�c����3�p&(:wg>f�LPt��|���ܝ����Y�D����,�	��ݙ�Y8��3�p&(:wg>f�z�2ѹ;�1g��w~7g��sw�c�E����,\�u&:wg>f�LPt��|���ܝ���3Aѹ;�1�Ӥ��ݙ�Y8��3�p&(:wg>f�LPt��|���k�sw�c�E����,�	��ݙ�Y8��3�p=9��ܝ���3Aѹ;�1g��sw�c�E����,\��&:wg>f�LPt��|���ܝ���3Aѹ;�5�S�ݙ�Y8��3_�p&(:wg�f�LPt��|���lr�sw�k�E����,�	��ݙ�Y8��3_�p=��ܝ���3Aѹ;�5g��sw�k�E����,\�a':wg�f�LPt��|���ܝ���3Aѹ;�5��߉�ݙ�Y8��3_�p&(:wg�f�LPt��|����y�sw�k�E����,�	��ݙ�Y8��3_�p=��ܝ���3Aѹ;�5g��sw�k�E����,\��':wg�f�LPt��|���ܝ���3Aѹ;�5�S���ݙ�Y8��3_�p&(:wg�f�LPt��|��� :wg�f�LPt��|���ܝ���3Aѹ;�5����ܝ���3Aѹ;�5g��sw�k�E����,\��sw�k�E����,�	��ݙ�Y8��3_�p���ݙ�Y8��3_�p&(:wg�f�LPt��|��� :wg�f�LPt��|���ܝ���3Aѹ;�5����ܝ���3Aѹ;�5g��sw�k�E����,\>�sw�k�E����,�	��ݙ�Y8��3_�pY8��ݙ�Y8��3_�p&(:wg�f�LPt��|���� :wg�f�LPt��|���ܝ���3Aѹ;�5�q��ܝ���3Aѹ;�5g��sw�k�E����,\��sw�k�E����,�	��ݙ�Y8��3_�p�U��ݙ�Y8��3_�p&(:wg�f�LPt��|���t!:wg�f�LPt��|���ܝ���3Aѹ;�5�I��ܝ���3Aѹ;�5g��sw�k�E����,\��sw�k�E����,�	��ݙ�Y8��3_�pYs��ݙ�Y8��3_�    p&(:wg~f�LPt�������!:wg~f�LPt������ܝ���3Aѹ;�3�!��ܝ���3Aѹ;�3g��sw�g�E����,\^"�sw�g�E����,�	��ݙ�Y8��3?�pِ��ݙ�Y8��3?�p&(:wg~f�LPt������`":wg~f�LPt������ܝ���3Aѹ;�3����ܝ���3Aѹ;�3g��sw�g�E����,\�)�sw�g�E����,�	��ݙ�Y8��3?�pY���ݙ�Y8��3?�p&(:wg~f�LPt�������":wg~f�LPt������ܝ���3Aѹ;�3�ы�ܝ���3Aѹ;�3g��sw�g�E����,\1�sw�g�E����,�	��ݙ�Y8��3?�p�ˈ�ݙ�Y8��3?�p&(:wg~f�LPt������L#:wg~f�LPt������ܝ���3Aѹ;�3����ܝ���3Aѹ;�3g��sw�g�E����,\~8�sw�g�E����,�	��ݙ�Y8��3?�pY��ݙ�Y8��3?�p&(:wg~f�LPt�������#:wg~f�LPt������ܝ���3Aѹ;�3����ܝ���3Aѹ;�3g��sw�g�E����,\�?�sw�g�E����,�	��ݙ�Y8��3?�p���ݙ�Y8��3?�p&(:wg~f�LPt������8$:wg~f�LPt������ܝ���3Aѹ;�3�Y��ܝ���3Aѹ;�3g��sw�g�E����,\>G�sw�g�E����,�	��ݙ�Y8��3?�pY$��ݙ�Y8��3?�p&(:wg~f�LPt������$:wg~f�LPt������؝Y?�p&(:vg�V�I�3�'�	��ݙ�x���3�'�	��ݙ��v�8&vg�O,\�3��ǭ�1�;�~bᚠ�؝y�n}�3�'�	��o��6���؝Y��mZ�1�;���ަU��ݙ�[ަՎ�ݙ���6��3뷼Mk;&vg��۴�cbw&��[�����oz�Xbbwf��۴>������m��cbwf���T�1�;��6�~���������1�;��6�8&vg֯�M��3�qoKOL�ά_y��qL�μǽM�:&vg֯�M�9&vg�VoԈ�ݙ�koS/����{����؝Y��6u;&vg���&���3��ަގ�ݙ�����cbwf���ԏcbw�=�m��
1�;�~�m��1�;�z���؝Y��6�rL�μǽM|3#&vg�o�Mӎ�ݙ���i�1�;�~�m��؝y�{��JL�ά�x��qL�μǽM�:&vg�o{��sL�μ��&�q�3뷽M{9&vg��ަ]��ݙ��ަݎ�ݙ���������mo�ގ�ݙ���i�����mo�~�3�qo?���ݙ�;ަ�9&vg�Vo��9&vg��x��rL�μǽM�h$&vg��x�N;&vg��ަ3��ݙ�;ަ��3�qo?���ݙ�;ަ�8&vg��ަ�:&vg���6��1�;�z���3��x���؝y�{��rL�ά��mz�1�;��6q� &vg���6=�1�;��6=�1�;�~���y�3�qoWbbwf�^o��9&vg�Vo��sL�ά��mz�cbw�=�m�EL�ά��mz�1�;��6��؝Y����n����{������؝Y����>��ݙ����}�3��y���1�;�z��T�3��y���؝y�{��rL�ά��m��1�;��6q�%&vg���6}�1�;��6}�1�;�~���{�3�qohbbwf������3o���	��ݙ����؝y��[�1�;��Y8�3����qL�άe�����{�q�qL�άe�����{�s��؝Y�,�	��ݙ����?bbwf-�p&(&vg���&X81�;��Y8�3�qo/	1�;��Y8�3�qo,��؝Y�,�	��ݙ����E &vg�2g�bbw�m�6��ݙ����؝y�{�X?bbwf-�p&(&vg���&X81�;��Y8�3�qoKOL�άe�����{��'&vg�2g�bbw�m�6�G��؝Y�,�	��ݙ���	NL�άe�����{���pbbwf-�p&(&vg���&X81�;��Y8�3�qo�V��ݙ����؝y[�M�pbbwf-�p&(&vg���&���3k��3A1�;��6��ݙ����؝y�{��JL�άe�����{��'&vg�2g�bbw�m�6񍛘؝Y�,�	��ݙ���	NL�άe�����{��ďbbwf-�p&(&vg���&X81�;��Y8�3�qo?���ݙ����؝y[�M�pbbwf-�p&(&vg���&~4�3k��3A1�;��6��ݙ����؝y�{���LL�άe�����{��'&vg�2g�bbw�m�6q &vg�2g�bbw�=�m���3k��3A1�;��6q� &vg�2g�bbw�=�m���3k��3A1�;��6q�!&vg�2g�bbw�m�6��ݙ����؝y�{��h�3k��3A1�;��6��ݙ����؝y�{����3k��3A1�;��6��ݙ����؝y[�M\*��ݙ����؝y�{�`�����Zf�LPL�μǽM\e��ݙ����؝y�{�`�����Zf�LPL�μǽM\���ݙUf�LPL�μ��&&(&vgV��3A1�;�o��cbwf�Y8�3����qL�ά2g�bbw�=���8&vgV��3A1�;����:&vgV��3A1�;�z���CL�ά2g�bbw�=�m���3����؝y�{�xI��ݙUf�LPL�μǽM�pbbwf�Y8�3�qo�@L�ά2g�bbw�m�6��ݙUf�LPL�μǽM�1�;��,�	��ݙ���	NL�ά2g�bbw�=�mb鉉ݙUf�LPL�μǽM�pbbwf�Y8�3o���?j����*�p&(&vg���&X81�;��,�	��ݙ����?�����*�p&(&vg���&X81�;��,�	��ݙ����o+����*�p&(&vg�Vo,��؝Ye�����{���73bbwf�Y8�3�qo,��؝Ye�����{��ķPbbwf�Y8�3�qo,��؝Ye�������m�71�;��,�	��ݙ���	NL�ά2g�bbw�=�m��1�;��,�	��ݙ���	NL�ά2g�bbw�=�m�1�;��,�	��ݙ���'&vgV��3A1�;��6񣑘؝Ye�����{��'&vgV��3A1�;��6���؝Ye�����{��'&vgV��3A1�;�z���3����؝y�{�`�����*�p&(&vg���&.����*�p&(&vg���&X81�;��,�	���-�,\��'&vgV��3A1�;�z�`�����*�p&(&vg���&.Z����*�p&(&vg���&X81�;��,�	��ݙ�����1�;��,�	��ݙ���	NL�ά2g�bbw�m�6q�$&vgV��3A1�;��6��ݙUf�LPL�μǽM\e��ݙUf�LPL�μǽM�pbbwf�Y8�3�qohbbwf�Y8�3o���	��ݙ�f�LPL�μ�ۭ�؝Ym�����{|�u�3����؝y�?n=��ݙ�f�LPL�μ�?����ݙ�f�LPL�μ��&���3����؝y�{�`�����j�p&(&vg���&^bbwf�Y8�3�qo,��؝Ym�����{���"�3����؝y[�M�pbbwf�Y8�3�qo�GL�ά6g�bbw�=�m���3����؝y�{�Xzbbwf�Y8�3�qo,��؝Ym�������m�1�;��,�	��ݙ���	NL�ά6g�bbw�=�m�81�;��,�	��ݙ���	NL�ά6g�bbw�=�m��
1�;��,�	��ݙ���'&vgV��3A1�;��6�͌�؝Ym�����{��'&vgV��3A1�;��6�-��؝Ym�����{��'&vgV��3A1�;�z���ML�ά6g�bbw�=�m���3����؝y�{��qAL�ά6g�bbw�=�m���3����؝y�{��!EL�ά6g�bbw�m�6��ݙ�f�LPL��    �ǽM�h$&vgV��3A1�;��6��ݙ�f�LPL�μǽM�@&&vgV��3A1�;��6��ݙ�f�LPL�μ��&�����j�p&(&vg���&X81�;��,�	��ݙ�����1�;��,�	��ݙ���	NL�ά6g�bbw�=�m��CL�ά6g�bbw�m�6��ݙ�f�LPL�μǽM\���ݙ�f�LPL�μǽM�pbbwf�Y8�3�qo�;bbwf�Y8�3�qo,��؝Ym�������m�RIL�ά6g�bbw�=�m���3����؝y�{����3����؝y�{�`�����j�p&(&vg���&.������p&(&vg�Vm�3k���؝y��[�1�;��,�	��ݙ��v�8&vg֘�3A1�;��z�3k���؝y�n}�3k���؝y[�M��!&vg֘�3A1�;��6��ݙ5f�LPL�μǽM�$�����p&(&vg���&X81�;��,�	��ݙ����E &vg֘�3A1�;�z�`������p&(&vg���&֏�؝Yc�����{��'&vg֘�3A1�;��6�������p&(&vg���&X81�;��,�	��ݙ����5bbwf�Y8�3�qo,��؝Yc�����{���pbbwf�Y8�3�qo,��؝Yc�����{��ķbbwf�Y8�3o��	NL�ά1g�bbw�=�m�1�;��,�	��ݙ���	NL�ά1g�bbw�=�m�[(1�;��,�	��ݙ���	NL�ά1g�bbw�m�6񍛘؝Yc�����{��'&vg֘�3A1�;��6�゘؝Yc�����{��'&vg֘�3A1�;��6�C��؝Yc�������m���3k���؝y�{���HL�ά1g�bbw�=�m���3k���؝y�{���LL�ά1g�bbw�=�m���3k���؝y[�M\��ݙ5f�LPL�μǽM�pbbwf�Y8�3�qo�bbwf�Y8�3�qo,��؝Yc�����{��ĕ��؝Yc�������m���3k���؝y�{��h�3k���؝y�{�`������p&(&vg���&�w�����p&(&vg���&X81�;��,�	��ݙ���ĥ��؝Yc�����{��'&vg֘�3A1�;��6q�%&vg֘�3A1�;��6��ݙ5f�LPL�μǽM\���ݙ�,�	��ݙ�,�	���3�Y8;wgn�p}��ع;s��3A�sw�6g�b���m���ݙ�,\"%v���f�LP�ܝ���ع;s��3Aq[�m2�GW���3�Y8;wgn�p&(v���f�LP�ܝ�����Yb���m���ݙ�,�	���3�Y8;wgn�p}L�ع;s��3A�sw�6g�b���m���ݙ�,\&v���f�LP�ܝ���ع;s��3A�sw�6�G����3�Y8;wgn�p&(v���f�LP�ܝ����Ahb���m���ݙ�,�	���3�Y8;wgn�p}��ع;s��3A�sw�6g�b���m���ݙ�,\�&v���f�LP�ܝ���ع;s��3A�sw�6�G͉��3�Y8;wgn�p&(v���f�LP�ܝ����wb���m���ݙ�,�	���3�Y8;wgn�p}��ع;s��3A�sw�6g�b���m���ݙ�,���b���m���ݙ�,�	���3�Y8;wgn�p=B�ع;s��3A�sw�6g�b���m���ݙ�,\. v���f�LP�ܝ���ع;s��3A�sw�6�����3�Y8;wgn�p&(v���f�LP�ܝ�����b���m���ݙ�,�	���3�Y8;wgn�p=�ع;s��3A�sw�6g�b���m���ݙ�,\� v���f�LP�ܝ���ع;s��3A�sw�6�c0���3�Y8;wgn�p&(v���f�LP�ܝ�����b���m���ݙ�,�	���3�Y8;wgn�p=�ع;s��3A�sw�6g�b���m���ݙ�,\!v���f�LP�ܝ���ع;s��3A�sw�6��M���3�Y8;wg�p&(v��<f�LP�ܝy���Pb���c���ݙ�,�	���3�Y8;wg�p=ʅع;�3A�sw�1g�b���c���ݙ�,\�!v��<f�LP�ܝy��ع;�3A�sw�1�ck���3�Y8;wg�p&(v��<f�LP�ܝy����b���c���ݙ�,�	���3�Y8;wg�p=��ع;�3A�sw�1g�b���c���ݙ�,\"v��<f�LP�ܝy��ع;�3A�sw�1�㈈��3�Y8;wg�p&(v��<f�LP�ܝy���$b���c���ݙ�,�	���3�Y8;wg�p=z�ع;�3A�sw�1g�b���c���ݙ�,\|"v��<f�LP�ܝy��ع;�3A�sw�1�c����3�Y8;wg�p&(v��<f�LP�ܝy���p+b���c���ݙ�,�	���3�Y8;wg�p=R�ع;�3A�sw�1g�b���c���ݙ�,\�"v��<f�LP�ܝy��ع;�3A�sw�1��È��3�Y8;wg�p&(v��<f�LP�ܝy����2b���c���ݙ�,�	���3�Y8;wg�p=*�ع;�3A�sw�1g�b���c���ݙ�,\h#v��<f�LP�ܝy��ع;�3A�sw�1�cም�3�Y8;wg�p&(v��<f�LP�ܝy���0:b���c���ݙ�,�	���3�Y8;wg�p=�ع;�3A�sw�1g�b���c���ݙ�,\�#v��<f�LP�ܝy��ع;�3A�sw�1������3�Y8;wg�p&(v��<f�LP�ܝy����Ab����,�	���3�p&(v��|��ع;�1ף���3�p&(v��|��ع;�1g�b����,\T$v��|��ع;�1g�b����,�	���3�p=Ƒع;�1�����F�%	��
�0]��]N9.�Mg�@�SA�hӂq�vf�µ`���Y�p-'og.�?)���Y�p-'og.\��ۙ�ׂq�vf�������ۙ�ׂq�vf�µ`���Y�p-'og.�?�)���Y�p-'og.\��ۙ�ׂq�vf������ۙ�ׂq�vf�µ`���Y�p-'og.�?
*���Y�p-'og.\��ۙ�ׂq�vf���S���ۙ�ׂq�vf�µ`���Y�p-'og.�?�*���Y�p-'og.\��ۙ�ׂq�vf�������ۙ�ׂq�vf�µ`���Y�p-'og.�?�*���Y�p-'og.\��ۙ�ׂq�vf������ۙ�ׂq�vf�µ`���Y�p-'og.�?l+���Y�p-'og.\��ۙ�ׂq�vf���s���ۙ�ׂq�vf�µ`���Y�p-'og.�?�+���Y�p-'og.\��ۙ�ׂq�vf�������ۙ�ׂq�vf�µ`���Y�p-'og.�?X,���Y�p-'og.\��ۙ�ׂq�vf���3���ۙ�ׂq�vf�µ`���Y�p-����������ۙ�ׂq�vf�µ`���Y�p-'og.�?	-���Y�p-'og.\��ۙ�ׂq�vf���C���ۙ�ׂq�vf�µ`���Y�p-'og.�?-���Y�p-'og.\��ۙ�ׂq�vf�������ۙ�ׂq�vf�µ`���Y�p-'og.�?�-���ٸp-'og6.\��ۙ�ׂq�vf������ۙ�ׂq�vf�µ`���ٸp-'og6.�?k.���ٸp-'og6.\��ۙ�ׂq�vf���c���ۙ�ׂq�vf�µ`���ٸp-'og6.�?�.���ٸp-'og6.\��ۙ�ׂq�vf�������ۙ�ׂq�vf�µ`���ٸp-'og6.�?W/���ٸp-'og6.\��ۙ�ׂq�vf���#���ۙ�ׂq�vf�µ`���ٸp-'og6.�?�/���ٸp-'og6.\��ۙ�ׂq�vf��N��l\����3�����ƅk�8y;�q��'og6.\��ۙ�    ׂq�vf�µ`���ٸp����3�����ƅk�8y;�q�Z0N��l\����ۙ�ׂq�vf�µ`���ٸp-'og6.ܡ����ƅk�8y;�q�Z0N��l\����3p�vf�µ`���ٸp-'og6.\��ۙ�w�B8y;�q�Z0N��l\����3�����ƅ;�!���ٸp-'og6.\��ۙ�ׂq�vf���N��l\����3�����ƅk�8y;�q�Ά'og6.\��ۙ�ׂq�vf�µ`���ٸp�J���3�����ƅk�8y;�q�Z0N��l\�)��ۙ�ׂq�vf�µ`���ٸp-'og6.�a����ƅk�8y;�q�Z0N��l\����3��p�vf�µ`���ٸp-'og6.\��ۙ�w�F8y;�q�Z0N��l\����3�����ƅ;}#���ٸp-'og6.\��ۙ�ׂq�vf���N��\����3�������k�8y;sp���'og.\��ۙ�ׂq�v��µ`���9�pǅ���3�������k�8y;sp�Z0N��\��F��ۙ�ׂq�v��µ`���9�p-'og.�!%������k�8y;sp�Z0N��\����3�|�p�v��µ`���9�p-'og.\��ۙ�w4J8y;sp�Z0N��\����3�������;U%���9�p-'og.\��ۙ�ׂq�v����N��\����3�������k�8y;sp��r	'og.\��ۙ�ׂq�v��µ`���9�p�����3�������k�8y;sp�Z0N��\�d��ۙ�ׂq�v��µ`���9�p-'og.��3������k�8y;sp�Z0N��\����3�ܚp�v��µ`���9�p-'og.\��ۙ�w�M8y;sp�Z0N��\����3�������;-'���9�p-'og.\��ۙ�ׂq�v����N��\����3�������k�8y;sp���	'og.\��ۙ�ׂq�v��µ`���9�p�����3�������k�8y;sp�Z0N��\�����ۙ�ׂq�v��µ`���9�p-'og.ܡB������k�8y;sp�Z0N��\����3�<�p�v��µ`���9�p-'og.\��ۙ�w�Q8y;sp�Z0N��\����3�������;)���9�p-'og.\��ۙ�ׂq�v����N��\����3�������k�8y;sp��^
'ng�?\���3ߧ�&/7ng�?�p/7ng��O?p�v�����q�v�{~�t��3ן]���3����n��\v�^0n��|χOܸ����½`�O�k�qM�?p�v���qM��q;�=�~�q;s�����7ng��\�o��3�ߏk�p�v�{�5�.�q;s����_��3�s���������qM�7ng�O���ܸ���>�����3�s�����ۙ��㚾n��|Ϲ�o��3���5}ܸ���sM�7ng���k�
ܸ���sM_��3��⚾7ng�O���n��\�kZ?p�v�{�5�ܸ���״�q;�=��7ng���5�n��|Ϲ�u��ۙ�oqM���ۙ�9״ܸ���6״ܸ��>���q;s�m�i���ۙ�9״?p�v���\�^������k�ܸ���6״�q;�=��7ng���5�7ng��\�np�v��;\�p�v���k:�����w���7ng��\����ۙ��pMg��3�s��lp�v��;\�9������k:ܸ����t
ܸ���sM���ۙ��rMg��ۙ�S�����3����ܸ���sM�7ng���5�n��|Ϲ����ۙ��rM���3�s��^p�v���\�-p�v�{�5�7ng�����3ߧ\S���3�_qM�7ng��\S}�����W\S-p�v�{�5�7ng�����3�s��.�q;s��Tn��|Ϲ�jp�v��k��ܸ��>��ܸ����k��q;�=��7ng���z��3�s��7�q;s�5��ܸ���sM}��ۙ믹�.p�v�{�5u��3��pM=�����)�4�����7\����ۙ�9�4�q;s��4ܸ���sM���ۙ�o��9������k�n��\�5M��3�s�iܸ��~\��q;�}�k҂q�v���µ`ܸ���/>���ۙ�ׂq�v�{~�t��3�����������3�������|����ۙ�ׂq�v���$.ܸ��~�p-7ng�pMr�ۙ�ׂq�v����ܸ��~�p-7ng�pMr�ۙ�ׂq�v���$.ܸ��~�p-7ng�O�&�p�����Åk��q;�=���3��������k�n��\?\���3�s�I.\�q;s�p�Z0n��|Ϲ&�p�����Åk��q;�}�5Ʌ7ng�.\ƍۙ�9�$.ܸ��~�p-7ng��\�\�p�v���µ`ܸ���sMr�ۙ�ׂq�v�{�5Ʌ7ng�.\ƍۙ�S�I.\�q;s�p�Z0n��|Ϲ&�p�����Åk��q;�=���3��������k�n��\?\���3�s�I.\�q;s�p�Z0n��|�rMr�ۙ�ׂq�v�{�5Ʌ7ng�.\ƍۙ�9�$.ܸ��~�p-7ng��\�\�p�v���µ`ܸ���sMr�ۙ�ׂq�v���k�n��\?\���3�s�I.\�q;s�p�Z0n��|Ϲ&�p�����Åk��q;�=���3��������k�n��\?\���3ߧ\�\�p�v���µ`ܸ���sMr�ۙ�ׂq�v�{�5Ʌ7ng�.\ƍۙ�9�$.ܸ��~�p-7ng��\�\�p�v���µ`ܸ��>���3��������k�n��\?\���3�s�I.\�q;s�p�Z0n��|Ϲ&�p�����Åk��q;�=���3�������)�$.ܸ��~�p-7ng��\�\�p�v���µ`ܸ���sMr�ۙ�ׂq�v�{�5Ʌ7ng�.\ƍۙ�9�$.ܸ��>\���3ߧ�&-7ng�������|��n��\.\ƍۙ����n��\.\ƍۙ�y��7ng�������|����ۙ�Åk��q;�}�5Ʌ7ng��������k�n��\.\ƍۙ�9�$.ܸ��>\���3�s�I.\�q;s}�p-7ng��\�\�p�v��p�Z0n��|�rMr�ۙ�Åk��q;�=���3ׇׂq�v�{�5Ʌ7ng��������k�n��\.\ƍۙ�9�$.ܸ��>\���3ߧ\�\�p�v��p�Z0n��|Ϲ&�p������µ`ܸ���sMr�ۙ�Åk��q;�=���3ׇׂq�v�{�5Ʌ7ng�������)�$.ܸ��>\���3�s�I.\�q;s}�p-7ng��\�\�p�v��p�Z0n��|Ϲ&�p������µ`ܸ���sMr�ۙ�Åk��q;�}�5Ʌ7ng��������k�n��\.\ƍۙ�9�$.ܸ��>\���3�s�I.\�q;s}�p-7ng��\�\�p�v��p�Z0n��|�rMr�ۙ�Åk��q;�=���3ׇׂq�v�{�5Ʌ7ng��������k�n��\.\ƍۙ�9�$.ܸ��>\���3ߧ\�\�p�v��p�Z0n��|Ϲ&�p������µ`ܸ���sMr�ۙ�Åk��q;�=���3ׇׂqO�W8.\ƍۙ�Åk��q;�}�5Ʌ7ng��������k�n��\.\ƍۙ�9�$.ܸ��>\���3�s�I.\�q;s}�p-7ng��\�\�p�v��p�Z0n��|�rMr�ۙ�Åk��q;�=���3ׇׂq�v�{�5Ʌ7ng��������k�n��\.\ƍۙ�9�$.ܸ��.\ƍۙ�S_���3�k��q;�=_|���3�k��q;�=?|���ۙk�µ`ܸ����^p�v�Z�p-7ng��çn��\������)�$.ܸ��.\ƍۙ�9�$.ܸ��.\ƍۙ�9    �$.ܸ��.\ƍۙ�9�$.ܸ��.\ƍۙ�9�$.ܸ��.\ƍۙ�S�I.\�q;s-\���3�s�I.\�q;s-\���3�s�I.\�q;s-\���3�s�I.\�q;s-\���3�s�I.\�q;s-\���3ߧ\�\�p�v�Z�p-7ng��\�\�p�v�Z�p-7ng��\�\�p�v�Z�p-7ng��\�\�p�v�Z�p-7ng��\�\�p�v�Z�p-7ng�O�&�p���̵p�Z0n��|Ϲ&�p���̵p�Z0n��|Ϲ&�p���̵p�Z0n��|Ϲ&�p���̵p�Z0n��|Ϲ&�p���̵p�Z0n��|�rMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ��>���3�k��q;�=���3�k��q;�=���3�k��q;�=���3�k��q;�=���3�k��q;�}�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v���k�n��\�������k�n��\�������k�n��\�������k�n��\�������k�n��\������)�$.ܸ��.\ƍۙ�9�$.ܸ��.\ƍۙ�9�$.ܸ��.\ƍۙ�9�$.ܸ��.\ƍۙ�9�$.ܸ��6.\ƍۙ�S_���3�ƅk��q;�=_|���3�ƅk��q;�=?|���ۙk�µ`ܸ����^p�v�ڸp-7ng��çn��\������)�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�S�I.\�q;sm\���3�s�I.\�q;sm\���3�s�I.\�q;sm\���3�s�I.\�q;sm\���3�s�I.\�q;sm\���3ߧ\�\�p�v�ڸp-7ng��\�\�p�v�ڸp-7ng��\�\�p�v�ڸp-7ng��\�\�p�v�ڸp-7ng��\�\�p�v�ڸp-7ng�O�&�p���̵q�Z0n��|Ϲ&�p���̵q�Z0n��|Ϲ&�p���̵q�Z0n��|Ϲ&�p���̵q�Z0n��|Ϲ&�p���̵q�Z0n��|�rMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ���sMr�ۙk�µ`ܸ��>���3�ƅk��q;�=���3�ƅk��q;�=���3�ƅk��q;�=���3�ƅk��q;�=���3�ƅk��q;�}�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v�{�5Ʌ7ng��ׂq�v���k�n��\�������k�n��\�������k�n��\�������k�n��\�������k�n��\������)�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�9�$.ܸ��6.\ƍۙ�9�$.ܼ�yp�Z0n��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\��4�&\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\���ۙ���v���k����yp�Z0*og\��gT��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T��<�p-��3.\F��̃ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T�μ�p-��3/.\F��̋ׂQy;��µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3��N�W8.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��,\���ۙ�ׂQy;�p�Z0*og.\F���k����Y�p-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��    l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F���ƅk����ٸp-��3���vf�µ`T��l\���ۙ�ׂQy;�q�Z0*og6.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T��\���ۙ�ׂQy;sp�Z0*og.\F�����k����9�p-��3���v��µ`T����p-�3ߧ�&/�3��]���ۙ����t���v�^0:ng��O7踝���½`t��|ϋO/踝���½`t��|χOt���v�^0ާ�5����踝��~\��:ng��\���3�ߏk�-�q;�=�~t���?��w@�����k�]�q;s����_��ۙ�9��k�q;s�}\�o@����)�����ۙ��㚾踝��sM�:ngk�踝��sM��3���5}t��|Ϲ�ۙ��㚾�3�s��k�q;s�-���q;�}�5�?�q;s�-�i�@�����kZ踝��״踝��sMk��ۙ�oqM뀎ۙ�9״.踝��״
t��|Ϲ�ՠ�v���\��q;�}�5�?�q;s�m�i�@�����k�踝��6״踝��sM{��ۙ�osM���ۙ�9״/踝��6״t��|Ϲ�ݠ�v��;\��q;�}�5�?�q;s����@�����k:踝���t踝��sMg��ۙ��pM瀎ۙ�9�t.踝���t
t��|Ϲ�Ӡ�v���\��q;�}�5�?�q;s�]���@�����k�踝��.�t踝��sMw��ۙ��rM���ۙ�9�t/踝��.�tt��|Ϲ�۠�v��+��踝�>��t����5�t��|Ϲ��@����W\S-�q;�=�j��ۙ����:��v�{�5��3�_qMU��v�{�5U��ۙ�����q;�}�5�踝���k�踝��sM���ۙ����^��v�{�5��3�_sM}@�����k�:ng�暺@�����k��3��pM=��v���k�?�q;s��4?�q;�=���3��pM�@�����k�:ng��怎ۙ�9�4t����5M��ۙ�9�4:ng���4:ng�O}MZ0:ng�.\F����|��:ng�.\F��������3����v�{^|zA����Åk�踝���6踝��p-�3ߧ\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng�O�&�p��v���µ`t��|Ϲ&�p��v���µ`t��|Ϲ&�p��v���µ`t��|Ϲ&�p��v���µ`t��|Ϲ&�p��v���µ`t��|�rMr�B����Åk�踝��sMr�B����Åk�踝��sMr�B����Åk�踝��sMr�B����Åk�踝��sMr�B����Åk�踝�>���ۙ��ׂ�q;�=���ۙ��ׂ�q;�=���ۙ��ׂ�q;�=���ۙ��ׂ�q;�=���ۙ��ׂ�q;�}�5Ʌ�3����v�{�5Ʌ�3����v�{�5Ʌ�3����v�{�5Ʌ�3����v�{�5Ʌ�3����v���k�:ng�.\F�����k�:ng�.\F�����k�:ng�.\F�����k�:ng�.\F�����k�:ng�.\F����)�$.t���?\���ۙ�9�$.t���?\���ۙ�9�$.t���?\���ۙ�9�$.t���?\���ۙ�9�$.t���?\���ۙ�S�I.\踝��p-�3�s�I.\踝��p-�3�s�I.\踝��p-�3�s�I.\踝��p-�3�s�I.\踝��p-�3ߧ\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng��\�\��q;s�p�Z0:ng��\�\��q;s�p-�3ߧ�&-�3��ׂ�q;�=_|���ۙ�Åk�踝��>ݠ�v��p�Z0:ng��ŧt���.\F����|��A�����µ`t��|�rMr�B�����µ`t��|Ϲ&�p��v��p�Z0:ng��\�\��q;s�p-�3�s�I.\踝�?\���ۙ�9�$.t���.\F����)�$.t���.\F�����k�:ng����v�{�5Ʌ�3��ׂ�q;�=���ۙ�Åk�踝��sMr�B�����µ`t��|�rMr�B�����µ`t��|Ϲ&�p��v��p�Z0:ng��\�\��q;s�p-�3�s�I.\踝�?\���ۙ�9�$.t���.\F����)�$.t���.\F�����k�:ng����v�{�5Ʌ�3��ׂ�q;�=���ۙ�Åk�踝��sMr�B�����µ`t��|�rMr�B�����µ`t��|Ϲ&�p��v��p�Z0:ng��\�\��q;s�p-�3�s�I.\踝�?\���ۙ�9�$.t���.\F����)�$.t���.\F�����k�:ng����v�{�5Ʌ�3��ׂ�q;�=���ۙ�Åk�踝��sMr�B�����µ`t��|�rMr�B�����µ`t��|Ϲ&�p��v��p�Z0:ng��\�\��q;s�p-�3�s�I.\踝�?\��>�_�p-�3��ׂ�q;�}�5Ʌ�3��ׂ�q;�=���ۙ�Åk�踝��sMr�B�����µ`t��|Ϲ&�p��v��p�Z0:ng��\�\��q;s�p-�3ߧ\�\��q;s�p-�3�s�I.\踝�?\���ۙ�9�$.t���.\F�����k�:ng����v�{�5Ʌ�3�k�踝�>�5i�踝�.\F����|��    :ng�ׂ�q;�=?|�A��̽p�Z0:ng��ŧt������v�{>|ڠ�v�^�p-�3ߧ\�\��q;s/\���ۙ�9�$.t������v�{�5Ʌ�3�k�踝��sMr�B��̽p�Z0:ng��\�\��q;s/\���ۙ�S�I.\踝�.\F�����k�:ng�ׂ�q;�=���ۙ{�µ`t��|Ϲ&�p��v�^�p-�3�s�I.\踝�.\F����)�$.t������v�{�5Ʌ�3�k�踝��sMr�B��̽p�Z0:ng��\�\��q;s/\���ۙ�9�$.t������v���k�:ng�ׂ�q;�=���ۙ{�µ`t��|Ϲ&�p��v�^�p-�3�s�I.\踝�.\F�����k�:ng�ׂ�q;�}�5Ʌ�3�k�踝��sMr�B��̽p�Z0:ng��\�\��q;s/\���ۙ�9�$.t������v�{�5Ʌ�3�k�踝�>���ۙ{�µ`t��|Ϲ&�p��v�^�p-�3�s�I.\踝�.\F�����k�:ng�ׂ�q;�=���ۙ{�µ`t��|�rMr�B��̽p�Z0:ng��\�\��q;s/\���ۙ�9�$.t������v�{�5Ʌ�3�k�踝��sMr�B��̽p�Z0:ng�O�&�p��v�^�p-�3�s�I.\踝�.\F�����k�:ng�ׂ�q;�=���ۙ{�µ`t��|Ϲ&�p��v�^�p-�3ߧ\�\��q;s/\���ۙ�9�$.t������v�{�5Ʌ�3�k�踝��sMr�B��̽p�Z0:ng��\�\��q;so\���ۙ�S_���ۙ{�µ`t��|��~��v�޸p-�3��çt������v�{^|zA��̽q�Z0:ng��ç:ng�ׂ�q;�}�5Ʌ�3�ƅk�踝��sMr�B��̽q�Z0:ng��\�\��q;so\���ۙ�9�$.t������v�{�5Ʌ�3�ƅk�踝�>���ۙ{�µ`t��|Ϲ&�p��v�޸p-�3�s�I.\踝�7.\F�����k�:ng�ׂ�q;�=���ۙ{�µ`t��|�rMr�B��̽q�Z0:ng��\�\��q;so\���ۙ�9�$.t������v�{�5Ʌ�3�ƅk�踝��sMr�B��̽q�Z0:ng�O�&�p��v�޸p-�3�s�I.\踝�7.\F�����k�:ng�ׂ�q;�=���ۙ{�µ`t��|Ϲ&�p��v�޸p-�3ߧ\�\��q;so\���ۙ�9�$.t������v�{�5Ʌ�3�ƅk�踝��sMr�B��̽q�Z0:ng��\�\��q;so\���ۙ�S�I.\踝�7.\F�����k�:ng�ׂ�q;�=���ۙ{�µ`t��|Ϲ&�p��v�޸p-�3�s�I.\踝�7.\F����)�$.t������v�{�5Ʌ�3�ƅk�踝��sMr�B��̽q�Z0:ng��\�\��q;so\���ۙ�9�$.t������v���k�:ng�ׂ�q;�=���ۙ{�µ`t��|Ϲ&�p��v�޸p-�3�s�I.\踝�7.\F�����k�:ng�ׂ�q;�}�5Ʌ�3�ƅk�踝��sMr�B��̽q�Z0:ng��\�\��q;so\���ۙ�9�$.t������v�{�5Ʌ��3.\F��̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`�O�kk����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v���k����yp�Z0&og\���ۙ�c�v�������̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̃ׂ1y;��µ`L��<�p-��3.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\���̋ׂ1y;��µ`L�μ�p-��3/.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0����µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����k����Y�p-��3�c�vf�µ`L��,\���ۙ�ׂ1y;�p�Z0&og.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y; �  �q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��l\���ۙ�ׂ1y;�q�Z0&og6.\����ƅk����ٸp-��3�c�vf�µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\������k����9�p-��3�c�v��µ`L��\���ۙ�ׂ1y;sp�Z0&og.\�����ׂ1q;�}�k��������߿���      b      x��[r�:�.����q"���Uč )J��t�Z����q����y��SG���P��� xI�d��ڽ�W�ɺ�K$�L�p����!�8��-��很���-w���s��VFwiB��ݟ{�!�.��1�q���\`o�N[���˚�~/����������}M%����)5p��R��^^�c�a�|���c��j�z|xX?��,����}�u
Q_'�i[��� ���c$E��4�!6�ӆ�:�6���9WHB���J!�+�4��t�%IF�gj�d�>R������:���qP ��05@���'�U���q��O�<��I����4������EeA�C&�Z^k4�4n�~�'-d�oۉƕR��_��r]���T@��7���/44�"0�/.��� RS �hS��?���8h_�~[|��Yc�ت���$����y��J����Ʈ���w�-<l5��_��Tc}"S�P�I{�˅gq����ՠ��[z̛�������(�[�83K�9ո�P��#��%(�k䄠HoN��'|��xxO�D�P�z�Y��P���լ?�Y܂x�$�=�ῒ�c�3|ۚ9Ҧ�T�Y�<�n��,�t�Y�b|��&r�S���K{ƚЅ�.&�~��h��}̪�qW�M�٠0*P�	�6:��:7��tHM�3�]��4QO j���i�u'�l`��[���D�)@���oӰ�����p���S'��VZ��3|�Ǟy�l�أoXpX?��Eoj��&�A���]��.�s�9�6,Ue�n���Mx0E��/&N�H��R"����M��R$�0�_w�=%#��a�jY�a�I��a�-�ޚ��V�A?"��w��ko)E\ӭ�5Ȗ�S*��ɷ����+�kA�ص=�Q��R[3,��@����1r�:bjG,4�;���S��I;Ň�q.�����w,Yy?k�o:�v�J���x�����r&�m�� �صt����E�r`C)��'��mT �'�}���P���M����U���H3�I�vFխ���P��3^J=k��4�od���^^m��rfe��ۣg��3� ̓}������������;u�>��RW?�"W�Յcs�U��I;-u ��
d�#��lV�����I<__	9�� h&�l��~���zB$vD*H�įɭ���=����^/y.�����m(ϡqS��9�o1��bg���z ����?�����6����g��Z��I!Kt�5��E���b6N����_b
�MH� ��(��Xf���� (��0��.��I��l�@^� �(��h��6�_��R!=��x�ܯ��_��O����6���z�C��ϟ%$X����A��󝎔��_0�_[=��t���g��D�1�	�����Q�=ũ.kp=�ip���"?�>O$	JuY��urH�:�l�D�_��o=�i���*~1~)3t��<OlDg��SO<a��I%���<�.��9��k}|��~��Mq��m����`s�h���<*����=A��,��v��q5�7p�Ox�I^�N�������x�^c�b�'��X�����]�6����`���vYs?�]yCK�J�*8c�5��w�:�;?�؟_s;"Z��9�q<��&�]��la�:���}#X��u:���^�F�sZR�&�5���Q�O���wQ�:����'`���H�����1�o����ui:�x}7�֥�^L�����
��Oj�������tB����ct}��?c�I;��&^��l����_J�\�jk�7S%�����������ۧ6�3S m`�g�(���>�w|�?�x���K�5�'��N��,��!�l�g}�M���⊓#Iz�����z'��|qDCB=�α�G~ff48a�H�F^����~��N��I,<�.u���8��bs�~ы�������A�g*&I�wq��9��O��1�y��i�:{�J��9�>=�ЛY����zV#o�[W�o��|��K���_����%�9����a�i�J���¯��U[{؛i�B���J�ԅ���u�L�8	h�t����o��%�;�*.��R�*hC�z��qU]X�0E�b�b��[Q�y=]k�����������U�&#2sd�I2�2(ag�G\�2�A��:�����p��WT�e��u���� `��
�T@{1u�ܮ�� ;�%d4�)�MlDk%U���z����T&x������p$�)q$�J�?�`����$����Q�6�e}�ѩBN�1�oP!C'E� ����m"�v�~l�8c���h��mP�{#���0�����D�`�l���7��cW��3�"(���h�I��<�#��/EEI��<��)�"R�. #a=�L�3t;m̪h�7]6��0&�y� �I�He��">�	�s6�`�Ig7�Љ���M=�T?y�c����~:p��e7��E$~�m'g)~�.�ԲJXjG!����6\]5�����I�1���ns���%CF%���y.Iv���N����#�� ���I\���7w�Ŝ1��\�Eu�4t�?�����g�/�R�Ck$#h�i�ɆF*� (d�|u֔�Ul ��D��/�;�ʲ� ���6��!��HbO���AFӐ�kO�$&%t7.6�;l&Ψ��~\��d��|�6R �R�g��-�fZ�C��j��e�&q�Sn����pJ���5����J���,����&�ޔ2~fx:�ئ��f�$t�qL�@VU[a���U���OjJ⴩��2��e�0,ܔ�YC}m8�&̉�D2,�!!�B��y�s]��[�BPα8TB<�lu�pG4S������`3�,�'�"qk�q��w����$!�F�M�V�&�]� 9K�y��$pf7��x��Op�K�%u�Ķ
����o@��@�Ye�贈�M�&q��:�I5�2m��C��~���V$�f�$�WMs^�yT4�c��DB��z�����y�Бy�hMI�;�NQ;��Gv	��"i�}f;E����kvH{I�(ka���=�JhMuE��P9���0��P>@kz�'9�4�J��К�~�QI~Z@���&:��������ܪ�G�ӗ:����{��++`
�i"۰�=l���.R�	t�H3�����S���X��q�O}�F\o��j�(6I'֮#G�:�7��pO�sڨ�b�i�i7z��uv�	��ŉQ3ƴ��6R�>w��*p{p���<�R��e�3��5ss	��JI�ӊ����l��)��p�WJ]��{{�M��gZ�#q�XJ��R��٨;����D�����"��p�}~�Ht/1L�(
L�ᯏy$��z�É��Ϊ�j������ڎ�u_)�Je%dF	�����J�`��Rf�]�:��i�<-�5a���������G/?%����,�؀�O�?-��B�k���e͙%�7N�:��Y�v,����?N�F��n,��%��9��EѕC�ؾ��j`o����,��)bG��m��b��*�g&C�O��K��wZ�����;dB�H�����ה�,�a�i�~����҅���*�t�p7����S����by���.�y��n��%+��4�	ێ3K=�V�z�<���v3#ϫ/"~�Ǵ�^�����t����������8����w�����"%�8�����
��u��u�H���8�aRO���Kʢ��]� �[bb�,u���+`���g�X�r�����\�lC���B�L��H	V_H�nk�zR^���&����iH���ؖ2K�.����-��I��� |R[:�Բ��mI��m���u��Q{h�M�ؓmc�'�=a0��d��c�qtwa��p��q�E$��ČE��	Ųa��{=���}XV�b%�=�F�wP/_�KKm������,I�WzRk�3�ELD/���NA6�ս�/j߶[���I�����+���#q�M��U��8Mnbl�]gg} ,��MJl�`�M����`�o�NsR'xk�c=p�    ŭ�jb�����&���3؃>Otl7uF�/-i=4xJp'<���*�Q�_���D���+��H��@�1��y�����x-N򒤩�޿�m6 40+AT�r:��Yk@>ѹ#~�!q܏����5��F�^�����֫�������D��(�$mh�4���/l��o5�ݗ
�Z|��r�rք��]x�����ry��1p)~����1�^�t�u��E�����/�o��/���j�D��+ic�vi����r�z����X�4�j7R(�H|�ŋ��L�sƑ�o�HY��m\�ݨN�w\b��.�i�55�����>x��]�X<Ï�%o*��@	^w�Z����`��D��R4���΃/\�����c)���ͩ�y���n~V=�E�E���C�f�W+2��7�
�gI*wಧ�|Gw@|�N�q�����͢�5AiB�i��T���/ջ{�S�]L���e�Y���o�!�n�D���l����z�t%��ߦ�R���0fM���1�V���2���r���c���-_i��e�Y�F/ ��Y<��vn1�y�� x���}[��6��>?ܯ��f�_,�[�)f���B_'y����Y�f.K}������8��ثF^�1��V�'Rc���^��rͪ��������V�ˀ|�uT�|(vK-�f��(h	�(ԇ������ȃ0����Ŵ]�X_�u�� �ȳ�r���*�s<�˶uY*�wϏQ%�����Kr�F�/ER��E~ȋ���5`�
�,�EQp��ۻ���.��<�c�����Lę����H��(��������Wʥ���|�V2�1��E�F.tM��_?JM�#k%�&�o���:1k:��Ԃ�3�6�J�l��P)�nŉ���1�(��a[�,_H� ��e��4�TCҙ��d�ť1��`2F���L�=Z���@g�9�ޟ�X��U�����Y�u�[IGq�	���l��ޜ&�wDsI)ᥚ0dCQ*�ZE���\���A
������A�A��HWKum6����JfN�B�.�t�V�����ȧ�����&4��\O����䫤�2?~�����Hͻ/���Q�혐sI���n�̙��D�K�V�J9�E��3i2����<����5I�����0��c����r�J
C������	�TLfR��6X/���F���z�R�(*���I�җ�R�c����yuk��/}�"��L�8�������5~\��vС-��p��*s<7�2H�o�!�^/+S&�P���=i��jQ��~u�-�կ��qU��)��{�$�v�����x�U�����?8$n�}����6���$�}} ����J!ݞց=LMI�[9�Л}�K[b��Hi�z@��V%T�/c�E�Eh���u���'$�E&h��䑶a�N����M�����s�
fW��^5YT�^1�S���H���nH-:�O��/�p�z�ag��>+���p��:��%,��Cri���ꊦ��&c$:<m�-��&#C��F�B�a��Si�y��S�>d��t0������&w�+\��w���:�`h��b&0&m���u'~�j7Wm��R��&C�Nv����/��GSǤ���� �e�h�9Db�DJQ�(+DB�H�<Q��坐O�x1Qb8A��m��U��nћ�J�#����\wѳM^�N�~��d����V��F�; �e�s�`1�1N�v/Z!b_�(�J!	�#��r�y��@�H���P�jI���Z �a(oi,�ҀNt��]#�i�(�-^ze���lFg�`�xsH�=}�Ԍ8�=���:<a�P��{=���`�rk�T���+ �F�B�}sv�,A"�D���u�=���x�h:K7'��R�L��/��
ؠg�����F @=�1��%�^L�Jw�C8�X,�j�M�@�3���(�|��E޲Q� ��op/e���z�<č���1߭���>��GG�&�.��E�~�'��I�8N������;{�S��0btD���W��,v=^o�����*����v�c���n�Eg�?L����`YC�a�jR�����m�R�6ڳ���(���l#��UQ'5�nI�IM�R}zKɜK�����>�Qg�ԫ:�z3QD�d- #mS�}�S�{�@�M��ܤ/���I�7�J)g*�����L8 "A����bu�Ƣ���W�Z��h�^�E�hh�ze��E��q��LH4�h;��Vm�Q���CS<=h	��,��M2nϜ��{��:�Ʃ�e2vIq�Rhe�>&��x�v����k0��*m����iX��ґ�(�ž�"UJGWʎ%�(�-5i��T�ط�������_o�<����y��m'�#
z:���)�F��,zN$�<?F����8��9�	��%���c���tEV+U��H|�~ʂ�(��4�/G�f�ť����~��k#D`�ђ��v�3�ٌ�&�6��Dhm ��[����c��
;���bs�hM9�"V_7���͕� �'f[zqNѻ?�_(=����Jg�1�L0�����D�6i"2��=�l-����4��Ip]�:B�o�r�=�6x,ѢE�y��X:"�� �HĦx��1%R�'��1������#���p >�⒒��ǔfg�B�z9�>���M"Q{�#D�#�t���w��k��$���F�T��Y2��PJPJ�:१���\T8k�Co2�j���$2�9��n��UA��%�Xn^.N������P���7K�[�qwx��I�NE:ӯD��+ʩբx�j!uP�\�'#�H�(%
\x�~]�LBo5A�T�����k�ε���&$E�X�x�4���faWN���Ǐ;��:P.#%���� �@ԲR�$�4��պ�M�r:6�m$q�6B�<m��k��$���6��7_lx����E����[��W~����5q;�G=�j��;�(�|!-j�H<N!�~���f�olJ���N�[0�f����A�iz��nѵ�T�	m*������6���P�BhSM���s��j�8#�',dS��&4.I���4ek唿��Id�~M(kŲ�����1��X��K�*"3��K*3<YN����C?����o��_bX��2�f���m��^�:���K"��ͤ��eܽ�t�$���L�B�'HQ3�*��%��4���;6ջ�k�^ܢ}d^����S�Gu���?%�*ݤs��"��D9$���롹�N�K�&H��Ts���k+��c~��^��OC�6o�ܜNڄ��&-��h�>�/���~�3��,A�w˄5�Ry�W��@�c��=_'JT�F^ܢ�ԼO$ͨs�Ԧ"���;(�xk���M&�������;5?o�G3��W����Ȕ@�l�'�(Ϝ6ӷ$=_u �;�pm�����N��}�O��� ��.�䐺�-������z�ypx�i�Xl����G�̈́eu���'�$f��e��t��SC�Mc��X��^4\�J�e���NGX|��t�ß
5�i5�D��E�~Ս
3,�A̴Ƭ����)���S����`ۯE#-VO��hr�y�vR����D_��@�?X���!ۧE�5��Q7�k����ߞ�������)[Kp\��Y���C5RA���?!������/��Kt���R�r�l�y)��� W������Qg5jz'�R�;tG�룵�T4ZvG7/��� ��P
�bR#�w�$O�Etz�E �.lq�Q
��D�Q����Q������翴G���=����A����F�h��>�U-����~������F.��������LD;������q��^a���(j��1�HV^@I(�>1��A!Q�;,��r�ܜ�O{}������騫���>�@5;"�������Q����~R0��"�-z�~�YU� �OV�!�����Ḍ��rR~��!��w�b�v�RmY�Q���xkFD�]����h�|z� 76_7��8$��Jh��(��'�q�î|�,Ow�KT}�+�3R��E��%���R*z�L	�@5�LA�Ň�gP    2Ə�L
*jy��d�~�J�QrՏ9���XT �4��������J�Y2kg �
[@<�=!1�(*�B�wQ�h�_�
 ���oe�v�79�iSf�������5l2��㵋M���ƭ!�����%3�<�2�, ���MM[	�^�����X��jt+��2+�/�}tȋM�u�e���#�q@|�:!�Tn-�a�"� ��b���������Ȯ{���$�- V
uJ���6���Hq����f�Q�7i+������G�T)@[�'
q�-�1LA������CIu9N}���] \�����G�(�v�,��G��Q���Eg`g?k9�,��_j��>c��ǭ�:��{�O������;>��#�xء���q�rV�1�1< �8��C�6��r��+B�pjL6�����4�<�4��#5�(b����/DF�?b$n"�,�Rĥ$���FD0�ff�.�&L�xpYódڳD"�������D��nO��+�`�C��՞8T��(3�<,��\sepQd3�̻_�A���N	�ᑸ�*@�]j:Kۍ����U_G۔���:%m�w��w& bߤI�Z�
�:ըͣn�������IIMwJ�Q�h',Hd;H�Xz �'�evf*�&tن.�l�pd�p\�݊II�Q���9ce �aj�����'R�#�&��>���c},֐��8�?�ig����p�S5:�M[�J�n5�X��SK�Ž~�Β O�4�55h��Q��<Ϗ��A�)4��T3 F�6
��O��}�n�_�N������Z>(��(j`���5+�ͷ˻���yU��u��D������tz����x��%3��D���𳅱ӻ�Z��O��:�;��u
��:xύX;܋o��;2��qj:%(�����b�<��:�,�X��;Fn�(�.ђ���P!gy�B�`ܟ>O"5-*̉�l3G�<Jt�3}�F`������������z��S��+��h�+Ϯ�������2��E�ٮAUdT�&>79���m sJP6n*A=W}@زc���aH�u���+��B��9#�Ҟi�9RÐ85u���-��qY�֫��X��b::�*3���J��|���^�Q��D�_?����v��8�8�:0�&d7�3��h���é�u��=f/-M�;a�E��~�5E���h��E��B��5C(H
�/��E����X�W�S��@�E�����fv��e�6lb��O�5�g֙8�٧NJ����B.f�J���#.jܙ��L=��q;��]A2xvB�+��{}?h4+-e҃~!�=�U�7�=ĕC/���j���<$|�&e�,��6x���3�?���@�K�,�񋗸�䈸�ٓQ��l���w�;�)�V%��~�n�L�i�I�_v�����.(�ȑ8��
[�%3�eI���@Q2���B�>���h��[�FD��t.��~�c]��FUb��U�
^� �S��T�,+#{�[eYgm`����RcJ��6�4�������0F�0
��JZ����m�}gD�9 �D�����J�0�JJj%鐭Q��ZmT�[���
��e�P�����r�$׃`��k��!���bkV�FEǁ]��sK���(]8�F�����c��;oK���(���nٲ�,��W�G\P� [vR�rr�펁O"�+�OX���8)�S�D\�If�óF;{Ɓ�!n��4ѼTp�1��t�L����'��Kb��U*,�z$9��$��q�}��E�Gn�M��fmŷ���;Ơ�D0�:_a���L�)";,��{� 
�樐�91ע	�'�eXO���n�[�`Z�(�)<_㸓���|�Z�A;p��Iq��IQ�-,[{zPs��K��Ô���o�B/(	�x���X:ҭ��ĩ�d��4��%�+Z������KN����oc%��}����j�u�dh��TH���-��h���#���	XO�H4)EX���=�/���SDg�A�a��?lK��<M�lK�F�P.�@܃�����\�t�K�􊘊=q٨D�>�Na� m�y�
G'�6,Ds�%ă���ցiE�Z;L�]2	e��&pB�H+���@%��8G�
�Y�؄[�3 -�S���kl�S��?�D��N9���s��E^o��#{�r�.��-�&�i�HՀB1�}�w���m����3�$��e�t�t�d�I�����퍖&҃W�Ss���\�π;��P[�U��%?�:ܔy��z�r���s��Ĳ��`�4ވ��A�dq�ᒿ�3�Ώ�7���ӡ�B���NR�
�#h���͈��7������l��#/�{��ǣ�e"C	�)�O��b��{.^�E�"'$@��f�����lr�����M�~��-�4>�m���~��v��KyP��o�l�l?�m�QL�8�T��1���Q�h�q��ffO��C"���h*���_a��z�2v��l���/0��G�q|T�Z�'.sF��ny8>�"/�/W�}Ff�S�o�A�I��ga�V
0lk]������L��zD��������jd��z�b��힊�YG�Fi0����+"�j�	k#V� �N�p�{�%	�aj��+܉���r_yv�DpZ7ӋH�M��R�����\D��X<�O���N:�5�ZR�@蹅�/�_��M4 �m 0|��"5��a]T���d�uXe���ߞw3��r��&t�a��I��/�#ؽ�s�+ȼ	��!���ϲ
$e]y�~X���iрMX�­�!�i7� ��&?=�(aK�6�r��mO�I�|�Xʌ<(�p�E	��ɦ��=����:�$��4m���[	�����K'�ǹ��|
�x�4͚蓶��ϣ��\��fq�C�$q��F���� ���<����/&�<0|�3�P�5��d2���ŗ%�^uU�ht��+I��j��٨h!��n~H��[Y���
�M��DNx;��vP|>u�Q�mНQW���Aa2;�^}��=�� Zz�-H{�ND�O2���z��A�_�|��L?S�
C��LO�&�k�R����l~�ǀY��b�57c�{8W5��%�e�鮗�6<�ۖ��z��8�r�x�9�(�Y7!�6dxM�A��L۲f1i@no��3��TRO�A��6A�h�fq�i*a8+(���J��6Q7��R�q{��ӌ�č�7 �Y�y���9V�*�E��@��Y�RSeڰx���,��l�BN���>�����N���Z
���T_%�t :(�4o�|%���#��>{�⚺	"���W� YI�vDݒP<��M0���Y��6�n����Q�/�!���2R5���:�iw�p�u�}����pc{&�kq�-/�"��Fe���^K���a�=���=dt&���J�if}��R3�x\�.��~�GN )�a����(�ИjFU�w�'\<_�����c��p�����
OC⩶�Jd��n�猋�'���|SB�?t&�{/j�OQ��RF�+jC�Sb�#��g���v�=`�nN�cp�et��I��S�$�|��- c�]���b�pYҋ���}z������kyd���;)�u���Nf�MX�]uE�;�.9-����ǿ.�T-e�c�����O�l��=:�Om������K�Ɉcx�k8��I����C^;uo�����cy��A�||.�A�%�mfa�e�`�ـ�3d�1;�F��x�b����"0&k��0���[>��R!��i��kUK7��:�+f�9���C���<a��@)�mX��h8�ϧ":hɽ��/Z�-˧!�(t�W�Jhw��	u����Mg�/��l��r�h��p�h���{�tm�Q�6<X���<i!��緲��w<�:�m�ސ�����p|T+���/mS�ѱq-��XLZ��F��4���!ۊ��N�N )�\�L��]Ҍ3x[g�Q= �#8�	���w�G�/��|��^�3�-�ŗ�v��إm����ݡ���(
�~7AЎ>(�&��~��@f)h�%�V�ZW�12x��p��O�#n    ���DڌM��D��eu� ��7kG̤�?�b��"M��H�Ybw.��[h����|�/���U�Vz�X�$p+��|�1�n�1��DL����oF�tkҴ���L�p1��;1G�v��85��ޤ]��2��Z���!��S����g��#��:	��G�vj�7͑��O�<�&p��vbG��]@~{����Y��qU_s��E�Xھ,^�����:a�#[O��2�b��j��3���r�΀|�Q�����Ӷ`2�k�Fyɍ�
4E3�f�ʗ��|�������)���O���hu���0X�(/t��*�`�_���m��1o⭸���`�M�]�lP|a���6;�`�kef�p�:�'���:sx��hCrP	#�&$<��a��z��zZV���q�ONJ�t�e�h�Ӆ��>��D:UHo)�;E�@.K���8)��;����Q��hɽR�6x
{����	;�t0����#���z��BٸL���K��e����d���z��^���^%tiI+������>f;	�'������l���n���5��E���~�\=W�;�O�_;��%G�Kf�y����S]��>4�y ��s	�_ ����O�č�5��v������9�ah���vV��7.�YI�x䶲 ����}����䠎��6B���m��>Rg�.X�X����
!=i��N@~)�y��� z�d[&h��O����d�c��t~�V�YC�@�-Ɯmc��Q��?*=.���/��x�I��v@���!�g�;��V����Y���XГ�B��{Ff�$��iL_�_|�g�Hܵ # m�(yi��1�$�m�P��=p����;KИ�m�`���[�G���m>�2�/���~���"Wt_#Q���m�`����v^Q@i�Vz��8e��~����h�x_s%�9\'
e�'��\�QC��W�m�2��V�_G�1����.xqv��9gK����k���+�U��)�
/.U�Й���'���Ӂ@�`��`Î��y�	ڶq�l}����������2��p/��J�x�{*W�Sd��v�^���.G��:��e܄Wv���sA�����Q6��J�_A���U�m_�%ѧ&���h���M�:3�=�k�'M����߱�S��w/�sT�W����r|�T�xTVmge���,��Oi����Fɮ���U�t��}�1��<N��1���lY��+q��C)�0�;�����!:-7e^�G�X���ŗ!(���s�>�eB����0�z^�µ�E�`U�YK/�y*�umwG�l$�Z���ʺ�bA6�i¨^R9�]v,�r�c�/�(O?�y��jP4h��1PK���	��Wjɾ����9>E�~�������cE�uQ����/O�;�m�|�6���/�$���a��F&�Lr�7A��Bm� uhmT/��X�� �!:�Hw�����rFX�+7��G�j$�/O�v
Z++g}���w�D:ɺ3���O�����n](p��S�,˧��Ps�I
�p,�z��˛�(���P����;��V1�]$���8:l���U��������3�ƶQPO����~;�#���T>a�A�ꅰx�4f� mf[+44A1Mа&-v7
��MB֊��*��Ņ}��Q�����Il�P|��Zm���,.�Z�@����I|( =�I�9�_n1�n�+X��Pt1�U��OA���ʴ
nWm�`�-*!��J`��B�׀��I�̆��`�Mj�Q�%��G��i|����5��P����K�*������C*B�h���zMP��J�ݢR���]/�R���-��| 	zv��h� �o0��ܯ �Kf�{�� �SѢ$A����};Ӕ��Gh��h�mY�7�\o�LH4����,^A��Kh�M�������sH��O1iB$�<Q�� �~�1 ~�U:Ա@w3��zH�v�p���\����|Ү��+����w���4�,��H����F��p�����o�ҡ��&�9^�K�Ni�����b����y��c<��%i�ظ>�rhհ��-���E�ea�B�ۘ��[�� ß
b���D��>֑h%��(^��Dޞ���(����ԃ���������=E2KM���b�g�1����M`Z�%̖(��\���ˇ�GB��c�&�$-�Zm�74+���K۝����˯��DS{�2���������o%ɗ����{�i羉�`��ܡ�zY�ձ՘)']��Q��Բ�6����_?VG�R"��n%�ʅ��3��#�)��㚝��X$�$s���7��5mJ��V@<�Q��N�H[� �nF	�(��K��������%Y[	D.@{������):.��*� �&���f���\#I���B��[�� �T���%�!f�}�fr��i�s$IPi�&��]�h�ɮ{�2&��ŐYb�����2&�V犫T������G�����v;�\�F���`y�1��9]�Cr:��;���v��+��O�0��	����i�}}������hrp����TH�G��j_�b��o#m����Է�&\���ul��GN�6�Q`�
��-H�O�ݦ�/�J~u���3>Lv0�L��cY�fr�6��� nB��I�/�A�đ<�7JX��D�䰘���C�	���f�����ᕠ~��G��u:N(��ۿae�%6{8�4�x�R��n�.<|�|����m���1��H��᤾����N��ۇD�T����	KZȌ��2	���œ�>3�Ԃ�Ed6J��]U���(U=��H[j�:�x^�ֲm��uI(Y�`E�Q����4M)ϰ~Q
 � �v�M|FË��/<$ضKD����㬌��
�+� �_������tsi;)T��S�EY��a�,�s	ɬ� �Nۃ� S)@}��Ct:lg��	v�L�P���9�I�2�BQL\iC)��*N$y��+-�w�����������w��_H�^�gs�����v�2C2A���x�
R̠u�w�n;��� �x����^�%i�XY��^��ݢ���ۚ2Ҁ��~��8�{�����A��b��0Ր��=��J/FY�	M�厱p�S�����\`��e̸�-S�a��F�l�@�NiC��S��ˋ���k�ք�Q��RQ�U;��Bqswo]���Ѽ����w�ف�/��p:��j����2m#W�/���5��Q�������������'�u���i�ce,���q�@�I�R��(A�˦������6Y�0��,�I.Բ�4ffw���1�s";�	�����=�M��
8u�KEGZ�� *�N���c�u��Ћ�V���TeE��uH}RX[��Ž �:`]2��Ӝ��}����(��I��{g���m@~Y$g`[��|��?�q�R_% ���j���p�.��kÉ�B�������o"�|�'XǠ�O�����|ObA_�lPC'�w�����j����!9�~�>�T�1/#_����
�����o7�1��N[֨�t�*�N6����t�,к�Ճ9��Q<�h�-����P=����{�X]�\8��*�b�VMXƶ��i�4v��"�=���|��*|Y�1 q<��P8U�a���(i��`�����
n��tTe���b����i^�Dj����b¢�aS5�ad�y�^\%���:`���r���K!y��*Q�eU@
����"l��_�L�}�����R��(��Н��9��a:G'X�!�.
��H�"���*A���O0f�O���*�
��j/���_?�cD���K��L��7JML;�y���y��E�����]����h��8�I�����iS!v�����`C�F`=2�n�Z7����A�ݢv܏6�~h��XL#���3�9b9�����d����5
NP�04�E3��`=�X�_��8�K?��|��z��6��P�ß
5��g�E���,醛�dtX܅��D,F2otJ�����m��T��5���    ~�Cv>ڐk㼉>�wW������1h�f�W2�g�T�;J�Hm8A�����MkpQ��-�����@E�Do�&0�`wT�q��2�hQl�D>�9�IA�ps�-��c��ԯ��:�N]�Ӏ�;��^���?�%�g��d7��h�]��2����an�k7Fy����eXz/�$���i����epb��ȸV�2h.a�wE{ֱ<%E:
\ֳ��|1�����t���mLƛ&�,��F���fɀ����O�q��Spx�L��ƶ��#k盰�h���W��=-j�Mrt�*������5 ևcç�7��m\WCS�f��t�C����Ӧ�C����MqM������ز��������|Ց��ѡp� ��iW�����]�=�
���C!葟tt��Z#]�N�кvc~���A��* ��o�p�.�a4i��\}������)���f1���gx��Pҗ�Z)ˆR��w:�M��xpji�ʺG�+���uOIf�����I��1��p[����v*��|��3�z`������P�]�NQ�?���)͟��"���Kԗ�Z�,Md�T�]��=���u�`+X1X	q�ٲ�m�0�a��,�D�ܮ( �fw� ��}�����dF]�J
�ʴ�C��_�ß
��{���B�b�����[�����q��oi�����Q���w��� ~���d�"���}կHT��lY��K?�5����ݜ��Y��	61X!Kb�����@�q@~~�	�!�	r�a��+�Q@;����k�w
�3����g�X	�Q2�3�fhm7;?�L/��$M�J/���C�:��X�kV�"��Y�
�VsW���9�'��M������"IY{tRP|�ß
xb�;��9TdzV�5�S�),
i����e�I��YH��yjçj��e��A����)!�J0��Ѣ8w|�)��hB@޵�DYy�E��<4�԰�Z+�"΋;b��Pt"<�.Eg5B��X��n�Ė:��I��C~Q��[�0Ƹ�?�,�y#c�nG�����B�7��01˲��8-�[�����_?��\.�����Fϲ1�+�@֪VjN5��īՑ��"���K�VB��&l�V� i�շ��v[@����ڈ�	V�3(�Ҹ�E~_ԩlp����E�����iY�۷����̘��hc�D�NH;��1ƀ��<���l����~��T7��]��sj8�<x�E���4{`���؅��a�;Vޙ���k6��]nԯ���g*�2D��ˏ��J�Q�·��.?!"��k��5Fq/����uv���Y՜���v�S�,B�*e�)�Tz0gq�׋���)E�.!��s֢��k w<��[p/<l�W�������0\/���CN�\��Z�q�Q	s���B,�<���,��+xL�
�S��/��PV����6����FxZ�j}`���i$�5��
��Q�b��V�P�g\�0���E!{��F!ayGC��>��kk�~v֤�bMh�,j���pE{\���)e�;_�V�Պ�$NIIkKLl%@�am������O�	C7�n�*ԗh�9����4d�$��o�=ӡTL9��.������؉il�� �%�R�)�6�V?�F�9�C�e	ۍM�WZ���r&�cZeh�lj�����9X��+X�����y�1�ts03D�
�%��_��+ �h߿�����-C+�ӄ�
��F����M޿���3������ͤVU[�)8+��.{E���{���zn�=ʺ�&��~}w���n�ն��Ѣ��Ĵ�`�`滳[�p&R|����އ���</6����):���6��0�-L�B�v����Rsh����	�C���ᐢ[	�CA�7�)_ma?��н��°(�5���P(�����B��S�ӑ��I�~zY�C��A�+q��F���ei�K�#T:�Vg���x����}MMl�n�r;��y�Poꍳ��a��nh�2H���5��X=�N��C	�a�[���rR�i��P��,ꗕC}���J��B�S�!ujxtjx�j8�>BZ`3��{C��(�.x1��A��9�na{�֘���Έ�]���1�2�.C#+��FV���7���y7(G�^Nԩ�������thϤp��rE1*=�/V�X�������L�P��af3��u�q��~�tc��Tn9ZN_�&�}y���'�?f��[��3�:�/n��śM��{�Z?>��C膕�a-��?J��dƖ7g�c�^��+�n`y=���>I9����m�F��F;넾�; N)W�K���YCV[�$���U��S��#뚈bg�3�50�?�����w�X�a�ȭ��ꈥ������p�Jt"\���x�@",K��&�%�� t��ʔtm�f6�����L�S)�R��M�_���sA��؜Ɔ�ė�^��m�ؤ��/n���ĭ�X��ې����1��M��4@�Y=<�<�3�li����.��������3@-q+�لF���z�d�B���p\��
�r�m_�]y��_}q��*�KaVCuR^
IbE�l_��ɺ��7s�#|sO�q��3���8�Gָʹn3yz�G��%�~��<��|����.���I���F=���/*�ƽ���E��/����;w��*��rg;cT1A�M�!1�WN:V�B����Sک�E����<<n���p��4���W����F�E(h�S�hR}>�qY.O�b���������EV�o��;�3&;������^�b���(��c�-�<-�<l �����s��"DWĔxL��=_<E��f��(������ˣ�P;��H�Io|a)�3 �:���j���RAf��v,N��8�]4.w�f��@}��5̣8�3�+�A�S��3.��Q�gi�g$)��~����Wo����Ц�*��6R9t��!U�;�9�>2O��W��hҨ�1��>F'�����6� a�9X
����ד(bX�r�R��{T|�vf�"�՗�vM�0)�54��I���0�}��,%fEq���rG@��i�iI(�p*����[�v*Fs��u�E����ED�@	��"���y��qM��7���&�:��s}$ʿ}��b�MQ��Q��-�}ƀ�MIO�Hf��-�\�P�i�D]J��ñ�Dzd#x�b��[�'C"{Q(+_��IO��?E�^<������Η���?��-ᵳ�X���^VN ��p��z�D_ʷy����_�_�V��Ӿ��6mL�nm )�ۑv�u�81�J=碆s��h���FW{/����6���rp�^-�X�k�SQé�^V��G�ƕͻo�7��'PT��_��=���2��4��X�X�CX>͐RtϞzrE�:.�����&���9Gk��°��3,*mլE�-?�燻���}CR U����I]��=����X�U4��׏������.�Z3]�B/��Q�֢�����]o)���b���sf?FD �z�ؘal�����}����A������%�GI�#�:��= ���=f�ޯ�5�&�ɔrgM��{ڦ='|u�j�y�l�kQ�p|6����o-WY����P���1w�T�7̉��'��vv��r����"��]̰����C ��p��K�{�w�� �yR�%Y><F��� �7cV6�I/�^'�j+M]��uu��3���tj�� u��62�H
��ݍ�O�Oۘ�*��!*���%�0U�l(P��0�wO�S1�Yxy�����"�6,�G�cwk�M��-n��q����5��?G�eg
f�{q�/�y���O�U��N�z\	��<m�6ig���Rm��������4�d��נ7v.P����%n�wm��gVܬ҇W(6�X`��w���S���cR��,4���5</ �7s��j2w�!�s�5��=�f=��k�s�����4���S    ��Q((z�Hc�ʸ����>f�I�h��aO{����<�\�b�Z,ːH�oO�+���;֎�	lgEc�ÄY�u���]m�o�.��=Aᄳ��g|���Y�0+�jW�T��D���Ys<
,�0�=�f�~X,�tw��M�������Z<Jl�aąƞ�	���G݌�*��]��8๮�zj&�E� ��*@≖0D�T\��By���%��� �L��`��xb%G@���=V��F��n��(��̘z^%d=-ǝ�毻DO��%P��PםM]M�P/7���(c���4I�4/���Jz�P���u��t�C<J�ʚ*����>Ϸ�
��m��w|g�۳��Њâ7�7y��;p�����	)�4*1<"�ݒ���O�u�	S{�ꄁ���	ƙV�O�n+�-O�~l�C=�>vk-әT��j�Q����=P��3�$����EgwI��N=�J�w;�$MԻ��m J=����%�]��Q�>N@��e�m�٭yr꩘��E�S.�|�x��Kz
��|Օ�1���$���%�m�X��*J��S��V÷���;i������f����Zϡ��ם��Ins��$�e�3�l����Bq �\m!�:Wp����N��$yuWUA�X� ��٧}#�:A�vLs�r�i���TN�e{W��?�$X��ϧG����s9iv᧯P"�BXX�sn)t�jbܞ�I�5/_�<?����P��2N4��<���M&)��Vq���׏}:�n�8���"I��?��3O�RK�^p�~a@��̵k/���]J��D?��ެ����\4{=��d����k��Y���F�����4uB6e�^�.n��qհ�ppL}*���L�3�TԹ���5���:��`T�V�˂����f�i�6R�Zb�o�L�T<�Jm��������(y���?�<�I3;������ ������NV/xp`d��̙~�WG�=��la�Wh�6�gx�(����=e��*���L�3�t� {� �{��;�#]��(���df�_�j���4�B2�	P|�K�\'34!��;&�$wu��o�O��k'͎cߒ`5(�d(n�dQ�<�<�7�L*�o^/�r=�^R�Б{���Srp��F��St{u_��M�]���,�*s;��`�.�p{�4Ϧ��n�]�g`�N=$NЦ޳�k�dY����<D�z?��i��[��>|-˼Zeyz>��v�f����������{m�	Z�����^4Xpo\(n���ѻd��9���j�x}�S��w;��f�I��]UH���y}�!����qN�J3^_��Sf�4�B0��֢(�å~�D��_�<�کp���DsS+�X��} ��q�mL�#^k�YJ%�Ox|��-`|'l�뀸����/G��C�w3�[O��i���
<#m*3>T�u��Bz���Ѩ����R��p�<��uL�l6㒥][��� Mq���+hZ�j��cL�o?���<á���SX|�C���W�Ԝ���Q��'�X��"��v��<"�����Lw��.���&!{�C\��~pK�h'�o�t�׋'��i��V��;�*j��
@d��qt%��-i��,�@���:���{��{��a5.�QG���>_��
���9:l��#��Yf��_��&�'G�V��%����B�{Qvɥ�w|ЊJ�R��Z��|�B9h�0�i��El֚��Փ'[s��Yo'��4�����~�M�Ƈ�3����V�,_��ι�j	X!�zh|Uxb+\K�4�)���ր���U�zE�1�zO��_?��~، x0?v���.��C�^����+|����G�v�������zWtϧ\���,S�=��#\X�l�}�Cg]�U�L��'��e�&p�/����?�׳�?�?�=���,��@��A�I��V����7Ol��
��|���5��$��	�J��1�tL{'3����v���)sm���3�Z'dvIo��[�d�z�W�fw�6�[,턖!ȁ�ߎ!�)�5�m'��/UOl��	f���ʠ
��G>E�x�&_��؊�Uɚ�xZ,�Q�q�vg���2���=E��Ǹc�Eꉭ��
\B�]�l�O�
8��9[:q�\�K��d��`���<_���"�
(<��w-Y��S(q���N���_���R�/��(w����^\�q�~�{�Oy��	7�ǯ;Zߌ ��ziq@�#�]�OL#Ց� ��H}Yzb�K>v.��0=�iy=,�·	fC�S���<[X�P��:#�Ւ��B��N@~��e_���J�� :�92���3�N�`�%����mj��qOl����`kt��P���+�����Y�-N����߮�sT�Y���NX
��B�[� �*>��������j=�Ri��}��W j`)���k�[��P��zU�|>�p��1��uO�;_�nG%�t4�{망4�F�>,P6�k�[��8��2n�i;�����D�)��B[�0��F��^�'�:b�B�L��cW��oi}�|b�$VU�<����н���GʆMPj�k�[7�H��U�mn�.Y��B�P4у���V�[�;8H���͚!'�hs�V���ua�>>�U�ґi�Q^�S�������Xb��塌�����ǅ9϶B�E9������ls�U>e�6>�������m��x�N���q�$5�m7���c��>H�P{*��U�k��e���i���wO��	+ż1�5�I���U�2}GM�����J�\4,��n`e踏�A	�`1_��Z��<b_��  �C����ڃA��	��g���T�=	�%"�%L8�N���	�ݙ�z�o�6�B��;f��>�E"�;���~��q|����F�{c�C��'���_ HS�iio�@�I�:t�@����+�XΑ:�;O�׸�F%�ޞ����~|869Z<Ϸ˯.�<Gב&5�1�?��t_�|}~bKC�M�ʿG����.GB�k!�滨#���*���Ol	��
jЩ\�L�?z����j������� ��|,Q�~ɣ��*O?�u��z�Y��	���z]7��GuC� �j��֓|�a(.	������t�4}�vv�|� b�P�V�Yo��>����o��D�(��.�􈲹�Ho0��|� b�N'8�u��� @R������z<�w���깟���|�6<���]��'�<�%��+8y��|,���M<l��?�e&�k��d� ��8_���ʒy ��=i��4C�$̖�|8���@����m��Q!��}̗�'� ���5���k=]wh<!�%'�C	ߪ���lH�#ɽ�Fm�0N�UO�l�����ݑL�&�fx74~d���p���Ol���>P��t�H1��+vo�j�	����	��>��[����k��6�W��T��;b_R��}��=D���wB�K���������\����� l��-�2��-���]Dp������kBƭ�)����Ukb�(>�5�h�E9?6̷`������=`a�~k��6ۀy�"��Јz!��� ��2�[%�Ya�ù��u���=��cX�$AOi|�}jKy�B�����bˁ�B5p�z�ԥ��{�,p6����Q���C�y������]m\'\�v�Q��'���Ԗ�Z���;1o{^�>��Ԓ�&i��_���"V�f�;b:�����q�L�I�m�j�������=;K(>Ҟ\{1��A�e��A�fΚ�zR�� A�aaI<-�����/�`��Vз�E���U��-�5�E$�n�;�U\�Ǫ����{��|e|jkpͥڲ��'��.��\,��n�X>u��v��Ut8Nx��D�^+;���gE�ǅ�><�ո��@�|�w��?,���e�b�GO�N���{zd�w��p�����͏D��t.ʎ�(���k�S[�k}��⤝0�� ��h
�@�Z���2��V�Z�Զ~
�5��X�@/�>��Pt5W�'S�Z�j{����V�~lO�e�������dt\�cXy�z̄2l��d/G�������%��    fӣ\.�����Om�r�Wc�YO��gU���w�>ٝ�v����"��sX�?�
<cc��*l�qJ;�,�ЋK
���A��2<�����;�L�

9�w(�0,��G�x�fKv��q�y��li?�6E���Wy��{�Ƹ��[�m�o����YrxW�q||*��S9[�l���,0=��ZHz������?�oZ�"��3˟aF߯]R�8X�s���Q������c���IÝ�#����c|a݀�8th��Lmj�#i�@1��Y��������ɛ�϶������
W@�oW �P��?���-і����yeư��w��*�:���Ԗh+��`�ǿ�SS_��r�l.����N�s/n����6�h���}��ǘ�YP=ͲĞ��&���E�n�X=A���9t�Df�|��D�H�D:c@�hH���kk�G��[d�B}�����;2:R��_����e�������3[{܃t��5�u)X�±�;Ј�ްe�|FG��C�����c[�m#:��^
��]����zZ�m�G���>�����(�z���^�x�{l9�� ��Y'w�E��^���c��������ʏp�Fֽph�(�\0?�H������z<.TdZ<�@�Ǵl�\::B��b�:�P����ц1x�Br�Ȱ�A�!�,(���2˳�}X���X�}��ZOmm�5xo)��)3�Q��%�-n�.v��pWì�'��
'���z�c+_��P,��Ñ6t�{@��'� �K�`H=��e���@�^ ՞6���eQ,�����������b��{w�/b���Ԗ�Y�WW��\W��T0<��w���{��'P��C�"�DC:��������hN������觫�"�鄭sS��Bҷ=�:u�h�t�!�,�$l!��X�To�!A#;�^9�eO�Լ�rfX<��K԰�!T��v�����.9��v8��v8=�M�G���t�~`�C���ߖ*��\Noo8���f�,
����rI"9^�c�&�:�Ԗ)Y`�1<]���"�#�
*X��*�B���zV���y�`+[��~�F�uI�$pEZ�@Q�!�5�u��j�'��\I�Jhܭ�96T��!�U��-ɰ�pL�@E�����cx.�<|
�	�Ӧ�r_~���@�\�9?���Ћ�聚s�*�f4̖l(�pu�s���գ� ����)�,���Y���] {C:z�#@��ֵ�+���+},�}
�gF\z��>vT�г=��),k��}m�|�=����W N<���<{�yHaN�������@��}�l�
n��8��H�	9��o9��m�n �<��>vU��C���XNe�����p�	�4��z>d����xW�"�U��8
����n�"�Yay����O��(���ݒ���@��*������hZ��9�����:7Sm-��@�>�4$����ɯ��F�a���1���z�0*)xP'z#�ڀ�wq�w��;@6�"Fӊ0�
Ȱ�2��������a����.�Q����R7�=Ԡ�\����\a-a��G&��@��+f�^z��wK�|o,��lȱCY�jZ�>���Ag�f)��-D�2� 1�I<~> EW?W��uk�n�`iF��rҩb=
$��wU�_�R�pP�k�R�e �G�wWǀ�Th-Q{--Z��-$�%U�+V�Z|�vv���$.⊩����Z}�jX��u��}�5�rM�Zg�j�p�R9ys�?�$yD-a��਼;�]if�X��� S1��G1tlw�F���n�-T�`.j�e����Muh��_��qa|��[��1������j��G�m����{^ns0��.x�_8@����0Bf.�t\bӑv�����R	vCǒ8����~�V�V�kQ�vd�2��go�Sa�ҫ(�S�#N�~!M40�ġ�Կ��s0�l&��������y��J�i[cB��Xc:��v�h��Q�~��.�ߞ����7���򧅥��0T�]�#Mu	,�e�����n%&.]]�x:VxO����^<����)?.`]�R�媰��a�y�7�͝�����]���YMl�Q��i���Y�yzY��r���׽O�m�8�_��[ڶ�[R��&I�	U��9P��5�E};�a�=��Q[�Z�_�j�d#��ʨ\O!Cs�7. XXK�iiS�AC	�EF ��o���+��4 ����j=m�9��L��"5��,ZXK��Ү������7��Ṉ!=!���,=X�r�^�6U�OM�=�Ў��V�.�Y�#Y/�h; ����Y� (��9�-�]~;Y�pRcFa���"cd��V�~�W����O��c��o͚�D��o�㫾�р�"�1W_��_>���4�u��ݯE�_?�pW����6!��GΌ4������<�%|k���퓖a9~k��z�c��H�P��]=F_�������oa1�����b_���7'j#	�`��Gs2lQn����^�/�@���U��{�!��)�4����.��P�z��,��r�|����do�ԁ�r������Xo������� m9��͡ŀ6`Ǐ^��$�1�i�z�껕^ps�6��a��M�>���RD����Q�4��p��q�����~ݶ��z��o�U���60 �ᖝ����O��,7�c��x_v[�<�����B,�6����zS׺ڦ��V_��um��@�A��r���������? �
���)c�)��pp�88�8��^?�������`/1]��#��U�0ר\�B�L)���?��=�$�~F�<oR��R���y����w̱�ς�I�٧�$�x��ѥ� �h�l��Y�}C���A6��
�z ��8��%t�t����؅�~�o��;�'�����}��u���ʑ$�6!��}��K�<y��ɗ�I`V������������*����W��=��O���}��\¼�`_��諰�\ڔ�����O����M�&�
Awk��~�~Y��|��*�6���:������^��sº�׼�qs�� W�}���Y��;��q��d����|����]p�k�e�q�W�u5n�n�N�Q[�_~��K�xR��L��ެ��z�Yl�lU����U�c��ZM䁜-�*�<�H"��͝�[���[=^O�I�N��c���l���z����äQ�Z������Ɏ�DaYu	H���������-����B����S��X:��"8��'i�+�0�T/&��$eֵdl��K���nE���]�FD�ܲ0I�+��
Y�)�Jpǭ��$"o�4{�;)��"U���\��J�lE�mE�J�Ĝy���Hy��d�״�(�H�$�7İ�Z2�Y���'�rLᢐ�2�\��D�p�
oY�ܚK|U6���`'Y!���Q�,tNM.|�L�gF�Kʽ ��F����<���˂�=���?��������B�����6CϘ:������dl��.�'[���?%r�,��}٤�6��5'��r�GKD���j'�bo��F�(er!c�8m+�ӱ��6�{�P9���`����H;��b=Ň�9��+eZҙV���$$��9��9�.�N/T+�R�ʐ�GD��NE����+��$�\oꐵ�� �SI��ņ��I)R��!���)#)p;�I���<E��ܓ^�WV���� �?�ی�"{z�������VjSq%k�-b��P#WK�`%I�BW�c�
��e:ӨQѢ�[�� �z���_1O�Wܣ$�¸�ο��:���G����]'8��G�y��S�'̺��采����<�_����r|y�e�g��F���f��YlhhF"�c͡�$�S3���0�%��L2Q��ո��cYH����x�d@�8NPy��f~/;�n�r�g�f��g�NŧƐN?�"�XQx��G:o,R��5R����,��䪁$�I�y�¡$d��_��d8�a<���
�^%l�2_V`�rp1.�co����)���H^&f    q ��� ����;	ss�~�]h$���
��r��"v��^����C��q�mA�$8'rx#�ׁ��^w!�O��U��~�Ȟ�Jk?w�lU��ձ�I�^}���˟D�����e7%��.=���0�	���y�
Z��N�{��}�pb��_�,`��	Ow$�l�9�QX�q�ޗۯ��H�A�(�ǖ�}�_
�b@i2��P����L{(y��³@,Z�e���i�~ʚ���׿������ȕ���)aDS��P#��Z�X�2�1����ѝ<�?��i�4�w��$^�T
]�pK�R�̐$�ӿB�`G�_Tg�F1%Z�� �t�҂1v~l0�¦���o��/b��LL�\АT�C�%��s���FYC��}$����\�WC�l?Eô�qQ��YC���Z��}˅��BJQK���pp$�A*hq	!%yH^?f��{ꦎ����̲f��/����8{���7�8x�#|^�]�W�s�5�˽�,?��Ҟ��_���l^�E<eX�mmEگ� =1C��j�=���<��2���Nl�]~ؔH�H��ʺ@����܋28?y>C.������EVt��(V�Mk`]�בr�)&�LT2�m;��Y��,����J9�\�8ŉ���O��W"���2\n�q�7����;�z�
���pn�ʦR��a/)��R�xح�R)+�f��̀K'8&$��^x�=6�L���٤cWEr�ĴC��l@Ў��6|[��w���C��Z��br�՟�C�d�]��L��s�E=����X���@�!W�����j_���bu�2ِ�;L�NU����la�����Y%2���Q&���ў���C��1���=j�����Ȭ\��\c�#֎�UXH�`�6�eaaaqX-"�5�NXB�r��m>o��g�A"�տVd�����"t.y�[-�r19�X�KU�X��E����v��z�#��HF2SG�Ο�{K�ʲ��yW������fsWÛ(tkmv	b�<��,�rd���Nʕ\Q%�,)>(��)̛�kj%������!�f+%7�M���SGv��N)��w��]��Ø�lfבvq�n�HTE�ޖ7K��H����AMn����<c���UZ�N�~���D��e��X���4	��ìÈ�
�|p�c4e�ni&9㽵������'Ӻ0S+�34�bh�bаT5K�xo�~%S�d�kf
�(�`DyhDl�%�(,M��n�RPz���Y�4,`Z;a);��Qˆ �o�^wz7��L�������fn�^uwV^n�M�����ZSí�s�c����$����򊤨Va�z�5��+��6*no�1�U�9_�
L�������?.���:v�c�������������M�޿~9���|�ϳ�j�����h�N0`zd3�r|��~�����A����+�"�,>ևz^�fu�b�S��x��g|�vn3�94����H�}\z��U����aD��:��$}�I��SA�}�����(e#��[�mN��?��Uv�x�Ȱ����f����5�[XiR*�A(�	����D+�&�jHx�:�"�-1D�Xb�!ƪ�9�C�h�٧�ܞ��Op�:���3��b�Q7����s:^��a�9bB�i���{�*>��80�p�	�$*]�F	S��D����_c�SFB:�FB�F�Z7wꝻ���W��x m��󵌶�pC�\�L�
M�%)�IiFf��كl�%dL3RH�Eaғr�Dh_ceG^�v�L$w�oq���Y�4r�D��X�[�i���EVvh�sp���xH7�l>}�ϑ��E�C��\e��9Ts�Í�r�b���y���U���g������o>�Y읫ܻ!�k�U-/�	��Ij$�~�X�FR�=0�bl��ĳ��)Vx�ae�3�7�P&��D�E2�>�k��W����uxу��hQ5���!֏�jsW�o��4�qˊ\��m9E��%����љO��%��q/����4��sbJ|b��I��$+˼V�s���P�o�B�F=~�[@I�d�H�s�j%9�M�^hkY�*��>�_"w��ir����?�}���D�$��~�.��Q���w�ϖ�c��w��g}�[�ͤ)�2)_8��@2L�� �l�������ۇ�$�����Tv�@���= ^v� �bi0��q� ����ۢ��1q	���U,��l�F+�V(H-4��A �
��U�;0�q��ʲb97A3�{Ӏhɓ��,:40�9(�����'Rus��N�t�b��$X[`C'	t�p� �z�D�����7?�ƒ~���"����C�2��Ж��_?:&^ͩK�B��X��#�D,P���^H�R9�Cb���4p��8���P*
�l����lRf�ٟ�����5��'��z]/�GeWN��J}�S�付9D4m���{:��"90O�ޕ]I)bܔqz�$�j��	�<�.��QX�W� �9G�3�+q�?���I�Z�YeWLV��j䤁ڼ3>���{"ТJO�]�XYC�T$¨ic�r(&A�ug	�ټ���-��S���T���*:c�)t���̠��8��J��K�5�Ck1'�Wp���aޛD��<Lk�Jg�-)����A��W��"p���ډ�lDz�	a�i9j�d���N�������#��kAd����m궀�~����޵�b�Q{��p��h��a�$)���#Ԁ��2�n#J_��\���@nχ� ����E�蛷#gE�$7e |#���o�?2�bZ��wф��&
s8��)�Q ���Y�����y�\��CU$��'~M�����ݵ��b�*�'pWE��t�h?;��l��'Ϻ+�2xQ��	gg�;t�d�I�P�. jX��agl�����m:r!�`��t�`��w�)Q����j��ڕ��Q��{(�a��Y�����9A&6u�#E	(�Ü$J�� S�5㵋�L�Ս����ǌ�2R=]kDtu#[u���0�ev|��OMbҝ��1�:.���K�2�6�ڒ+j���0��?�"e��G�9v�K�$���O��*Zl�؞�t�y��dy\^s����W�M��[����RA.G�&��h[ו�gw�E�@�/�건C`x���xa��
�n���ӷ��
�Q�7���̗�����ss[���JI�cGI<�ɭ8ţ·.10-S�K^t��C��ZOd���nuq#'��a�Z�1^R��	�7��'w������X��"���wy��G���g��U/�R���f��m�
FE����Om/2��4�ǋ��D�"%8�L��I��Jq�x��JF�qTt�[��'���P��9��m:�:rӜ�6�Ֆ�D�oOH���D��Z�c�x�:��#�>�	�b��~L�W���9)��6�)Uy�􆑹T���n�S����ן���+�]��a#�'��u�f�\�?�r��}//�j�3'*3�1y���V^@�, �o����#Y� ��i��S8w��<�Ǽ�U�-��L�Eh��6�;�i��a�W�+����'�	�v��L�W�^S)�J'�*�GD���o�D���|�(�ڔ� L�QU]j�����a�Lx@~��S��&��W
�<����A5�:?>p<u{���2���>F]r�&��'��S0hg�:��\��p�ǸKׄ�i4$Ħʉ�q�wY|�����?4��A�9(�Qt�c*o7)�a;�*I�O�c|'����k&L��͏ �/?ã���.k{$8ʶ��o���F�6�C���'D%��u��4?�9���ڟ���rb ��P����?�0���=Z-z0�� ��x����v�J�T߬�.2� ̒�9]J��d���0�5,؞,oR�1T�����P��P�%�)��k>��1Ηf5��Jީ��2�4#Cm�`�����!�*�x2���e�k�8�P��v��N�s���.�RC.�0����'���8OF�pB�l��P����Q��T)�����:I~h��J�3Tb	~8��    �����.�C�Vb��b	���n&e�	�N}6rDظ=9*��FS���L��Xܩ-�B���+���Z	��U���H�;@&=<AQ�)�<EU��>G�	����n�A�q�A���6�p��S3g�8�j��� J��SAi��)�5uDZ*��-a�p� � �K�6_�8-Y����:�\�{���D/�b`3���0���̀2�Q$��r_L�A�%E��8�I��}A�`H�dRT���sT�H�a�C֏;S�:9_�A���Ę^��r�A�өͮ ���?m�(�O��!{��z�bʆ�+���<�i�>�y�љ�ט�N������9���6�z�E��0�l�E߀G�X'ML�.��w��'8lM�Ѓ�����T���a���L;$� �w*=��-~j�/|�,�;� |p��G��{�TT�d�wn��h:X���#AycT"���d�^n��h�<Hl6�!p��e��f) �yC�<�7���Dκ�I�c+�h��ER&�W1�{��d�?���
'Ӽs[qGs"���IN:��V���15DLH:2�V����4����u��g����<Bӕȸ���(Q��JN�����7"9�ߝVq��ad��X���4'$�F�o���@WJ5N+���Y+8Q_p�4�1��Dco�sKM]&)Lu��Va���<1L�W��N����<1����#�A2T�Vw�fp�ڍ���C+/�!?16:饯�Ah����G�Ǵ rl|_x��x�y�
Q_�PA�=q��#o��6��e�ZR�j�+u�`9�ez�D�L�\.�7"w�F8�մ!�\� ��l4'4�&8�(f�7"7XOO��R�)J��඀������%����BP	�xNE��h[�Fq�á�SC'zi;�Fd_潭�D
5n��hBB#�)#9[*�Ȭ})�Q��Qp�	����"z5��5���NqP�������88�I
��_x�4������!��J�B�t�-P#)i ��8�h3���̑뤉1�,��m5�y�@�{uf���똸�}tN��Q\&g�u�x�R��%N34��~�$m�eЕ�A���b����yL;$K�Ȓt�:rD�P\�1"M�<�ڼ-jJ�&N*m�G�|{Ȓ�0������f�t�^��a��]h��Y�P��^_�� �n��Sh}^�+n��ǥ��a~z�:71�Un�X��v�ֹ�~vZ�	L;�EZ̈���<�
�ȸ1+��_e���@���`���.��~�*,����v>RqZg��Q xOWCb�9�(�g%�t(h=��l\�4Љ{]��ЖДƁ��櫬�t��	E�!� cƑ�o,�~��1F��k\�.�)��T�^b��"�Wa��"�Fe���߄� ��'��Nh�4�0��.FhW&O�4梕�Ўj����T�*=bl���kN��(AIUt(8Q:҉�U�F&���hHoU�t��%R�$�H�@��è��D�nL�Q-w��<��B���Z7*'1�Pq�b��w�u���;w��;dǇc6S�ώ��6;>���u�
�3��zN�]x�B���8��w8/��;J*��<cT�.r�٨�[ ;���x���;1��Q����$�O�C��c�.�q@ë��I�։Y�!9��ͱ^gt���A)��۽`�b��?Lz�0Y��0
�`�1L���c1�ϝ7J���.
����۫�i{���������O�b�g��S�3Z5�=H��d�͏d��D]ڢ.+����}��c�ke�d<u�Q�/�ܣ {
2���6�^2��Lƽ@$�<��<�Job����s��y�G��>��⢐KEG;F�s�;� o#$�<����:nE���#��˽ ���{Jt��RwJ[~���^����	2������)��m'�"�Ʌ��b��ť�&b<��l�u�W��7<�����[��K3�[�G]� �7_S��Q�tՂ�8.��lU��n��-�e�3�i;�K	�ʦ�~<.��s�U%�7���`�*�h�Iμ7�F.mY��(j�:�7Y�����pT�Ŧ�\�􋊛�*m�;hK�����vּ_��Җ/QhՔ�E+����I�kk�(�"���;qI�6��}��Y���ſ���z�z��W����x`��;~I��1ND�E�J[b�)p�?���:���B%ut-�չش�r ����N�]���di�;D݊�o�_�,*^��m���o��9$���`b�U���u�dO�B��q[-�����5�Jh���,�����aar/3�_Bg�:�C�pjju�&W���O��)m��X�� 1�Q���mgC6����߲E�hy� e�ɽkF9�<����a��04sGq{���o�ϻ$}bK_(:�:	��E��a�$;�~v�����dI����\L�Mc��`����N��%#9����:��g�����^�"v�/m���������EՎ��'���d����h��Ѻ�Ňf�����i��ٖHWX�����ۯ�@�$��l��uS�.vݒ3 :�SG�����E<l����� �U�%�`���F��;t���r�VC��J��������ōi�[�Jp�0 7܌i��<i���1%'#�K[�±Q�(A6x��Q͝�#C$�����]|D%U��MЊ���Ѱ����a��'�#�ү���7-dyz�rTz�4#\�#�δؓ��J[x�9j?ֵi�0�]�Ȫ�^��ir^�U%���Ro�>���ã�k��,��bcS4�U7�H��-m�	ŃJ��� 7�J�f��|c,��H1M��͋����ӧ�Yf��
y��zUߨ�:&�~v��5/S2h>h���P+V�eV"��S��:��m	O�Q�I�f�Q4/Ǖ��dn�6p�3�8c�h��f��(�ʤ61�%X��#9ov�E���g���O�|&�*�!�����5B��##+.��ɴ}��!�AJ-����t&��a��_����ݫ���w��4}���� s�H�)��0��a��O�|ա@�}@���)pە��P�d����`��'TtG��=5��&n���Q^���4	�$����b@uy���8����J5�+;K�q0�#ء�^E�	���Ռ������l���A0�3�~�k�$7.L�I���:<D��, �QN�,A��S�<j���3T`�=,������T�bS�ѻf�ϲο���l�Zu�_�HC�KS�>�����C�U�|��� ��p;�iP�;՜�F'��O[�p�qљEUS&��OY�P`�^Y@����Δ��8)$LI��$�#�]"܎rW{2-���2�[��l����%Rk�P�)����V^Y����z��M�B(��;�ɶO��s���s��㞯S?��~q�)�0�<"n��5�x���v��������	F��3�:L�"V~1��������p? 7�#Ĥ�YOfwY���(9���l�r�
�v����)R��]�i)���H����	#��~k7
�P��׫`;N����30j.:d)�0UV�~d�g��.�]�5Œ���cwy�cZ6��IU��`-x�)�,�K%Q�IH-V�>�����������{�ݮW�����/3���g��V�g��\����b��@�O*��f�*��e؎s/S��]�
�g��)Ҳ�1�Ϭ�P�ޑ���f�w���ן>-�k�0,&PY��E��4c��YֿJ�Ʃw9i�>�+�r��q�tԉ�F����������|/�� ��`3�k`�D��#h����ݡҪ�͊쉑�j ed�t�	����<Uf)c��@#���w5��6_�[��DQ�p�I����B��E�5l��(S{�C��$�=���4S��ay�	t�A�͡�љ�0K�˒�u�_��j��L�C%���,��ܼЎ��+��v\��?D��dĉ4�J|W�;��t��K��p��Z�V��@[�z�|OI�e��=�v�T�#�"�/nj~?�?��Vg�kT�����>o�C�d    &�N���j~gO�LX�V6Dr���S��.z�������nI�X]�Ŗ�uQxhrEBS�7YUnr��mڦ��j*�8��۴�/0�Y�z�臊�ϯ�U{�rC���~�ִi�>����O����W��N��Ux�S)p|���L�t홆?�|Ӟ_��׹����S��5hu�_̘v7��n{�W��O�n�O�}z_����hJM���<|��jh����5�����f�6S�fG���whY8�W�H��Y�vY�8�"F�~��/��-��'=�p�m���ҺL���v�g�,f�r$����ȵMh;�1��l�w�_��4�ܺ{�%�`g�Db����#�xbZL0/���BC^��N>�Y΍<����I�}S�?�����a��c6�ݡB�;� � y��Y灭�Vi�X.0&�* �Ī�f���LIF���0�'���/���My�YV�z��~�� �H�ߛ�[��I�ٷϚr��_ɿ>r��b�a�a?��S��V�k-�)�����=�s���2罋��܊�l�}x�=q�G����!�*�^��~����E'��MO�:��nY��I�В@��g3O��Q/Pcʞ��,�`EVx�˻�Ci�dص�� �,w`Yس��,�z�b#��'�m�)���z�t`y��Z�PƵ��O��*���o*�Yџ�夬Ϯfԡv��y��{��-"����p���֡:�\����1!��3�s[H��nT���I��9���t�b9�Zn�`�Ye�෈;��g�$m�"w=�\~`��2Q��g�D$�ʮ�G(>]�A&
� �g`5�&�U�!)܌���7O���$�9"xoLs��i,) ��D��y�玉�ge�$��ʲgg,������ailΎ�4�V�7?EyV�̹b)���1&���y�N�͇jӜF&c����՝`s��p����@��"ԣ����I{2�_�AP�-"F-�cj��;q5K��o>���Jԇ>�`��Of���eN{Q��	�d�´%�3�iR��ʫ[��m1�4m勤if2�6�o���r�zsx������:�ɾA��c���JL��}�"/Q�� T��>����u�W����q���>���B��E�a���O����ﵩ�W�/��T�D�~Y!�Q���|3v�{KC�Z�i��e,WS���r�C%�o���?�<m�
��pK8�n&��z{i
���Q�w�L�L���ϊ�����9�}_��3P+�P�"�M`"���[$;�NA��4�wcX@Ee��|��d��o��W��wcp2nc��-ⴺl��u�mfwU�}F�M�J��Ae�N7�P�\����.�$u��v�#�dz&���#�X۳�����>�3����:ߕ����e-�u���	9M���Y�����r �8W�ylN`-�F�Aؐq��Y��U�4� ���,u焪�dZ�K��1a��	c��0����\����K'Q�G �[��L&�X��;��낎���W��9
v��J��T�$f���zz|\N*�U�ʣ �T?K@�[�j�*�Γ��)Z�s�
쿋u<�i���s/���>o�sJy�}��r�B��9R1܂ �v���jLZ����ƃK�-��:�_�8��9��0��:���L��LԶ�n���}����:I�`�T!SPZ��_\��@�BHq.4R�=�Jd+���g���0�C0E��q\�Eo��ͧ��	��c'����d�AX��"͘���b�ӗ� ��jL ���7륞~=�S$�Q�U"�R���xfC�����J�~� "�{_=�HF9Ĳ�`� IwXj�W��Ax�#	�ڬo����/�-n�K���7�!���{VA��t��!m�U3�
I���,'&h�\@$8�笒�s@h��Ѣerwv�w��ޓ�����sґ������8k(��W��t;-���l�d��s81�۰�cO΁�Iz�����>J@�H�tD��-��`uM����
�sz5?IҊ���59�(��4i�)�Y�2�i]��~NnQځ�BZ�]�H�je�hg����u�+<��˴+d-�>5	��yB�A����n$T7���cC�R.�;|��ǽ�<؅�aNE�NU�Z��9��g�<��Yв%���/x�������q���!�hqBC�%�6R���-F�5r�:�^ɵa g	cF����(�w�t�C��Z]K�ʤ�L�	X��_�hi'eS��d�V�î���(YMX0���a��F���w�8�i?�����׬�֫	z��r<����]���"�W_bȆH�A�&o��t���EL�����^���������X�)�N�B��]�f/T�_uF>7�V�����c	?���:�$��5���H� L�6�Epx��^OƬ긼�'?�<ry��_]M���bPR�`S)�>Q�RX�>�v�y�9ц 79�I���k_1\�{�eB;�$��I	S�D��T�M�T�|�]���<�Un�����fqX>�pkP��{@���NF�_r8u�
�&B�@�x#9���F-~{M�����?򌾝��1A�	�C2AI�I��m���V�]&,��6_�O�N����viB�UzM'�G��,�Ŷɪڲ���A�Emr�#ٓ�n��	��u�k?����-�Q�O�]�6��(A�a��r�W�[Q�W@�
ɗ��9�.c.�9��#�\p��)��N)W�Z�Y{M���TC~`�R����!4� �8�0dD4"D�k��,��V�����ܫ��۠9oH眎b�6&�:�H�&�(��yX��P�\�A����z��з;-���b���S��1G-�qIA�05��yb��{U'�*�mĄ5�����4�=TX	eRb�&�'�r�KRPՄ&'�q��>�3h�f��Kǂt5C8�X��҉}�pP$�(u����`a�,�>����h(!c(Ac�f{�>���8$-�K�N��h��s������w<�ADpc�	I?؝G�.!e�I7TwZ�0~+'9 J�dU=H���@�%�}BU�ɘ0azP���Q�xg�34�,"I�S���)�i��H0�j?�|��:�����!I�ӧ��)(#`a(��Xꇢ{�������渍�s�(G���+� ��d3L���3���Fg@��=��~�2",�oi��S��E%���f�-��Ef����R�H�����x������/�/�-�ִ�sr��Fx�J\n���9tI΄��d�FV���}�왢�����%`|>�z�����~��{Ϙ@cX�b3��:<��{y�ouSQeg��a����hQ���7���{&��M��M���إ��m�������$ϝ�B=�^�(Z؃��5���-5�T�3Uz}�����۟r��K˅���)����3akL`�k�l���ȍ:3?$v�׫��>�T�n�i�g�x9�ͺ1R�*3�)G\�;����\�/��!@x-��.��#c�M��^q���
xg�%Ea�#���`��"5��x�#R�eV5��
�L����)���S����n+����ި����o�gh^T��[)s�;�1��`+2��ԉ�}v���z���2�\���	!:����,'��rd(Y�!���34܊���t� &�z<�l�X����P�D�3o�w�0�Y�t�fm`��yѥ�!�8gN��G��[P���Z���f�^�2�`x�T9Gհ[*o/��U�8Ib4���9`l"X]��H=�@�����#�X��+rq�'7�<�Ě��K�t����"r�a7���1Ȕc`-�7�HU��v^Jgp.Z��dnQL4i�Z�N���O�g��!�Y�ԝW%����r��K(���A�őޕK>pjpkɝx���ӊ����'�']mMO��cH�I��܃���������*P��2��x �`'�0�������i�]��c�U���0��"�D�Ԝ��0�dP+&�T.    �)�tp8G����*)]]M���M���}�h��?͑����#��Dw���a�� v�O0h��
8x|�U�x��#�&I�r�+�l0@�K������?�N��v����@���~�+�'y����9 [)�&�<g��,�R?���\tNrC:��������o��W�̴�,y�x [��Ӎ��n�0�%b��+��@��!w7y["��1j��DjW�r�9�l8ZX���h!���-m�^�J�-�N��n�t��s����`j��ru9��η���M� T��^�C�	��"�GS��{9���[������8��M��Mx���;�znh_U��#�o:g��R0�s��|Ӊ@��L5�Bd�R�.^���h��r\�l@��͸��>�+r�����
^Nr����nEȔ�Ww7���2�}�߃O���9U-�^�����iD�є�,H$�8�%S�*�`+����*W&䨷޻�$:#�jw�����ENz��&S!�����u#҆�[BP�X��$�?���'6�v{���"�H�(g�)���������@;,�(�P��Beg�u�	�z�+3W�DS�"z\�d(�%+.�a[o�0x�F�S�q�z�(=<�*��Sp�N�~~2��lE��ksc,ς�L��E��E������=zA���hU�Ebt�����_9؋M\D�P��άLĩ}B�镤�!��ĝ�Ʌ���+p	��=}S�q�� �X�[ _�.����0T!ı�&ݙ��4Q�s����6Њ�-�=mɈ;��������
�$f@���$6�7��`+6�#��d$,�OF�2~�dx��v�cd��ځF� ,Gh@؊�/.H���,A�R�"TTex�TQ�7��^&����;�rr�.����5O�:�;�%��l��Q�/E�JD�Jl%�R��;�`N��V����	�ҲJIե���D��u�̖������R(k5�����p�7��z2�u��+��{le9�7i�o�~G�P6���O�lq�����\���ipM^����_�W2�}ek����=�w����Y���i�bZ?�}l���69���j�N�՟3%�*u;���K�j��֏���}�?-��X�U��Z6L�mjEŠ\��n�n�~�)yH���l5��N��^����/�����/?�~� P�L.	���U��y��(ѷ9�����W��Y���맏pުʖ-Y����f�d����o٪~�֯?/�C���\3�T�z >�I`�3*��o�d�-<���/�a�w��|�<���!(��)?<�q���d��?�gZAP��m0	��$���X��K��(ǩ�ɕ-v���6�����9�A����2[�2�?�dv�ʖ�z]�w?��Eb��6MpOXcl.t9��O:ɡ���Oօ����׻쩹������#PsԎrlAδ�j����\dR絛
�B���/���z�XC}׻����ն��c�A{\ȉ+�Gl��`�ٚ*ۼ8]r�R���2�Nq!�����f�M�d���Rv��=�p��O�<q�
�i���8�|T\��u��f���|�>4w+�o�1$�� �-BiF����?>��X�9B��o�v	��	�0!��AzOCSPZgu)��J���/�Y���N.-�Ϛ��'28WbE��CV�(V����H��Pg�D+G�KB	s���;u�J����k�VY&r�����3��W�htN����WIR���'e��0��fT�7_��L�YQ��P�a��g~N�l�i����"0��W�6�EN~oRcn}|6�}k�3�Ǥy��V��Ӧ�VOǧ�S�����b���hP����^�2'�0j7Wv��nU?,9���(axiv\�'�O\-[>ѩN�I�L���������d��b��~�Oݧ�+*�w�����Q������%+#s8s����^2��UP5�0��"�H�u�bw�������|n��K��P�~�����e���,��,���V6�vn�B��al&lͬUrf��
L��B�~�'M�]�/����
�~)?_ow�\U��ze�,���2k�J�K��j��S����(4#��+ٙ~�@��LdjIּ~��;!�u6���G�F[>j9�d��"R�~<��-)�����~~�["��.6z����fJxQ&��-6r��\v�� ���g��o�N#���^�Yf��sv����8�B�"��.�.�Z��55[
�N$�vVݬ������6�\lm6��A�7N��	l��*�9z�I���8m	��ڀ�` ����
��o�܈��A�x�S�{!'��p{��}W0F=�;��K�ʞ�f�:��2{�b2�����%���a+.;t0�X}B���H�L��s���?�3�=�rU�W��R;}P�[B��6�wQ�.��Z��M/r�JH/�a��H�db���>C��{�]e/r�|�r-�@�D��B��4R����V�P�1�c�K�_j�#��*�2�&
��'���Ei�����d�Ubk��f��Tr����g�夷a��Ut5N��0�Oq�\����nueQ��%�
q�n���/m!C5rcb�t�p+*>s�6'՟��SrF�H.Am��K�6E�d,��IG:�=g�7����-��>r��)Ne��l}�U52���~/GR����&VJ.r[ܽ03�8�0#xJ�*~=	[�j;Ɓ�]9	)2�oAW�sa+�$�$��?l	X����[�	��,^��z�@7#��u8;ܠw�����b~� �h'X?=��yx�lp[&&����E�l�k�UNv6w�*쨒������dSAA�4��M�g��D�Æ<�&�i��7=����b�	��UaP3�E_���x�l���+}�S���ެ�+\H"0H�)��7p��{y�NGҖN��n�{r� �l]Ϸ�|"�A\�2�s`3B��8uSO�bVo'."-**�2!{�9�Ka�!"�PD�<�6	�4ः�����~�y��2`Qz�\8-y�`�끯т��ax��l�V~2�>^����ӱ�©��^�wn�H��A���u��d<U7cB�F@<��̋��sI���ܖ��%ܞI��%���mݙ�p�w�l����C��Kæ���_���$�9"4/d�	Ff����u������xe=�?��fq���Lݖ��{u�>e��a\����&S��WO��'_��2)>��1��O�_~x�m��CY�������!�pU�y,����-橞���&�l�m���q)��z6{�<�kuW�EaJt�)l��!-�C=�v�ĸ�1��
"������GMb�m�o����N'oL�Z���ƑB����Yz���O�(Â7vo/�l*�����q�Pr{c����v����x������O�OYa� ���2�����:�4��աi�������Ca�ak�hy7�����7m�"u-�mS�ámmŌ�3o�ѱ�w�FŚ�c�����c�e�G�R��:�u5�a��:��u���JH̟��Mb%�I��zl?; �ih������H���K��� �v�	�u��{Lj�JF9UV�ɏ}y��a��e��u�L�!p8Y�	����B��կp�K��fރ.��U�L���Kw-.�~�!�Q�����(��������~ЗS�G�6���h_�18�������_E��wO���]�V��L��V/�~*;��<I3�$�~�$���d��E���"�(g�����?4F����?s������w{}���� @����G���*�O�W$
S�C�,�w���������S��;)���Bz��w�W�3%DBXbN�^��-ȍ4���5�O�:ɗ���!���e��E�����7{;^�n�tx�g�l�{����<5���n�I� ��
�(-*��F�z���{vW�1o��a71�`+��ړ�r�2���0�0U;4B}��!���q4�@Rch�D4/mS��<�lu5�j��G�0u:4�ojD<ߗ�F�r<�	��������/Ե"u� 
S}C    ���ߢt1(kw����� �yu�(��<��Po��-<�C��(p�D�T\�4
�i�<إOX���kߗ��Q�sl��q7��喦tTx�nJ���:�����&LO��	1�(���o���]�-�,AYV7A���[u8���o���NL�W��a��8�`-�;(S�<��y>s����q��~�]��l��R�����	�f����<��}Q �������Qㆃ���V��f���`��K�s��@ƩHQ �
��f��Q��6Wsd�l��Ύ�,��)���d��A��^�p�E!v¡�ݰ����2.�O������y��ݬ�HV��>/�r=��K���e�n�� 5U��*��I�F��#&��Z:����-�L�~QT@N�D�h�@��E�MU��{ш����ȝq}�" ̩ӪAr���H�K�����<�	�ʕvXlvǅ��i�I���I��5��#�E�$����I.�d&��X�~���߷�?�)".���	���s�*t�o~$oǛTUZ`d�ϻl�[/�k^�ⲷ��Պ�I�2ݼ~�K ��	І�J>�u��R&��E��:�"H�H�q�\)^�nl�m9���hT�;�
ti}I�^z�jheԛ���B����52`k���~�N^3D��{*�f���z�e@�V�6%�o<^�()�$N/1	R��\!�e���g��?-T����QMBd�-CO��3�>��_~V����n�ևz=K���kzٱ^~|<��b.��b/�5������zG~��QN�3�
�ɹy��\M��;��v�"�B��j��u��杞j����GuQ�O���j�m����_���)����`^���V�/�x�˼��I�PG�:�����a���O������;ˢ�^E�V"]�n%��K���y��/{��^G�Zv��.��U%��L�!;��~�m�!�����E��t"~��9�}Kr�z~�ZQ>����MnA/	�ۓ�[��a���zzvTG�<ϲ�kvW&Lg���A�+�!W���H�v��IOlx^�\x�a/&���$]��r���#�����׏�m�y��J�>l�ɀ�-�bs��ҝ�
]J��)�R���?5�J��I�e����#ŝ-�0��r���`��2�x�n�Ry#�y�B����6c�p���
�_ [����A�F\��J����\�Mv�_2�T)�l��X��o�n�ޣc�`k�� ����і�5������KC�ފ�K���>[Ζp`��{	.e���S��;l��aJFP�.����<�R	���TORY��wH�I.�d��Y�=h.N^l�I*f1):L���l�����4�^��(O��� Ą'��Eaʉh|,�G�w8����/b���}���i!R	
DaJ�h̼u�4C�<2k^g ��$�*)$M��G�@)r��?�p	�"�(�	�&~�5�ΟV���0Y̓%B�)����\��TM:=���L�;����X���ŧ�/s0�u$�46}c�F�ox�VZ��w�L�E	* J���)��fi��H�ل���v���a����?����������S���9�9�N���@
^�'�&�� �GO�|P�k�GD^���bu�̫EDT��@
��
��Ki��f�b��ת�*B�
gʗ?�H���8F�(��_:�w� ml��޸�H�~�y��JJ�,��u�N`�uP'1{����RRET1�O�l�m���|>��@#b�k�\�2����CUh�$��0�Ϲ:��*.%z���Z�3���`�[4�MN�T��V�٪���=������b�;HٲتȤ��q���L�A.QQ	W�]d�+Lܑ.���f�ű$�ȷ�Z%#�_�/r��~ZT�C���Ao�%�l�]6���Y�)oR>,כ�Z�����j+��P��3NS��|T.�q����!��q���s���1�j	�z�����~�J;����M��Cȳ����2�)u9�v�Sfo+��ظӉ9 EZtr�8 ��dH �c�a��:Ҋ��DdO���o�=���raK��J�	O�LGx!���a��ּ� "���z��~ �6oh��`��C$��RU�a�A�8/�����1����΃(��,S�*@ojlW�{�wx� �|�V��(a�}����T:���/?˵�a��~�YW؀'���`��.\)b��|��ǩ�o�J4���˾��2EF$\T���Q�ǻ-�*ۓ�<b�w�^�$=�T���\�l��3%Y���O�۵�Z���ԉ�\|r��<��6����	)9���Q�PA2M�,�SP��+'Oq.s=��/��N7!6 z�M�۝��Xlu?��D}���鍘�)%�'
uų�ڕխ&����@�a��J��$N!`�P�W9�o�smj�
`&҈��Z�ҫ�'��?�a��Ц6oU�$�9�X�i�/w��M��o:��
�q �
�uD�O���	i@*Z-�w<�~�}����=�|�4����4�"��N��8)���3�kE��]S�s�;�9�c߱l�9��r-�ݯ�y�{�F�,�6u�}R���D��3��Ef������6���S���Iۧ��UjV��������,��4,�껬y\.�*�~;��.EY��CH�1��!��=Oh/ ��.�qKg�PQ�������9��*M
MJˑ�����EH2$,�<iD�F-�g���^���x�kb3{�}N&������P�H��e�;RhNP�$��r�*���S���3��#1�S�"9ٚ����ِҰ�6��g�r�W&tV�PF�����u��saҁȯo^�yAaj|(*�~8�j�(wu��{[&3�ȫ~����r��J��|$=�k���Wo��8*H�
^*H�
����� �ޟ�9��I�0%������N�գ�15����^�~��B�t���M{�]M��7S%7�#6N�9��ne�=�y*R��	.z��P?L��V'=��G�''�s�>�+;�!\�4>+����猂?��tJ��
�)�{��!U�E���%s�Sp�7��s�N�}@��j�Q��U��|�P�̲�v%W+�]�I8l�c�$��:� �o7
'͏E8mvu��h@�1��������
�T��v����F��P�4U���$�Ć�G�jjEjk�L'�?�DtUC\�$JV�ޯ�do�Ԃ�(B��A�wb���e_e �}�V��p ��h��S��*Q2�H���1�ށ��Ĉ5�UL�D��s��(�"D�Y���u�
{"s��)�.`ph*߮SC�#&���d?V/v)惻Ia�%��x{��Z�$wT+'ӏ�:a��N�5�����L����X��'X�ؒ0�2&� �g��{��퀬�zX��a��Xg`� Y�����J8�����7B'C��
ig^v��=*�2�g�b����O����ǿ&�;.���l?����0�{Lq��HHY���g(X�=�ԛM*A��ʯ�~��q�-,��½х��d]i�۵D�HJ�i�@!�	&��c���M�uQ|U!���D��@��E�rS��	�4����`(�i�ہh�D3L�1|#Q�,y^�tA��1D��5\7g�����.���|���F&�����i�D(l"aI6ᐃ�2��w�`�	�n�c)y�l��_$�t�J�ۜ�|<͞�՜�F�C��"E��D��T�vUV6��8�I�D���ɡ^����YnkS�J�GTa�XK�t��y���-�M� ���7ߜ�EE��(R��e��l�� l,5a��Z�� �M�GY	����g�F�B��*[��+T����l�G0��n�"GP,�J�,�`�.�ˌ(��re �\��+�ھ~y�_Gu�qUg��>{�_e�D6���o�ً�k%T.���.|���aF���>���\�q\$��Y�Z��g�I���X�}�u�yU�-[}�������5Xq�L:��3x5Ϟ�)�,9K]�D�t������/~o��U��x�X���뗦>��N.�TؽZ���awox$ǯ\�v�%�~��?![H)    ^��NOl.��5P�W�D.�А�K�p����4!�в^V�Tp�I��3��+�<�2usdU|��K�X�
�K�#;e]ē���:֥RAڣ[	��1��H��V�jm�j���*cj���l��0Dh���B���Uʨ����zj
_��W9CN.�P+�Q+������l�Q���i6�"L�i�c��p�$����2-��'����:s�6�X+�Q_#Z ��[N^�Ȁ%4�y�Z��bb�Q7��,���DX�y�W2��A&�. �JE�J����]V��Nm����*�`_��[�ٝf��3&"9�q�Q	�F�A��� j&�窽 �L�� ܊9Ԋ9Ƅ*L�]���>�[,�<�1�$�<P*��
ox�S��ԭE�[I'ǉ6�f�2^|�[���a�}����\a2Vm���-i�^eVO�V��1�`�8� �ɥ����	hEnE����H��p��R��H��	��\��07��,��qw��~�9i��o��Q<ΐ�Mv�i�Hϋ^�4���;Xt�Y�w�{c��� ��k_��Ӣd8YQ�V�⃶����O��V�h.���eŮ��(�!�V"ԏ�M������H;�J���Z�V5�v����(�-kk��`�Q�7W���J�T\�Lɡ�
eҰuR��"��<,�Y���-Y�*,BC�I��) '�s�)f��"I�����ǻZP+�X� g^��˲�ڎL%�D����]� X�����D\C�U^�U�W�YN��j+2X��;R�5`���^5/V��;�(�h��f"����P#�ʥ���n���lL�JB��F*��
"A���yA�tY��X�	�]��ڐ���p�S��A�2wE�",�/=C���Rx|	0c��Z�V��a�U���fx�"�#{m��Xd��\h�?Q�a&�X���<=a"�����+�+�'MK�Ba$�m$���w�/A��������p���Vj�V.���O��b�����jg:^b3�aB�����v���c�a�����Z-�_�a��#���퓥T�i�ZJ[����Fe��2�`��%�h�>i+�l-�ߜ��qh`���j���"���mS�-� �� ���O�L������tx�Ξ��¸"4MK[}�ڨ��g+��CS���<���V3�!�����4�raBۦe	�I[oP�Q/zQ'�x߬2�=Nh>���&�g�UbM�֞-�O�rP����Jp`&��E(d����Y���:=-i;`^���p�h.�5K�YB���������e��"5X^� /�j�6�PRi�3��U�ۺPy�̽��K���P=3oƆw~�Fg�yx�ˮ��:�!���z�A�>g�UoVۇBϧ���+bT ����!@A�)/P>;���m�)Y���E�	��Y}i���0o�^�S#�;�-��Y4�#x"L՜�|-sN��yxB�7l�K���D� WN�?U�1��w��"�#�{�ꬿ�\�Y��X��]�ۮ�uk�����uPY�R4�.���W���"o��ٟ��]jd�.��	�G����o���(�ms>5�������3�3\��#$#Dm ���
��
�	p�koF�Z����rv�cf���2o'dh�N���6di{�ֵ.�C'�op�g�
)���`)hm�U�9�bw�����=B�TVXE���X��k�2��0��h���!�ى^PO��Y3�6�SMv}�Zy��9��� "!�V�s�U�;p���sȸ��[�W񋭵v�D�	i�,�[?e!@vR��
G��d4�6�N�Wr�Iu�ݮ�W=L�������Ji�V&� ���$�q�[�$#�9�r�ŉ��0��A�:96���ٹ��<�>�xE���`��-���1� �	�����3D�wEq�) � �Y��̵��[Oj����r�~G㈚����[��WFw�y��GH�d�6T-�~���Dg[rs��'��c�������C"].�mOl�yO�s�1��UQ�[D�>$��}��"�"�/Fz�=�^�ٓ��׃[M�O>�Y��FL�4)JJ����2ڄh��LsBl�*.��(G�;ѩVt5���ןV_R�8P��v�~��>���|Y�J�k(�:�5�ܳO�y���'�H����BN��%��"W���9�ZNp�9��[��s����y��7<�n�����|���2g�v�;��>�Fϣ����a�xVǱ��E.8���dG
AB��Օ[�p���R�L�����O����-���9S�)C8{6;�8�)���Ǆ��7���p!�g���@A[��P��B=�Q��y&?���X�2�����$�π�B���ۡ�T�5�c��U�@ l�����Ê��S9j��.���z7����wpwR�9����y�/kN��8�ngn']"h�۩�� ��]�6;��~������Ĩ���3QUVݟ�>�a�n͹"C������:�给�u�1S��)J��qya]�?RDT��ZZvj_P��AT��s�1FM��H�4���p~�"{�:�yH���њ£WG�D���Y+��м�q?�&9��C��SK�q���i�1 Sz8��[���Et,�C�Ip�qU-�U�,T��/	����ѳ�,W�}/U�r��|S��2u�)_����ٗ:%+r�Z��2l������~/fM���'em'� �sV��˿��י�H��m�.[���k�\x�"_�gY������2��R��:�������I3q�LSDD�;i�j�(F�s�ں5A59�Fd�f]�lN�B�%]�*�(|���-���·;��\�YW,B�:ٷD�++��
��\�:�	�)l@[�y�b)z�Ay���\�E���[F��N0h��,��O�<2`��[W��+��7�\�,\�\=���	`5[���VO�z;��r_�t�&��r��Qj�_#lv�ø�W��P3�8�ߩ��xح�}�]�m���n�>b�us���b9J����Z�NL�|�Ň:��s4�I�6�n����|��fÁ2	%H`^�u��7��2�_ڕ Ҕ��aT���a���k� ��-���7U�H��0Mٺ?��Ǉ!��A�Dpp����,�m��V]J���}T�%&+F�0��@��9��<4�
&�Mv�j�h^���{��R%�Xi����;}+K��
�h.X��S6X�;��R�<#�\$�:܅]E��UxB<���٢�W� 	�<)��g.�l���S1ؕ�ѐ����}�DMU��Xk�W���q���Oܣ��Jcb^�i#�'��b��э���IU��)JW�Ąyv���;:���x^��M5�4��T����Y�0I�gG:O��^��%U�j�;��9D�<A�7S4u��WD�(���"��?H�^����;F�UE��7��7�L�#�=�KG-��`ϱW��ZG���7���f���	�i���#/�Z*��+'�.|����S�ܑ	jCwj.\�~��9��Ē��Bj	�������~�aZG�1Rw�D�;�Г.��A�Q�X�*$���=�+OĦyiU${.|M���b;�Ց��P��j7_@5������ض�Ȟ?K��a��"�}!{�U7��Q�	�ˏ�c�6B_X��y�x����L��%�!{�v���^F�g9Ľ˛������t���z��lв���-�5WË1��(OO�������ß������l����������_��=����+��?����?�����?��?��?�9�_�˟~��_������߲��������������P��O��C��������_~��/�����������?��/����?�9�O��_�?}�俖o��_�ͯ����Ï���/����<�X:��I��eӧ���/_N<��׹�Ӌ�]Lc��:�DeHz��]�����7���f�:�v[��"��m_� �bd������ ��ܬ�F�D����&;.��T��}���@L���k�T���M�q�8�o��m�l�i�����;�    �T9�v�ݦ>f���Q,{o�\�[i��;�#�7��!�|�k����%j�C��^��.{�3I��G��7�FM=R��k[m�d�[�v���^s�,p@%
qJ��K;������ u��9e�[���5!���}���~]7��*�_�����L��^n��.~�9$�1PQ���1���z��������M:�-�����,���M2��'D�O�,=L����l��~Ye/�-h�����ܢ���dlK��?���Y-�w�_�U����TQ��]���Nwe���~�=��\7����삈QIRA��Q�+���q���a����u����%�j��욦�|+����8��V8��w�l_��B.̟�OЬd"��O�����8%�䎋-Y�0����¶W�s����:�Sģ"UVώ8 yp�`-l�y��-�l�h�jp.?-!\�T�(��j���$�i�\��4(F	����C���X��`�����v�
��%u7\�Y��2�\ȉ�w��%�O�����x��*�/� ��s��}ꮁ��g���aGX��hR�H��؊6�����jZ�a7!�4�\L��~����e2Ze=��3�0ߥ�����IX��M���7��6��^_l�ȳ�Rx�F5S^�!#qf����l�8���y+*�z5��~6��"�\�<�>ujv�H�a�_$t��{c��54�/���z���$<`�� �i��	v"���j���`.�D�F"�wwc���|�L`;3+O�L8�U%6�r�	r�v���fsu����[�oG��E�3��El������&�/���a�~���sd?�9�7��]ĺS�f�r�~�zzyB�z��W��������i�l�e�܀���S��x����Ln�P�s�ѹ��z����.ˍ#Y���aխ���� �X ��&��u�-�:�fy��YA�A����4z�3)������"F�4�@yDH\˷o_�}�*l�毟o�8{�*��8Ԍ_�!7�@V�P J����g���G���� da��X���z~�X�&Q?�cWL}���@���x��Jc%�o��'�:˒S�\�C,�h����6��9��YN7�OH(�Xq�Y��T�ik��ẙ}V�%e�n�4����`�Nu���JE��s���5�y��t�:�%)�T4N�6/$-�ۃ��F �K�I�87EY%�����ZF�o8��=o�%�Y��	��ZZ�z�hʕZڻp?hÛĮ�q�U��(A����en��ȩ���y�}���݉�@���[MpoI|��%�����^?��B ��+W�ZB���}��L�
��t���[m9���P�>��]#�J�ևK$�?��ve���N����������v$�BF��sύ8� ����q����V�=V�4�^{�T_������7�IKHi%
7_#��"����q�=VB��XK���<O]1��ֺ�7k��]{5�=	b�}z+�A8x�"���PRD~�0kJ.Y�"���#�C0B��V2**]m�2�Ŋ+�߈(Ho��@[�(�FI�`+�} x�8�^���3�T�*� +"�}QL��)�����V��l:�K��3cعh��S4����_T'�.}ɡxW"�;��[#? �A�37�O�6�*>h����blX��)�۞M��NlV�Y8���9�S��~����B�Q8���v���Q�7�u��<Q��l:<��.\"��m8���Ϲ�&}ا�0딎U�x`�$�i茓�Kv;9�o__���U���
�l�B�2���#q{�U/|�<�t�m�:%'�BpWK�&��;����~�{�brC���95��@>H������@�b��щ��!��u�,]�����St�|���c*��^?��~���N��"fW%�����X$cP��v���+��U���@*(4V6Y
n+��Fp���z^�(B8��;��V�٬�r؈x���P�u$XG��B����˪����m�,���!���>+�ri��X՝��fo��ZYb@-��潓r�>X.ԙ�t�2ݱ0ȥ<
"�k	�o�v�N��=G��	�@�qEn��_r������5�(�'��0��(�� �s��NVKz�]�s ����~M�H�i�L�=�p0���T0ʜ�A�Q������Cq�̡m�3����������+���,[xŖ������r����INq��В��%o�Yw\K"gм����Uz+>fZ�R��D�q;5��
��z%Qw	��|�,����?���6b  Jh����|���J��Sj���;���wb�>>3���.)`��`�ΊvX11��م2ϥXx$B$ν`U�� -��He7'A��m4n�K:�ܓ,��Nd����ZҀƙ�AC�@��C��.0_�ߐ3%4V�:��������cÁ.2��G�0�ZS�s�O��ls��2����Q����cUqCC��;y��%ˁn�T�����о�;��9�Z��{�e/2jE\���Tޭ��23��#��ra�hB��q>��;��Q�zg/��&x�O�����~�+�8y u�D�z]�U����/rEɝ$(����^��6k���qKЋ�r��|I�����'DapHm��sҗsṰ�<���wݓߙ��"L�� 	��K�m>�sO~9k@�cD���o/����^Z.���|X�NCQ9S�#n��� ��uKa�CT������_�b��t���t���~a��}"�R�묽�� /���ʷ�E�����J��*��I'o�k�_�/i�9�t,P�q�
$$�/�o�/cF����� Y.��.���ġk�CT	��it	�곛��Q@��D�W*j�`��-����*pt�X߅��B�
�"�z�DSJ4bJ+���W�L_Qa��|;�Sˁ��eʽ��,�
4�s��U|�of����k�X�[4$ӱ"yZ�{��T}�W�K�RB<ǝ^^)2�R�Ꮊ���k����Q���@GQ��R}��^&�(%��R^Vǣ���護�,���YнĪ�5���`vNs,�?�99��;���B�<�]����J�N-�%�sҁP茛 �~���UV���9�uQ��*�v4ȁ�tq��i�vUQ�CX�G`"��
nBKw��"�0A�W�f��:���
>��@Q�S�#��*�q�[Ϙ��nO� u��SU� ^�#Dp�ޓyDr��Es��'[)!Vg-��� '*��Z�ҙ��WU����;q��y�z���t�xPJ~Ю����X��gh���6�M�r;k|6����:�)B��P�G2%2��yeBu�	f,�WI��%S�*��HƼ��~���H��_������F�3w܇���|�:ս�o`\��9�%y斫e\&~��T*���|�$ו��#�6m�6��~�wQ?lK.���Ҍ���I�c��g1)�*'T��A~<��b�r��ǃ����tV��c��h"�4�P�d�rS`�0kV��9krSv�x�e�&�B(�I�ki67��1��������z�n����J�&!�c
�n�*�����������l�3�)��<|���TB��<bu�Q40O���#HM).K�$�����h��� ����2�-���.z���a�qX���k�?9��K�CZZ�8=~FOA����^��R�S2i��g���vA;�^���	�b�|4��_����}����G�O�b.�|����50�Zz��y�����:}��l��Jƈ���(ً���� ��t����w�c��p�����u��Ҵ/�޷�p���q��ȳ�˲208������j�t��4#������&:����.�~m+ �x���Csyx��y%F�~+� X��ͧ����g�NNS��M�hZ��c���j�\�e$-�6�ǙF{�Ӏ���4hS���J�>����C�{�o�[KaC�m^ˏ~B�w���T/�m란(jQcY*����w��n7���`��yC�P��7�,Tz��{�XK��8�IJzĠ��/��N��z몊�<    ��8I�=�,�qn����NR�����&WJ�1Υe-��m}� �y
���(m�ے59�?��������g��5��&-wT,m�����G���[E%2g#P����j;K�w�qy�>An�1���y�8d�K�t�q9k��n���5�t�=�~},��˒˓�Yr�p�#���<	=�Y&���r����饦�y����Go_�E��ע����A�9�뜴řP��)2����E{����|�U�S~��O��H���.<���?6Kv�n8"�htif�3���3��[���QT��w�D]@3�/f2���_dF��/�P��߳C�l�a3�'l��
/9�1s��߱Am�.G��F �Zl����-�k-�)���hs�f7isY�� �T�]4.�����be�3� �1�u��s5*ٷ/�N�#����>55���c�	BL�"�3�'��z�%��wERzL��%���nFA<�f/k�Yy��A��B��c� NI�gX����;��CԤ�I5�3ױZ�W�ޥa?$T(l���P�1��ni1n���	�_��$�`,ձ1U)̀	���;G��d	[�} |�:F�n}_�7���3� ?6(l�{g�Ԙ��ts��z�6l��>;�|ֈ3�����3��Ńb��C�4laN��+���%SCwk��.���4�5H�v��R��Y0���5�ǝ`�9(Rg���nیy��K�xq�2���} "n�BJ��uT��X[A�{d$
�|���1n^�K��T��B�M��-�hh���4���:r�;�9��"ڢcdȘ}����-ͨ�?�����Ȝ�ck�4"nj�7DHuWd���8W7Q؃?��/_�Q?�)��(}���w�w^������'�<-���@y,���O��g(�Ǐ���{TK�$��MKK���\�?n�� B�y��u�?��uo%�-;�4ֿ��R})��✅c����]+񩙀���@w.zc܅��G�U_��4_7�ˍ˫���(��p���O��M��Ɔ��p-�(���O�Hy鰒�yD7u+�)�{w#Ic~7Y��*���=�v֓qgMl7u.�W�?X���|�/��R��|Jv͑���nH��ɬ)��P��HБ��l\B�(��	&N8�yug���X�:�b�2߿��Yd��r,�}����\1w�)�$D:�3�G�ZP����� HNwT�M�&�&�.��]�Q��|ZN[MP����i>IФ7�-(�lI�n;�/n�~ؕO�"�l�������&qjq1ֲ�>����o�sO^ЂP��5M���"�15m��X�H���G7�!�uN�	��H,d�K�Yi�S7tTdiƃA�뒁��hڤʲD��R��q�&jTl��<I	�عPK�ʾ=췢�ʉ�-�}�/�5|s��2՛~őq�s��E��G�&�T��W<�E��Pq�k�ι7St$1�0�!Z��ٚ�S��>�i�V�	;��5Tg�b����D~�j����<ED��XL�ȗ���>]n�,�����u���{[n�^�S�̷�P�Id� �זid2��p�j]a�<gJ��1�Nv/4�����܎�ka�qsVϤA� (m��ǃ|}������qU�Sѷ�eQl�����&���<[�6�">m/���e���y�V>���];4�MnƎ>E�8���]����Q������Mu^�iдi�Ԍ���4��<#����h��M�[�Ř�ΎNz`�$�=;�(p)j�&[']��|h�W'�=�w�r����/l��TF՞4�M|I �����S�∓��\G4��~�P�W�en�ˮ��C�r�{��u�������B�k��V ���{�/A��%yI�����3fOB����d�b���y�A��mMܐ��N{ |	�Q&j�����S�sP��19��}"��)؉��D���V R0|��:XI���<Z�7�fP��9L<b�4��5��,�=,H���>ݣ^x�ݙ=�Ʒ����\�[��d}^@rcx"�1�htp�����EQS����Qu��r+��s;�wݶI�.��8_�JB_Hr����x�6�VH�<<X�Q����������.)*�6򴀓��˘inv��t+��KlYRJ�D-}ˇ,�&����#�2��Jw�c"5��?��P���O �>�0u�Ҫj�Bމd�i����ฐ�Az�˵����*I����Y�ҙ�;�`43�<IUeg%0Z��S�)hʇ��l6��ȝ�K v�Ѫ2��r_֭-�t��5�c�؃��m̓sP�g�sz3��b̲˹YSՂS��{^>�=$�tX��i�u8���7��saI.h���=yH��t��;"J4��bPY�qk=�䟂>��7�:""�n���ܣ l�1�L�BL�ӎZ2ap�HZ�>�������U7�K�N�F�J��8`#BϜA���&����	[ԋQF�j$����<����T�2\g*k�������.=���hۧ��\�I�7�U��;1L��w����XP�䂊�l�f�?Y��0,����*H��sb��$F\a��}3���H?��;P�u'p2�]+qB�@>	K��m'���O+���_���&���|���V�K��폃'LǺ�<���q����� <���x�S7S;>W�̢
M�qf�CФtXhi�N�q>�;4�s���|���۪��:q'7Wܱ_mZ ����aMT��͓l`�a��Y6��c�Ne(�XF~��P��8C����ח,`c��{Ñ���ڨ�ۃ����oӒw�:ۧ�RdN������a؏*i�LzC
nn��A�����D�87k)i��!�@"�9���tf�����N�Ե�3��D�<��`ACy(��y��m��.2�{$�J��[����r�\y�MZ~��Y1�3o�,AQ���zC�>q���8��8k�P]K`� V��^#��"�њ7���7 Zt�,r�+�@[fww靷��H�w�H����H2ព�d���xt�*�_奯(��Tz�b�N��u�@Ś$K;2N��n8	�/�|P���LY�X��x���{��_����#�|xL�\l� ��z��kQ��c#�v��\���0tƐ��T��p����|.`r	N�E8�A�87�u%*�I$F�W߬[yi���;�Zsٚ16���X�;ņ!v�]wJ�7ظ��q!���d$�~v�B'U�)��C�@A����@���.����P>p�q�쳅�(\�4͆��:;�0[���y�������c�A�����H���C�X�V����as�u[�L��%�q�v6��(�*����Wv�Eh�Az����[ζ����L�IY�w����/	�^i��\�2N��¿Ф�b�d� �^�	_�HA�;w(p��H�[�b�S�˵�����ow**��h�
�_`*�J�*�g7�� 4q�;����|��_����ه�E��}����8�\3��n��*��;Pnaz���l�R��}�"2�@r����`���E�E�����:s�<i���ey�N9?%!	��z0����@軡�Z���rV"uR^d���� �mx?{���K����&E#O��b� .��vl�<<.�M�Ȉ-�ђZ<Q��Sw5���"	Jb�պw�G��/�xo������?�R�ug �v�7/����ޤ5:&�k@)���S��]��K��jIK�K�Q�jj�j&�����?'�Y���a�@�0��܆3g!`36 �-���>�^�D5q�F��ﳍ���d-k%hce���N��Ip�I�*���#uT��b�n��̬Ӣ�~�ׄ$�(�*����^�Z�c�Q���#�36r	�"���0�hAA�.��'�m�F�Gh>��"0����ք� C ��������l(5x^�*������֛o���f���2h���*�$��Y���Ut��֣��>�\��L*A⾅�
R�-޾~�-�Pg61[sp��5�e���S\Lh��}����®��    �����&��!'�s=r;餐�w�`I��\���"�ݽ}Oou��|c��Uhn��`�,r{K�.�������������>�wi	x�n�$s����9#�u)!	���Rs�e��;�Tc�-�\�$nM�K	)�A����O��}u��L�G��_BH�7�t� �z����1�<?���f`;��3�F_� �jJW�Q����s�~ ?���>~�jU�5��6~�B�MA?��n�ۧ� ��������������t���i��u�ƤACإ����� I���ܒ`�$,�nh���3R76���ێA�݉�↼��澧��;��D��^��M�����{?TX����`w뻸��ޡn-{\����}���{C�� y�ޏ,���z�m���Q׭ۑ�w<m��8<�D�4��_����3���S}�C�I}�]C�ak7B�6�����+d���0���P���r?O��!�0�����ŭ���j!6��)�Ax&)	�r�:O`��������{�xX�IICs�nﺶ��\��fҺ��`j^�>�L�n>7�!�Xw�6�p[L�M4�y�BC�� IC^���:�j:�iF\����A���4�Um�Y��*w�!4Vl�Y��!��;4X�uo�����e�,h���vt.��֤��@�)`�_�\�bUf�,�V���� 3��B���$��'�W�P�8��Fջ	/�+˗l���ϋ"=��9��6�b��ܒo�O�h��U9�+Q�g�+�����kp�0{x�����Sd��|����>?�߻�#��4��M��16�#z���2�SX���9�Q��|�Kk�a�l.M/-'�~y>��G�L��p2dفu�{6�h��(�!?nkwE�|m�	�chCF���,��7��[q5Zʈ����"�a��ŝ��*���*0Uo͂р�R�l�n�e��'�׶����,u�v2���"�BHܫs�6p+��l�p:��_7ޞ��A��$��X�f���.�;h]�;��<@�	6*����F�0;�sm��H�g�r9[��������	O�(�N���h�î䆻+u�ߦp�dXE	L�@agtCa�X�KKW�p��(��@�΢~��/q��2�l`��e���{��05�{:��D���P\c"
�6�C
����>��m�I��qZ�"�2 �+�� ����:�kpP��Zp����[���I�/ru��ɰ�l����6�S�xA|j>،GHW��r:�y<�0��p���[���n� ���<=N��Ke��5�2����˽�
�H�Μ�
��
�v���ገ1!ԙq���7�'����j�z򽷜ﳍ��\�ċ�l�,`60ӗ��w�|"��g�偄�T�>�r��N|� �P�x�&�?v7D��93�X��s�[pq.pǀeڣ����%�*�����+S�`?��QA��D�P_c���tl�[}�+�U�Y�7Va���>+�۵�{�B�/$ڸF�+��÷/��{H���sp���	���p��FqN4��$��]��	٤��-\$5���Z���	)X�C�S5ܩ��.���0�����,�����u�z^�������V^��~9��۱�M��`���E���[쐬�����ݦ�ޗ+ ���+��&��������Ρ �3տ��-y�̃;Gf����b�kh�յ7$,�Qy���b��*���DE��VWݐ�i9:�Oӝ�B\9�0]JC�b���'b�EB������f,ݽ֨#ӛk���"�S92k�Ɇ'�Q87�t!	̸��'DD���ʫt������1	�Mu�Ɏ���
!y���r�+�sŋdu@!�Ը��T��Qgn֧p��q>!W8)���˗�N$����:Jv	Eq9/i0ZKDj��5�e��t�ٛ���4�ʂн�Bk�X�\����c�^&1��%Q�����/f�{R�˵��#Yţ���#[/���ix��;/#��B��)�/��I9h�L䑢$t�!Z�!Ԑ�B�Y��(L���h:�N�c�#�Պ��d��<���g`@��S@f	�6Hȵ�A��I�_���rc��F�e����>�(&ΠlZ#���-�;}/�Ľ�d����6L�d��8�U�T�;3���VKl��k�Y̓Em;4��O�%��\����|�H'(H�}�~�b��e��F
�C����=^���>	f�Xn`�5��^���W���PwB��y��g��U��S(��߾Z/�V)U6w�9����}��5�Q�!C���NG�������K"���m5A��R��_��%��56t:NsF�rN�?�Zy4�j�]\%M�:v��J�oa*��m�گ� 9j�m&k���ae#��^���3s�1��	�ӿ�տ����j� �_c�VzL�̤͘���7j���n�̉|ސ�I.N{! �8����
=�|��Nk�a��5�����;K��;���l7;�!���r�)n�����r�w
o������a�<i����(A����x��/1�#꾖����n�&�b���ٗ0ہ�S��9}�r��?zB��Z�ZUw�>��#����^�q�I�ع��y�XR��J i��ŕ=Wj�#�q��}�D�IM��lɆ�o#�ۗ�EVQ�㘙̷��~��0�5�������ft�*�dHC�^D�4>�Ɍ������"S���'U[���A�ke"�S��I�f1���(�n��Gc��*%����x�7�|��Cސ+���(1C�b�H�������O�h}����v���X U$xj��6x�rd�A���)�ɸ���\$����Le��hت��>A�L��B�4�<�i�_~N���D���^V1tA�_�R��`�$�9b�T�n_@�������er>8'���U�}A@�!`1H@�����fbq��;��TV}1nC�s/qO(�n��y��\g��$v��ʙ/�%]N�}W'ŗ�p�	K��T�|@�b{�&�)%�:�g��ߙ3����B��&bU�;��:!��)��`��!��2�(u��F�����.?S��:�֍�Bm��<�@������}�žXl�j+/�E���p�4�~�34&6��%h �h.�:�7LqX�y�p�ؙ���Fj���:�J 0���>�.��N���):b��P�E���pW�+�2n����۸��B����<���X��ҼY��?�U��� �_a�5�ZN-�[s�Ϸ�3,��}+�vְ����o�	>��ռY�j��R\~V��V\�nOWu��}&2�� ��9ݴ4`֤P�_����3�i?\������z{B~���ű�K�tԶ֙�E�9	%���vS�'(��Xf���C;x�ڶ4O��f�2:��_g�hncֈ,\�5m�%��Z�\­Yw��N+������sx�m�<�6�u"��}Q4�k�m��2��:���? ��v�Oj�m�-�3+x����g��S���
��F�P9��]
���.�0+P����	�ռ��8I��O!�җe������B�T���)��)��cw�rN���D����g#|AA��+�֑���~`d�
5
fe�Y,�M���m��A��dM�����.2e����jy&nX7�����&1���C�����^#�C��XK�Ύ��?��
}Ϧ���f�y�C6욉àV^���������U|��!E ���Nm�VlZ\Aw�Pd�˗g�]�o�@�Gƨ^d�E��p4��{�*љR��[h��1��Nc��:�>�Ab8��r���Eo��K�r�O��y|�-���)Ĝ8���g�(����.v;p�D ��1��W��)�S�&f�P������	�;]���:�<t9�̅*�|r{��6]q�x+�H!o��RQ�P�>܉R�����<"A�!�ե�K$g�J�#��D����e����=��/Ty�l/L7�㟛E{��~��-���i�}A���@e����L�v�1�H�i\���:���Yѹ�R�*_�G��D�&�
+Ʌ�S^@�8�C�*g�F[�    ,��7+.���<�p��C���s�v��M��}�P=��TB�{������}�j�Ջw[��go���!��7�)�m��t�F��r�G�^�Û���r&�X�*VP��h��<"�tNڍ��'�vt�W��%���/c<��w��ε����������a�!o�|H_>�%\f-Gg��P%���Q=q �$�LB� 6���a�+��p4uuwbI��_#�J�!҄�~���~��!F��,�
ɛ#v'.&mrV�	q%��\�<Ϭn�y���:݈%Ke}9c��@�uq%�P-d���Q��-_�z�<[g�4�nNisD6Os��3�$�Rs(lشȩ����`u�n�u8]�8T�]�}�Ǯy�v"zuR �y��u^
�'q��J������6���v�h����p�4406堁T�W�E����?�a-�C��EF=%��]H*͆+ղ�V���E�_o���7:��J��J�����+�B�s��� �J�a�2y�������!d���k�_�8\����ӽ?�j����ǁ�G����9�MCR�<�#!�?f$T
��9�!l����}��E��T�7T�S����>E�W���g}y�#V1)>;��r�"m~�M��.@ !�y�)��|#A�����*(���Z�'�|�NܹO+)GPG�Ww�������w�/��$Dx��f����𻿓�~�J����lp;B��<S�Z�"s�cZ�2�8(����C:O�)��ci�b%;oɇ��b��b���w���r��N�	9S��U\^q��8�������3k��ū�T���E������ɑ��>��m����)_C�?��f�F��>�b7�:Q����1�x����k���EJ��2KP/��e)
TЎ2�K� U�8���"��x�e��	UN�D&��,���/��b����*�~"3�h#��	�e���*�~"��(8�[D@��l�� A#���/�ƻ��1�T�XW�F���S�P�}�n�I��"<�,W��s��$@>m��;�!U�|Ej����H�>e[�fL� �a�I���)���^w�HC�SHKO���It�K�#�/����
9�-_�y�A?V�a�q��ז̖�Ô*���=��G���y-�$
|���"'�ɡ}r"69�L�g�G��	�N�w�mB/�:.���BN���^[nt���u9�6�h�L֜U�ڏΓ�.��)H⫐<+c�AW\�v�
mt��g6�l�ݿ���l����AURSu�BVG��J"�mp��r��z>�xn߅�U��0���g��r����W���(�
��!��ާH夶�w8�l� U����=k���cwy���ʇ!�	L�
�M�0i�ʳ'xqVA?oP	�.�����&��Cv�u�-�ݲ�4-7�NW,v�Ր��EG_����;
�R'��,G�
\V�T~�	Xqv�U]��sL)�\���Pk]�1�A${�ö5�N�j��l'鬮 #LbI@�$��Ũ'��U�u#��c����0���"Ʊg ɨe0�I:�[U�q�㬗,>\��(�#���?8$pXK`�*6Q�Ἲ�f�]�7!�]�S�[k*޾V�c3؇ؚ��u�^�L�e@ð��(��}�`����:4��ޱ�����T�k��Q�L1�S��.��1�W��Yg�����d����d�~�G��.���!"�mR���y3�j��׻��]V����$�y�`���Yi9�j��E����ۗU��qU��ư[���.�! ��]�NLg�t�ۍG0'n�r��B��ԧ��E�]���q�S�O�j!��	rnҪj7����/���2!�}�(�u#�ߖ�N/F�'�$�C���8��c@>t;n����Y*;�j�c�o��T$�E ��Ղ'��v#r-�z�n0^}rd�wl��(�%	���/K��r�N;���8�[D+��9�L6_G(IT|�E�]�(h.p������=�h�ŵ�#8��|��lsWd�lN������)��9��_a��H�$P��b���m6�B�-׫�+<�7��/�@��#�1��a�>b���VG���,yfg1�0�U��p����B"7��k�M��B�*n홸X�a�}0�!�c���C�17�:xw	X�)�*�;�O\�3Vj���T�+��x����9�(�d��IS49YQ�-�sS�=�}]{�㈠��>qH~$�d�a`�<Tԃ�,:�	u	��$�HCó����y��! ��Z�+�i
$�@���oq��-��_d��~��*!����чRbk���JM�G�����v�vTJ�*�嵆��J	��pD��ZpB#���b{W��,�S�m�*T	H��<�0�����yƗ1��ۗe��d^G���D	k/E���[U�ͳ�;"(�z�,�Ǭȷ�/D��L��I!��l7��l�/�
V\@-^9�do_�˿}I�=�'�?|��w��xy��Uۻ�ae����Z55��V;�ǹN�������H��V|�[lsO��@^�%����s/���\}nQ�Y�9��g�"���SDK"�o��? x��k��D~9�ez�퟽�,-ć�RJ"��l��bZ��Rt���l-��y�ρ��N�8�K����� ��\�3E��G���s�v��n������j	����H����RpQls� d���6�ͰS�qWG/���v���H�r�I��p"��d����{y����!�������Y�:�?����e�»�~c����|o�yzD�~<<�%���2�r#YA���٥�[���R/56�g����n��q�_�֩���#Cr-^~Zn��Ld� �8����ݫZ�'ۏ�I��`9�܁�4pn�[���[���׎T9�� ?0w����Zn���8�kuޫZ�	6��cJI񐥏������r]�M���M�ʫ*����Ϝq���.�H���]�w�N�*�(��S�,v\Kh���V!N_�ni��o�-�l��?\�~�w
�.��R��X�[�W�h�󋖋��$�JW+tͯ���_�/��~����=Xn`Iql9[o7|�W����8ڹ�=�������ԍU��J@��-�ݧt)�(�r9���J��}��Q�U t�nN�� ���^n����%w�03��W���R��4߷����$B����<�G�@/	�`�3��l���_!
x��5~�S���>��p]��\|zf\c�ùY4\3bB�2t�.�q�A]=b�;9�!�5������_k`K:ؒ�p�И�/���7��&�M�|y�x)I����F5�;��һ<�Re�^�\a�ܔC�O�zY>Ȫ+����܋5��%�0� ���Mx�6��9��K��xq����q����Gൿ$6�Ė����4D��J��a��t��-�]��#��Q�UF�N{4�"dRޒ;��u?��wV"�PH{܆���;�z��hO���u#s�b��RhO���uC��$�J�i��u�ٓ������P��H��S�����8��l�z�J���b�*wO�Ti�Fl�c-n�E¾fЉ�,�I{ u`��:jV�x>�&�V�ֽE �$z�a���(�s�q���~Y��i}m0�ЏR�U��:��������!��M��1��t�{�>��T܍*U�`+vFB&��ث�^��G����y����ϯ�n����Cz�y���:�͂�.��8���O[��q�����Y�S��^>�N��P�)�o�(Y��oEd����)���hu�QɽTqn�\�ܻ%����yY��K�z?�4��o��G�������a�)�qu��'9<� ��5�o�9��{o�c����|�6��H�<��s�]*�Ed���BA�)X�{�L]~�xZ��4R��4�ξ������F�6�� ݮ�E�G�{4\bJ��x���X���U������D|�f� u�� ���'�+�v'$�]��0E5t���[�Q��lɉ��?���������Hfy��R
����'u�K7��>-����r��3]i	�UQ�'u������]�     �J���EɁK�w��g�|�zsH�!ucw���G��ؕ.�J{�meo�ؖ"��tL��\����\���1#\�tY4b�Opv2�z4��Y�������<+3ױ�vE���"!w�QzC?�������Xi����'���.>�"[��D�jt�B��I�-�|�.p�P@7Q�V?P�JVv�0��vh[�e����*d����4���]�;}�N4��3��j��ƎT���X�p�;q�;��ʏ��T�}>_p��_��vu��PW�o���!c$���0�����������m���	�k����Ȳ�' vAyHq�#v�ĽGy?F������œ�W�숡��~Ԡ���݋���
3����+��+ʏ��6O�y�c�����(h��;�{x���F>#Jl�g�q�W�����l����o_��N�vo_��{����?Z/P�ge��ʛsV�[��U��7�7��>.�V�O>CZGR@k
�4/]g�᐀^�u����	��{�U�曽�&��-vG�3�����J��ٴmk}������#DLɮ�r�}���ޙ����p�yjo���h��pT��֟.9�*�lWlE49_:����% �l��k0�8��<qu[z������/���|�^nĕڻm�^���b?q��ee�Kۍ��v����m[~H�T�=Ʈ��&P�;��O�<䖻	LI������`��|qx��k���{X.����q՞54L�
��?{�wܠ������n~%��'_����:8�V�, C j��:���G�}j�l�����,zW���`�5-"x��uRdS}�n7}n�{FE��*�E��k�[W~��u=9_M��mY�P�Ƈrָ|^�~.w�wB��[�־Vj��o�{��ẘ;�t�z����߯ ���2]�\/qDw)�l�G�v��筸�k�J���a�A��s��[��c������~��?������������[�����������_��w�/���/��?{����������oo���/�<��O��?~���������O�?����?����_�_��_���������o?���_�����o?���_�����33/��[�缒O��m4���*dK&o�Y:'�:'����9)��R�=�4��窛��������8������O�?���I�zL��.M^:�s�$��x˸T�{y;[���{���D�(��Yj�dԼ�i�_V�9�Q³��Ǉ���"��}��Rxe�	��f�(n>��w���?����L��/U��z!�_5���-E�.l�	�ҿ܋��7��{"��ߝ�w҄5�@�8�)ѠM�@~�h�*]��V��D���w�-D�g��p��/|	�N�g�d�j�FV���e�2Q��̧��NҜ��F�"��LO��"{��|.�:�V@Ɍ/��xS\�ʑp�5v����MN��{i �U�o�o_w��R�4���}m���Hi�<]��m�"{ֻ�Ϲ}�#�9}q�/M�Ѯd�Q5%MD�Q�v�c���(Ʈ$�Q7��#�D��S��c�4�37��	-n"�?y�|1�	���<�W��	�#�_]�4M~[�*v�ۿ~�yBߋ��3BܛJt��D��.�,D�"���X�|�t�׳|�N���[�y��tЫ���K��P?q�~~tG��6?�3�lA�+Է�f1�Ι<���/����� p��#�Z������] r��V��䴜{�F�B*Z�P5��� 3P���C���_�� UC,����@�5Č�RA��Idkjh�a�9�Y���l����0��c-���Q�o�)�V=��	�i��z{��E毲	�W��r�������E~Sno���z�,�f(-���G����2�a�=�K�����Ž	fa�&��j>Ҝ�9��7xZ��J,�.P5�u��+���ޮ��U�.݈@=��U���������~��mnzE����$�ݓ�gr�ފ$ҁObo��#"�������I�[��f"�����y�=�����O�"I��̻��į�8XJzq�%�鰿�k�W�"�fZ\ajr�\��D�"Ǽ�ܞ�նS;�X�qb�()�+����3G�G;��{�v�����M��Q�`)DM �C��a����٣�vG��o��Qg{F�gi&�߮e?e��I64��*�&��(i�-���Kn���x$����W1�Hg�ww�Y�݉�t�/RQb7��}������]+.%�";��%]�S��8p׾H!��c/�D��c�"���&�ôΊU��u�r�\T�b�G�&	t��t^���R���T���ܗ�,�K�J��HC|9���X��G�l�-��5at�b�KW2FI#B�
"rb�_�}��8(eoq\������Csb�`ߊ|#i�Z�[�Q�ʋ|��t���0��xn����k��U�}k�f]�я�V;Ie;欴�$�Ѹ�2��7e!^0�z�u�ˡB�
ڱʧ�Q�
Ս�2����O�'\*�K��Z���"��� ���s(�8_�����Pp�g�J���6�L�u�Q��IГ��`"qq������>$\WEb�>s�3��[��Mkh(b�F}Hp+��6��+Q�,�xWd�L|���0��̐а��/B��9���H��}D����㶜i|���?�fQu�\��as�M;Z@7T��w/A�/�}�?����/#��]�~p|^
#�դ�k���m�H�ʓ�WL�./����Xe���[�����V�[�i�\/=���k�c��B��E�����.�y�y(q.ZTJ{��\�&�.ci�}�>ǈ:��JxO�|�������OH&��֖|��VE��s<��>��M�ѐV����V���-n
lO�ځj!��Ik��&'��V
T ���
�4�h٬ܮO������<ϡ��b�Ydyj�҉}�)h��Il�vҀ�4�h�;�ܥ���6�H'�>	N�Ɖ5�D[����`:ۤ�)HUzy�-�4�"d����[p��Wu��á�?$]�=Ů�F��<�4�'nn��l.;�r�nJ�yZ�H����_��S��_-�h����$E:o(����X\%|mfB�dW�p/7���MEIt�)��Ρ�~��_ .���Gry���cy��CK^��y��MV����n^?�"����f��:b��G4֠Kq-t�g�J|ݨt0}��N�2ؓb��zaz//ަ\h���^c'*	T��䖐�O��BF>�F�K@�H��o>'r�PW�[���K�\������R����)wr��kI\J ���e:����[����Kv+*�So��w�1S�v��7�!a	�L�:J5�t����B�[p�5�&5Ѩ�|���k����s^%����qx��}�=��_ӘX���?�^�K�����~�$��s�J	�a���m56��un0?B���I�f*3<�5񖯟7�����t�����<��^\��(�不y^�b���0�HFD��N��~�����S��_��9ϼc��� :xo�\��=�	���E���ٍ�Cw��e:�?z��]z� 	�lcW���t����햛�� + �Ì�����WUIP���\8����#�n_��ԥ��+�/�]�Q��t-�b)�v=1�i�6�<+�[���wb�j�����9����u��Tt�2x����q�>~z(���zu�;!*�9�+���V��������.b�M#w�����y '�B��He`$�z���R�s�i���M�s^�5�_�xVm<+.x�q
@�®Xn�\�>�/2r��@8��Nw�*A�˟E���_��An%���B�C��*�7-��l�(��wW�1�]�כ�Y�ȍK=�p��$5��[�9��ȗP?`D|�&���4ǠN,J��so�����z�=*��g���l=��֤�ܿ�n��P_�y?�U���4�����K����Ƿ�/�`�\�W9�顼������n��z��no_ ��Ȣ+6�a���;�Y�c%�������[g�m�ÌCl��f�B     �=��4ؐW�����$"v��@�祑\���?�*�3�����N�^�7�,|g���������ׂ���+���<r�#�#v����*��X��-�����Z�U�g&*B�*���\�\�N�FZ�~^���P?}��Ҝt��9�/�i�:+-(LT7�!ɀ����c�}���<Ţ��N%���<���;=���@T�D�׿��ɪb>û���&[�/�;��{��c�`�����5�-IQgigE'2D4&&+.*cE%iPI�Tz�S��ن��}�=�-����q�ݢ�N�ek�f1
��-�,d6Q���t�H�9�T�O�57����|-T!��4Qt�(�Ǚ�W2��� ��,���78�lG����ho�˵�q�qg��|,:F%�f����|xL�<]��Qs��z��QTo�`���+��̟��f��9�(C�"El��7A4��譒A�e^"�y�>:��˴�>�Ac���>�B���8�����
�ؒ�/�}�9ZT&yY`Kݱ��C9�RĪ�� %���͗w{Up��\�?,��'=#�	��0CLLq[$�-6&׍���Ün0�J�o��n��������1F5c9�f�W�c�a?f�P�ԓW��CL5#��8�J)J���6�?Zde�xW�����ǿ��?������������_?��׿��W˾�&��DU(S�8���E�uI�K�PC��lI��a}r�W�s��*G�N�H3��ѹIbC$�"�,� �<i�6��lf�'t�r�dةY��f�D;I=�����uEz������,NTm�AԷ��64��D,h�峘�Nq�2�W�޶�TB�@[�Pa�bC��#I%NqP��>e����K����u��E��l�RB�[�s�T nE�qr�{*1K�(a�q0�B柸)h�A	Ȁ��-����D�'�a Nj���T���P��f �Ԝ�ė�Nq*�d+A���2I�tSr�4#A/W�[�Ebi	J��noQ0��e���]s.YQ�r/�<�=I�guڷ0�^�b�dԃ��/	�T`i,M=*�2�8��K�&V��j Sw���%?09Y{~� ���@f�9J=����pd'S��)��6�Р�ʠ����C?���&MCm�՛�AĬk�,�	G,��84Y�é��[��s:����Tr�����!�\�L�Ai��8CU�n	���Z���b�5�5K��h?n��N�3(Me�V�9�Nq�MYe�V��.�(����R�
j�F踆�;��B(��o9��[�[Gz������@�K�����:��UX�
!��J���F;����^#��F�������R
�'�<���컡��?rw�5L�Z7u'���K�λz�%q��&A-�pO7~��[K$�U�ftZu��w� �Z$�e(��y��pW�9!��qx�E����OخmЎ��{��k����q�[�^�,ܕ�Ɖ�V���
w��o��kم��<�J/�E��ts}1sf^NPCf%5�2}��=_'�v[�j�O1�c�4�)ί��P��H��m~��D]��	�EA�qT�+���ЄN��ja�E���19r��ۥ��/�*p�WtR�M��u�2A��!z,�̒����o_�p5j�B�ԨP�5��Z�
�.��k-�аv���O��3v��E_����͂ǵ �*Y^y��2�Z0u�I�ݯDr��Ͽ��kq��KUܾ~~��;ߛQ9��y.Ҩ�߾���|�3��܇Ω��[�T͇\�w��*{����~��6kF��e�}�O7���˥�:��j7�i6o��� x��f�-��G��3D�F u�_?l<�+w�r!�'C�(��'":b�z3��K��Ҋ�7�`Z�\�|�|Wd��[\E�6s<�m֞�=���k��v0�Э��	���0���+����+�rY�E�ETs�p��,d�@�����L�y�d0qMƝ�l�ɀ-��R8mz�����!Y�O�_������"i	�1�B���	�^]1�����wH����P)���P?C\(���%�k���4P
��XH@����9`}�@�*+�3�Kb%+R,֮����<����c��]�{p�C6w�a+O�:�`���t}�3�6�V�;�6�ʕ����VKV���M����rՈ��$!��ǲ�ȡ�� ��Y;�	C�L�U�'��r��T20!̲$�R�|���O�22*����\����<���8��i�9��#_&A��z^8T	%��K�5���!�y�D��#���J�S+	�\P\�X>���lРfTL�GM���49R��X N���J8r��˟ *��*E�W�G��R2�hre�Mh�	,*�r��m�vR��kM��E	L�� ���6W�Ԇl�bL:�JN�����p�rC�DL����c�S��I�؁�ǂ�V����jEb�����]�p����d�5���?S�f�ڋS[q�Y�D#��Pޏ� ���P8`*��
px�A�MSI���w��'LF�/�p��`�N��$2FA}E���t{/�����<��q�g��%��gwj7
j=���=<9��X%.)��h�Ԗש�m�iLViL�z���Q=�N�C}�1�v*��jx����4�+���Es9�Q\b�]4`�<�*�¢"Ժ��'�_HF����20Z0`&h��(B��h��G?)��<�6.1r�W����a5Q����np��ՂM��:+�ּ�-9~sA,tѠ0�4T
4w�"\m#
P-?�\������f<�0?"�РV#L�'��p2�=����fT[�GX�����%�	�E �ARs Ψ�G�ΈH�֥ס�Cx�� �5�w4LZWc[�j���݊	�=�JLƠ����ˑ>�z��9=��t�qcb��q�����ӹ�xP���t��G�hDd�u0e��(�T� (攌a�O8E�����
��'B2 ��=�#��"��"�;�N���� ӠU��r~iNyB۾�
h����y�n�G��6���pA"p[>r�|�D�����d�~�r�s.(8<۸��Q9��#LT�Sr:���� ���w�F�����A#h`���}N� "�9����+� [h`F��0r�\;\��q��0i)�����2�#!CK�6�U�R'���9��6,5Z[���^R�p϶�Ζ����cƩ,F��/b2-T0/Zk��z4S?����8S5�Ы�:8`.���5���QH�A��������N]�2��^oÀ�0j4�����~�"[f��̋Q���Jѱ�|���~�i�YֻO�Rܭ��QRU�-��=�T�a���P�jbD�7Q�1n'~�T�����c7PX`'v���^Xķ/�����닪i�����0'A��}s�B6۬��Q����R�)���(52�]CЂ-�M>B�������-� �"�P��1��h��[yp�k*^J|2o���RWL+��Qa�U4Ec������������������O��H�ŭ��'�H����QT�����S���on��r���=r��(;ҳ��P=X��!i�fԥ���ѮJ�������/7+�7�ﴺ�͵���2�x��	F���̒�Y�c��X�I��s��"2?�z 7ޟ��I��2H������?a����2������z����&�U$E���"D����,D���t����$ց�j&~��������|Y��as�)�0[a�V�a��,lT1���#|�ĭ-�_�j����D?Ɍ�t�JBy�{�z��<0���NB�!���y:N8�u��hN4<��J~se�����Y��vӲ"H+�p�3i?';MiBQ,���B��w�����k�/2/[����Ի�6Y>;�IB��H���k6�7�Ŏcͦ��2	8Z�
K��D�M�7Z����J3�"�}ǡ�v
��� �cG;mc�.�P7�و�lZ���p�c��a3'l����j?	)횼��*haôCKئ%��h�A��ôPCKԦ%rѢ��#r�ז    �Xci�
Z�aZ��E��m�¿�ӂ�:$"ʇ ?�q\�l�
b*tvb�P����Պ�k"����DN�����6�>���Y�G4�!;�oN���[z��M�d��P�~ff/�ً��E>����V=H!E~ؤ*0E��(��z���|Z��0B�v���+z��+�:z�̆��D�ީ���O���j>�pi��z�35%0�I�h0��"�ѐ��V�e��f�;}��ǟ!�Mb��%h�y h�i��.�9�h���Q$��m6u�f���-(n�y��f	�ʆw'f�����s�	w �{�zJQ�7��8��Y�GZ��id�ӊO�or��,D L#�hlxAM#!� t�,g�TGwf�4�=U�c���.D�$R����$O��:��Db?Fͽ#W�1.��X����Y�TN��
{D�0Q�t��;(8"��C;Tf�>w6�̾�H�l5R_�_���^�F߄3P��g3@`����k�'��ό]���Ł����VΈ��J�?3�3r�����&�O��J;OI��@�Ϸٳܜ�nʬ��N�Q3�0��7�iHE >���3U�p�@`2�������qd����E�%�GV&vL�2H�	�;�,p��ƱC��\�M��� �T�;�$:�М��M�&Q�Xf�)0�Ak��܍�~�Ϋv͞��0����嶘LD�!�V��X=Ʊ�PÌ�XX�w�C.#}T3TGyz�! ����\W���Czw��?`��l�җ�S���{��68H����`f��y���3k��A@�=�e��B���{Y}An]�RX{�USL�i",͛�4P�)�ؔ���-�t�\�GZ�&������nʿT(�u',i�z��箋,U?!��Rn=V�8�関
2���cG���v'5o4j�!-kD0Q��ٰEl��i�At���~l�o����
?���K ��9;P�L%�?�4�����BTPx�,�&�_���AD:�d��q�U�Z��9˵�Yr"O���U	����/���dQ��#�y�#�|
G���φƖep��6�PM~���	����N�7��<f�?n}�7Ꮬ�9G�H�lF�+��B�+#�>�^6�;��"�?cTo�W�_�d[�B(����/�����S!v%V뙨ez/�y����Oo��VjpǬ�%N�eA�fЀ>�n���5?�T�c!����-j���9ژ�Pb�����Y�G�sP�4۠�5<!P��]@��X��1}�qԖ�!��NRjy�,�d�"�0M��	���zb���aB|���n��!R�]|+Ld�ssZ(q�g�ʁ�U���⏓��H���H\~j�[��R%��I����5�WKܕ�R��JY�>ɯް��|�M��.G��th\Yl�E6��\}ʣn��lT�F���Ѹ��j�ӟ�'C���>�M+�0E�:����D�bc/��Ē$Ѧ���r��?u4d8��Jde�T�
�cj�XMM�Z�Ic�U؋�f�_8e�e�%���7��6����	�+y���50۟F���j��t	�U���%������6��P�2�WA5l7��[3F�rxK�|�\�~��~'=EVS��M���
pd7���{��& ���h)9�������noQ,��+�N�u�6Wȯ�#] 
cI�x�I�I��6G��#wd::���q#�ܝX���*�{Xy�>�'�V�M�b$m�S�츭_|�z�y����5D�O���*���b��8���Rv'?�)FGX^dl��m�<l
��1@N��V����QDaGJ��e���"Qn<{y�?�iG1��]��eu����>���Q���W��Hj#$*1D�F�o�����A[ȑ����%~�Z~�����5��~�K�@���Rl����v�an�	>5ѧ4�&	��|)n���FD��1l'��ֿ�� ($��#�=h�4_� ���޼R8��`�Os�O(	d�'�b�<c#�7K������� ;=��.���!������N�o'Ba���|1r�؁8vl�ӡ�����b�����b���X5�5�_��Q�x ��P҂�l���j��F�$�y�m���K�1f﮽ӂ3�%r�ܸ��L]N�0��T]��_������0�{sG	���h�[���������}V�}(��)�P\�n(�Z#������.W���'�?�&���6����@��#J�W�>����S�d2RǑ����&�/���f��w��٤��0��;�E��DVd��P�;��>��4VW|S��=��<w_�}�GG�8:���h��.�������&4�vv����k��"_������0h\�f��,<Vy��C��WO{:m�Z�����05;
�S�S5ș}���mtw�M�M�5�Qb�b'��,���]�N�:S�%���Č��
G:1�Yx�3zl��Ru�Sl�4���0��K���cf�%�T�Q��u��˽��֫7W����w�z�eH�׉��	Uh͓j�'�y{���N'�N�����Gz���ȏsod���JƄ�i<���.����	�O��ãz�%u��ídK�I�_�O�-+>m$ND��nF�ħ�yql�9iU~<J�<6�2䖭̳�m�v^��2�����������>��h��]��#83w��3
B?jn���b��B5+�m����N��D���_I��#_+0,������j��ט�yn"��&2y���̹� �3��J[�Y�������>x1����~�	�i�˙mim(���C�F�%�q�I7�sU��]� {���1���S#l>�P�8��m_��ܑ�i�y�+�����G�+�S��.]z&�T��q�Db�I1}�4h_DT������
�	�h~s�N�q�9�0	ҵ�A���@�T����ڗ�t��5؎�e����/që��a^�$�W6���}��}ƙh����'3+����91���$Nbp6��ԙ��O޻,7�$m�k��UVGH�@� �X�	)����e[OϢ��z��Z��g�y�ɬ����G �HJ�L��]��������I�K��wL�6{ǹ��8##��C=}����/��Od�ɶW�N1��Y#��_�O̐�V���+�.MR��1�('�2A{�i&L�ۃ�yl�Jf�{W�1ҬYx��1�*ʾY��9E=00<Y5}�:�+o銯�]�:پ#$��(��O�K�ه��!�����n���v�����v��['f,�W�>V�Q���!X_c��KSo�@� g����JK��ݡ�N�a���AZ�Hi:A�@d�������A���/%�I�(��o"�,�����Ō��?����IZ8i�c��6�o/.B�z��;Ѽۜ���K���<΋��c]���4�j�,w�dS͟���!"P�J7Y�TH�P�ޟ��.�s�Cl"���E8��+r>Rޅd�dFR�|
��E�7��%Y�>�Æʴ�~�kS�FOǦ��BeNbF1Hƃ��g�J%�;�@*�8� 5��r�4��](�|9F����z�W���ǿ�V�����AsH�ܘ*��;SB�����KAs��r$4�e�Q����En�BC[D��C�ɇ��u-B��߬_?{c�e�/=\IO�fl\�����3��]�0�	JR��w�%X�89��/�,�_S�^p�q�bi�[��CV��0W���q�È�\yKA!��(�	�o(����	����N�����}i��]X؜���P5G��'r�ȱ$A�扰�����*"����=�z�\2��u�r��#�(K���/;�I���'Ee`&R�K�R�֘"wl�}~!��EXJ��~;�t�P��O��X�H*z#ɾ;���)&� �AE�GQa��H���C�YJ�����B�4ffƴ#9טQ�יb&$,A�哈K�r_Rį���Ei"�� �S�Fͼs���(0e*͖>=3y��B�_�	��T|�ڼ!i�    ��I��8�4gX[&����D}8L��CE����T�SA��u��b��.2�N���`ج݌�fe)�ĭЈ��~;W����r�mگ¦eG�ۃ��2j��HV���]ư��4O�"��f.�9}��cnF�eP�.u�Tй�G(W'Τ��m�~�'�(˰e�퟈
'��,x���cNZd](�ig/0���<E+���[j���9!%��d,Gn�Y�.>�����#'�s���ۋS�p���χt�C�2SZ�xPf���(����i��Ġ��@b��5s����ҧ�juQڐ�������)���t4��I;Q��W_�2�߇��t�%v8�"3�Ӣ���:���B����(K
�O��S��^��C��=&{�C��=�_��_�r�B'����	Fe�Z6�o��X���ȷ��]�@:�#0�qt�r:��-ԧcS����q"���f�V��#9�cl��ֲ��V��;Ūo�OR"���J`�������2.�e�[\� �-�j	�)�D��㟮ҝ��{�dᾚ���ǧF6�^�,��ߪox����j[�I��(l����K��2�6�_ٵ�B&-����zKr��D_�Q�d������خ ����V-0���wؒ�|����B�ɗ両�~��/,�]��М�]��D_2]�t�.�,6~"�/v�&�����̟��jzx|��W���$(.�g������$�|O],�l���U ��X1���q��Q]��v��'�2�3��B�d���f�l�tW2X5�Ֆ����K\�=x���.$ky�����y�7�����d�G�݉K������� ��O��.�Oz����g�{��  M�0%�:�aa���{NjK<���0RD�z�_KѲ�6�
+���4c�
��/�^[z���I�� ��~A,�qS�'* v��OJ;B�Pa�;�����Kz�&�`��	Az�U����˅׈2NIi)�1b��+y���C0<@|�p��pi��4j)�̒��L1A�~����gZ9������8���0j�Yx���^D��A�ݠ���<�bc�����H�W}lD�!�+��c&u_�1�X�I]t����ldZg��\�C��?=�u���^ 6v߆d�UD�*ٜU�}.�>Ű%ԋk��8�g�b*�Я)BXK�
j�k Wk�}d�c���|\�I�4jbޱ����	WBr�^>Ci������t!J"�.��H��z�����y�I��r�4GL�WY�
�	A&;��9?�C��pip��՛��&2$��:���2/�~���^M�e�F���yS��&2�ԏp�'C�n�?�ݹ��Ҡ�I���>V����sƣK��;$� ���r���@�G!6�j�ʰ�����D�!�1�[�0t���I���E>QO��G���3���[��?�������:��/�[�PoWI��6�����+8����W��#�#�Y��-���c��?t�=����˅��e����k&K����>���$��;�	Q�}=d��F�	E����~t��ҭz��=�9�Y[�b$yl�6��@_�]�Bf����yA�k����z��ev,tB��\�$_tq�^�i���CbS���a~c�Ɉ(-��ё$�,I��w�a�x��}=�;D�K>�9�����1���u�f'��d?�o��z��㤞E�Nj,��˔$�gQa�6��k"+�V�j%˥�,��;0<�i�/�4��x�[�+�XC�yݼ�.������wo�G��է����S�Q.�G.��g�*0>�:�qؙG���$ٹ�k���,��tb`�C&I�i�0��eg>z�Ԋ����Xd��|���_������-Ia�1lf�ß0i�2K��ϼUM��̏�;y��%��~�U�� �+a`�3B����翿�k.���tc�[�G��׏��)9<�����E$Cc�,K��?(���&@OZ���c����������6��z+�nv�z-�o��ʉ�|��C-�)������,A�5���4�"%�ԅ�o]d�@	'EÊ�V}w_mK$e�����w��n�~K�C�ARS�����
�e��E��׏UmEC���DI2�_�$���$��F��x��Ᏹ�H� YkA����q�)�YVfUr������+=g@�T��ᩳ��TU��5)_C�X�q���Je��\�V��~`�c�����Y�5%_�.+�
�,)�Z@2�iyGŷ R�~ʧ�O5�/K
�/.��+7�"�kߖ~�倳`��F	����Nd��WL:�C���+A�G��"Rq�����`]Љ����t����D('#��;Ѐm��U�/=�o ��Cǔ���a�̍�	��)�{�#��߁��	��"0���U��e��!1�rj��B��1	��Î{b �'�`���dC,�� L̗k�ϗ։t,�Q�Ij���X1�_
��$���1�����]��VD�yG��`L�7���*��xd(�+s�Y�Th�q�r	�V�h�3���:3��"!0��K�d�j.$U|M���&9{�B��Xm�?�}h4�������!7j��9�g�彲���i�7��MfDL�B�% �$����+��<#�T��?6u�N�wM�۴�v�d�|h�����{2��w�R�4�ء�f�XhD�,֫��:t����E;�"��5�̹Ȇf4L�:	����U����K�X޳A�.Ǵ�ALE��8�
!��B�u
v-H�쒐�@��Ū�F�|є���T��Wz%ѓ��x��ꠣ1����S�8�՞�T8��;*���7R�@Ⲫ	{�.�>�j�i�����d9!8*u8���V�v6[�`c�kΒzu��"�Z��8z�'*�\�>M�z�h�e���	O���Ü��!�v�����$O��n �T~�C��F�꾠�SH�豢+Ii^D����rA��81�J��]�9��<�p���	����e�b��.S�=�</`�r�!f���Ox�6`|�f"=#� ��~I�<z!�6D1�!3�&�fv��d��鲗]M����W�ZE�uB6������O���7��Q�Q|��9�D-j���⛃�۷��d4���5��5�0up��U��]����:�2�Ъ��g��翪UR����)fUR���tK�|��=-��9�4��e����w��w;w:S�C���>ή:�8W�3�U���dk}����A	f9}�QZ�~N�n��Ӓ�a>��X��׏�E�xT{E�$G������c�,��Z��~8[#�4e��-=�/�nó}���/D�ʃL�@��c��������.m֛�d,\�0:]��M��_5:Q448�IO�+�@��W!�N��Ao���W�~l�.���뇄�t� !��<�o8���Mv�5i6D#�����*Vc+�TA��*��"����_��b6��4��+&�э=ՊD#备t��J��Ě_���D�4bd���)�� ���#���X׊����ʴk7!����\�.Z�C5Q��#Gu#��3
�yim��u��I��Cf���l�q?3����E���_M�ת-�B��N������:ZTh����FUm��F�	�Wą��?m�ů�A,sa!#YP9�${�-x`~+]�-�W�'�g��n�Ȫ������TI��vM�����[���A��Ͽĺ��IX��`�"��)|��a��l��C]��$x,���;�R����Ϩ�,��OJ�}�� �Cc���6�������6�����>�.+�8����N"�B'����9�c�H��˰f��h�
b����k�e��eX��Ql�`����F���Q&n��3Kek�5H�z�Q�u���Q��m�񰞽%4!83,qF��t�>��IJ���2��BxiIK��״��aݸ�J�Q�M-9[��l#������_�Vp-)��V7��(��2���8�`N��h))�    ��v���x��FD���6Ju2ŘPh�e#�^ke#�xQ�D�/�Q�2l��32MHΘ2SԆ���Xa~r���%�[qN1K����(�E>C"s��t+Ђ��0N�kL�5��匹�&蓼�U���g��������=�j�KN�f�*�\]C�&��x
y�0d<
ܩW?Z~������^@��)d�5�ECp<�N��ES�Z�_�	i`dl|���$�P�T�Z�b����5��,_A:���S�2�8"c��nr�����h�-Ű��N�݀:eU�x��������y�&��UH��]��71�K<��
�Lفya��c������P����zei�@+7����u5�O�5�?��Ƃ�X�E�1WDE*W:8��h��S�)B̙�p��%��ɛ��`T���[ɘ��f.w
��{h�iwܖZl����q�Ȝ|^8ᗂc�Myo��6U�̑ 3��I�P?!Z�Y��E���`�KZ���h�EK[�����X��E�C`5�O��bs�w[���'c���h���16M���%:�e�&�Q�w�2�0�Jq����5����=��F��;�������%h2�	�mt���cv{��5�}0+фqiA�Ξc��=!�~I�$�нͮO��'�q,!cս���ޓ���Ѝ�T��e���Y,c/�f��,G���)�腎���ښ2,��L�f�n&Y���Cp4{jip|q��t�6o�j?m��	�;��bĄY���N>�	�6��b��p�vPi �ɪ�nt�J-�Hhn�r'>���4"&,a�~��
sS��l]r���T�M3�OKۙF�	Y�.�	�R��L��ς� �K�A��+4���iB3%C������ЬeǣG�� A��6���y/j�>�'K���(��]\�����(������l=f.�6�����	���Fؙ�Z��r�S'�]j�%�x���7����+���;��)�1)рD�bjm)�X�$d"sm0��ٍ�u
�I�.�.��uD��D������`R,l�b�ܢ�:�h���n��pZÈ98Yg��ZOs�.������{ʎ<�A����YP�|?��'Vc��1ϣO�YC���b���bA��3�\撍ۿS�O�~�7a��9�5GU�T�CNe]4}j�׏�X� �R���B�~�ݴZ�Oa��k����ʘL�o��V� a��k �e��y����'�X2����ޖPa `G�:O�� k�ܼ�g3���t���=�c�����A3�ۨ���A��?�v͝6ѧ���E�mU�o=�Q��˴ �ã���&S�A.��ָ����(c��^��Q��'��Ya	����1*��Sfԫ� �u׸��w"�/(���Y
�����v[NT
S|���z�s�[�����ܫ�h�@��3X#�X��up紛p�%�f�y���Ϡ�6�\˯�/E^�'"���:MU�R�����\8����/�B$������C��0= >�)a=rr5z&�Qc���m9P������Sʍ����~P�����ϔ]�1�Ft�N�!G�8�M�DN����#'�e�T��#�c���$.c�c�a̍.���Ϭ�i�L��<%���͵��4G(=ɦ�~��9�2="K%%�
�d3�F�M&��>��Q8vtV�A��50��nˠ���)�t���Ӥ��	rMh���$�1�ms�(�0�Kp�Сpl�&*���C:�!�[,�X�.�=�m9��S/,3t3�oh��O�R}���5b��1xg��3n�YG��Ē�K��\��:����N�i�2�+1S�a`��Nb��1�:�L��9f�z�T+�
.
6$�Ҳ3i�rDՌbΙ�g;�����3��]3N�1�h
ďzs���B	c#:\,Y�q���5]v�������9�<���j'NP����+s���_���s���Nx��1�8'��ď�����_Q��pG��Aq�Z#V|�l�G��f�X�� �Ͻ�B'Of������3>�6��9���>b[��/�m=ϊ���-V<��W�P	D���,��;G��8|��:4�c����ۘ�s=J��Ua�A��_�1C��	��>>l`�ß�1/�rrfp~֞��t�i�Ƃ��D���g�ml�9' lN`�z�����ռ�O�)�>J?*P��Ԭ#4-R�
VF?$�{�c�y�\|ha�FD�Ғe�$�H���[:!nLc�foج�j
" ���^䗚'm���C����=f`_��m/��Yl'��$ަ�L���A�2<��=ac$z&�t�i��+>5n�Ot�KA�~\�-���W�ߦY�%�Kc�~����Dx4'���i��*>z�0��;���#�B��� ���$'Y�4�m'=�
G��}�Ql�DΣUL��;��3y�r�[�_Ᵽ����0���ڃ,H�)S02i����,S"�qj��� �����0�~�я�fJ�3��T�̚�`DSq�7���BSF����K�S�+�k��nn�w�"��LӀ֕��U��!�>I@���)�S������&2M�WvR�T���3�2�@f�d����!1ۃ�6)M�fK7�a�h�ɶ؞��3,��}��K�4Ki
�&
�&���)�>tm��ϗ�NLk��a \6�K	a0\<�'�����3>yc�6���twUT���G�ۋ���#��I����*c}Dϼ�4�E���<�1�U���@�����bp�1������X�qU�W����9��Z}�Q��T)��+�|�)��Hd��J@����׏\��V��"�*����bV#^3�0�z/d:9�B������W\ �YJ��F5S��O��u�	�����,�	.^1@����?e��9X-�Jt	�@ӄp�_Q�SȌ��z��'��4�F]`��`��4m�,U����	�����K������1�)`R�&�b�`,|��[�C�8:�n�`�W;_��ɾ:�B���<y���D�(��~<�K
�2��~/4�~]�_?V�v���bH�8�?��-�m4�2+H�z6� 4�)�d�釘�Q�=����6����ּ������w��؀2�|��(?B��Kb����g���<4%�9{����V���翅ͳ�6��Z}W ��CU��; ]�!U1h]���I�e���x��0�ˬ�0RaOfH�w��p�&l���F8����aZt{�cS�
��ja?��z��$s{-�>�p�,�FJ�4{��g��&�y����e��K1}o?�����[�Cx沧���|���%�����y��
h�!X�����*�f�s�~)D�""�BȀ�N<5-���>5"�^��u�?����*�DUt?�(Bj2_.Q9.��<U.�i:&��F�b�G�PݛC"����#�~�q<M�LXdR�~24���-�5Јxr-w/c�B���}�A���I�<�2)0!��T;� .Fc�VD�����5g�N�p��<(O��vÉ�l��R��Wj�;Ya��2���Rj<�kt�H1w{������W�Դ9dق|�L�f�<U���5����V�!�D+P�6}}�����m���?+���ꞬBԞ��o\�)Jy�c���S�$�(�q-I��Y�"�4'r	T�G��>�W�L؜E&�$j�í�+�H?�yg�
��~�jXaW��k�γ�Q���G��NhJ����[�ZN�����#�G�u���cЧ���ZT�tJs� ���,)�@���҉TL�+��<�C|h��h��X�
��gKԇΠ1?�k�ڈ�ZP9fFHk����84ᗂc�&�;�����:�S�"h�Jc��qE)�č�_�����AkE��\ˡ��
�m/d�~ἜT��}�ί|l~�<FkIa�H%���Wƒ�L���e���h%z���W�n���D�R�	�`--�0"٫x�"B�qO�g' RA�!v0Q�C������&p�E�� D_0�#����I`�L��42��!��A    !`��h�Wfk�����N}�B���x"�y���S�v�r{���f)�DrqY��h	Ŗ����� r�L�(gY�)c���F�~�t$#�eNt��T�M�IT��b�XFhI~��r���4��$�.�^�z��]��ϛ�u��Ǧ�.����z�%��o�+�� O���;9uZ�:�Z�^��Ň� �D�1ؖ��2@
�����8��~x��}-�#	���{��yr���z�Xn�2�R^喓��
�xy����mb6A��� ��\��}/��XL'�GJ����~X>>�\�X�-K��S�myH����Ǳj �6'�^���~px�yi��La))!J�u��_#�bX�v��D�o�Oًd#�0��T���!M�J��6�O�GP��;��@��(kf /����vt��{�S~'��(jb�	]!>��p��i���a7�����\d2��}[�o�䄺��?{���I������ �@����s���Ā������"�C���`!�^��F/�:� zn��ç�'������_�����g�'�(����E4O�Y��(�i����b�d^}���#D�srpKO��C�P��y{�2_�����(�G@n��v@b����I�ny��	<� n2��l:Ct_��ykcv/��o�R�k�`f@hO���M��?i]���h�<�U�vM�YWod��aք$�9��]�l)Af��l�t�P�⁩9�M�����$���w������o%I)�1\�V��S�����nqk;2?���$�N�1o(�)sS:�RZ�?v���59qQ3v/Iu��2a�HhB�l�!�u^�>{%��N,|;���k=�[�Hv��4���s�=H�a��q�P:��BXD�H=]SP�T�E)��I��Pj��]d��?����D�J'�[0^.���AD�u>��S��6���X�ν�+�J��|�N�4�B�[`�{�9����L��n�=���=a	\@���_W>"�Λ#��ϛ*�/����<m����B ��0O�m_:�8I��m�sc�ՙ����X�~��/lQ���x�����-O����I2*�)�5��Ǣ�oy�RE}�t��s�&�D��D΢��9j��	���}b�F��Č�Ԣj4�--�O���G�2�6�8QG:'��W�q��%�С~x��崅��b����`�u�^|�ӞW���9k�{y����Cu�"�Ҵ�Iy7oq��U!��퀷y�S�Md΀ǫF��;��;�w�;9;5��b�S7�;�a/�0�~�L���b�GI�ڒ^PHX�o����^<��0 ��!%Ek$Ҟ��B�!�e�`\w��`mS��i��)�����p1��y_�V �a'T�GS.��[�'tB0��[;��9�"��8�$�XQ�syO�1v���#�n�d0��e����	���1��G~)��W��;��JP�?�pV�w��k���OVG@�#��{�����&����`��f�����_��y&�ߧ��'�Ӌb�6���:!>	3�M@��3͛9+��<�~�������Z��̔Kr&w6ቫ7��=4�	��[�&]i*c���f_����Q�U�'ؾM?����*�9�Ԩ�Q��n���o�F�����W=�Ԉ�F�,�d$��� ��$�&	�%��W1�>��Yƾn/����J,VLzX�;LX��D)�����	����oQ�]Җ�`�Qz$@5s�DS�KfIp]jE�L�� �x�b���9M�4�?f:D-ђ[ho �p�=^�.L�<��Bɺ�&8Z|�ҢenY`}r�\�X�ۃ�b)uw��y@p��R�r��²�{J�w�X�P�qFJ����<
���gdA[~G1i��{h�M�J̢���&Dۈ%ݙ�	&5��h<�J~։�،wb����<���;G7@-`��R�������E�y��}@�J=�T -�VX��خk
%�P��T�T7�:#�}AfJ���Q��N�yC�Z�V�9���E�<`Cu��6���m����n�:6�ߐIE���W�k��s�yKxY8��YH`�\4���b��c�8h�/���x�t,&Ju_�����j�Q��.�o�0�g�����ݍ�u��/'=���T�:�>�^��G&2�T�NL�L��΂,�@ޕBEu;�V��q�b,�ұ��&xhj�:ؾ_��=:&�1C����Yo����MxF�8Y�z1��]z��}�8Pk__O�\ ͣP�tu��rmU����M/����1 ȚY�WcT��x�7FT�f����Z�~Y��3ћ"kg����,z�˸�ڵ��9�Jʾ_���C�u��"ko�>֜%����U�yu��1Gh���
���z�92�E�pkz���J�,���cp�C�Z�녩���H�՞Ty�*2��O��A
�&�oUF�4���Fu=J��d�>�5�I(O}���^rG�-����2m]�+�--Zr�cA}�]�{��j�L���*�վ��%�Υ�!�^��Ob�����I��'nG^ `��
�liP���lL��@�Wo�}�}+�[�f.wTvW$��c{�£ӭ2�����p�n.7���pu�	�l��tֿ���}
^��N���Ww'ß���	H��)zNb3� #������3�"գ���>1���E狣λ�i���q���;W1�Z�(s��t��=5�:ϟG�F+T�*PX��5�>q��=�	��2O8���x��7��P��G���)�-b�]�<�,���W��-��[�xy��c�W,>����ᗂl�C�!VL��-i~�������q�����K1��u�*,�T�(��	����/'7���y���R�z[����`�<W��1��foEwyi1uUZ[)���F��:�ʔ���T�}����O��~�
oѠ>a�����	!�>�C�-���7�>�C{w�5Jr� WU�>@>�]<�� ��I0�#�h��O�KJ���D@����S������Ϻ�Rc�_;e)�]Гq���)*r^�m{�IQ\q[�H��Ǝ<S�ZJ�KI�S���L�fG���.'ao��2��a�O��ëX	z�'����%1O�yG0���s�z�k��,%�����Q����2�e_gkvr�e
��Qc�5�Ҕ$(��X�����,p�qYPzR� �@�t,�_7斆¥A�F�FxPf^� �"����o*��@c�5��!���l~������)f����C�׏�6��:�������C�Z�����1p4/?z�v@��B!z밇�z��E_�6}����ӣ������C��@ğ�2�x��yT=���.����ȃ�_��"{�h<S F�a���W�*I!�\W���YF��0�&v��V�������uv_�­쾃��T�H���XFh��%dDH�y�粴�f#��������5�Rd_>�����tŠ�0"iQ |��������k��I��C����'+���v���E�� �3w\s�'�;I��X+S���u�ÂS~��8�Ĵ�z��ۃ�Z�̨q_�͓�y}h��y��;LWn��-_�.�%oP1a��<�<�Ӗr�TZ��(Y2�(�T����:M����7���b�n�n��I ��}�9���IP��+Y�njOf�}i���zW��_���r���,� ��N|����$b�k�7��I�\@�$;G<.8#p���܇�B!���^�R?�����B��K�5���;3� DFqW�<d���iF<�FHt�[��6x�`�U���YOn�4M ����pz�	�;��.��q#g�5ܼ ��fA��jK�Bͬ�*��Y���]m��[m�����dGw�t�Q8�F�����Mux��R�,]8��RsP��v�~�f�R"E��c&0þdw� �N3����uI�A�����"�X��a��	����%�$A+�VR�%� �E`�gv�9WEJ!�G�����T�������Ϡ�RYr����i�#�    �Q5i��6WBQ��"�aK���~O�6V0�B�,�%����$�K�@PMq�]b�q�'M�h�^nc�[�i`�'Y�zk����0�i�-m��'�Rd3��=G1 �A�[l�8JQ���"M:ύE�xn"F@����W��a^��},�@�ǆ�uy�?��`Z7��\(Ko9e�|J���q g�LW	���I�:5?͞��a�ے��m	ӑS��˞w(<:S����h�Z�q�<ߧ��Ң�&*�;������L�zcMږ��4l�#W��}#?%t��\�u��$\?md�=�!6걸�E��@�>̈́$�G�[���W�<T���D�٨��ȅA���I�9��,�,��6�I֑��������M ��l�H{�����C?�2���ºUhL�4���y���fY��
y���d��e���*Ҡ�E�o�k"�'��ɗD)p�-u�5yò�qoXi���O*M�ޥ�+V�|8���Ema��A�Fk\P�E6BL���rZ��^��΁�"���vϧR�B +�N�h{��<HN��'��G-@ɋ�'�Qٓ #F�p�3�Ӹ�3|ާV%e���RD�u{ɘ]G���c-��3^R�l~��
;
 M��1}UVg`�$��	�ҹ�u�=�6ȡ����[]���� ���֋n�3�3���]��f-��6øx}M��&�k\|!4y��_��*�K���I<;h��y��B��{��L�,�)�%�fu��J�7��Bړ�eĂ�o��Zqn��f�]&Y�g�*�#��}_b�g~��-�a"NˢG!t�	Aj���L_��J���8�]#̅�Z����?��f_�A�Ja,$����?���p��z�L�����h������׏oo; �x�����A���Y3�f_�����.Ȝ�� ؕ2����ٴ`�(/��_/a�-.x��=���)�ª�Z-7�=>��*����|�S7��M�!�!���Q����E���^�ny��#��]H��߿�g��xL�m��T�if���� .]m��r���)R��Z&Q��2�yg>S�T�y�c&/�?���7�׏_� ��q�^}��Z�V�o���׏{a�Vo��v]5�*Y=7�J��\t�;M�� c̑'[�݋;���E(>u�Ʒ�<|������'պ:l��Ǧި8J�l�.���m�ze�<���V뱇U��nv[�9
�ӓ�l�b�꞉��~�q���w�lZ���k���'&r���?�]:�ձn�4hK��3�`7;����t�-������Ͳ�u��+���Vϳj��{B7��j֕����z72����VQ��gy��}�k*o.��~_5M}xS�����ׇd.��ÿ�)-!H3��S)�=�F"B�B02��]����(d��0ݘB2�#�4F�k���C?������,�܆T�U���.Q�L���?��N����yڤwk�]-�<���tw�B� ʖۗYUk�NU�WR�H�R�Ӭ߅A�P�a!����
�bn��.$��j�{�[�f����"�o���y�$�^�sU�t3��n�v뵘�;C� G���<M��Ώ���R�H��4Ag���gOhʡЌqB`��2�l�\��M� A\$7;䗤լ��D0���S�[VMYhp4�� LxX0�إ��� s�&R�������>�2ݘ�ϡ({���}�͡�8it�X��j�̾���F�Lg���H1�����<�A��5W
(B�bR�heBD�3�:xc�h�v~P{D�y���Ǻ9�b��~�c/#��t��B��N�����RQ,,׺���  ����� G�_��K|�FO�nCÊo��)����8���hv�|�5z�����4�I"�N����0k8��Heo�1��+ҍ�{����:3���\<��'����!��6q��^��L뎕X���A�ξf��
�cr�JJ)}��`�J[�4���:ym;Sz>ܜQ�A�
����:�lM� ��?��H�V�h����g⿝<���#�NI���Y}�a(�b�ד�Է�[dh�a!c����7Ͳ�E�7�%� ?{��I�a9w�y ���~W>�}+V�լ]����� ����#���:±�a�ۗ�Lh��u��&�ݪn��p�p9��/��JUǉ.!XQ ?�_����[��7�0F����\�y�p$���假x��Y����̙|p���/�" t�(*,E�(�R�p��˙w,ԥgw�#]��l��2uQ���UD	Yz�����TLብ�GڋVy�8j�FذK�{ؠ$H�n&��Yʪ�l��n]b1p�yPj�(SR�f̐���జc�	Gy_  9�l�2ݩ�%�D� ��!K���8����>]Ǧq�,8���.5([/�E�W~��~��2bѳ�Ifw0����%�Lʔ�������t'��|�c�9�/�A02�$9
����~�Z�Im6������[�<U��g���8��y��.l�I~��[�_�?���{|*����>��^������E�f�?�����4�ޣ�x"~�]&>�IL��N\`\�:�Q�$؈za�p���ɞ���꿷���p��2z��N��(��fě�R:�7}^��iS�O㴙���Y�Լ���I��"�B˲n���ӌ�[潄D�*��%1[��T@/��1#�ΤkD���riSVc�����]s�H���h`�=|�O�E{J���/<.e�F��$v��\��J�{E�"l�"��Ey~C!Ȁ���j[��c��w'�Ww'o�cY��0����Qp�#y#�G}3�"S�`b�KL]�I94�z�뢅]���p:x7#wl���>?'bl�}�Nu�О�.pq�-�C��3 [���ɛ_�&�\�%@�����	d�1�l~~߬����;h�gO�<��^��.G)0����E"D��?5��!d�?ҭ��vѠ�ྲ"�9@�)D�?��n�^�Q�
�qi�
�-N�3��i����)!���ț��������)����w3�:ӐWs?N���D������ ��}��<:��]��m0s �C�b첓=gō��x$�
LDg��z�0 B��<x��SA��̎ۉ�~�\HH0���f8�����mG�cN�﯅��img���~����7��r��o�j�a��M��eDfA	������tYnh6����� c�촳�~9 ��u?�q��~��.D�~��v����hT ,s�����G׊SU�-�`	g��\0'��d1 ��-���Ul݊��L�)3�*{y��*+�eWn�J�Md;�a��݀3o�N�ZWS�+lt�p��7<Z�zX��塆X!+^`�l��o�ۑ��߱�Q�%�R��2b^�Ǟ <�sj���{7�a&6k-N��s.8SuH�Q�Q���ع��1��ܒ�A�;�k?C�r�����y��V�|��D�2�M��<���;=�~�\ƥ�(9�)�/:���s`���*.��m�~N�5��ԧ]v��_�@��N<��z�DkC���&S�M<�:�}�<s���z�Y�����h(�#�r��[nє�_�it��BD�]d��G6��`�y>(c�
0��q��v���dLi��p*8|�ˣ[����}�C���a��,��u��l�q�Sz�C�r:oqN:�;�?������^*y��>��R��}�W��F�%�燺�FY�L@~����ż�o��cK�]������Ѽ�S��͛�@φ2� �T��!�{3[NR2(E��mpX�fo�Q���	�!��̚iZ�3%{�H|�X��'���� �%��;Ӓ�ð>�����h�����+$bt��y�'�_��<<ve�b��ج�d��N����������7�F�xk��l�=n������rP�ݤj�㳜��х�!�qd�)H0ԥbq�B��@v|�ЫDkw�X���[ h��a���
(8�/w*�5���նYN[CI�u̼������F�,�L���T�ǽ..q�2̩&������h��4�Ve��E    �J�nCVCL�滽��������c�G��S��1hXm�߮��[h�5�����*����E�\��VGHn��������)���T9ń�E5�@��y�oG"��T�x0#&j^zt��0�nb��^Ru����ܺ[n��X�u����"�8?96���U7�B��`�vxKP��o.��0����qK�j���i��mO�X/9��\�W�4�7C%�� +�%1���������J�+�`g�zA=�v��ϊ@)�6ݭ,��ؕ��4��Q0��#0G⹚��ۙ�ry�0Z4MƎj٣)�;�O>���*6��B�� �}�|�i������R�P	(
	f��X��x��Do�ĈYZ��'�IK���jR[��+�%X9���٬��ꈳR 뮪뷯禰_\���C��Ө�+E��ȡ����ݲ-��i5�r���ʸ�\�����`:\��uHƘ��*?R��z*ؼ�P%�\��5,_��`
'�f�Ŋ�?�!�C0`>#�j����N��){��Z'����i��7s4_��]�&{�Z�͠���U�*���*��"�
1��x�-0��P���b"
�yaS0��,!�(vqaS���p���"��qA�n�E ���6N��ͮ-�>����U����e��[��ҹd=H�7-u����	3�+r`Z8�5�h�ˀ�Z>=���=9��dY� �h�C���P�?�}H�TۆF��F��C�M���K�g�k����Bث2��T}[:���o��k�
*l`X5����_Q,"s��&:�2B������J��aM­2�$���r���76B+R�U�ֆk`X�]��f�bi����@qa��)�����,�{���p��wra�mp�EG�4�7�s���C�uaw0֣���:�+6�M��r��\�;��X����i�#�*ƈ*R���[�0���@�h|�*,Sxt��w���d��H�P|���,��훙�LL���6�ve������i����HV��P۝0T}���\۳�D�ɉ�W��~_7_UJx�~��.��M�_�$��=f�~�:�ə#���.]x��0�)�C�(0,��H[�۫u�8jml���Ka%�	{�M���	��n�{��]Pk��1����%l�*��"��q��?���D�_�)m�?=dY%gc*�%͒��Z%��u�;$=U��?�x��e�	�n�,KU;� i�	������O{&��Y��f/ա���������g���D��HR�p���WH�{߲�3�J���v*bm0�T�K�>K���/P8�@�48����C�5�в���4��I�8�<�j��^�F*gYi-u}��Wɕ�K+kH�ߛ���KG��z�;���P�[ʜ.��n���+�]���v,0Y��]B�� ^����e�\�I�T��R���Qe��/���%�͕��-�5'�O�fF��WJu�e<���翪�~S]P���Gd���ao�iA\U�e�?��r��
+]n5Jh�����}:y5��˖LwBJ Sg#�woЭ�R�HA��(��cV��L�߽P�	T���f�d5=�$Q�dM���;a�
����j��p��f�'\�d�������cҗ��|5M�sd�O��	kM��t2qy�;�q��a� î���&@�#og���H�R31��X�3�r���4�����OX(s����EҞ3{�d���~�v��Mz�Dl=��ßߏ�q ܓ��o@�ݞ�h�50�L�w� �ꈚ���W��Pg��7Y-��ϱ� �N �V��r�ݍ�Zf��̺�@?8� ^č����9��֨�=�Bi����^�Eݮ���q��%_��x��Vh�ۭ�����&,,��������_���+���:�Fj���CbÊ�Ik\���U�r�J�B˛5�`���J��L'��a]�����4	c�b#��l�[��a㱮C�yX�љX0���Z ����i� 6�Ò�s��[�\��u}<N�X{[(�c����[����3V&3�$+���!�tե�Һ~��k�\�8�,@�5��w��xn��ϧ�D�eC>Ê��K���~�������'+@���Q.�Ҥ=.=��	
c����b'j����{.�v�s���wv��v���s�kL�b�&԰�FZ���L`��4�� ��+��!a�!��R�sx�%�p���%��O��ޯIw#"q6"F�!
2X���L8oW؆�v�.�	�<�i^ڽ���g�c�q��!��I[<K)L�������cs2�ؠp�oTx���q�͎{!�UXV1��ضu�'��mkhXf��*�O�\\�-.IP���%��H����qŗ�~�sD'0�h�Q3�0-����Qf�q�ԇ}=;To��k��xĎ�-���W�a���o�>͍4ݺ�V��� ���k9_�7S�=�~7
]�+0��OF�w�X���_68���멙w��z-��a#��j�
�Oq�jѱC}�4�ZUb�UO�z[,���3�R��VΡ��X�W"�S�
ѡ��p6��X�4cTX��(��v��v��:+�e��
$��_9.DJN���r�~�,����IJ����C-�����_��+��>o��Kۙ�B=�BϽ�+�=��X`�X��O�H"�$<�hQ��Z-U��'��p�Ƅ��	e$G��Sdtڝ.B�����X����I�1�Z�:�%�4�� BԮߗ��I�x���4;]�څ�vM�D�MR��1	�YZzQ�6�+u6!��{mo�#���,r�"j�vQXU�Q5Ր��~~?č#�"c�W2��E;؝>��0��d6��NC΄	�Y@���
J�Yꪰd��,<�E���KYo�
�a-Y7u˂�U2�+"3��N7�ɒ[���v'����h�����}�d������J(rV��;��#�tzG�[��D��~�!�qC�eH��2ĲS*z�K��[`\2t���$R'�[��C?� �A���aEύ|���#�=z�DzHKO�:zrv*=J	+znT 0'%4��	�X뚿"C���Dz�aث�j���eK�[�k/��pj!N ����#��>�l���jy���4���
�I�_�xO[�@��F�ޘkT��~i�u���Ƙ)z9X�n�C��ԧ�m�������?%wI�_wyTW�+E�n�U��4�k�c��W���j���2;���Us���#O�X��Md�(ߞ���@ň�J+�Q��j�j"L�ߌ�"wM:>�[lگ���G���I�n��:�ٜc�)�N���<����EF<�r�h���W�!�����f�	�d��cs���?7���y�M�?��)�VаPy~� @�I��+�eau�]	~���&���P����M��ە��4pX1q�9bE7�L7A�x�K�[ަ��C2��c}U�w��+i���n%��3� ��-q��m�d�LM�~��h�=y�'U�]���O������B�R��рO�� �]}1g�&*��ڟpDLvҢ=c��v����_��vv�j/��o➪�b�[6Q�͎N5+�?R.�{�z+��k,�������J������ׯ�������)�:������v��|�\:��+M}�.1ƨ�n��b&����ٟ�f���U���4V&���q����o�ũ(sئ	�Ku��	ѵ�%�i�I[��'���+��(6��-Z0�������'��U��[5���i�&Y��DC"�.��R���h�/�Y�\���z�$O3�8^`X�V��ʢEuL'8I��91h���c�z�yJ}=�M~8�Y�U��(	Ԑ@	�]�̞���n
���t3�~
�se�F`Gd��R��O�!�r���]i�7
��x�4�JM@�������)"R�Y� $̨,t�&=h�+�9�l���FUO��i*n�A��d�05�#]���?S����ڧ�8�4e1GЦ֡:j�K\\����n�gP�?.�D�+ӥ�p�����N��v��N�����o{�Ci����L�gBY�ͳ��﫣��M�M��f�*s�)V$�;��t��;�ɰ�ǘD[	n�$���飉���-�a�ڶ:�$    `�}RH�[���������I���M�eJ�����Bwc��US�Ӏn�z���qFS�f���ZpX���ti���*�%�9^9<�J��O�7���	;n��VE�EK�}��I��d� �@ <��(G�(�t
��L�5#Lnw��\;�����Z�Wh&��k
�2��~�۵	�_ʸ�	���2hCJ�?��xx�i��ݽ��������y_����?�%�/�ǟ��.j��s���zT�r4���:�>��,;5(b�'aT����4��$��>��P��m��Gu�gb��F�/��Q�V�����b�<�II���hGa�/�7�_�e#���Z^W�vG��3�o���tU��)�ל�o#U��i�x���� �|	����?�����2��Q4�����&����E�J�Ќ̪H�P|��b�(Q�� �XRu}�>�'�ۚbة.&,�[g���R�і8�Jn���q��f�<�:�L�h�5��n���2��n�K�^ׯM�=�SZ�-�䮭әآ��P�-(���sʿ�UY>"m-�����aՋ���97n)�@�J�6���xZz����Hа���ye�5���j``�~�j����&6/[�0XSw��n�7~Մ���\�	Ř"S��%uG��`	���{�{�V�3]��)�Nj�3]!uz��̓y{	a�%b�Һ�)�IX별K�N���yiD+w*���V��.*}�:��֙rM�bnh Nگ�Z_#Z1w$E���4�"��7��Wd�]�|���%3�PG�V�ıԞ�^������M��@/ED�����k����M�M:m3��B���(�P��j�0�E�z^��������I�C�jj���K���;<M�gy5���;��t<t*��4�1�Uk���Y;�|�;-Òg��~��שb��a��]!MC�}���z��_?ŨM����F�\H��*i;�i���T�VS��a9��X5�m}:Yn��tU�9���@�����)�ei��иd6Z�|97&XJ���cZ�&uuh�|��7�g�);�0�_H��!��ֻ�"޺�zۃb�#:g)������9���f|�ܶ��T׵9��RE�{����K}����4���ΎGf}]�{�:qڹ4YO(�V%�',�� %�^�<�&�K����c}	���B��<����l�;�K��'SG�
bg�w;%��v�&?V�37DY'(�=��7�c(а�r��n�E��ܦZ��|��^zI6m�o��{�~�ݔJc�������3��O<z����a���Nݒ���^�n��:J�_�a�|�|cT'"�騢�n�����4#C�+V'|V�sq��W	wH��!��ˠV�p��R���:�+Z&D[��@�\�Pxo�����:)�*᧔/����'f�V�LؐP�ty��*�ʃ�Bc����G�E��H��Z�LU)߷'��ܸ,��D��yI��h����,�P+&"����s�'R{���.�1:;����a��
���t�ޣ2�ߑn���h��Bk��pM�ذ_QΞ��չ��f?�;��N���Z�G��<�Ӽ�%~B-g�Ꝗ�B2�nTH.��5ʏ�Ǘ.�!�mˁ��$�Qg3�G����	��K�;E`���`�<F���t%@|k��{��ò
l���x�e�a� ���	�p*Ke�K�%xX�MF'��*= J�)�0��4ib�pK8xXQ3)b�q˚��ݷzݑ�TbE=L�g�x��t �a-=����	f�>�ck��iEYmiׯ��Y1nkۚ�>��o���J�a��&��W���_U�l�T���_�{;3��	��u�M�BkM���r=I��𪰗,����-XLnTu"vh57������U��h���ƌ��"��8�l��^����M��f���4���#�ަ�X�I��}[�VE�b��hq;��Q��Fn�%6{ڕj=	<b��V8oT�o�Uiu6�`BL��f��:���N��B��a����V��I0���f5k~~�Ȭi�L�>sZ�I���Z5<6	L#���Q�I3�f�ͺWq6߯�c����f/�J@���ݻ�˞�.q�\b�V
l���R
�ߚz��Oz!��z���N�"�1Y�,��R;h�A�I8��0�KȂ�Ҟ,nT����h���4?,�I��!I�[.Vċ
�{+�����i�'9�a�*����)A�L@�7� St[yK	S���K�G�y8�j�-%b$�g��I:�C�J�n�?K��ı7E�e�������h��)	чk:�A�]OD��I6���Zm�ħ~�Ss�Ϲ��]�]�ʰpz��InQ��q��NG��#��p��\�q�I���M?Ib�'Q{a5�?�OVx~�Xɳ	F"�%>���슩�e��&	��I��#g�N������4�l��A�`E������,���L񁌅�$?1G����G�9R3N
|8�(йA��!���>=.?��<9̐�h{7�n*HZ[�w�£'$����ކM����PoE3��j~{z�3܌����>�U��ʬEy���
~锁���-�կ���;E��ko��<��ҷzk������ѸL����;��<)Q{����`�ܳ ��Pt����Z�A�Sy%yZ@-'�4�Ad!>����X��>��^Wl�J���NL�r�Ïd�SP](z/]�Ip|-Lz�Y(cK��Q��㾊0�ښY�n�N�ܮ�`�t�C�r2X�ò�A$�c��o����w> ����+bQG����_?�B$ΠVX��imA�Êڳ�]�ھ��q�ز�	���SS<	�+�s)7YH8��:���Ш�� ��8��_�?T��;#�ఒͳ*@�D6���8T_O%�z>� �!R��"ҷ.=�m5�N���;���Զ��e�O���c
$����%lD��)s�gsN$�/�.� ��@�I0�d(�-�A�ə����s�f�eҖ�'N	~B�ii������߭"o��;�����Wv[��U���)>n�T�"�wݗ�=�kZO*
�R�>B��)�g�R�,�+��Cŝ_�]�� ��.�T-�g��Ŗ�~����
��umr��--������z��M9xX�h�f+��A�{\?�j����jMoN���8�OB����R��?#H��קPN�C�r8X���ܣ�U�c$�CI��a�VM���eʔ�(�SV�hƶ���9�����:T愦\�DJ�'5���|vKM�P�z�Ӹ��m-�n�9w3��`�M�l�y4%@�40����t�@�(�7�:��QC �t'pd9�N��Ps9N3oA��t=cg<��O��0����Z/�;	�h�Qu�Z��y���[So�}x�~߉v�~rS����F����Cp|�yݹ�'�Y��ʹe8�AO}��>&p����z�����Z�z�-Y��B,ꗃ�@X�L���J�W~��[��tZ�W3�]��(�&;�E yG�Q�n{�':T�y���q�~V���e���s������A�Ʀ�\xcs���k�]?a�[����?d��T}��
���	�g�]M��j1�Du�<��Xm���W�"���fFM�a�S�-�/�2�R�z�U�?�2�~�����q��v�Ú���^LUu��H���翺��K8E��XxX����kˍ�Q��d�zUT'���[�*V��I'RB��xm�FhXu�� J�TB���2sTmfd�Q��<��Jsb��Rb���~�fsu��� �"uU[������grݒ�R����Eh�(I�wZ��V�<@���ȓ�Υ�2�-�g�L�`֌ G?���a���`q��2Q�`����fP3�Di���H�^���u�q`X�#�:�9�x�K��U��5��WML-~UX�j��M��Vo��[�Y0i�l7�4p8��T0�>�~�*z��	�<U���^~��������҆/�X��MMQK�^�6��=Ge���!)S�K4�SA{7}�q��đ�|��o�^�e��`����T�@�R�y�V���Nv�Rf����dyab    �RN��Z���;�'3�Ư�	�#`(oP£�n�۹%��l��C�c��S즟!�B�!n٘ӫ޶J֔��U�A>�}P&J�N�h�P��cV�Otj�5�ܭ���of�=�<7�j�X���2��E=��>����(y��ؔ�zNOu�|�ړ�����345�G`F	�q{��=e��M��G�C���?��h�����G��3����y������V1C�j���1��m�6~X+y�G�ML[�VUo��Vh�M� � �ԑ����j�a�o�rjC
y_2P`����楢�[������D��a�6� ��ixş���3�
�w�}k�bF���=���yD��~����)ά?"B�(�ϵkؼ�$��RƷ��@3���Ul�p@(Ӱ�ѳ��c#f�|I��t2��m\W��S���l������]��x٭��n�^�?�Z��a g bp���ԉ��~���?�bw>�`�=G5�/(�?���	,`s��;r0�����t>=V��� �-���b�[��c��� �.H���.݇X�؀�D�	� ��s��K>~>x�Ā/ ��Y�pr�_\|1_�k��x�tvܭ�r���e�i�7���~��{ܥ)R�e�!{r�eT(�Z4�(�rE�wjʛI_T֤5�����먾Suצd�*��(M6�3�4y�7������E-_��_%���[�}�J���c�O��S�M��\�M�`���Q����R������'��
g`BF`X=*X��yH��T�>$�iHp�Q9����`�Q��������Lp���?*���{�@��Q�S�ʘ�o���_����]z���6��LxYp#��R�#�{
r���r���SA����=,���|y�?/����r�V�coݶ�aN����5���T?���&D5��ir������^41���Æ�Hu3��w�gr�p��[4c�[7$&�Ǚ��^t�3��Kǟ�@�;������/�v�K�i�K��➈���3>��z\���i�y�+U�R5o�ϓ�c�P7o����L�;l�����_�e�0C��T[�#/��XTVdN���u�Lyw$�o������G+^��U��xU�3�WO/A���ˑ��L m�ъ4lI�S�3�SM�LB��V�z�Ι�Ƴ�u
��8���#q���&��$�Sv���sD��u�_�-C�B����*��'��X9��bA�>��2�%צ�FU]��@!���܊�S���:7���I�ݣKBW��wa�6��-S�%�M��� �|R��p!G���5�����K`�JѢ}��ړ٥�r�&���|��e�r�>���}ܼ�Pls�޾ߥ��G/ڀ:aY~K���?�ۉS�i�<.���Bp��6�W+���ך���V'�Pj�Nx\�D����$jc��N�jj6.y5>�?�m�&a쟪cm�vr��rw�MR���Tܔ-7�z����>4�a=�g����alj�jw�]5�k0&w%]:�yqX��͒$����}�<J6�d�1����dfV�ffUw�x��h�O�Y�Fc6��:ѴǹR�}�n��?��WD  ��8c5�bvv|��p�;��˅o.е�8t�7��~���H�-mδ�@PgQ�<r�w��;o�����f��؃����v��釙s&j��=���)�ս�|������=сx�] u� dɂ~V��B��;�i�;o����>�1q	��sp��}���&�ȶ/�����So,�GR(�t��������x|9ه�ￛ�Z��g�Π8G5���fO��CR���g>�������VAՙS��AkM�Ϸ�s77h%�/�/��Lc'|S`���_6�f9�����AvR�X�����Bj5���=�`k��݃'e�� ��`�����p�x*:!c�;/��9��>����fU��;n�2����F�^!L�M�C:n�v�6�k�Ž������Q!����֕8��\7�%Su��	�Z'��y$�ZclW��棟~V.���jq�6`��{n|�2��,��k�I�$����['�9<5ݛK>��܉#���Q�d�\�6�{���w��S��e��C3ɴp^�3��Tv�e'�������f���E���[��VL��,(������1K�̜��+���ȗU�Eգ�Ʋ�&��v��;��0�ߺ�H��2�/c�}i����9�N"t�|�5J����1��c�f
�99#8�a��q��逹��Q�����箒ф0��<����!�N���� ���3���C5:"?tD||xR=����С��)�0�G�'�眱��ά�����-)KJk���*&�����jeI8/�:�1��u� �lQijkSs�}o����a,=09��6'Q�U���s
�|U����9����XZ[��|sxo�pз-&k��1�_:��ӭ�m���p�i�������n�9�!Oё�i�5�tL��|林=����sA��P}�$�<o>�%,>���x޽{l��,ӗ����p���w{h��OI��uz�p�r{s�Ё�ε���W��?�heۨ�>�?Cro+O�ͻ����Af!� ��_��/���H����w�����]��o���������w�����fu�����o���o���j��o~�o�g���w����s���o��������_����?��e{���u��|¿�E���������{�Ǝ��o�m������v��V
�#�����)�<��(�
��Bpl�К+�n���?i��2 #)�Q�"uD���8I��m�)FW�#���ak���_E> �.#�}Y��GD�����bG�!4"�!І]�G��F+ίrD���uF$�'����%�?��DM5j� �d�������!럵ؓ+�=	�=qŞ鱠	cAG�B�A�l�~c��2l�2�74<�]���`P�1�
�
��D�H�����`a��3�sw�^�ވ�!mͯ�C��(��5���S�~�V����&�*�h��@�t�br�ō�IZ��,X➬�r."��4�*����Ӈ�+m��>|l�t�x��7o������v�U�Ɖ��naWw���@��yAx�w�H����~ɒ�����|�<7_� � ��<H?sυd����Q�H9_���_R�_�����A�ȠE�(�����G���!z�0��/��y�ê���:+��:x�,�ՠy��L6�7w;�FqMӁ��U��� 9�����/u�r|�cLU���,>OI�$|�@�N!�����C. ��*Д�*�p)LP�A�~aTN����q��<��2�GT;=�Vͬ����p��hɩ��G�}s��|����Qf�`Q`��?Ӊ�jsǻ��cc=��̏$�<�����������b�>6�:��$���h{4�scMʽ}O��s�{Q�uv����������k��r,�N7���vg� �I�����E�:s����e�}?�ňr NB˷[0�����(�,έ�Tb�������mǭZe �P�:bC`9>��L���3-��G�vza�No[����7��4a��VΝ[���9y������~Ź�}��R�d5JQSPq���CH�b�h�LR�Q�g���*���eO6�$����1w7N��U;��cӪ���Y�)J�ԕ7��3��bG�F'�i{i{��{O�bUR��ұ�y~R�dq�����A�C�������[��(�2_�5$�C�5�睬K3F����8/'�w�D�a"��t�\���]c��ϗmo��ǒXj�^K�1߻Jn�0��tn>�߼ۜ6_�켤�N����y��F���E/S~�k��(>m�_�
<�w�Jd�X���Z�?�g��'�M����d�Í��ݓ&�������4�}�&�o�2�;to!��M>%��y2����������9��A�z$�t����g��x ��䮽c�!��=����@�)Ѥ�x������y!ED��C,�]$h�������q45�j����t0�@�<Ș�Ȁ    #�+Ƚ�D�4��Pp�w�۝8f2"<��	|��U��ͨ�d��o5��6ttx?R��G�>�y�;o�8�Ǝh���_ʃƽ��C4��Gtv��h���*�a~�z%X]�;y�e��x�����BA�{�b��A��Tj�W�;"k������4��p���7��d�.����~�ԃ7�􇟛���˃�:�=��or�բw�_������Z��w����u�RG��Sck�͐�e�'ǅR~"���[�/���;q���b�:ޞ����t�[�����������݃�Kt~m��[l�}�=���p|,���:O��}���Y�y�(�xi��[��jg�s�_�����$,Aж�k�a�tf�Dh;�(T���bׄ����5[�C`2Rh�n<��4�R�X��W���Y%�(w��_=��W��r�.,����Z�O���!���b��'�d�l�w�4ﾺ�)_]D@!�>���]�I�I�ig]M��Ԯ_�K�޽����v���5��m�$>�I�g��P����)���}���Q����0����l��>}L�DT"Hv�q7�U�xs�(�I�D�X�y�ׇ{p�tl���׷+��7��߻����* ��x�״s^�TXdU0 �_�y,� ���=wP@�o |��	,Hk^p���7����UY��@�&o|Cx>ٚ�1 ]������+�������eߖ��o�/�Ȩ��oķ§�i7ڣ-�������T;��� �����a�(:{�%r��s�$>Y�agX<�����gy��s�b��Ȏ�a��=�½�{v�σ�w6���,��������dMվ��Mō#�����!�m��ŏ���g·E��3m�c�ƠģD0�����0{ �C��}�܈���xJj>�G ��C�Q"/�C���k�K����Owbk͔�^�|�ٯM���}|�^T%�(�v�|,�2�ඣ|��˾[�ǉ��v�;m�a�d���ߞ����H`T����a��������GW��s8{1Y��<���xto)y(��$ruݾ�ȟ{L�Ӛ��"�Zy|�g�V�|~}���ʬ�F�����~��_>��_���g1����9�I4�k܉��Fu�c�Kn��C��yN�᧰j�O��m���5"����~�,���^�7Կ�y�}�x��y�e�V�]�ȹ,}�`mUk�
�����4�/=�ZDw��]sJW1wKv����i#�'h��i󄇛ûlȻO�XB
�]����(%�tx�4(����6OךJ��0[�����c�Z���������H[D>N�;JNPsj��LN��1��*��ta�3x9�^����j��4X�T����-P�ߨ��**�|��}{������i.����������Ƿ�?��߿�?����������������_W��������������_���o?�u�<���~��}��o�_��2վ�#���k���tl��Ἲ<��oĽ�w�io�ֲT-��V�����W�\������|�MS�%���儽:qɊc1m;w�2��^���������R�y~� ��f�xwx���~Q�F�62FU�ʶ�85�6ϯ�E�+U����1�²Fòf^IU��w��/�����V�T�̧���˥wO	�h�G�$1�k_K`�ǲϬ?U{*y���G:�Fȏ���A���%wj���C��ۉN�n�y��� �����S@�Ñ�����I~�$���{��ی ��@0e���s:�M�#�"��Ty�� ��p�I���/����Ʃ�(�����,Y����!���~b�\q-��g^E�n�ɉM���az�_�qu�'���,�C�W=��n��+�o^��7�n>n>�e%O���Ӏ��w�j�s}_o�$xm�ƭ������������N��q�:��� �T>lvJ��>�X}}:\6͔>=]T�>�G����!�?������k_�x�c�6�L9� �+�V�w���Gy�;q.�L�eS����T��f�}#�?����{=\�Uc6�:ͪ�>z�r���M���XS�_8��g':k Hf��ߴ���+�n�}�� y7�	kN�ω|A�H�������W�K��"k�K|�m��K��b�ۖE��Ou�������{s������TZ�  o^��cg�1�z�\��?�����J�J�EFrC�B�(�"����R���%ĭR��kn̯��d�CzIhk4�K���k��c��km��W�*���S(*6L��!h�yzjv���`�OP6q�b��1Z�,f}9��3�M���C� @g��49 D�6Y�X;-I�LO�b���ںc��C5Y��+�OM�cV��s���YF}�ff'_ Zv.N͙��`ۇ%��˸�H*EVv^�,X=��sXM���- $0'I���
U�9�pS�%��ͷڨW12mN�*>'g"s2O̜9��b.N͙��`�I�1'Eq7AI���ɚ�)���������I�@蟓�r$���-,󋜖>�)��om��5��E�V�%���� 615}!��� ן�˓s�fm���f{���	@��U����d��F��,^��':� ���\�ޤ%�����[*C�Ad��D��=Ћ+���oA��m�4-�@=|T|��*���� �w���2~L��6��lޝ��wz�S���ދ#��d��{���5وi���z����O��}=}�1^�`s�%:$��!i�1�4�r�^݉�zz�>�OO�⦣İ!v?�r��j�`˨��(*5��Nb��C2ty:>�0"9*W�T�*9cS�=:�ҁ�!�^-�� U;����,�Y"3�����BLbjF��8O�Q����6�S���m�OOc���IΔ�	t�ԂNS���l�Xx�f���9\��ɁS8�!�t}��:������S��|�ɛM��tB�3�oxզG�?���N��3[l2�h[W�l�Ee�	��9*��i�/���a��7���F:ã���=2f���~p���T�,��d�6D�a�0����!q��$ST�q��'� �

VZ��"��#�^,��7=��}�)�žw�dH�@.��4�cDJf�Ȕm��%�K�R�g��v�1�H(>�7�Ǘhu!�-4�J"�ž�OR=�����.%�s�O��Ϙ��"��t��eHF[�М�Gp�SS�mN�"����0�~��D��2��y�4���¾��ӥC�h���E�`�f�Ĉl�A�,ڒE��Y9�V�r�*��{�/�F8<�Ѷ��h�CӒ��o�$�2���,��X�-,��&1"sP���6*�1b�eX��h<�J�Hqi�Y�m��LuvM���"M.������d�@ZPG.�,ӖĘ\�@�,� �� �$� ֹ��&�3�������O13̗�/���֡m���c��{��&p��2@���%A������V��۫Яl���u�w �A��o��}k�_��)��<�������U՞|�V��������][Cl�?%�kO�t�+S6��~�2b�= ��ں�������6�ă�?_��z?��d�4��N�U{���i���������Jy�����H%8�}�@񿁭��;�������Ȅx_�߷фͿW1�TϜq�
Z��F��Z�t%\7��Ӽ���'oz+܀�w/���&�F8[3�+h�li+(��¤t��*M��sJF?��EQ������|-��<��gJ��}�B���P�!��F��JFL:��ȗ��냈 �娍���@���_�E��0k�?���a�T��se��u҃��xr�W<%�����$&��@�5����� �kl88Ryǘ���4��}�\��þs�� �!<l�@M	�tQD%c2�	���m�����JG'*�hє��2�D�E2ݷ�_Ԑ����.z3�]iR�,�1�����<T�5*�͊�B��A�̨���LLFz8�}�t�����s����ɡu�	L��R��D
࣐%��a��Bm��]    ���A	�YH�!�!�L�O�ϟ,�2��+�����*	�O��S���t9�@���Zw$3���:P�a�C/�����t�>]�y��{��(.�:�(隄 .
SdK�21?
����߼߬��ݦ�����_!�1���'Y�e^�_L�L�;m���M�n�L���^�]�$�n�&��?�1����S'�\��xA�{���Ei�2��p��Z�e��뜼��b�W:���q�))��U������$�Ke��r���w��:zȝt��S�Pң��>p�d��!_wJp�
����H9���v�X
I�I���^�Ԙ��uxe=F�s��2a�Z2	��3��2E�`�s���S���K`4��6.c%��K[�᱁����N���.��I�	x�Y��e%_2O�Xe���^3=�G�Sb�;�)���%΄�/�q�,�3[PXæ\�8B��֋�$�U�ӡ�n����l)��@
�#� p���_%����qY+�,_ҐF7\g��fjh�
��c��z��X�L;�p�i���m�3��C�ӗL�?R�k	��,m���o��,B2_*�"b��+g��T�q3��0�Z���������M�����:!rԐ��x:%k���&W���BhB|��6*�K��h���MDD�w���<��G9>�"�:x?&��.@	���~�&74;!ҏ9^Q�Ss��q�� d/Cf/ৡ�#�ڱ��kf��c�=�/S�Qo��k�G��p�l�(1^bq�OG����El�{S\�%H�2�2$�k�]鼽	��j��Xn�O�F�(�����'K4�җ���P=��/�)��^L9�&��ٟ��7����'�F���j�G�� �{�qbm#�5�u�^]���?B�N��t,�]%��_V���F;�CU�|C���G�������Цo��Ʃ���ӣ�_x�/ms��zw����o�i��.Y��EC��.B�n�����ֶ�<a\w=\��x����Z�'ZU`$0o
��cQ۪��3��������Awpѭ47	���G��oK [3�[3�}QVܰ�^Vh�w���,)<�qM�(J�n)�
Eww�b��#9����k��0�?n,J��-K���w��ww�j=~�o�$��������a]�Ћ����G�W�	�`���z��t�iR;���QwC�!H�L�a��L!aʠW.�K�a�\�i3�V7f0����8�������<`��F��z9�wz� K�`�˽`�&��Wb�K�W�X����`��B@o��onE��h5�Le�X"T]�ܧ��U��� z�9���6�̔�������~��כ�a�8/&kO���ǳ��]��!25��������Ǘ�֨�~래ޏE��98�N�m5�������"-o*Q3��UŨ9F+�
��X�U�oE�'�}���9<B�O]6��v�+isC�i�j�:�nL�m��ejoE�Oa�xLK�&�5�jm4X��'�L��j��@Jh@�0�1cVHɢ�M�\�:	#0Q�˅��`j7�.̷/��zθ�֞n���+�gQU�<���y��� ^}���]}��2RY#���-J��e�~�"{�cl�2�&1����X��Wv+)�� �ÐW�/�;soj�C�GW�L��K\�LD�`"��_{ ��ǃ��C�e3Wa�o�����?�7/��T��&��po?��>|�?�%���Q�N$5 ����V�ߚj.��̎ю��q�L���}]���O���`b� �~��E`:���3��u'<��;�����Wڛ�vtG����5�,#�T1��;��^����J�б^�$kCFH�Mx�QR��_�k~`�,�6bo��(���<���=G��������w��>��w�_}���7߯���o���oW�~�����w������o��������~�ݿ����������������]����w����_������7���A�������w�N�
������w���w�A����{G9���w�ۿr��}��e32�Uǿ�_��c�M��,\������%�Uq���@ڔ!a�Y�]�K�@k��J��r,��#�6�8!k�'�� ����m3+g�%)��@�~I��;s�2c�!Ȳ���Sņ�G��ϣ�G�@�W7���9-4e�!�$FhES��4��0ܟX��XFh&���:z�.�t��~@����^en��[On�N�����p��璞��:���i��r�=-Y<#��I�r+�
|���^|#�k`z2���:/��Ǔ�2^]$-����^!h��N	L3�&*��K4;��Nf��-�,_��%.�T+H�6��6!�Y$�����!݆н7�Ah!�BTnԅ<Rؼ6k�0���=�non_.O���r��V��~w:�ޭn7_�N��H_O�A��=����yYl�GVo��Wi�7�;�=ӱ��찚 ��5��1��1*uF0�t��ބh;�JdЏlD��z`��K�,�h���㐐����pZ��SE���1��g���԰�F���QQ�73��%Ű�d!j�I�qj4N�j�O����T�8%���,D-7C2N�ǩ)�Zz�.�^ n�܆�e<�jJAdO#g����vW�<�ڇ2�C���,΃�I�L���*�Y�	6!+Ҽ�<=�� �����	�ܠ��Y�I(�"ъt�]����.�dw��ח�� ��#+�N ����^p�U<���zQe�±�[�$g�I�5��J4+%o�� �O�<Btliשxԟ��,�?��4!-d�� %�OT;."F���7�?� O#V(�ΏЉI� '�$} GR���E�f�zq��e{���ys9�V����}<F��!\�2��BYL���}Դ�)�㲫8C?ۺ*���<����ZT��)� cKemcY!b����7�~��\^N�i��� �~�#I��D�}.{����{S%�AF�>�������� �!́Fl��SI��|�Ph-�f7�*�p����b�lݱ����9���٘��T�D�d�$��D�<�WE���Xe����T#�����KȢ���%�������tZ
c$�;���<lO_m'D �:ąc���бh]h�!��JN�Ź���+۱j;���P���\��r�օ3���o�n	��*��B� _>�p<l���LU��GKwB[�������XP��	{Tm�n(+c �y��O�)j]VgQ=쾁�f��p�|A�G�<�^�	�ܬ�0>u�Ҷ��V�Wl�Q�6b"���77wQ]�u���G�y?��!�l��y{X�W��y���������rȡ09Ԑc��L�T�⨍W�%�:x������������%�c��p�9��fw��[�vkZ�X�oLs֛�Wؚ�������H��C2���P��BJ�#+"����^���%�D�����9$|��H�}Ē�S��M�{9�/��Ó#���Qj�x: d�2afVD}��u��$/�R��WR��"�su�H�>[�5�Od�Y��� ��8�h6��٣i~jbZ�[lw��Jl���N�[�lVM� ���"�柖^�f673g6���ٜ��;H� )H��*�B6ZUJ��WQT����(��$��fA��$�Xk+%}��4XG���j�@��چҼ�6r�6�֖CȚ�MAֶcW�8���^z����5�	K�T�1W���. �U�In�|����!�N�,�Coe�`#����4�xM�Z�V���8�M t��֗|�Q�7B�cK��?�B3Nu�nn6�7���w;u�-4��\�	��� 1�1�E����f�vƂ��<q�GW�;�r�K��/�^�W[����no�w�&� H�!���a[�`ۮ�^��&�;m��s��C����j���ZE�%^���Y:��rӽ,s=u�n.p멗�]J#��z ��]�>�P%r�u{��ͷ��때�Ȏ�t!�V�aƤ�+R�x9�ԋ�jk�8h��XV�F    i�a&J��i��`�omOՋu�e*�r���R�b��X�����Ud��XG���$k��,��҃=�c�%��<b�Ne��T3�0;4ߦѦ���,rȒ0�ԘU��)�ٰ-9I����l�N֝a�Iv���8c������N�:m��ۗ�����Ou��y��%��aGo3����&Q��3w�ČC���Y4p��h��'��QsSy��
�+l�v��튮as�^����v^�e�F��h�p��6�־毫�vѻ�[������E/���w-�ǧ��t�=�DHE؈��vwߊ].JP�2[:mO��d�T�7������RE�,����=�$�ѳCt7�$��X`D';$��IfI�`���_���&����ˌi�UȒ��xJ�2@�c���<�F�{R�����Y����G�-QGSvF���/�B[�0
'��q�Ba-$�x����Lo$J���{{A�U�$��Kk~AV�/�zt���92�YO��� ��@wN�'�I�8N�4廚�zDA2`���z;�rV��x����"�Ia.�19Ԣ�"ȐH�q�;K���rP�lf9J]�u�Q��@ ������_-����w����"2{�d>F�t1L��0Tf��AԱ&��KP��:ݘd�@���	��V_�U.U�v�Pe���K�|���������u��Y�j%v ��ɜ�ȮT��I7 ����Q��A�%�`�c�[�` ������)�+�ͅ��P�td��Xd[t�˾w6r>|�qў�%Y�(�b�Ȥ�4ׄ���
��^�e<AɌ��_8PR}2f|2�����Hfu���Ɋ�l~X^'maƒƗM���j�رA:|�,c�t;w㠡"�Et�V^��1�JR��̍7���3>�
�f �Tr�����δ�P��O��]���q�@I���q��+ӝ+��FfZHLq6Um.��?¹cj����$bN7����!@z��a�A�ac2aCa��}M�ε>8����W�����i{�u�Q@�"�&���s��>�5�b��r����3�p�`u��YOIXǫ3�����'|ؙó��Y�7��ǖ4���<s}E��(b�5��C����U�P�a΍����y.c\�{��sk�ظ1��3���u���YĎ���|̌�T4%I1��}y&����<���LPu�qP�q{E�j��uR7&j�qT"Z������Qb�RQ�f��?�VcVym@;ݽ��<���~�l�|uG��J:�&�+�9�]�/�:Irj�t�M�n��1�7h�<ƀ!vg^O0�j`��̎|�X1���(�ׇh{펫Jw��QCC�gxL����c�Lp2C����U)����.�-�H�o����%Q���i��	)n}�u�����|�0��['Ơjl:Z�{)W�$ia���T��H��0�Z7�9ӲAIj�X�Gy�~�#|��6Q��A��c.�����Sø�L�Ԁ�o�J�(�f׷ވ&�]�U
��3��W>E�~ʌ�
lj���jQ���q�H���k.�+�Y&�!Tu	sμѭeh�7�M�֬3�a���Ξᵥ�W�Ω�����w�/��活ۍ���I�l4�S��ig��j�`7b@&a@e|7�ײ�M�F,EN"w�VS�j�e%:M˲V?�>��������M�P�WRT��I�KI����Ρ�,%U��u-*ޥdQQI\JD�E��ؚ���S�~Qy&��,���j_��
o���L}m��ۯP���ԻMZ���Ijex~�FCӿ0���ӌ HZ��n�t����ÔK�L5#�p��z���P��4ٵ�C�Q�R�o%��Yɬ
�#�J�z%T�Do�7�"�����mE�ߨ%�B$Q�ڣ4&3AƧ$�I2up�O���Dq8�$$�P)��螅��c�t��BZ[�@�	F�,���[��tV������+�<�q�S|���>��`����{oI����]
A1{�	D����r��$hg��ws��6/.B�`�Ru��Bg+�Z�����n.��"��W��e�{]�Y\>�Yս�&:	��}�S�]Խ<Z �&M�]am�O�1aU5�55I]b��֡�a{�������FW�e��-��*V=w��A\|Ə�ePh "氄8�������vX�,> ���g� S�"���e4'.>KIc���A8X|�-j���m�B�]|�B�������h%&��8�
��$#Y�}�3��`5yU�t��s�����tޝ����L]7z�z�S~���n&����3U3��&��z����r��5���Q�\�a�&��k"���k!N�ǵE��<&2fw���U���b��Z�{=��V����p{XĞ�*��J�y�~Кՠ�F"���)]7�X�������Rw�LWX~\�͕ngY�R۱)Q+;�9����e�ۧ��^�y��<(�%���c3,��~xz9�24�-[p<T�N�i�A�d6�`ڗ��	�q��B�aND��q�\�a��:��+B�.�g<:�SBh�`>\0�-f�j�^�WO_s�b�����UǨ���;�8'p�������͉��b� ��lI]����$������1��>
p=Ƹ��|�&��P��ԹY ���-(�^M[:W�@LV��P*�Q�@�@h�X�2F���x5��zS�� �C�|�Z�7�?���K�M����YN�I��yv�Ӛ��i=����Դ��i��G���AL�ֵ�8���5< mt�%�#p�ϮF1uZ�֓z�����a������Z��T{�/��Z���O�}������%�'2׶) rO7�)llVA�G[<��A�X�B����V=�Xꃇ��7w�<��4�ϒ�a�Q���HvZ/��N�f�Η��"��(rH�v����G��ŉ�ņ�5��d���o�n.o��J9�0z�(=4�����9�i��k{�Rp���qt 6
A�,{*8�������r���>j/<KQݲ��w��*�Q8�Ga�O_�������$H�.D?�XNC�� b�_��M�m���*G��O��r5�����SͿ-����TP2��U��	j����PD���K/3�CKo=g�Å�<���[�e�cp�M�Yr����g�����f�;w_��n��as�=�����[��Z��m��%.22���ӓ�����5nd-ddԳM041~�3=Ӹ���qQO6-tc[*Ml�]���a�F=�<Ӣ��ϯCE=מpE}A�>}ĚH�^ũg�X�����iz��9Cj��#����~daӌr�+w�<��	�FXo�eq~z�.�=���W���"R�ҽ�]���׼�9⾷ߚg4K*�wo�9с�{ ��Q�]^|���sW1�/)t]��9��o�k=���=Խ��ر�u�[�\ܺD
&�N"\��j��r�a⽿�M糖.�m4{:o�K��u}ޗ��6����{ɛZ������\u����< �^ .5�~���E������}� �3�=��]A���+h�X���O<��&,��� _tU9�ȦN���+�qH#*f��8y��EP�^;�z�h�,��<s%�����	����z���{d-�;s%�=�
��J�W����
Ī�4ԖR �����%w���
1���d��<�B�#
D&_�~��E�����:3%�8����FJ��T2��:�z��ޞHT5���0 �2aT�8d�7&_Ԅ hØӟB��e�,�6�yPـ�&�Tc[��幻J�,���g���w�YZ��a%3ل�@U�r:��e�T�U\�v����0���0��L�����2ˋ���0K�εa�3�X�A�B�b1C� �$E N�*u���BP~�b�D�g%3ӖO�b�|pv)�WP_�YAay��E>�����\?n�%{�򰨫k�XAU�lR�^Z������Iϓ��:���
j�篠jw��$"���i����<s��+%�T_:��)ަD�]��k��;f�L2Pj�P���H%����	��̭���<��M� ������qj�O������8U}�17z�,��y�s���e�g)r    ��"7س9�j�9k-Rʗ��W�K��U����AE�/��ș2O���K��ᐷ_�/�;W��3�I$/��9j��~kĜ����
�R�Gv��L�b��&����U�r~�����^ y1W����r%G��3�Id.��U�.k�J7��M�H�*y�j�t��aP(.=+l�t՝��_x��5�}�Mtg������p��
���Z�س�J�j�0GDx�(y�ѯV����V0�Cj�\:_��J�0s<��S������%xg���N�z�bc��R�b�MsG�.�ij�N����,�������|X������+���hU����i�����U�)`�8�D
,*�M�.is���ʣNmo��Xs�Í>D�1K��͋o�ov�.��5ϗ�糁轱�Vd�5����fkcP��FZ�]C=���$1���J�:�xP�KOPǵ^��彬������U��WG�]4�H��9�V�i��/l���i�Ռ"�h�~E�{��8�V5�Cz�b��WTg���@M�o�^Y�w�^axH��K���*�H����1���e	๊E��(���^z��Xת�3��e���|�B�p�wk�=�X&�� �3?5��]C��K9ޙ��Wx\�L�PQ�[Ų�fN�b)<S�p����B$Jv�Y��k�p��9#�O�poLA9T�4��}F�N 8y��C�=�X�|�U�fmpS��ۯW����W���+���
J�;9�7H*�ۯV����V�㉂{���|�& �'�gġ�~��j��γwѸ�?�{�������k �;^H�*z��\�b<��漹���+�X��WQ,��*�y�`�&&�Tg~j��4�K���#ɛ�-0�_�����,�pi�=_��� ��ݎ��/ܯY��ZjC<�Z̥'�]�  ''b�\�~ղ�<�UB��ց�m4g[��u8�P޶�:���5�Ob�	��]���Sk�ӸJ��P��Np
_A^�T2�
	lvt�|\'O�Nyu2^ԫI��%�g*��q�<->�U�7 �-Lo�~�\y��Wkם->BdS9:S�������*�۴��������U_�L����/ؐ��|����w��J�b/yq�~��\C󐂱מ�aQ�$|sF
j�s��Y�y���N<��SY'�Y�#�΂�HI�>dOc�_�N�E���(S�0�>�c��:�S-Y�K��.ˠ��-ܰ�{�	����I��Leǆ���e��*�Ƴ��)�2�l��K�2{>�-�p���z`�9�4����Yiϔ��9,�^�_Ĝw`�.�)��H~��EW�I�7'���2��>����U��:��x��2_p1�I��5|:4�C�^{����6����E��š4�2�3Æ�vP��XW��>�q�/�:f>�{~=oy��2�6���~�Ețe�� q�^��[3"�>��B��{T�[T����^p�3$�!E�z�h<���Fy�5PU�L�������7����㈸�[�N�}�Wź��u8�U�XJU,i/�yH����e�b��YBfr��a�gRh�%��<D�@F�x�aY�A��L�`��^�O��w���!���|{hַ����]=�ݮ�js#��v�����Iװ��S��u�K��������딟X/$�;��q#G�j�C� G�Աh*�\i�� �����#J�;K޵���hM�κ�.�J#^ [{����(�slE2H����Ae@�
4ڵ?4�E_�^�� ���N&�Xm��s�p��Yr�st%���!�n��q���U�<���D)�}+���6ԴIж"m+�:�	Z�s�nn�40R�k\�4@�r���d㊫N�Y㪼����:n\)��g[U"/]��պ��Ǭʢ�_�Hg��X�Gy����Ǐ/��9&_cx(�z��+�{�E��h���`��h��i��
�$ٌq�&F�����͵���-/:��SU����r�:�#�_h:�9��3$Z$|�E�jԏ�,,ͦ �rf�.�#�y�Ab��h�֩	R��C��M,L�ցAR�Z�E����:oy�Z� �%�v֊�-�:iE$j�V�n��uSVq6�Q��[���uZ'����*��Y�^� � �E,:oI��}�0�$�rjS�D�zN:^���Cٖ9RάgԶ�
���[!6�c�*gz1�4#����❥�UU�cU_�J�-2�%���P��L�3�/%w�r)9��w�J���*{N[�T=O��L��b���X�C���Q�9V�sҲF�Al�5�e�5[@nqΙ��v�QZ�D��I����)��ö��rf͛�f�摱�q9VFk֪&�Td��������>.��VK�^sZ/�#����Qe��
�MZ�E�����p�����ge.�бBe��E��J�}��/��A筋H�Ո�E6q]���.��8�!wj!��*<�f�0f��"Bq�XӼUQ+�
��h�hli�Ĺ���G�5����,�o����:$����dN�X]�iˢ�g��G�WI�����Ag���p��Ú�*rUc��s����E�4��EQ;�8���'�)��EZ��Gr
��ODvNpv���C���=l_7�O����!�_��es��:�����%�G�
���[!���&�!���X��y+�J�!�9�L\Y���ú{fJ�-J�7��ߥ�1��C���$�E�b�5�领9�$5e���pvVo-cz{{{:o�����=�V����=����������7Wڭv���!�i(�qpN�4X1�y�km?��9��P�_IɂF�b��&l��t���e��$��j�<�#K:ݚ��T�׀^�!����C�=pL  :ӝ.P����%
+E6���'��oN����>��A,�67}�V-hb:s����j� �j���
mX��e��{ZM�Il�\ґcB$Ckߛ��FZ��qc�1V����H��[H�Rߜj���F���x��[����92Dآ�Y�밵�pU�vR&�� �6��0��@��.�����G��OtIq�yʄh��:��GT��XU��R͜/��؂�<:�4<ȝZU���6����_XcBT� 3��=�"��	3g����^��vI�^�$O�hh�*�L�.:x��Q`���P-��#�f���@����3�äHiqLY$B�+��Y�$C��I�-�>��@}W��?���^��o�y��������v���&PO>�IUJ�S�-ѧ���m���.1�@�!�u;����ͧ?�\E��z�9�w�_m.�����
��`��5��0����j}��W:���Z5p�/_V������#������ +ƃ3��&��I
����z�!�û�׷�7_��v��DK�z����������nO�L@�f��BG���ta%��N�]ÃF�A��D~d2�Z�c����Z�7�e�@%��`��ʙ�#���)�V�����gi*u��:��ӧ?�����Ӛ��R[%��}�f�TGN��ϴ�5��y���8�ѧUh��t�i'�D򶰣����.H�I��ڟr�cI
1縒zH���b�s\UpB�(�9.�o��<J����Q��hkBIu��� ㊖{ ��"U5�ت<`՚��>��3�&��/�xw�5n'�>N���*8f��2@����>dz���?%42�y�j�P�%M�v-m�Ӧ'B�a�D�8_��Ǩ�)5���%sՒz�tr����U���j�O�Ng�#Hz��wH����º_���h��tY����1$����D0M��I&��y����r�L�ת���W���o�
�~͸�3��p$Ä�k��^��������B��^8��%8h�$�8����8��u�r����|�
/��Y%�����c����88U
HK�4�r��5�:��9�����������yLS|z���'&�O���u�c�)W�U,���d{�a0�W2���IXU8G
��G�бgց��d�!{H�7���>�%��e�,�s��t����,X    ���2����3��0E'N�Q�i̸a�4�'����ϧ��(q���l��˦�w��~���ڕ����>�D��n���"�)Rx�p�'5��d�:��::psyh�'BY����]�����n��!p��{\�0�<�,yeX�GX&[܀����z[���T?\�e��S���!�27��� W#�K�ΗN�T+̀hB��ùK��*UȚ��m�&Mr+1Q��kMr��뽥��Kdb�Z�!D�	~	 ݕ' k�$4�՘̜✈R KLq��&� �o��@���m/Cq�����=s�pX5���}�{N_�W����W�~� ĝ������ћ�DTM�7�Oۑ����).�67l�+0�>mN�������t^Q
&��y̓L[�=IF��<��<��Mӷ���c��������%ojx��&���,N�6��r
�<_�.N�[J�L�d!�ʦ�Te4��?Z)Kҩ��#��T�[W�"rKN��:m�?��_w�������9��v���j�f{����4 C���g̉�MM�{�j�~"W<������,+��ڢ~��4�V����Z��ܷ��!}9�S�
��X����b�~t5	X~$�hBt l�'�ӵld:���aX��C���c�3ۿ��������"I�MLL�M�IL�g��1�s;�'����[ʲ�i�~�Wݸ��Β;���sÝ��<1���i��U���V�M�'�:ϯT��<˝گ��/��[�����kW�VY+�uNF�!P�'ń�,rw���*]�h ��ϭ��&��� �Iu�z�Pw?��SR$C�� 7V�a��QjہD�E�2�ϻ��Q4���9�'55MH��mbh{/ؼ�U�Bi%�.����I`�O��`�f����|ܾ��)����j�CSڛúH��22�����n�I�Z�@�^�/��SiQ�����m�����������ǿ������=Ӣ@�A��ߍ���P� ^�#�\P�E�u(�>a�Lm�����&�!t�w{��Y�1�y\Äf�-^3�$ܐq��ɗ��4/\)r��*C�܆D�K��~��Po� |�ܣ콹�\;�7�ڭ�r8.\7��؞)D���� �X�.��7��|y9��\��M�a`�����~�� �A-���oG �Sݳ�CU�V��8�V��"⧢">��=�����a|NT�S,<U��JG����T���zJ$`�y����{ݠ���n������r-sTO�����)iL��:�#��-�o�z�A�/��;�"��&ʴ3�V��F��M�멆4�D���%M7L`�նg�Vw.���tC@x��|ǄwY}8��6dQi���,�`\k��Z�u�<H�S��!�#�q��p�����>7s��������"��F��c�L�n���!l��9�8�9�hO�i�?�3�m��x�$��n�r��݆���G+�e�'����@5�1����Hڵ�=.��\�B�ƊkTu)92� ��v�#*����`�Z/��@�%m���x[�[�wO��rЍ�M�?�N&�J}`#ބԅ�ȈX\�丁 Z�	�d��������hm�i��Kt\�s`�A�ఴ�8�e�pF�*F;f�qZ��s���z\�ťg�L]��l2q��(�������}ɛX�i�'����hD�����"��2�P>�;�E��������j����AME��8vY>n��*�|X��C�� 7�ݍ��:��23j�$]K[�:�z�W�+�g�,� h�F����!*8�d�������;��ۻT�u�e��F@mY���؈�jd���R�=�.I9.��(�/8���#�@p��ȵ�ޘ܅U���xq��ۨU��?�@�V-Wڛ[��^�Y	�����9�{�P�/�3g����7�����W@E��Y�@?r�0�A�8M°�ΨXTig8RF9��ڔ�|�5�e�ƥ=Ӷ̸���i��ò�����{��Ƴ*���3]{�Ȉ}AbA'��b_�����@q��ׁ��Y2B_���,!��f�� ��J�J���Wii�	}A����$���^�@ J��5���������uQ�!/6'�Ň!����X�����	��ځ��bS#^*K3/V.�U ���W�  ���xɣ%^PW :�Ъ��Թ�k��Y�.�h����0:�[�`ל��G�ʞ�ګ��1��H���0Ot)��)uJx�\��4�¨8*�yA.�� �HA���-1���LtA��q-%�S\[�3�/$�}�(pB�����[.�٪�tq�p�1�\���O���1`v�,��h�~}1�p����e{
^tf������⽪��#f'�����\sU�[�!zC����̗�����P�i��(�i�h�]^�/+�U{��j�о*Ca�Y���]|�]���(j��{9/����������m@߈��@}��<>��Q��V�3�Լ�#��p�x~^�>}o�66i�P�l�\���w3)�ܑ��i�Ϛ�U�e/�����+}�U�SRwPmA�r�ƨ�%�Q*k��]�� �иr '�0�m&�w��aE��a��=/��߸�)�l���B�j[�Mϗ��u��I$X9�{jti�N!��R��Yy:�>�ȭc�������8�`6nu��0?u�f��("���P$=�~�z)q��Tc� �p�ڽ���DM&~]���@x��ϚX֣d�1�Fj��A]�pq�l@�����ھI]`� O�J4}ݲ6okEI�)��)����f�\��,a�C>�,�L��́�����6W��_�p���@�v���d�m8a�6��e����o�9]�>8��ܾ{���A�^��%��[zH�7~eʉ20=�Fm��:-F��ʞ�!��[?3v����u����jQ*�u�����:<��	��P��"���:��M����
R��2)�D	�ɡ!�!<��>�§�"�X��5kOA��ܙ\;$�n !o�X_1o�,��"el �J�v��G&���܄���ѦI	3f[��	3��Y7��hS6|�1�'��wU�YeL�!��tZ��~��h�Xo�����E�v(�t��?oo�7�Co�nF��󏢓��v�q��[=l�ޝV��yw�\VN�o����:��r�~�F�E^�c��J�&:~bt`�C�N
"��U��E����.��"8���D08��R��Ɖ�)��j��-gv�Oq&B����R�<Ǚ �"��I΄.�El��I�D�U%8˙0�0Oq&�dgB2�k+�S��e�3��gy�E<*��,�Z����NN��cp�*�9V��0���'��>�|h�@��4Lh["xw����'X���C���D�A�`�Bo��L�Z��j��zr����~�vm���0ˮ�m��,���0�A�"m����o�e"N��@�+�@��K Ǫ��M����)"wg_�y�O�~�sN�y�s��`gDb"��J��h���[5�$u/@��]�5IU/���³"،n�(��`O�_�	0��o�Vנ|�!]�w_�R�9����>��фu�7kX�"��,��z<�0��^(3x�y�I6Uy���d9���!����8�y���iY�D�0��H(ƶ�!�#��a\;x����6�p�)��m�~V~Q7\oe9�+.it�8�L;��J�jd�Y�Qu�1��W3Y��fG���������"����h����U.��F(%E4�e}ծ#�4��r�Yײ�bz0��̚u�ga�~�n1y�隃,�q9��,gnZ,7l���'�����u�	f���DL�`Pnc �HĶ&�� �uL�%(�!bs�1U��Ĥ�3^��,b��ς6k�ȫae@��x^3���zb6`����������&�}�wp�{�R�U<�DT�̝��9κ���LO3�� $���a$���O1<���T��zmJR�L��WS'qã��%^tJ^w�>���u�AC��26�K�P�p}^\��8�8x��qy�	�sk{0� ��)�3o<�;Io�����k���póQu^�B�!�"+&�    ��A������~���8���}�f3&*A��s����d����=�qH�#����ֵ�OCt��7�K���e�� ��ߜX��<���Q� ��[d�ʲ�H.XNrspNߔΪ�S��ڴb�k!e�9a���8��Y£<m�J%�R'ZfcвJ�<�Q�2&�'H��[=��/x�$��I�������$�ꙺ�7�̑��*��6�˭�Oz'�����qu;��B��5N8��ҞW��++�N%��H��q��3��=�84pI��w{	����#E�G���^�y����G|[�x��v�T�=7oy��rR2Q�C�>F���R;�01�,zO��%t
���S`��W��}9�D���8���.4���u��9#1x9H��Oh�&2���z�W�`v)'�U���^�����M�Z(.n�CH���N���5������=`��C��-��v�{���Ϥ�=b���oq�Yb��Y�x���7����z7��a��5❭1W�&�D���tG��ū�|�S�̖�^��ޔ���j^S�d�j��s�$pj�')O1��E�p�n4ܜa�����Zym��eZ�i�fJ����t�9$uf����i4���Li9�͢�3n4���b&3���t�q���� '����>˕�n�������~��x�I�ļq�1��l�,.��+ʶ��*ƞ{ĸ2�7������ �"�̃yޠ�N��}�7��|�v��tW0Ԥi�$�ᬦy� ���i��h��WW�)���fT�T� �Ikg������;�io�x��6qǤQ��)���8+T�L��pA�ӣ=n�=���\P���&9�M�Q�@l��@�ʛX�3܌�V����y��B���t<��O:Z9�ۯ����m���Z2���]I��f�,�
�D�-ӭ`?f�0;����  �G����	��D�/�F`Ԑ�>kJu�I�*&P3�U �l����ZuS��vm`ϯs?*�©MOc5Y�a]�������<W���O�-)�m�Ֆ�v��?臭�c`UN�^������Q
T稴 MM�/�5Ed�6�H2u��R���%j��3u��ؤ7�g�`F��o�,��Pwyd_�7#�a�Lb��Xcg�!�8JV�3v�ql��wlU
��0�ĉ��:H^ӟ�e�{T/R�6����|F���l-�^��q���E�T�uT�k�6�V�$[��=m�� ��e�B�`u%M���=�l�x�!Ց�?C��G�sx`]��މ"�n�E���[Qg��&o<j;3�9��T	%���r����rR�;��l[>P�j�<W���� #��C���)m�nq�1[;�6'�Sx�\*����ZP󤕸���mE���(�26 �Qbj\�q!�g�'�V�{G�K��ʌѭ�ҙ�����-��	���Nn���J�_7�+S.������t�4qj��#P�s�B#0TM����UM�뽛�x7RUE9�=��������s2S�{���8�������|��pB:g�|�ڪӚ����E�㘢���D���K���zq���[rf�s�`�d´R"���.�f�%|*I8x�7�{	��)�BFT�oe�cf:aXnc��{��*�@
����{gɺvXo�W���us�Fٿ�����rZ�� 
6�Cd��6�Q���~'�����n�䰂�P�;Ĩ��D}�&Hߟ?����0 gr|�Y�96�K*����P	*\�~��P�ݜ�SF���]F3&�|
9��ր?~��}���䄰� �#�J)��ƼC��8z��G��X g,���EM�����R���F� ��k��#�^F�C0fo΀U�Kk#2뽋��"<bu�an.A�o(�\7�0;�B��1����b��X�C�Q�j��C��~�?u�~��`�@U�R���Q(��OK��y�h~�����s��V)��8���>���z�W�H�W�[K����W�����[��Ż����z˪��w]�ֿM�5�Ïp�U�wM��B���]Η�q7�������^����U�K��w�3�����G�/��-%��GD�\ ������U4p˭�")q� F*Ne�6L\��'����I�5�H������o�by&�SW��P �>�$�-���v�
���<�������i�xY��M$L�㕗H���ps��
�{I$��Ri���K_K/�}bC|\��۸3G])ᅴJ@��[w���J���۷}���X�P�X���6�0Z"�������tɧ+��#a�@��e %�j��|>��6Wݮ6�O?��J�7i�錣rY��*���i#3��i��?\;Ô��4���7�Rn�����L���C2q�)u֘H����p*?$EW'�XfH�n;�	k�:���ۛFo�^���%jpr�+�@�j�ԝ7���Z��Ha�V[94z�Ro��ܸkX ��ר��|��-�T鳡Wb����l�f����?^5]����0��(A��m�� ��������2�Z��@;Ñ���x�τ��2c[.D�3"	s冃�L��K���\�����ϥ���LؠB���	{t-x�g%�g���#�t��e9y��ؠBt�n*f�^X�Ì�<-Ή�$��IHر���߳��8�{d�n����$�uGj�����f&�F���?e|f~i�P���C���t j�ѭ��r��L]��v���Um��=Uj|^v���$�wkh�Jf*�[7��q��u���N�1<�v��&�_ʡ�>�=��#tG �%엟������q?(Y$� V$�:���f�vJ�i�x�3ZW��:�-�Z���t����?��M,��r
��nR���V��7��#9w�
�P����)/�`Q�?q/�HBe���6�yX������I(HC�s�ܤgP�&�p����#�*���_U�'�X��<�v�n��l����s�L�+l�A@B�L�_��_Ʈ}9Itb��two",��PxLLܵ����ڳ���]���������D�1��F;����	p�d�KM��a� �j�բ��R
�p���݊�_Ht� 9��ܜ ΜXb�(<!{D��;#��R���bֹ�Y)w���G�U�³!�R$`~?�H���<�b� �IPn�:�V�l[���ȴ_M�#΅Ю5#�p��,3�V��B=c@�B�u��΀$�������
.cIiD���D�:�"a	)�[�&��O-q��%L�MFV��,f	�,����*�l�0*u�&�y�R�V��4f}�4�p�ֱ4��Z3|9W`l{J'�\'�Z�ʁ���1e�Z�jc5 p�j��ع�ev8̃�&��w���e[m]w���T;��g�v��;9U�k���T� 0���O�XV�6ufsP�;��)S�8��G���V����!]�Q��#������nEsl(Ƿ�u��	������s.�2;������5��r�ע|DO�vA$H�Q���o���;Й��::�Ayx��S������/�����]���y!��{όs�w�9n^?�X�t\w��
p�5l�?R���Q�9m�&��v�����O�����D�*MnH�tk�>]u6�k�^ e
���׳�2J+�C>c��� y�� �q��8�QҤ���ì�A�ff]9������p���a��1�Px�� g@��6�F525憭����4�
'�X���w4�G^���y@L��-��o���!��9{G�F����# ���e��Y��`�i���)�;��3i��b�������q":{4�3�坢;������V�>��g�8��u�v1�!��Ĥ��Om�X*�|�$��0s��΂qR70k�G70'"&�4��!��T0�x���͢����{��u��.��wtOe�l����C��;��N�8'�[ֵ:�t^xGJ4�[Y,px�f�P�lYz"�"�eq+*���D��ʶz�"��+)�2�/夲�kt�x"gSJ��Wi`/E�og
7KWک{Ĥ2�)I�#�v�����@z�eNj���&��    ���B�rT���E*
O��!�.���"�3	���8�L*�b�A�+�n�_��&��@[�v�.������i��x�\>��_m�ӱ�=[E���Zpr�߼4~�֌���n����w�}ڜ�Wo�N�}.O/wbg��乞�>b�/Q�N�s���6��������d0�N�w�IE�	;�n���l�o���ݥ�*�=[�!�̲ժ�D���>Ρ�B�_������mdQ�A�N�F�w�@�v�o���ك��F^�,K,�.��,rJ�q�y��	�Τ��6��?��s��_�=iHfT~P��;�3@��-o�}ͅg��~DfF=��;7<g2;��� ��j�̡bn�.�8�`��6�A��Jt�ݸ$���){��0U�P�1W��8�"�r�'.�{X�<�70��:�A�<\�l�E|U�1us� 뛧lL;��T?Z���D
w�X�R�zr�X?47�Ƙ֭���c^�<�e<[��0QyN����x���9U�k�D����2��4��9�R�+�6xFDד�8D|�	�*�VC�=���V]�)���1��e>*��iSu&�R����\�c2^�`d��_ʍ�Sl=>��j�v����5E��7�wX��>XY������'�\/p���|e�N6���y���'$\$ue-l�����}��S�c�Aha����ʶ���K�����E�:����g�0a��)& ��M�����o���#&�{q3;!�I�H�5��b�I�4��r������P�3'Js��_����`c�Kϰ�Y+όp�E��[�~{)�N5�!u��]�aS���3�� ,�wwf���3��K����33�֙��\�q��>[ߤENB����	�N�<���ֹl^�a�@�p�������a�N�tj�z\��!�v�MSR/	����~&{9�2��y�|�TJ{��c�{����r2q'�8G����E=*�:|���E��u��p��d�iWUQ�USoS�c��^��A���m��J}�f$��F�PN0�奧��^�r;�Ė����ܫ>$�T;a|T�g�����f�1z�+-꫊w������`�̳m U�( M��`�m����`'[z�Z�㒝O(���b�v��K��2�n�1:�֓מ`�AeYX�C�`������[J�Ӎ=nY�
��@�� ����[��ނB�n�i?�4�Bl����%R;��������j�ߛ/�,���%�y�kU|�}�%��A=�y����o�K�M[#�r�u�H�@FCK�o�,%�ɖ����dO��ԩ�f�4>:��ɴ�YP��-l�ǔJ����H��y�j��|-F�%��P'["[֣B=��㕢l����'K��B�l�`�3��N���_Rm�"@e	7��v9ų�e���Ȇ0�7\,�g	%��ڇ�)����@�%�ՒR0[�x�Gr-��k��8[����5�Y�Qy�I�R�$�bZ���c�=�>�vP�Ӛ)�� O0�3����T��x~W�n�)�Bn���t�c�5����W�	�����j��T'��2��
�v� ��n�^b�����<�d�hW���2Q���Lq��� I�TD}s�!Y
�@C;��!��im�M�_��l�ik���l�Љ[	W[idæ�6�2�m��cC��� �tZ�Vu�����+�����N�߉v+Y��fӴ6���d��f1=b������~�yZ��)=�im*�h�'��h풴ӵ�v!7S�y䣿<�F�����L	h�ùЃ��6C;�=_|���%�dM�&4�zne�q�0p;*|ҽ�b]�Ո�j`�����/�	eL��YM��X��XdL�9����{]DZ��;5OX��!>1ƃ-z$��K7���H�nu�����
b*CݴD��N3��k�FG�.i#���k&
��h&y�Y]`��a�ʹD�P���1�L;��5�=��E7��+���v��E���������v{�mF�՝���۩�>;��ׄ�Hm����4�HZ�l��wY;�1uel���!��)c��Hb_	3ߵ��F��������o�YCѓ�K WE�kh�oE��H��o鬄P����p���!�9�`3 �Hqk�C��j[��,���'�ޡ��=��b�-�8���y��V-�m�
N��&p|T�V��J�:���K���a< �������^�XA.w@3����J}�8���C݀Y5���|�j�KLj �O�sd��Y���	��3MX�_�{:����cY�+��J����6wh�s=[yR_e`�
;���'�^X�� �D><*�Xᄒ���g�]�G�s�5�+ٌI�A�K$�̤xAfV��ٱ�j�S��=��";������Զf������~"dV����BE%��~������`X����}�x�^�_���R�l�����P�_:���P���l�sI���ϣf��8e���d�j��S"l=z���~<�}�z�xެ��kEH�L�Tl�]3�҅ɥXZ���d�5�X�1�(GT^�fq��/��aR�{غt���X ��e9�s�,:=��1M&+z҆��3�r�G�	r/7��Z��.δ����b�f6N�G���ĳ�Z�i*;��e��x=6�O:-�& g�>6/w!&�2U<Yʥ	�뱱	a3�a�F�6N�+�yY)5扎��v|�n���C�QL8}��B����s�N��,2K��q���z`&Ҟ��Bۨ@k������'��+����|�]�{�hO�=ڧ��E������z{����ɺ�!�9�����&am`����w~�nP9#��Q���U�d�t��LP1ݜl�¿��Ds�9i<EӺ[w�=ډ�o@���)�Q,q��o�1�Z�Ї4�0�m�B���}_$
�&��n|1б|�*��*�ӊ|����I�&U��(����|Lwg��gL��0!-���a�ze��-(�=	YěŊ_�U��J������VH����s�:��Q"q�N�4�|e���+�Q듴�O����Y��t�"�/�Kզ��QU���+Jl*׽�������j|	���x�����]�=����RںN��X�e�?�,9���Gy	���,��;���翾|�;f�Fq)��. v���l`�����2�_nC��ma��n���0sV��Iyv��$�1��p�a���|�[��%���=i�Nb������-쇴��7,��+\&l��΅�����U�BC�D�Ā6R�&�{�0a�h���qa�������s;���4��>��bΏ;W��b�T�r}��� G���c/�t�ꕱOA�	�����x���2Wfd�#�2S2U�\�13͜Hǌ8��q���B�I�^p� �U&B������S���: 1��!ΩՔd���-��nu�n�#N�AV�ḜqbŲPj��N��NG��G�,m��$1 ���{���>jr���H��2�fW$�wܝ�����x��F�T��?̚�@�Y�������@�3���}Y��,�����_hB�`���3fD�k�<�XM7#��S�e��7��d��ɒ��Ϗ�Ej�;vH_7zIO�Ӎn�y��Hg�C��/>H�$���-�S�v�����]@0���t|��1�)�3ڟ^t��Ș����LT��:q�H�<�C9<)X�i.9\� �s�%�.�&)[���}p�7V�nq�  N�.Ʌ���YZz�%2B�� mлe&IKC��Y�	�=����<�EY�(Y|	�����=og�?On��^�3;�/"~(��S5�4��q,^���ݸ��G�'��e���i�G9��U�nv)^��}�YT*�p(N=v^M���֩~j
y��Ho��T+D�lq&^d:.d�N1!^�L��+��������'��d�DWUk<���
�^n��q�|?��jCF��Db��y��+S��!��\L��j�A�'�0���������щ�+Y���T|6S�̾�K�Cޮ1 -X�kl$�E�0Ns����%�W��ѥ�櫇7��{�3    �dqH�(7��Z���C�z�rcG�V�Q;�CǧV;��<���["J�\+��JGp���n^���gp�F��%8��2��REz^L�3�/��}c:3 ,x��s0:��d��R�,Y�N��}��m�1�`I>O�(%ؽ����̊P� ���$�{��e��y:����'�7٧��ОR����r;bݮRo�ᘂ@~V��>��Y���qt�c���V�C������Ɲ�޾D��΂�,_m��q)��61`,����(G����G�@�@�p�_���m(�f�60����d<-���dU�;p���K��y;L�&�D^�)-�y
[9�ʭ�����6@���E&�W���x֦D@0Ȓ�ȇ
oS
����	���3�ȅ.�5τ�~W���J��E�kd���;_�C�Bn]B�9�gB��("Q;;?��9��釜��ِ\�!/��(��p�#H�������i��,�/��莹�����m�${�N�VCk�g[<À�\�E<M+ɸ�J�4�.c��8?K��)KՉ3�E�q)��1�]��rD�]�!���1�ȑ�����%9Ϭ���G�G��xz~��Foum�Ģej4i�vo̹��z�J<��ITH�|�l�ԅ��a���Agvg�WN�������39��׿\�óM[!��f��t�6�[���4����Gp�����<z:���X $�S���a�4�?�6��{������#��q�<6����̱1l�	M	��<�Y��_�:G��#� 	A�G�qƙS�K�cNK�YSv�s���$��-��x�|�'��c�%�X�/]���w#����.j=����+�%��L�O�m��:���S|��#���:
Ʉ�$�ƾH�G-UlR$ͬY
$Z�g��0����,S2Y��.��iY�x;hI@��8$���X �Dr��A3��&H$���0��c����Cކɚ�$I.��:Y�aomGǸVx�#V�f4l����&q�����4�o�&��}y�͡L9ru3����dʩ�1�0Nǔ��͍O� ߗ)�o�+k��R��D�Z�Їġ��>�ݍ�ɭIP�A��&S�2���%x���))����ǉ&7 �&=��fζ���%��M��ی����>]p�I���>����Z�*n"�~6�
w��n(P@G��C����	��'�k��3�?=^�l�&;~����,�9�a�4���	/�D���[���g��2L��R�*���ҏ[M�%��y��!Y���&h�X5���t�f�������O��1�������|�����������?���>>���o��!����?����0ؿ��/��>��������[���ѷ�����Ew�㧿?�_�^�F=��*�@}�w��㿣>�_���o�����6�oݕ<=��/_��ק��Q��~�g�C�����}��_�?��Q���~��㧏߅�P ��ԇU�Nb9�I��k�<Ro�n���#���z�ց�7f�4�5��˧���ox��L����+�'&��x���c���/��R��݋M5c��]�`��"g��]�ջ�! #Mu�� �|=�i�\l���%���.��
nI4n�*�(
g�R�G�L-N�����U�#Y��8�c�Q][J�r��20�1�3Z?KNm��W9z��9"Si��N����*9��đ�=o��P5Y�"�2V�>|����?}����o_�����@�����[߽���®�8��	�Yd	kB�������~��WߚQE�k�&c�(rΊ�m�����n+����l�D\ՐS;��y�v���=��zK��rJ!A���L�;�$v3C���AbG�T���d���/���|�^��D{S����5M�?�$��c��C��TH�|�@���)�n���zF*�.�Լ[�	����t#�3&�I��N�#\T@w�χ��O%��=#F�`��"32�`P7�4i��V�۵gI�Q�׮j�ީl2ú�rI��7�A�����ݧ���7>}$��j�e|����=��9��DN.v?��ٯOwBڰQ�4䷚�|EwI.rr����u����&ǳH�I��Y��cf96#���w���_U��`S���Z�?B�V
n��C���~��$LS�l6�]�0�BD�	HfH���	u�)�.��D��,�o*�>���}u���z��[͐����p�mwh�YS��@����2�����-�|w:"x��'�L�����Lr)A�g��>��B;a�,�c��[,e�"��1� uv	�K��m$�G�d�Q+P�X����Ο���>�i�_ܑ�,x@�tl���m t���@cV�<�� $��Nm������[��"��k��b��oУ����Z�o�6sb�mb@C��T���K�'���Z�E��n��J��|9�Bʠ�	��:MOr��jP�yѕq��/ķ�"�}�`Kl������8p �K"����8�/^�B�X6`�Hl�7U|%։�+�R����xR	O�$�Hh`ȘB^ ���W ��N&��fM��l�λ��E���4�PI{\������$���3����M}X׿����֟-�3����b�Ԙ �A�-����3�[w��
8NѶA5aQH����B�z���k�qTp��"c��P�aJ-�=�߾�����{ʉ������C�0ִ�Ȣ=z�8�*���|J��~�#����x�S�̅r���ˑ�/�_�<P�ߍv�q��O�r�p4K�qx�դ`�qlBۄ�����}hC�Xc��	�s$+�|m��r���X2N ���W�応je��,o�6�!��dĘƥB�>�t.�C�$�a�e�C],��iM�A�B�H�2a�G�gY ����"�S���>	=�@�S���a<�e1�\��pN�kY(�;;���4�y ��=�G��+x��ϋ Nޱ22|3����ӆcʹ�.���d�5�E�/����:�Pw�
u����.A+����3�i��~L����x*&a{6&�7O��uȌdrFb���	t_�!�zv���J���M�!�f�vVO��9mW윐@�8�upL��5�<� ����ߎ����sf��CmH�p4+8��`��Ǔ�YBQv��7��Ǔ����T�¾z�}�fg0@&��p�E�j�J��M�Y� C�<�J�y��U���6~�gJۿh��
��zw:4F,�����{n�t���ʭ� ��&F�o�p�="�qe��2��:�/�kFQ��{*�I��?�M��g�x����-�d)����V}'+*C^b�_�^eJ.�Azl��3�P0�(|L�O�ia
y�@~���i:���[�X&�$��X&���n��_����sMB�ua�fI�K�ū��9q雅�Af}����LLƬ���$R*�t`һ*��������w9Tu�n(�Zhg=x����4-�r��tL��ad����9��b{'25�25O��<U�;�����{�F@����0��8c�S��7��v�<�H���ۣ�L�K���01��tP��u�\b	?�����n�����1��J'��/^��Y�B*�Kz|iНj�D���{����B�oq:T�����z��T�q���Lɑ�[ve�y8��E��όxfK��}ȳ�[��:�=��-�B~�M��2&�@��vq��'��'��"6�%�M�h�2/���8�T�$�@�#���S��������e�E<�82̅SM4!&qd��4*��[z������%a+b�̊y��ʴ>��_��+$�F�4�̙��ϦB¥���5Eފ�c5ݍ�d2�uJ&ùD&��m��vp6IX
�(2s�i��hJ���Z;����z���>��/	�:q/�	��Ny�2P�c�{:CP�0ׄ=\�c��lz���*���v:�1ƌ�%��J��j�X�9���z��4���u�
�Q`@m񠆣�v�H�::� <0�~�)��=�z0xC�J��r� v;3-]�����|����    �-ڬ�����X�09���	{ǃ�X�^ ��;:{��,IOnlG��3�ۄ��++p!�.Vh��I���{��4]O��.���KX�vX�b�߯��Y�YFZP+Lg�fe��JJb節Q�S�!ۆ1z�c�{�ߣ��0(���x��]լ�V�J;�=�q�a2�Ҡ���/{�	�;�!���3!¬ش'd��y]o�N�k�Ȩ�����Pw{�*�MmtK�EX�j�<��ϗ�J�NO�ڠq(/���P[�ǚb���Es�'j���voD aZ�-L�7�y�����ys���I;)Լ?��~I%qp#����Th[���r�3kh��w�(�����]�o���+B����#��Px�Ǐ����������?����O���}���.��5����p�(Z��k\������}�~�9lYE�O���-)Ʉ.��XHY ��bR�����Z�-��>X/��^�,�]�e���<���y�����4��z�7�z�M��z�*Zc'�y8�%�'��-����t�?�u���h�r����a��k��d�"ݯA����Z�G���N����]��ę>�p����p�w�{Ay'|�E:��%����ԁ֋0,�t��<L�����3w� �5g��8�Cә��!�P(����� ��N�a2`�p�Y���:|!��C)案�%=Lz� ��)�%�:K�a�
���c�g,�G��� R�����<d%2�KR�f����~y>	�R����� H�yދp���p\d��3幑�=$ɄΡ+�Tf�O��˒8LU������q1�d�y��.�,x�s�yH��y��BН�0���$;kZ�M>r~l��E�s��09�(����^���i� 0�ix���~�?	�R�p����V-2�?5�#���#�<�!y&d|�h��)��'�/�Δ��p�YP�c!�σ�nKP�;���!����Ҿ0���
���Vm57���B�|��~��!�l;dg�B����@:���,�x.�*yw%�yׂ.��ָ�H���������}Qhν�t�	�[ �.��V���j`͆LC-g��6���bC�p��_�{DP��?|���������|��������>|����?�g=)����~��>~ ���3��7�Kju��߽���� _~��_���x��폟~�.���ӧ�S�cEh�(�Y�������R���##]IH=��S/�,�P��l��N�an4�ێY�M����a���ab��p���ݟ-zǅ�K�u�A�g�i��0V`��oqu?YM`��Ӛ=��b��䕋Lø��nf.�̢\��Hij��<�WP�`��-�'
�M?�A3�I鋾H�"Lu�,�_0�R�\�TA�h��ss��`%!;p����O�qI��0�-B�,��C�LA������b14Da,*����@�y����g�~�r�3I ����|��U-��,cvj-/�H��޴�(�ѮE�k�=��B���^B�G���T*�R�΋�HQ��nUx�@/Ѝ?�_���H���%�#����E�ՙ�W�:��#�l졌yky�j�TdX���j1�[��5���4
��#<,Èݣl��
�;�����r�L�*8����Y�r�K�sm����	f�|Sy׍���
��Ӟ`ĨS�y�K��%ш��+��	gÚ(���,����\Jy2<��k񻌅��>��|�RtDSѧs�l���Vq��/���K�_m}Ť4�,�;R��ߍ�0�a���q�2�#l��~�ϗ*�m�8W����9 ����abK\H�^l�-�#[���44*ɖ��xs3�T�� ݲz�J��ïv�m�:>�tXc����vS&��tw�6���B�^�G�,�_�\��ꔽ&�4k�wkq��RA���:��zl����y�l?g��yU?U"-PK���=��dQ��ؙ�	����r�MTu�h���8+��9$NS,�Á�0I�j&H��v�]g*|�t�k�'��~�NC`�����q�}��v&5�3�M�[�D��n���oX��(�a����o��E��en⊑�=�Zh+D�g�D�����c�\.�$}�3jtaB?�U5P�\Z�eopBR��xn��fF&�-��7�h���]�W���%3��]��L$`�Kh1`7l1���l��3�T`�����[��C�
����Lԋ�2ɠ���~�H�DӮ'����
��m��SB�&/	����8Ն�T�*�7����ݑ5�z�,J��*��O���^~YW���0�X��S�a��(V�G������|P��у������-���Q������1���C����?т
߅��G�+����?|���Ӈ����Wd<��/���w��܍��>|���!����C}>�(۽(y�08�����4Rf�7��*
`��q�<�e��]��>D�@��t>���P:QJ4h�
P�	 �ܟ��J���@V���{��4�m3��������=�HF�,��D&Z+�>k&gv��;��2�ڤ�x�2�K�*u���R
/Oc�I�"u`�=#C��y3G����[��h|6I���-l�c���	�p_��Zݨ��j��}R@!9��/F�D������n�¬����5[�-�a�^� �J�������dt��^
^Z����9�T����qdpsz��>���A�Kե[`LͣY��R��u�,3V~O��j#�$g��:F��YJyO��<����OYԣ�N�I�hj��GXZ��>&�(-:���T1���X.X!�
x/�1�S�F2#\\-R�M�w�EN>�R��L{`,�H��{��,�,+�O��s�^�yk���Ϸy�T����v0YvZHMT�e�ҕ�����gKLl�PL<�|&!ll[��`�;�b�	��&�eF��gv2���+0dT��r���0������aƝ�1'��܌�ȷq���	̣\��@�]��aw%�Ы��2�\(ӗ�?��>�{����c��;d��xl;1��[����3-�ۂw�HZ��}:/_>�8e�Ũ�I�}��v_<z�Aj�%ռz�as/���uP=-��uu�TS�"2�܋+j���0[r0Փ4��@ը#����Wp�u9���5�A�7����'Z�ڲ���ӊ�Ҡ�N�~�r@ 	"�d�徭��B�X6qTm)�/�u��6��j{B�.WAm6ppۂbH�U� @���T����`��sJ�r{��6�dt]���"��"�U�2&�dXPH�$��7\P�7�cw�����_^>�� �������翾|F�J��w�0�N��d!��A��b�f)Lu=������P��N�v��B��p-(�2D�P����8�a�IR7�e!"�rM��#4��p��)8�.���`�#�W6�)pX���[����n-��5��������z�y4M�\�?�茁]t:Q�?�����xp 5eȃ�X��jQ� ���i�9}�7��K!��1B�x&�a�AEh�d�Gq��V�G"w�øW|nυ�����~�Z��y̰=܂��|�Բ,��r��^x6U���$<�n�i;��f�o�}��o�Ǌ5s�g$���U��ϙP��ζ�SN�R�����_	��j�Y�B �0�2���eL�>�eX�%�mk "�{Ȼ���~�� �8�c�q�U�Du*�?�Ŝ�L@�m�����g��e���|"$S�9�����N�e�V4m�a\j'�t4��alR�MI��L���!�G�Bݦ�2�97�Sݽ!���=�@{��m���v�`�<l��L��0��ٝ�*6[�q�Cm
�z�a�G��j�a�����n�vKB �L� ��i4qFM��g�P7j��?���Rg3�{�������!�ʋTÂ�F�05������T��7Pڷ��-��|$-H�LY �hG�H�+I�׀��V F��������Ņ�G���B����b���_nnV3��� ¡*�:x��K��_    b���S��@WT��x��q��0�(�AJ��v�R��!Vn����q��#�h�L��R	�?�Ɗ��2�/���鶱L%
dd6�$�
�B����(�x�'60�¦��(1+"��xP1���X/O�:�h&���9)��:SI=4�K���;We�#���#,d�t��t���4�	]tI+c\া�u����m^��2D�n�.W��u`w�>H����ւA�bpp�Oo���1�"�M�Rb	�-�0ѥ<ԃ�E=��/�:��̏;�#��J�Φi��!%�%f}�2͐Ipu�R�l �v�"ѕQ�q��
�EiN��_%!ԥ[�p4�R�4����r�T�����eK��J���z�P�1r-�e��t�oL��nB�C�.�W�8c�B�Z�U�D!���Ǳzn]�'
���80�bX�� �L��`u���F ��ۀ�x����r�3:�� �J& ���� 6K�f[b��v �;������[x�M�9�0dnC�����ʊ�����vMFt`(l����h�Z��������3.H�"��ͪê
��~甓Y�:��\�,�<BCQ
��C�(4n������|0��"���c3�5�B6	c ,4q�jX ��A���-4��jP�|�'0���%U�0h��W�!�0x1�Pч��5~5�z���C���@H%^�0L*�a�)�����h������X�+�L3��f�*�����ƥ�YӴH=W|sD�5V�H�>�uS���zmGT���P�gs������C��gu ���e�;�e���8��@��67�l,�+m��&/�����,�XIs�R1�.G��\�&,&��f&yΒo 4��[9�zr�5�2�]e��e	g7�P�8
����xe�n������h��y���S0��vƑ�k�>(���N��퐗E��k��X�����F��C��ds[�� >���
�cq�TW
�$Ԃ<�~|(Iq��r��rũ��YfE�&n�TT��C�<.��i74EPg���L���b��a��rv�B���oq]�('�%�s����LD(����ف�jtL����3h\L� ����<p��z$hb�����2�������o��6\��JoƁaf��!4Ǐ"ƹz��Qe�q�'@�#E�xK߫7�F��>�J�ֵo�mo[g�d��(�q��L�,1�|��{ض�O]KMhq����4!C(1��)T���&�1'B�o� �G߂��C�9�u�5g4�[h9��P��C��{W����G��K�`b*O�R�ȯ�KӏQLնY�ۣ��2�X��Z����� �9B_B�#N��\"�؃P�P��H��Ed�����r�K��c�2��U�^Η^K06�I�ڨ�`W�O���æں�`)�2/AW����T��<�ݒd������F�w����4�`�W#�)"�3X�a��uu����K1����H�[1(KMSǀ�i@�]��I�4,���zgXO�B�J�*>�#;��Id�i4�I����,2Q_#=$�T�=�}�J�4V�̺������;~i�� hE�� ��f���1^��k/3 �*Q|lg��뎒����T�-��(Ԧ}׃j��*P+P���8�Lg�q���	x�R�jT�&b�4���ʹ�|w��qqi�ճ�9�k�ތ��J�%�Ҽ��\R��==��j�Up�|'#��U� �Y�s��Sc����4�|��[����W���:X����;��^5pT��LjqROh��w���nuk�^ӇP$�����_A3=h��PZ�U���>�BΠ y�S�7��#��C�f�^�\��օ�ł��{Ln/���q5j-�2���v�S�UAH¬l�3U��lH�k�ⶊ��s�ȪSp�EX�U5�0.3�3�l+�h��eP0 �ʧ�ŕ�*�#�鈻����L�Ƃse攰<�tlbiLy�ˮ�\�>��%6�"Sn�B+�H4_[�����\e�6�0��4���\ �����
�� �J�(�U��Unƣ����&�S��=z�e2��.7�^։�`��8j�K/Ӛ�t�d��)��v2��ѱʔ�Uժre�֟���5NK,HT_��\��{�On�,�����h,�b'��x=�+�o�<w��������!9%4��+�*3 n]@��{����"�8��Ì����g���V�'"}ټ@?#Y!�� ���v�2.�~��~H�RoZm�� j�����J�m?�8�n��+y��+
����ȃ���b	�D�:��H�`K�/���[n�Ά�00������ia�!P��67�B��u�J��RV��f:V���b�
�:!���P�ͭ��GjlItu�8��Bjl@��IW�ߠ��'�E�{�K�o��.r�Vln+�� �L�8��5��U� L���j��J������W��1- a�W6(��t���u�ٝ���EQ*�`�<،a��v>"l��g?Ĵ�NQ/���
ȭ���X���hjV�'>�RJ�`�5��2��o�Q��J�P�l��'�U���c�`lߌ� -�&�¬�Rjq �.�_!�,��RQ߰�*x�M�X�u�=NM�5�+58�=DhG�9H��'�{��*��sL�����
�x�Y7�,�[�	��D��s��?�,Uro=��+]]%ɝM`�H�aP�[��$O��;)
���mIu��R^��h�}�7��*[������T��p�N��W?��b۷��Bh˕�����MyC3�0�v��2S��c�[�fò�R�[��ߎ�㱣���𻢡mV���>�X,}�$\+�RI�;��������W��{/�7}���d�=�ݯS*�J�T�b������'��wK�ּ9=��1[+;��v2)D���u�e�$y��q+�R_�y���s��ik VH^����s}}'z�R�I:�\�tQL���O�/l;��&�'Āf%���Wv�1�@*2�Y�O��+ųY��Mb�y�Ѯ>����P(o���M�������v��*�fCvXcz��gk	#���ӵ��a���Ziυ�~�@���=�|'��㖝�C��v���s�
��w9(����[_箳�&
�j4�S��R�j���ʐ�vEb��������>�v�!�|�$��؅�R��D�wGq�f
.,b��A�i�m Ab�pjB�-_������Of�O��F��4��6�e�],a!Sγ�\h��򠯿�bح"���Z��T_����K��9l�őDH"y��A��5�Ye:�Ew��Y��bh �8 ��-�}ǃ������Oˁ���1co����X��/�g�;Eo!^c�d��!���!Cw^n/?��Z��0�0s�&�(L$6�e�*�<qp��_y��6�Cڜ������C{��oBp�s�]�9�8W���H��F{/y���v$�m�C������`Z7�*(����@����Aps��D*���H�X���<�!����=k"
�Nz>�Q�[H�2��aPs��a�$��e�$V���%��B}!��|�T/c�F1|=�Fin�� ȍ�T�[̠���B��i��2�"'�T_?<���lI�R�Q�j`u���| �+��LJ���UAO�2L[�^�"pU"+�H��Y�j��^=�8veД)�ԺK-�֯���,/W�P!ӧ���#���Kc�`�RK��e��8�4Q�VZ�����$�ʏ���6ٴ��E®>�^����_bhx(�]��*�Sʾ�8�TQ�l��FD��V�+�Re�{��&6�b����Phժ���k��A���A�ZZ�I�м��w�r7űB�V�K���3oI��b�ѝ��D���I�P���ѪN6�J-�3jF۬{��^�p�,S��!ey���oX�
���ȹ��WiጫϤ����9�s��[���LQ���<�O��ɻl��q��g	ѷ���z�H��-��n�Z�
��& �I�MU7��)O�������H��Q�ԣh!�X���G�f�'e������0�Ybɛ$ 7������;�Cbm���2���;>    u��K1�#2�g?u�����Q�`��9�t۱�vY.�|&o�S�Ʉ������k����!P/R�D���^�n�����m��3���f�h5���=��PĐ�Gs��4����Q�V��S~޻�a���&�>����f!�d}��+�2J���]��x�^��i�66Q� ��j��)3�Gs="�͗���l��a�_#�`�L��J<���	v�O����LmeJ#�\�/c����o��T ������k���i�E�/̓X�����n�v��<�\��ץ�j�ռj`5�0A��m&N���Jj�W7aP=!��'�(|��ч�w�����K֒�н�{�����a�1?�,��<���m�cX�8�Un�Da3��qX��="�[]����;�n�
y�ys�׻zk*��3��!�V�X�p�#E�x�Bt�K��Rrg�6k^Q�1�����P�k�+)F�)�1ay	�0�ژS[')�\��rnA�c:
��-�������cU�D.�l\���~�G|\̟8=�����n{���a��$�f��X1����FE]X0��f>��G�SI�I&T�<��q�WH4륺:L�.�����oEZ6mY��Ȼ(���� �aB^�����vw��k�p��!��Mb��r^͎�?o�$�klN�u�
��j��l��_�ק��Z�]�L"mq�I\�Q5C�#B��i~rh�t*�OMq�1��%й�F��<���L��%Ϣ~i�`�A�n�1���Oͱ>�Ճ�|�1h{���e�)����HBU�d�alK���ő	��A�5��f�{D�Ճ(�d����Ɗ��cP�� A������m�6�x,��(K�Y�1��dI��>�b����s�����qvT(iC	B_��u�1��{�@��+����P����m���z8u�/E�{reesC��H31&�_b��5��1�� ���,��I������k�����`���_��4��Y6�z�����P����(,4ېÑe� �6!m����Ǆ@�~�Y$�Z��e\�D�ڢ(��9�<�"(�K�=��"	��'h5d�9���'qe�"���c��g%� ���r�֒&`�<͉��^�QF�x%��0�5[���]���t �ę!�J������Q!���;�"��9eqB���� /�_ĝ&�t@!��QI%*�	�����9�L:�g%s�7�T��iR_f���j�fM��X6�u���C�|�?�8@fق׋O��iA�!��(�ǵmpUq��
�!�j�W���)���6&�i�G�\{�4���>&6��Ġ<�0l{$�ﮇ4�Hp�m]/�.?"z�n�����<�_.��\1&8V�2j� YK1�h7�
�LE����G�C�ZϧD$�����^���� ���� �SuX����8�R�*��h����Q�b)�i.p{��8�{v���ַ� k����Î�d;�X�JI�i�2�4#�0E�xhd�B�7��Ba9'&X@�����lH$e���Ԝr��|	�h1iG��D�C�L�Dʐ� ��E̡8�/��S��E#���[v� �K�	*�i[ѥ-��l�X�d�C-vZ'2T?w���������_2��ͺ~��U���*X�|>����J�4kIWr�e-5��E�庒��D�����O
"����?�������f�w�(*Uo��[+�7�??y��I匣��C��Jy��� 6A�#�`ZT�� ���.x�֧�֌ú�ݿ4\�'�y�A�<�6@Wfa�K��jx�vJ�h�"\�ЂTΑZW��y��2���T�D90���I@<�mȈ�&��"��9*��P�>{A!�YlTh|BV8���.J�ހ���#�2�ߦ��B})�?�"����	_C�ݟZ�N���4�*�onѡisBu�!�ZW����)�8���N�=�6c�p��)�t H_�W��Q*�@�C��[�w�|��k�t[���Mg�7/������.Sޞn�!�ɖ7�,�;�C �9 ���B�I�E�,�P������47j��a�#x�#�HG(�@4o���n.I8H��cU=-��
;^Kq�;�v���)�"���NJ�����DD�\|V��V��,�4���f�~�.!�ހ��V���(��J�T�$�y^>��zR������|aZ����0z��}��spx���o�!����1�_�3�R�����@a�h��0���)Z�FG_�A�dZM�j���Q��ԇe�TMr��o�Ҫ S���GS���LC}�J��O!�i�S�X!K
���f6�XRX�AJ�AS��w�	4W_��cM�@�0S�]���.Q���*�t�3��WRq�Y�;>E��M	�������{X��*k���p_�m�/�G7!T"�S�+� dM�P�<x3�>�q�C�c7<4v�P`��t��Fȿ=���B�A��@��������h�G�U�r�����A`H�ncg���P`���k����]R���iEl�S	�&�椐��g����{���E��X��� ���,FZ�f��S��ϓR�u?���W�㙲�iw:��hqL�E��g���w��^R8���� f�OD�6Uh��}uSp�+?���<��d�,3�hV"�G]�iWĭ�L(�>����O�H�?��Ha5)��0�]�d*��a�HBf-�$;Z�q4G�S�IE����cg���^�Θ3x�hsX/���y����������Whѿ��95&�����L��)h]x�F`0��i�þ����0���v�xI�傡���~�s�y�m�wqA�v㘝i��8���v:2�� ��rJ�h��@���ID�űK�夰>��c}������=�KpSݭ����[�a��\+�(��i,-�ت����������t��GO��L��6v�'a�h��ީ�!7B��pU����g��D���
	Xz�'���/�^��?p�0�.ȴgȀ
Y}<����?ϕE�"�w�G,['�l	���<�=����g@)yP����,����g)HHҨ�u��厘8�R���!������'�|ħ0B"�Q��ދ�C-��?����#̛A�=O�T�hBS�@�JD�
�_ ه�wJ���#����_��k["��C��=�5�����}M�10�G3�mE��&���Qc=��t��c�1K��Q4=��I����矝�4���,�01T�������L^�ʺ�o����a���OM�����h�qaP���8���_kv�f�ڍ�{j�If�LSc	�4c��D��N�:�m������T6�@�s�뷘w��b3n�t���`�YɖI5����%�HiM<v�-GO��9�Y��[e9޾�[�C�]�dXk�0#?3`,A�'�D�l��TNRY��ǧ�ZT�>����I9�������'^S�H�_4�M�E��+����8��/��߷pV"e}2s��X���1���}[�f`ӈ;�q����7Kd��|n�����a#M�P�*�0k�(���
��mZ �$C�Ci��vg�Hw|nz#��c�!��hF�h�T_�zn����6-������Bڭp�<<<���2�ԐĝD�hLrG:%��k��~���,~SBu@�V�e,����
Yl�,AZ����e���Y�j�OJ	8z�e�T6����D`�X�I���y��(P�L�y�eg�� i��|W�H�=C���������2"�L�e��@)�h�;Ґ��%�+��X.����NQ�FSn@<.�@n�h��^>����8��A4�0���I�ga�����q�B6REz"�Sn<n ���&4<99��G0USm�+�6�vQ���>mmN�1YEJ:��r���X�1#hw�c&��eb6!��Z����)�]�H\��RB���U>�6��C�0���
3ע<����gUN0G,�Lh=�τY�y��Q,hnl;�B*kq��_B����m��Z�����������C    ~���ܬ˻���u�,�O誧���2�ej��9�%�M%�]��
~Q
��wX�_�2Y���;�`~��?Ӭ��v�̔�hü��$R�c���Īq�FZ�bq�e�q���Ğ?��9M�-���0��	/�o��g~����e��$���V������=5۩s̒���0�����a��n������q�0�k"�����Ww�) �z�����gQ8��s,`ŵ�bV;�h���_R���faZ��~�̇O�:T7��r#|��M9�L5iM#�h���`�yP�
�W���{�WZ�\3�8-g]y_�!��	��$.�nQG2ۭLw}����R�g��hO�4���b�����@sI�4fT\�/r��ϒ�"��	S�U:t����[]tȰaA�a�w�V��}�%Y1?����X�Y�[���AY] ��h��1r���g��o�%?1~	M���g5?i?��*A��'zDL��oV�6����X*��Ea�Vt#eXf���0mZTIsj�B�
j�ͨ����:��O���z�[U�DP�.
�yT����9�hH����B���a�?�o�f���A[�a0t8�|�_q+�h�w�T��}�],A�2I_Y�B��e��`ǂ9@�`�IS�7�k���2�&2��`�7��LA-eXF�$,�6�\�63��^_ ~�m����m��$��oM��ڛ�V�W�;'��;$�}��g!�˳��my"�".� ��b�����$�����CK�tas��R�o�AKH�,��vbS�� E$p@򨃃E�!��.)�Fm�sh�NbA�*�
�[X�>�Yd�i41��iX����	�6����BL�����F��B!3̧�"z��b�����}�rʱX�Rn��=4��)����E"(G�K�U�`�U�$�H1��(��]���P͚�I@�/`��.M�v}�����V7�����u�e
�;(4�)�e���״��:�����=.��v̐e4�^Jrf �D�'>]��/�
�z��^��;��Zj�9G�f��	�x.�( ;,0���omqi�c3Vp��� `�:P������{|��<��$SR\�+W��2�8�,P=5*h�Kn��Ǩ,?8�;�m�`�Őԋ+����������sS=���j����$u%Ұ+�|CI�g���B)x�0G?���;�>��H��~�Q�=��n�B�[
k̈��ώ����dRUAXFI'�<Z������X�dz��7=�b"ǎ8Ϝd�6��v9��DU3h���BP�<��P�ve�Np�E��E��C��o4���$���Id��V��(\��U[����t�V�S��0S��i��q4G;��H,�2%I$�?M�h�\���)1��=�M�B�As���18kV��lgac&&n6��Fϋ��yn^,cka�����75!��NT�����I���Hb�bc�m�����D12�qb��o���Z��Kz��wO�"�`U=���Z�@c�z\$��I^7�2�	/9Ax�C�N-�è���)�wu0?��-T�E�"}�!��?��Ӓ�4�.a�N��(0�IC�Ų�x���_k�%l�P�����8*�G����3I=$cb�.�w��pg�MRm�eq��Q�Ԥ��%�����YȽ�U&��4�k3�<��#Ό���j}�y�i�J2k�k�����z~D*9:f��	��YX����Yx�a4Og��ǐ~��=A,57F7È�mM�\����Q����O?Ԁ�\�P�5B���h�B2�5�.`�֎l#>#a{ۆ�š�pK�X�V�!�&����#m'�#��h�a4)C��~ӓ�",m�/��9`���Sa���D��D`����Kc�Y$",9�y����V ��jf��OW6�����^��;�h��;KZݰ����}I�3�t�~\�}�<Q��8��0����VK<7�;�$�
ީծͣ�b�Z���g{LԉAiN�Z�@F��X�_Y
���H!���W�G��X�9����B�۹_�%�6������p�A�Tą��3���#m`�DE��Go�IFy�#cAZ���)���&�[�H��M�  �@!��������Ma�u`�[�d_�o^/`�����h>��q�
���:G�4���,�61���/Uud������̫�M5C?x����f
q�I�<E�L��)[g"Wy���L�%mA.�
��?:�iG\T���&T�[-:r�i��@��HE���5�$���x��0"!4�]�pv2B/(��'���h����]�ڀ��\P�8���r<� ÂB���sQy�d�4�gtm;�8�cn|)Z�d�j*�B4к�՜�ߤ2�p��6�hR��r�eM�tw�ڒ���4w�wĲO<"q�*L:-V��,z��.v'h�Z�Ñ�W�O�]�]�����50���x�/��W0L&Z�yf,�"�5�)�.a�L�q�1B�og
��L���}��<-T�	^X�.��c��gZJ������r���c7n}��|ŧ�q�r�����ѫޏ�I���]f�58\fy.'!�^�I<�V! ��]h�p"���h�w$����R���5w�zJ�RA�.��c���F�H�i��b��R0R0�/Yʁ×�G8��d_1�%��5O
��M���,䭷�%;�6H�)QM=@M
�%���}�J4G��H��y�aR\����}�R�/\�b���}M�<�4�2���Me �
e�z�C�p��k0��I SN�ʕp�Z�^(u�"b�+7S���\���#�S[��������~�o�����+7	Өn@҇ͣ��[E�
UV�+ܐň��w�z��k�$�;�?��]H�v����� �3�L��)Q�M����x��vp+��`1;O�M,�@����T�����A��9mY�(�����$��4
�%�2�������8Kc3��֡8�s=��
$���LQs������sPⷴ����}0qkdQg��5�Vu I�(LE>��� ����b�t]�SmGQ�_>��Ӫ-$��
�P����&̣E�S{B�۴�i��_Ұ��.N��f&I	-�A���)K�����}���ds"a�}a�W�$��R�9�!v����G90����1�xnUPd��B�_>�	�Ւ��ƃ��9S��}���Ea-�N�m�:@%�#�����zF㪂�矚#��������Ⱦ�8G�q)P9��,��~@�r����;W�ls��vÍ����lj{�4I<�+#�Qv��=A���Hlv���Iz)HWiߠUPo�N�A(�ڌ�H��Ϛ��$F�d����t�6huTt�BKir��7�bP��ƔD�������*�<�zT_�u���T�έv�B6�jm���z.���X U�"���� �*�D��н��Ro���5S��G�I�q��Y�fB#�l��>\+�3W8	�y�4.�r�	{��k���E���dM���eH�·2
�[�sklBxafh4�0�3����8�KE`�W�1u"8������n2t�Xi��I&�@���D�pj��fK���U�W��BÈ�^g-ɭ�.�r�D���P��|u������(�:��x�m���Fa�`*S�6�nf�v��3/i7���뺩}|<��!/.ܝ�Q�%��������<z֩3S���b�z��h���j[�}C<\DOw d����?�Y���nw����tz�zRK����z 
�N�O�o�:,#��׷g���	��֧��~t
$ s;�LךW���"�7����Թ��Z��rX��B���0�v�]����:=�]��C}��N'c0�i>_�����|���⃈���Q:�ڠ��D
F��<͗��H��ٽ]{aX�*S١�i4a(�l�§e~)����K�[���y##1�%{�������y�������j��#n$�:T�u���9�������@&��<Ε?�    �jeq�|ť�B�S�|�-�+�;���w���hF�{�ј�:o�jk,���hYmH?�R5�7�Y{�Q@����4����`�����d�,�9�����y&A�黋fq�l�=ڻ��mױ)w ��'��'��n&/������3~D�"W��>;N���vZ�u���6cjq�]��vꇠ��w�X7�<L�&��,%�0ʙ�W�ȼz�;��ޮ����=cA"��m÷�(Ə5@����	�����Y�)16{�[�y��"����\� ��������p��LH:����s���K[�1m��f���V�<{ze��
��0���@Q��,<��.-�
��f���S5?(Bt��M�-9�c���P�}�-C 1�r6������d�X'
�S��8qbJ~}�����}�"{y�[��*Ԋ2�QJ�!�K�Hp�������Oo���qwX)��_m��cߕ�	���Mʡ��';�! J[x�	�|��y�� f�oNHg��r�����3��|1�g�����/ʘ��\�g�v����������Ͽ��F����g+��J($�Uƺs��b��v �V�u��F�OvO~�BȜ��A���m��"�,>|]�HW��3Y���ڠ�+��i�E$����~\Ե��uB�p��/�J����刉sS���<n$���똚���_,��j�0�[�����r�E�/���u��aej+j�G�Z!�X��1�*m�
�7<z��4S�Ք�MyJ1������X�+c��5Uu��`=z1E�T�������w�<�3Z�<�|>O�7��n~?$5���^��������7��%�v�t�4�E	S�ۛٯ��7���E���+�9k�V$�գ�`B^���/��y[o6�:��8����JP�ΐ ��nB*���g��4TB��]Z������H��8�"�~6܌�:�������2���z�#����Q˙�A��
'����������?��WOAs�Tm#�h^r9$ E��C�a���Ep�/��#v�u�8,�ǈ��,Bd���^_>��S�x�|C��3��Yⴐ�5�����.�����!f�W˺��z�w��z�^����a4ہv�6�f9k� �:���z�Z��-�x%h����)��R��
�#'{�,"?�sW�^*�QT����"��^�
Ί
����և�TQ�|�I2��d�z��3�CG�,�5��d�ԫ�a�>V�<Hi��C��x�tYv��<.�I�\f����w����������b�"�v�h�q��-�(�(�N-'�8�k$׻�> cd�o���#�q�Ёgr�E0k�����h1�d33���H
��E��0M��Z��8�zg��#�z��D�����M�VFn��735��{�=�Y�8�?�V������m���G��'�O�2 )���X/IagBMB7&�#�?��ܩKp�m��������
rZ�>�)2�-y�3Z����w���P��Ù� ͵R�ԋh�	j���+���@|�s�J��q1=d��W���6DL��/���[U� �fڼ2���v�Ƽ�6�d�PQ��V��!dg:YSZ�ݧ~{<T4����o�|f�L��-�i����_���U���]��eZ:*A.� Ǩ�g%V�b F>�h�����gC�9�G!ǅSy�����0�QA&XAS'4XS[��څ���*�9��{=�����"�2��l?��w@��W97�!*�D5��i�Ń&��;E;�q��ú�b�旂(K����47LS����v�@�6�wř�B�FC�Gi�N�G`a�8C�����i�w��a�Xң-���ig��Gxq�c	�L�>40���MFĹw���5`�D���2L� �P�B���UKkaJ�z�Z�Jzr����=J<�͍L?�zw����h�Wmp�MU�����d�� ��Ѩ`�"�тE���"��-�z�{�b�����;i��K���|�&�ɧ� B��5?��g7��q��p�+��,AzaK��@t�C���%��d�
B@֐5oH���Y=VQ�D^h���ɳc+Li���ΐuIE��+-y<@#��"f��Y�0��fű���s�|B���M��(0Z�]%q�!�*����B�c��`(�Dw|+�ܝr�S���
���M�̻%v�(y����W)���aZ4s��f�|*�F2Բ���2���JBk�b|��]լ{�B�j� �����A����ۨ����;�!�q�j^��%�9n�G�7�32�+R���_�r�)�'qKF-��>b�yXu$	R-��,�-� �ʧ5(�o*��;:q��u��Q$ն��A�q�T3S�_�8�%�ϔ��<̵`��#Kg��B�-�T��.
��[���5���U֖3�%��KKힵU
�V}h����p#��t9�������[q"B�}�zmV���py�
�oVn��&�6�R����A�DUS9�W@���4qw�͒d�o�����S��h:k�K��e���r�w�z{�f�Lo�z��\~�$��J�Q
["\��7��@\l���~��ޕ�omq �
'��V%o�z�AC=�~��W����oA����b�"���c	�c�n�Œ 
Y1.ٍ9�=��D?���F�	)�T�&B�#I��~�fx[�}_���M�E�h���h�1]�|>�((&<y�WKͮ~theH��.`��t�H���]5�G�)|}��L@~�b��7_l�{|1o[�O���*�g�2��������Tl�7��������]L<M�hb��4S�sZ�:E�OL�&-������(L�v��=I)Wd�Mn�[
t��0��0�Ɔ14�g��h�O�-`j�>PyFt�3?H�
�R��*r�La��)��٪����À���.�﯅��	��	��	1��s1�ق9����/�1��h�iη^��ٍ�	��5���#4ck1��W	�$�l�ۆ�|'/x�ٰ���N��t+��� ���$譇e{A�p����������s�u��8n �\�~��3�3PK�p}[��t��"��� Tk:���6��(�#$�|�u����<���~��l�R_z$#�����c1"4����ퟚ-� ���Y�6�1�Sܺ���Y?��*�P���ul������G�_�(L�!���I�1���R>���@ sO�քk3i-M���L����f��ĕ��$�%��@d��;}�����|�d@��<$��fq3F��Ev�e������ʘ��ď-��h�V3y���z;Ǖ����@Zh�x��y�qz�0�
H�p	Cvc���v�,RdRg�s� �ݽ��#��1P��ɧ��]�X��Q8�.ۨ1��pc�s	LLQ~����Q0J��Z/J��ԋ2�5AͨD��Q4J�ro�S�q�W�m��,!7*0H�0�r^*���L�\�#�H0��q�_,��Z.ۥŀ�4gr@y��E�- ��6�Gu찶d�߀�P�S׭�9�y=-�#��Uh��)����!�Ҷ�o���_�S�C���C�[l�U�F��g��-`���*X�Se���S�^�i�S�7|lV3��n<�˶��<�'��k�f�-I��qvσ	\T�-���1*N���
�y
@���4J�ɒ0�};<�#�|�g���
'i����'��{� �h5������ĻR�q���;��%;y,�\��G����=yJ⩋�x��`_55�ۥ��d}	���*���MI��y�P��Y���¢aFiw{�|�*M�HomE�������!���6������Ұ���(���P�(N�h�Y҅�HB��)J�d>��͇��PJT�㳈|WC@,��E3���w��L�r�ꢕ5e��T/�L��aa��L� �.��]�D��8�����C`�8lK:���C�D��	m��5=��x�/L��XF��@3$#�h5�:�C��������V���4�D���zƓ��9-�8�$�\\�JʦQ$�XL�b!��_�ݼ/    VpD�ӥь
���r�������3��7�aU�@,N�jeiIX$ZeC��GqOBMc`=��H��ZH��QȋI7PvO��X��;b�+U�2�E�UF�2B�� �y�Ԗ$�O�2�Ae]}W�
d�XKK�T�e�	�:$*"�$�yTR�PCm8�8i���p������!aF(h�*Z�-�f��b-4�A��A�0A�~sE�e�	ZPA��a�+M�N
�y4	aʖ�.�D� �v
pe�@�2\�b�P�_�Y5���x����V0�(���2L� &�J�	/�!$SjƉ���rU�Џ�P?�|~����hKd�@U��2���v������0Ժ���a�w�??�W5�V/�,��?�
��R����k��,AJ�1$8_����ͷ����xv*�^��s�Ӗ�ى��6�1-��T��j&@���N�+}��m�9_�Ii)#�ڻD��
��i��?���D 1�䲜9E�%�r��02Q*�T��qX����Y��5h;�`]/n*��Q���_C��/����d�I/�C:�ӎ=�I��ͣ�����I-�}������$� 	�X�����z1�`I�^�d-��E��H��cfFFIS7�H/��k���ܴ�������>��W�Sۣ	�@�#9��(;�)��T����i����'EpN�xǳ f.e �g �=� �q�k��z}SW�"ͨ�'��03��f�u�������&Բ�c�z�����Շ@����9~5u(�{�\c�
�8�%�1�q���&��GH����r��Q�o�a� ,^�#L�!!����)J͎Q�4U�'��
,{',�q���
�z�n��b%��^I��v51��P-vPr;���9�/�wZP���J�p��D�N�ݦ:.���q��'��qS���h���I�ji&�Z���GcZj/�$Y�'`���7���4�E�O���!4���N�q䬑��yx�Z�D�a���-p�>�E�TI�t�������q1���o�YS�~�6��	0�>����FQ��;�$[v��c4
�0��>p����w�0�K3d\��=���֦�2jyRf]�i��R�!�E�1���a����ndA��HՖh�8u���Ӭ�y�s<gk�PyR��4������6�f�`��D��w�9�[�6��r+� C�$�������AUPK^B�Z�\!��[�QoE�_��.�º��<A 0��:�b_'�E�%�z�E��GKʎ�T����:`N,�r��/�nyw��A,��:��ك�"�Ɠ�>����h�$��Z�͌�T?��d��ޕ��c���5���!�mC�|�r�ScZ� �+"��S�ZX۱��l�����z*�?�+"��9�l ���k�:�Z@//�X�df���v�0CŃ�wP�Ή��i 5M��P��0S��</�BURc��v��b=qd��k������T+{T��z>-�d��-B]ɩ{�iK	E��T�\�'`@l%k,Z�n�Ht�?��UyX��P���F���Xqd��r���2��]1}y�`�~��k ����q#�ct���6��EL�l�˯&E�L����tH��9.z����,���< 
Ρ
*0JM���?�0 v�v�Y3L+�?��D��zܜ��-�-��S��0��Ρ�y45��da���%����1.�yzFB������/P�� ���z��i�b)r�j�âu���طD"����G���le������6;�#ɢ�:ނ+��C:��ю��������*���$]���	�f�����;T�{���N��1Yգ3]��E�?������	���_�|~!��w���mEr������崧�7H�F���Z��,�tʠ�!�b��f/�ig��],a$_D�^	��=�؏A�����	�j�in�ξr ��fr:}��Ыz��_	b"5�+�����>�'�����ư蘺ч~��]j��LRm`��;�s��}�ps����ۊ��>ܾ=������]�7Q�@�E!�E�/��#f$Χ�D7M�)�e���M���'����>��b08�Q����̮�_��`3+.='5��V�(���j|!��e�Q�����O�{�nd.�<
�#���e݊�����WrQ.wD-}�mfƤ��Suy�����'���_~��|!:_�;���{�;]˾�M��Y����{��d�>���~sZ��~w����_�wky0yZ6�d��V��m���2���G<�ʆ+���uz����s��|�C���#/$��^������r����J�R�U���[̓�9
��a�p���@`���J2 Eb���&{K6k(��M3҇�۬��:J�R�o�� ������ׄ`���*̫R�֦���s��P��ڒ���	�:"� �g���4���'>~r��䈡'�O�ݗ��"EDtӅJ؊k���Uw���Y��:�Uy�	d!J�0�1!N�S�da�(���ĝBy�l)I��!MD�N����ȑaZ��t>�D��P9���]G�9{�����P��ٸy+�Op���[�{C�F��a�/�IX���R�"���eG�֚hB��g�^o�� �<��X�W�\����XP0�� i!*�R�GZP�8)�TV�΃"[�,O[q6K�,�+S��r�<c�0#�Ř+��c�#�"0�ӄ�/)�V�QD���&�1�%�.J���u9��X�dm�l�B�)nj��*[kí��<�lP�"cRK��.~����D'*�\���s7�*ى��{+ l|�;���(]-�n��n�����B;(s8��⭘^������Z28ƾ�[�SV�HȐ��Q�7���b�u�`�L��f��i�"��Z(I�P��RٳQ#5MH�e{Δ�{臱`}�!��|���f�@�e���@n�)����:��!�B�S��b���|ǎ��D����=��|�tϧQ_�C`��U�g_a��Z�FM7a\c��=m��D��c_�C�I�C�R0?a�\[^|����0�
DM�ϝԤ[s��5��Ȗii�ܐ��X��D���q	C�u}�����,ݺ�J�G[��m���d����������+B<�ccW���b��g3�8��P�hL�m�Ս�+��uZV"URk'V��X����|��T�l���ٯ�H쩌�v��Yq�*+ui����L�8o��E�/�H�〝��ݽ��F����ɷ���|�|�_���7�f�5��d�@�y�S���ҿ��4�Z��\fn��1�*{ob�J2dE���U����E#���}�%� a^���k�#+�����%܌�pMY�)���'uS5�n�o!���ͪ
bZ��hH��'bw���� �&`�` �O!�۔̦�4��q�P-�/��P#Ci��.��~� ��JM&G�l��'(��X���\���	j����R73�s5g�0��l��Vb��j��L�����٥�4/*��op�b5��XQ��f�s�^]Z 4_>�$@��"$GY:PZ�?*�d�I\���Zs"��f��n	�@��P ��$�Yyp��Y)n��b���(k�F�)S7����6�	���Mf٪�B/=3�_�� �4�āb���+�fE%�/�x�F�Y�rUdI�����Bڷw*�\\Ǧ^����#��FA�Қf���474�bY(U63�vgFe�q`�U�.uQj�+/kP�qA'�z�1�fDUt=�_Rc�͔uk�`X�u����5V���1XN�Z�0����_غ`3�������h5�f6T̱�3��,��r,�p3"K�
���b�ޙ�w���D�Q��0{���u�M�،�<�Z�SP��K�w���D�(wǎ]cƳ��ӕC�
�7ي���"8���L?�]�V��o�oror����e:����9ϳ�K����ɿ\�M�ޜ�Z�IQ0�7-=�K��:���    ��#B�GZ��"G��6�B,q�/��	��[y��M(1^ؓC�B�V> ��rf:�
�O��sc}vq������M����O��.g���vօI\>0/:/�4�R	�yRE�OR�FTE㗐*y���_�=U/����h����Jˬ6��P6��<�i�˭C�6#�6�
�T0٨4X���X�П�� ���"��/D��j��d�b��4."�5��Bd��dY�ԯ-�JX떕�QS�c*'���j��� ��`k܏�h����:�
�3C�f������1�!BN�i$!��,�̢��<��J�6k_���4�\[���`3==C���=.[��t��Vk���}�eYOv�,��[+�R^�N�f��D����tȶ�m���4���o|CĹF2���ֹ[�?n�; �
`i��[9�q����X�e��|x��m�)��V6n��[�sC*�:�j�ɦc1�ܑ�1�ˎ�����V,�?�^��Q�w���{�\�~k-��
���0��!]���e���.��^[�Y�^�o�� �W�p(C�t�w�4��yF/�N5������sw�����ӾAH�|��}.ۿb}q����k2goh6_=T�'a�4S+i��HO_�3�Uȣ����9���e��xz�a�L�YNaZ7���	�Id��W#����)�b>R6?b���'`{�8��V0Zpe)Yݖc��f"��r��X������g����A�6��Vsy�D5���7���-ں���,�-J�j�nf~�&�(��v�hm�$ ���-�K��%��)��$�
nF�����Q�+`3�8�_�>�QＮ)�X�ǂ �F�͈&���IK3�8ӳ�>+G,9�}�����m퓑Yյq�N��B�l��)�4!����V�ZxT��/��d�u�4��a�;��Mx|������2iw��y�;{ݔi�K-�	��4SA��[�r�[��`��d��5
��Έd���C.�����-�8�[�5:�+~g��@�F\�ж��*�+���[�����Z�K&(쁂�����F�{G�!��]����,��a�l��k*�&;W@���(�x�2J���Ң�Sw��x�e=�"C�o��S�CqB�-ױ�l몢�&�t5r[lFE���D���6Ӂ�0l�Te��ݰ�uA%��B�bc�UJ����7��~ן�4^��¤�)__D<�=��I�'O�2Df|������>u?��i�ϻ�s��i���.��t��.!y������!� �3�8+��~a����:Y�N�i/ϼ�T%�ev'�u�D%*�wZ~ò�
M��zfᪧ"s蓜��q�z�Z��j��0�#JR�J�n���sQ����;�����U�|H��B����H���Jwg9'���Mп�R�F������g&�QA�[k�< 7\��Pπ�i��������!0�qA��Z�]��<�k���ϯ�ȡ���/��ȇ뮙]��i�A[�y�̪��D؇�K�*db҄f8���(-�A��%7�YCX�p3����w$e�+�S5/���e&�G���0�����k݌�5��1�QF.�ZJ0��T����ohѴ��6��H�]>��Xr���ek�'�D���ͩ�iS�z,dp3c7���!c(3ء��]�����2fތ�+4v��m��<m���O-�ݬyPH�C��5D��m����O��@���>�ϰ�}���S�|�^%�>�03�9�;�����G >�:�'�uF�Ū�t����������Z�q1�a����d�sT�.);5��	�f�)��+��J�\��0?'\���B\&}	6?�ZB����z���&Tfa�1��Ҷ����;Yw�t�&���ۍ�>o��}�^�lɥKw���뫮��c��ȝFt-(���C��< �i��ĺF �&�����G����d���~�������V,"�G����*o���2͍��X���z ��+2 �c��+�qWC���H��F��u���RK��M���߾g�I���_�Nd6\�ĐX�p�����&8C��)x�<�[�3XG�Ο�V��R�vk��޵b�+6k·��tY���5oڐ:���G����k�����0�/D�弄�C�9uX#7,�C|m���Ub%O��P`�]�Bá���V2�K��y�п�^&�����T��<�*��z?ơ�8|��B\�~��Qe��I��"�� 
����A�I��#M^��>k�v�u��V3n��(��Y��i,�p+[�f�k6z��%[SKT�<��ؘO��ş�/�>�8�q�$2�s��F��7�W�&��(3�$�fN�d�/ȁX�w��X��k��9���
�IP.y���O .�~`���l��_"�z8�P�F"���r>s��/�6S�v^�����yGq�G�G~0%��x?�\��{x}�Ǘ��!:L�a�_]|yj�*L=�R�hþT�0�9����lx?8a��v���䃎�03�b�|H�ݮ��/����H�72�q��5ԛ9}�.+�x�nw���u�(me���z;i�|-a��;����O��ڞ�-W�Ȏqv��~>l^;ĭ��V�����:toDN��1yz�����Bݿ�$yw���+�B�Mf��Y�V<����)a�t�Y��2-�^פ��@k-lN��*�|B�_��d�w;�V�:K�N�Q���,{wqj�S� �z EԱ�s9����+QVd�5�]S:�C�\�GqqU�-x)�:�����/�x.0���Qv�!���.5ϙ7g+�_@������-���������oɿ���ߒ������-�S��H�����o��F��n��*�
����ቼ�G�`�DƜĉy��Z�c���\s�kgr
d$�(����&3^v�|\\�EJ^�λuw�V�τwt��>}P�`�� ��MR�B|2`�A��\u�����a���`�L�C�h��N�u�6��3����8&[:C?w�]����>��C�Y�hC��3#u@�`��gc̹��wr>H˳0�ŀs��4�k�vT�Fr�KYB��"�����Ա1�'O�9w8e�U5tG;6^�j�|G�\v ��XW������z�B�̤��X!v����5��m��t<ōS�
���<��\cՉx!7���yE��.{��]|J���r�.�=uo]�u�T�}}��M�(a\͊W� L��W��.�Ñ���O���'k�[�k�?����@�����y��<o7̸�o:����A�b"{�*~��#����=����h��u�[���U:Gz�A�Q�v|ơ�.wq����9�)s�KD����y�V�G�
b�_��%���!3�iI�P�!������������]����^w���H�ޠ��+��R�s����y���7K�R�vx��a}A�/����I�R�@����x�>q�ܞ�U��)s�9O�/`�-P���r{�i��
�/��;�׼>����bO��g�#~�S/��F�K>~���ߓ�i�������8��K���|�������F�L�#�}1�݋ۍQЧ���#n��� ���~�E�vҿ�}�z�݃o��1C��6DeM&�t�~����ߒ���qLN��k�����n�pm�mQc!Jrh��_��Bn�l��uw۞�"�"9��ܒ��үYkw��>Mo��T
ͦ������0�a[<4:5�u���<�O����`Ã)(�a�&S+2!` "�IT�]ޖ�6ņo���RU��������l8���iE�vڶr�������'UR�lȺ
�V[��:^��.����o��ѷ{*�%A�pHv[��;鲃6�g5w���H�gw�7P���TR��Кm2|�9��
��������)a7�l��}�Y�<�{�������������p����;k�=�X`=_NG8N��xRZE[��[5b��A�(5w\��藕:�TΕg�1�2(!D֩XmB� U�]�A��i�p�<OS�?�\��E.�n�E*5}H�4��ң�wޏ��&և�=�DrTj,r�1�Rd�    @�Q�;\�0��KOu����y�6+�$�a�U����x"�9�@����(��$����Z�+M�Aȣ*�=�&8J�7���t�������*9`j�A@]C�QD��^�k/4 >���	5�3[9b����uA]h�� ��R��@�S��� T�6��Hj�J��Pm��1"x���i]w}��gIj�����d5���\AV�I4k��(���lw&�1�����sN�b�������D�\?󲑄�ژ4�����'�)3K1��X�í|��P��,�Z �i�� ��$� MU�VML��G�'�I7�
���d����,��H��ܾ?��
ȥ=���.69"?��Q��H�!s�`��Hn�i� �󑩎�e�W)����}��1��(�%���Q<)��a�8��-7����%�I�=�2;%��q�]_s��YKC�ox�Y�C��զ�IKk�y4�H*ra"5dR�%O:��o�U0�2!x��@Cw0$���+S*��A�-��c1?3��0���9#�<#�<�JF�63g�V��@ӂ��[����i�*;g��oj�9#�8�f�8#�8?�re��ށ2��f^�a��'�v�?t;g]n�C;|I���M%JLK��OST��8��*g�8�w�W�T8�R����B41�q4K׌6�tI'�q�u-��G:���
�S�2;�8�2�
��hu�d9B���y�O��� �O�υx���,�h���p:l�*жm�0W_�0Qy\�)�g*�0�Ә^���A�@Y�� �T4.$� �.)�t�.-�H	9�A�?��Hۨ �O54��t��F��:� 뙁�FhYd]��3B�� [�5g�٩Q��@���S�M�J��~�?f���ekp�	0z'��3�� ;�q�Q���(�+�3�U���
4��@u����G�W}��S�870���=�(̀�Ԍh�J�� �.qV/�r���eZh���vu
j�' A��.�	� �q&��]���
Z��RGhש˯���D�$2`��տkP�,�16x�Dr��?��ʪ ��p��#���?�4�+v��?�ލ��a)[?`w%BF���A�!��l@ɠ������q�u	i�#ui��x��6J����[`[��zM�����G�lX�� �Ě�MX��V�Zj��7�j���7>1�� S^�?�ުa��q���}5Q��<'"����|n�4�=�{1��t�N���G.OC���'3���󹻉����v�n��/E!µ�j���"����D�Ցj�	N/����c��]V����8>N�����av�BK:7������_��'�G~����Gcy����Ĉ��q0a�?�'A�g��w�h�\KD�����\���hD(��
�8�q!(�*���S.<`|A�_aC���)�NH4֓�(��όP�扏l(􂜁����)�7���B��E���0��0����O�ik�S8����:�u7��wp���ՙ��;$ɳ�a�P�9}�VZ֥k8�!��^�X5 �|���`Y����'�Az�-��(�B�K~�j�EIZ���qm�ަ2-�Va?���$e�!�8�v���rE�D"ơer����BY(!��D���`�J��ݡ��K����FB�(�DҲT�(QJaq���J��s%��2�ڗ�f�Իai��Iڀ����8y(G����X�H5V�,�Gֶ�#j�8 ���97~ �
�&���#�Kː���^�l�f\*Qi7!��G����w�Եd`S�~eZU��|fdí"Gs;:쭖�ȝ�Qs'.�� �>;�S����ӋO���塄"Ne1�}u1iÿؕ��ȫ��,`Z[v4��'ܩ�i���U�8���h�v�mp���s���P=v6?��irE�j��Ga�=�,(������0����~�HTb�p1Z�qwn�ʈ1R[��{	g�%"څ?`!����GX�B�]���zn��M1`k�q�q6H��t���{�fm���?O*F�rX�����J�d��`�!s��� �����|�AT{�NUDpu���7�46��4��W�������eZIV�A�����u�z��S�F���zir�>� ��^V�XP�������N�6s�����z��=��;2��(*Q��Gbz,TҴ~���ެސ6-�r�ai�GY�DbS_dq�漅

,ҭ6���f�)��uʛ�I� LU��%����u�*/�d�N�s,�Za�oF>�^�ۼ�=�yG�UbrBpo��b�-��"���,�q9Z�8��MN�t�6L8-�8U=�"[��D(L.y*$�M?%���y�=��W@�:�}}/e���Xһ�MUڌ��SQ�#Ov�9���i��1|�B㗊x2YZ�f@�t�K��	'UN�NB������jG���q�?l?�.)4�U��Α�u:U�����<�a��O����a����z4���\�x,�0�y�$�ߠ�85M�@��p��͏�#G���0��_G��]D)K�&���� z<KM�ˌ�e�{�Y��պZ�)n�Rl��/����/H@�TW������T�z���:Zp&������[�b�UJ���eas�!(gɰ����?��Mv:̵�ޑ#gH�s�;��T��U�E�^ܦ'���6΄廷F8�]m��^�������F!�����o�o�O[{G�J�Ų:�;B�X��*a��N\�K���À3a;���s@��<�[�U�3�ŀ��E2��~�� <|��]rT)Z??��ފ��*\��}�f��V.�f���&BG�>��u_��9y���B�X�|'���aq�&��LVj�l��"����R_1��)8�M��Y\fY]�z���ML%2�CG��b��WhZIBT-��i��6``Ҟ��M�f> ��Óc��]�x�WN�&p��I �*%ei��{(:s�������2v�x\��Zi����������p���4�@W��7�k�ԡ��K��� W�J��Pr�!�mr�{��8n�o�f���[��G��r�Ԓ��C�\J���\
p^�Oo5y�|q��<�X*��!<��*-�Q�ev�j-�)!l����P�@��)�Α�%@��K訐�K9N��hӀ�t���=C��)���وe=sЩ�Ah��)J%�Pk��KU�f��]JFH]3��S��zb�kl;T���_�ev��z�Ɔ5C��4g��B���?Z4굳����vd$Y�$����L�N��˴���W��3��<^���.���P�x9%O,6jl����n��,�d��Y���0�.١�r���l�(�Q>K�u4�7߅�KLDI���`ʹ�i��s
�\�����><X��FY�N�{7�J���^�R~&/��<m;�
Hj�HI�@߇O����ހ86�LT���@�釪,L�����.ͯ"�E�͐q��I;G;�3$���%	â��fȹ�&5ͽJ���,4J��	b3?o"e�7C�4/�I�.@��ś�	�Ҿ�Q�GɆ�/�S���~赪�1�I���I��:���^�k5
�s�81!T�us��ζ��4h�|����+��W?֤AGz��w��!̰���2G�+?j  �?H�J����#����?��H���I�(7N����7��@�&����H�ox�����D_ � �Z�:�H��o�}���[}�ú+��荃ݥg��{k���[a&n���
��u30O��,���KR����& �6Kr7^��Ƅ�����ǎB�^����]'�zV��� �-��[��נ����߂beFl�ַ��J~��뒷,�jTZ�&-��Z��ق�_ܒa�>q)dB��b?8�E���U`���v9\�k�V�lV�0��n�;�v㹅S�i��U��?b<�iL<�	���kv�̛��چG���^�A}p��r��G���.��V7ns����;sas���6A�6/��vCD�R1 ���iV2�ݼe�Ye�g�ϥ��dNmg�!t��g���8sFaQ�����Ag�    ')LPZ�̺\�.J����*��ט��f�Oo�B Ѱ�� ���S��K&�'�&���kV��l[��Ds
S/�VRT�U�SК-�e�vp�;)$˚��?	���B*E=�Q5YP(FI��>��jA���)����|Y{�1-��� W�,�\a���B��K����aZ����&i�:ϥG�����\���}z�&�����uK�g��O����v=x��)�׺z&}g"��|�V#��B��fv��+b]�3
�BU�E<U�` X ٘@��ަ����'0�����-⏗�_j��`�3�a��I3��o������ڗ��[H�v�Y��c��0�c�Ԋ�zBIW��7l��6��Z��T�ܚg(	��/���N~�$^�a�����U��Qo^�7+�:mq��G�5�^x<|I9��<N=�I�\$���r���ُl�43�0��[��J���%\����e1��P���	�a'*j6�_��-�
���H�Ma7�;Љ�Z�JEH�{�8p�#��6)16u�0)�Z�Es�̲!U��:�����U�2:)ݬ��v�DmI�kv!�mE=�(ҹ�%"
���<\RZH���|�C��,b��kJq&�Қef+�����~Ù�,�]�3��D�ҥG��r�j[��k���Ud*T��x�I�E��e;���+�����bOM6=�jk5����CZv�ƨ�`&G��j��V�f]��:�Nti@��c9Nw�.��+�}���Ln��������Z���x!��5W���h/Qc��(��._͌}����~��7���u^,�g�(���o6Y�Yd��7c���L����E]L�[��W���~(��o�k��������f��2&��~�_w�$<�e!RtH��%vN��uw*0���U����䇖�s;}��_�����ow{"������o����0����3;3Orrg����3p�Tռ*�����[X��5�g����;�7I #"M�ۏ/��C��$������Q����h��L�ap��ޞW�;����B��u{�n<B:�dU�;7������H�?��ܤ=ty��$��y��W�~*��(����^I�R1=Q]RxLĝv�"��[����X+f8`��u�����?~��z������߈H컷�4��*��d��_��Md,�|ѯջ~���b��W�E��C��V���l��4��<�{*�V��xY�?�>��z9�{a�	n��/ITw��ˇ(<�)�ɕ�D}p�X|9]�_�ʱ��I�$W��P�%�����-�1 �+�6��f30�%�-�'��BԴ<t%�r\J�]�1��;�ڷ�2Z�P#��}��(zI.E��)&��d�٫/Ϥ����jf
uQ��еT���i�p,eX<�t�����p�{$WԳ����pD���� "�������&�rX�(�����7(#J@8YS)8��NT �?aО�|E���t��gД?��&jG�� �)���5(\��0Lo�e�r#�����?V�&]�̲�K�I�w쬨�x~z�TMp������W����U���X�����(�H�g	��:>�̚�u�OQ�_���O"�e�Vj���XŢ�KOҞ����HA�uA�?�dݟɩA!�ҏ�W	��t������U��V��'Ok=��Ї[���PZ�Y-s%��B�?S��dA�D#�i��M�X6�F�n��4�& Z
����@t�$m�����a��Z+5�pk�b�N���&AI���2@V����X�{<[���ՋcX�(�����UXZ���%}�&��*�Ļ�͝�*�!�į�S�������G�\�f����k~���������ʰ����`cO/͡8F^��Z2q�ٱ�U�D �ڤ�`�gQK3��v�
X�^�(Xy=���Jd={�f�1K�nͳi[,�kp����	��p��L�����9�����N,�fP<��0���9	K��~v�0�v>�+S�Nⱥ��[eZ��r��k��w�O�3,��)����J��� ��H_F�X�j�=��S�n�T� ���y"v
T�9��Hǅ�)2ပ�-c%cۅC���jW�rG�DML
k,Z,o��HVD��y������:�7�qIS% ��/��������]�1PM��[w;�������ؽ�����C
#U���1�W�K;%�Xҿ{���۲g�Y�H��i]w=Z}��n�@~������pZ��Ӳ��;�eÙDϷ�ΧFg"�} p�p����&�[��[��"�XR�AF�Qac�<h�q��$R떓�,PP�z��Ǉ7&tm�7��8�H�C�.��C��r���'&��
�.M�<�hi5(�B�U��tyV�| ]A���Q`ܢ+
��_���l�C�f�"��((�H��$����%�H­���D���*��*k�w� ��<�m���l�!>J��*$FD�1p˩D�Q�ې�j$m'��A��!�r�ɀ���@�(�H�L�IP�N�1N��X:�ė�����ؚ��A�l�,B�gTu�'�X�hG��(�m��YÑwǎ�;0�'G�M�.A���IZ����[�V0�NS_��8C㭦p���Ȕ��$�H�/�`���Ҏ�!1���9M�g�t	k��hM�J�����(�bj�քxO3'�%oE��v��E���g�󴈧��\gS4�/���NQ��moY��V��gò��Ӱ]q��ǣ�Em�>��NA�<�}�B]��e�43�UJ�95���5`8�*�m@����4""�J��^^�����%�(�*~�"t>] ��1sH>�T��>h�,ʢ�߆����5� K��MaJ�"�;� .R�u\8�_A=�%Q�oC2�]G@
�(?��� �Sm���Q����ʿ��XVd4	Y>HQر��5�R�]ƊZ��-R�^�F�
)i��$�"۫��K��lX��Qu�.��i:�(;kA\6a�V��
��(��B
��T�5��[1�<�f�2�9���4t�gZ�k�z��aV�{���x*r��E�b�'M=*n�i˙��/VwZR�M����(��%�LX�߷� l�%�j�N�ZE��e��nX���K`;�u�#q��m*o7k"�`lY�0f��Y[8"���'�.������X�>�[�(*W"���LĖf&q!���]�'\�P˛W��(o~7����̅$y�}�/q���x��bz�����Q�'"�g�E������ �=I��������(�k�U��D�TJ� c�]뾬s��1�;G��C�)j��n�u�1 ������E�ܕ [� ��L%J�RJ��T��U��}���|������Q�as�o��᧽����,�n�X_uq�����F?�7Ь��L���}`����ȉp�{	��4&�s�����%	PE(���(B��P	>��:M[����
�*��)#M������!ol���R�}��O����N]�ԕ���G�v�w��v)�cj��]١�ݕ��S�/��p:���/=��yd�,k�r@h��e��pkш��!�~S�On��~GK���h��=��U�6yN�/�I�dTb�\�' ɳ�h�_gʲ?�?KẦ#��).����$���_�^�]�/dA�lN���n�h �� ��,�-��g��.�sv���Å�)SME�8�;���c]��ʍ
~�H@i�!�P�J����n6?�w���EB��r�{?�|�U��-.��pS
��M�8�[ @j
c�;�Z�����i�'�����\�\o��t�3F��x�*=���g$w�-��G��^Q2*h�;���������w��rH�򻃿���:�.(��z�	g<9���x�o�ur%����B��H�<��(i��)k�pM���ղ�B�����O��(X/1���3�9�xd�W".���g�ʁ]Ŵw���Hu�7J���F���,��sɢ֋{��.�rt�@y�S"w U�<��Ajd��LV�i�Ȫ�Ni�+�y���U�W��+��F�P�@+%��h,�L��˟H�"    �� �p��{-��Zf��/�GuC͚�uRI��L��'��^i͓k0^8����1Y�F�FjNZR��(`�`if�������4��@uރ�m��y-TbӖ�Z lf;^,����,��# �R���J����r��RK3Me�>F,8����Hf�.+��z0^r�?�'�ڗ�~����䪼Ȳe?�}޳�G�j����%����U��S�*3����k���UW%�,��Yf�T�,E'1�d����	-]m����S�ϊw�*�N�o��:Yk��&�L��-/����mxwS5�|�
+D��ҟ������iO'~^;�������BYXGq9Z_�]ew���]�d�B��E�=��yN>��19����<E."^�'(��>��&�<=6��C���;�w��}<�Ǜ���]ԕ�(�����H���.�ӧ+��E��vO�A)c�>˼�&�`"L
�M�0B.������T�\�`�w�Y0��d���(����_��`3�̭�j���|j�v&�R#:O�h��Vikf����fF4�����R+Q��J�����$��h�܇e9M{E�Y��U�7¹��S<�����|ک3y���Z@��4�'f5�D L��1�43�r9&Z&��Y�5�%��	�����;����G�z�A9Zm����U��˝螕���U3�/�U�b�J}�X����e��a��X�����d��%+����{�NL��pש��00'�P��tKh���_�(��K�a���"U3n�[3:6V��c������7`I{K3�`��	���(;��1l��������K���ŽH)Rd �%`3���)��������7)���;X�N.H�/b7�H>}����vNbE������]�� �CG]����1�Tp��Y10+�CҸk��W:ez����iu778bq�Y�
j&�
)���f�*r.��~�Nj��[�mפ�v�#���r`X��B�>�%�l6]�Y�����1��3й9.!}��P������J<�9���y*wx�WdeV�s��gȒO����BU��f�Q&��sw��V��y��Q�!Pjf�-�&�eB�Zu�a4�T*:O���g}7�:v;�~�c=pD G±���[�G�C�^�h)�(��XJ�E�4�G2D���E��P��!�+ lf��2W��\@s���!���#���PND��D~��4ՆȘ53��\��� ���f
�MC�1�(rX�p3�P�0؟��L�.y���68Z4d���͍9��f�qI'�]�;0N�юQ�H��/5`��Xc�:�Lɫe���_"���\0P6��N��(�n�0,�6Q�"��B�<|P3C贫�@8ߏ5�`�b�R���/���>�2����X��a������|/cgtX��adb!R�\7��b�l\�b���TQ��˯�]Kh��V��bk�-�T��A��8�w��?~_�?�[����u�ݗ�܁��S*����������>�������5 b�z��}�&�[O��� ����t�.��U��T��X7�=a��`&# ��E�Me-(C(�\�z�]o�8�i��,͌_�����e�-@���)�F�g�����V{���f�/@��ⷌ2~(��\u��@�τ�i+��o�}���фhIѩ�Y���;�sǓ��kU��P(���@sO�u��b��ђ�Ss�����Ak2?Ùb1|�z��:��'�{�Z��?!<�p3s�GZ#<�n����iW��]�������x�9�[cPH�;�̜�s֩�;�n��}`7�۽����Ӿ�c7����\������������^xs������@N��>nO&8��nn��`if�n��m��7ss�Ac}g�D�'a�b���h�̈@$��֦svk� ]F��(��iL�f�ԙX�|�s�O��I#��ۻp�2�_�[�Ȁ�n�ʯ�; �U>��v�y����F�_���i�^�5)2TO�`if�渋C�-�a}^�6���X{|���A�K4[��YVs�aG�GށN����d3�+2P�Y��Y�2����2^�}�&je���>�>o��=-��+��Z&�G���C�c�f�y7�9��z���;,��������Dtx���5�\�:?�Fxء�W���Q��&UĉP��p�Z�2�q���b��n�#�t{�Yɧ?��v�N�[��p��>m/��[�p7�)Z�2�H�ɩ���\&a򵧧�hr�˷ߎ�o��������/��4_〉���m��c��)7�[�"�ɍ%[��Rm�6ɧ�rdQ,��"U?`����19�o�ӑ��"�~�B�|1`����w�w�"i��,�,3�S>nC��*�uw�cO��AdG��2sޔ�B�f&Ia�<�Þ�=�x��B�?�����=v7b����������>��K B|�?�>����OI��tG��Ԣ>	J�@#쀞�y>�N+�#߶�b�}�P|-�<~\}�Y����Df�=QKd���1N�qSXd�z��Q;��-Hm�h�?z�\�}��Ywս<��J�'���O�s�E�f\���E�fF.�ȝ�ei|:71Og��|,��l���ȆN�*�!�Yi�p���\�/��6���l������&�f�ߋ�䫅~K̍�h꙳gl"2�fv��K���s�X���_��	(S�n+#��X�Ј���43���?v���M���N�w2b���R���~3�?�S�#��̼��R�X���q\AaKs��������ۂ*2�Ä���J&O��V�)��Ո]r=��^��0���RIS%>KH��kǊ�'@�cO.�:\�_W;��?~�g��C��o����s��:���yX6�@0�"���ҳ(g�[ҿ��zҠ��#b���D�����k�>E_��w�"V���w��3c�?~��B���PfгF�������؊Ϲva"^�k1�;0�"8��� '��E�H�1И�@�o���f�:zʟe�Om�¥��;�`5L�d�Ԣ9�E���I%��KY�"���鄥8_5�>��ѩ"�u��׽N��z*��sO��>ay�	�ế�,<.G�{�]�f��#�D�\V5vOd���=nN��,J�Z�;�S�b6��S�3�I� ��ky>���rTf;+ϟfBs9+�>:����a�)��d��QFI8�qy��P�]���o��<�!{����6��￻��N[c�AE=A�lH����@���ˉz'��״��-�aL��~�?�a��Z��+!;�󞯷�#��l_M�PП��[z�%��	�Ml�ϟ�����ot���^,2����E��٦>�߂B/��~궼#���pk��K�mk��olmM�ٝxh߼����]$�c`3]W��-�� O^O�_�(��>��/�����H��)�h�|�x\}�z{��ܯ� ��˭�l�����Eu�qGԦ92�Q}��&��ch����h}�^z)��˶;~��z#4���C��v����3y�h?�����# ��o������lxB��lp3M�6��
��Wg�0�aE���1(��4:+v��f�  o�2����m�vZ�?�mF�9Pή�43ce^2���Nѣ��7w׵^=�~�1��zޗ�]u���'&���K�wd]������L8�!�u�y�d+D��'��Ƈ�����iz�\u�b�����#O�x�TfV�Zf����[̆#C6�C�4��/��D���@�y���Fk#���LZ���3��p��%��,~� R �@��=�`�Сɿ�<,53:3�XI���_T��0�ȍ��aU*d; Y��󭥙������Cl�FǗ��d�a�� `
vd�]	,*���l��V��!VI���4�����ߙ[�$'�XB������$ͣ��_hMA�V ������K�\���HXeZ�ӱdifC,�-+z�!6��\3r���hx����6��Ê��>h�M ��c+!h��Y>�R�툚43���
n����p�����/[�Qup(�L���b �:�@7�18�4@��X�A�s�    	t���B���An�A�15�t�х�y�Jht=w� �#r*_1���|� �>ayx�
4~�`4X�h����� ���d��
4B�@Ԁs����e��<���h:n������҃1��%�)avI��N޾�[�:��I�JL��T&xC��7���4�Qc�B�z�����,�<�53)�g�Ǚʹ����YɸV�,�%�Q+�a5�����X|ѓ����D�4��E��2�=��53���RE�3�Ǭ��Hȭ�@fWQ�	�fT���v��Q�?�z�.=*%��C�����[989���ED�p�%A�9[�AU�`���R��`��9������o�<�.=j}�&����w�n��qTu�7�Z�`k�R�LE��L�y��qb'�¶H�
E�9/N<O�K3����G��}�'ʡT��3�#ha_�f�Cf�~��?��O�	V����C�N��E(Ulb�i1��^gif���tu5qρ�9jb�����,����|%r)6�|��+��X*?l6��M��z�!F�B/�B�x�r�/ǿ��as�����͆�{��*��E	U����[=���/bK-�|EY;#���,L}"�4�� �w��џ�OF�h|�"p�@x��J�nĀB�0���jP8s(���QՙB�b�<q/���EhI$�Sl;i���r\�KF����8ój��7Nj�EpD��a*��q
c���1�/8�����hE=�Q�C�f��K��͌`���񥬙��]�G/���q�
��z�&&���s�a8,�R�%Ӣ�OF�Q���#o�7㡼�fat&�d(j�b�"%��P;h������*1���-+�$g���D�qahc$�4�̔t�����3��ܨ��N��h%w]B�2���,͔RHe�e)� $����>٬Q�c;.Q����g�^ّ{�b�Z���.\��˜���R�^&c�}ׅ��N��uY�j��yOa��v�ɿ�%ϒ�MU�����f'!��@%:����������V����m�U��ӹ>>ª̷ikl5��������j0QA~�a4����T �o`��g`)���;<�頻����X��3Z��m|�XM�����`�h�y��Ï�\tn:)�{^��խ���m�u�h��!�T�b�`if��3��I�+���ω�B����i/�b�Q��d�#�<K3�E�O��?c�H�����!��'����M��ȴ�����|�S��D�_��F	��X*�Ԯ��QUR��׉}�z�vb�v����:s^�C�n�c�&2گ���x:���t1����K)>��^�|�/�m�nD%c�43��A�"�;)"~
�J�U�w�9�&�"(�6�!vo1�?�T>��**Ň:�9`y�i@x����S�jaTP3C��.��U9��lA��s�yDo4��e�%��_��w����G$��}1�1��z����x����߇�䉯�ٚɀ�`tj	@W�����y v(� 53t�:���*�Ή9�]X���&�������it�ȁ����.r��<ˈ�2�oWØ�Q�7eёK{+ (g���A�u�m:�,PQ���vY#N�C����a�nH+o m�V�.��8��6�B�!������$i�eR��ǘ{8��pjK3�`fDY�|:�<C�k�FG�7���p���-���ʟܰ���f��b����bW��C�2��aV.�ò�
��!sӆ)G��m���4��Y�& #��sk���V���o��Tp�f��o娝	�|˄��?do�����m�m6�.Ÿc�<ʴO;���P�Z�Z��v�<�*��0��1��P��fF+>����^\b)��}�aGk�*�gif%q�.�V��#6�ݽ(�'�:Y�Iñ�~�'��4����̲'3ڝ;.n�d�e^�4әÝ���g`i����=B��G�}z��z�?qy���]ƦUlv&i���0���Av��s�Y⼡��Z"�ѡ�FT�=j9!�#����ZEhfr�OW<��g.̶�� 6�F����2R�y�അT�����?�O=_l@��!�CCJ��=Z�@��@V������S���OF�G�dD
��я�,�,Mx���M|�g��(3�Ff:�J�����ܲT��	 ,�l���u�Y|�MN!���V���!��Df��+6�fJ�2�m��5@�AW)<��~<9p���̆`|\����C��q��Z�C�,'Ry������:|E���Z~Fc���Q��i�Q4�Y�4�z:�[��s{�\�0�)m�M�>6y�(ٓ>Pj��<�癇��|�H��H�� i?�?􌈇D��F΍��K3c��3*�W��*�a�rɖ��\ʷ���L�L�H �>�&i"�"[�H?"s5ZJDP3�#��ׅh��N��Cm�'�AҰF�zr�D�بI#\IԀ���y�z��(3��Q�xA6#*�ݝ�d~�f��K��L�y������lj("���e�<�ʼ��"ImD��؀HϨ��a��R>���43l�,h��Q#L3�/�n� St��/�����Ù2�L��|�Ѩ��60����43ɛ�v[$�a�騕Vxa_���"C�Ea�43��<��x�*Ϛ����9�E�8Z�|�8��r�f6��m,��0��x,��h]��� �#���q�jz���'ú@
�������gg���͝��f�E���}p<�ծhQ0wL��wκ��!e�L�A����@���� ��ޅ�*Y�������(�hX��M�gn���FZ�gj�*n��o��#���<��Ѩ�0�l_*�����J��E��l;K3�爷Xx��Ȓ&��/���L�q,��X��K��V��z�h��$v��I�1h�/=���R�43J�~�E��4�\��H�������4(�����l	���5^w��Kp��ev�,�U$ôj)��	P��N�5`@D��V#a���C,7Ƒ'Ġ�@���&�8��+���������c2���"v Hٍ�e�i���f6���ho��y��8q!��0F���H�-���i��R�b��<&y(BLMC#����)*w6�ǡ�f�����a����xP^cK3s���͎���"��״r�������0Ka�Զ���>q��q<�C�Պۓ�5e+}e�d5�zlf���7u�Y�V���R�N�Q�v��U�|������x����-4�y;]�X��m��L��4K3���E����c����O�>�Il���2�X��T��1��>n������L4I��w�*�����L����X_�mg{�G�fq��s�z0�!�M;M�u�äW�;x�[�Pʇ���I�� �4
����BA��e-e�e=�/n��@�FA�.%����2}E�/��d���<�l`),;K���*���o&]a��gO'Eh|Z��f�_��f�Z{�̈́`�Yr�{�����o�8�m ���X�����1({enfғ��ff�<��������\�V+R�1���oy	x,�D����#X�,I0+J&�T�HƤBr�5�	lf2?_>P��`�A�F�XL�f�FpAK3��{��k]���#�(�9�u��U��E�$5��P��<��j=��	Hp�0N��)�/�R����@BEH,��}��Ȍ_G9�A�|�p��̟=Wq(9K3M��^+������ȟ��ǁm���Y;"�C�@���L��<^���}ġxEb�&J�-Ǿ�X�Qq�G�[���ė��O��S�gy���`:��S�6g)���ļ�'�g�y̙o�e*1�pnٍ)�ie(^��73������n���~y�6�yf�*���ϧ+K3�FY�,&��>Ǚ���5����jG����73)��zH����w��&�j#��]/#�ܥb5�	.>�X<���*D9Ńώ��AW�P�~K3�"w����Cϫ��=�B$���U�ʼV�{����1��w&UQ�ʉ��}',�0
���iS73i�g0���˳��Dd
�    �}��êJ�����Լu��d*TS��vv�B�6-O
?�ki�98>��u�����&b���#�nte������$K33����D_�� �7:i�����+Ҽ���L�ͳ>���Y�t"��s�C�L[>6�����3=����"58a�O�|H劉J��}�J����T��6U��8�a鐞���G@��	����yOF�U��>~���]�����u�{� U<,QN�<>���T�Uа4S!+����Dl�o��IP�,W���j8۸��IU<�;��᱊�����Y�к9�q�f��%����Q9v�8��`�����95H��!�T�"�rF}�&�x?��u�*%�[�_~�"��Bu2Llf�������L�^%����h�#�8N��=�4�����L����CÒk�8Z��eC�L�:-�L��f6߅�.�[F��bà�9�Պ�!�[�ff�b��6�i�ݫ� X��I����D��)GJ�A�l
����Γ��A3�q�D��pX��u��*J^m3
�C�sW.p���Q��Uq�<tt�!rKp��sUo�4���)3Cǚ3���u 5�Q������܏.� ���PP*�=\���)J�$1|ai�^�+���޾�%�n�=l����Q�NU�7�*_F��ɩ�p~:��� ¼j-��v����횜��^�nM������M���>���R�+��؏�QJG�@!���fV�mV� F�1B|�y���K>g��Ad+����K \��V��a�$��!���@I)e���5<G��-B,�v��$8��|��	���I�bhw8����`Z��0RE�E����X����}��L�n�^��Ћ��o��I`3�<K��p`(�",/;��iE�Ջ�e �R�4Sј�(v��PvtN^u�yӊ��[ �S,hif21c�������'���t�����oɈP�y���LH	w�P���P_1)�Q���]+���M��Tp
�x�f�@
hf�&��"��N�k���2�6g�_%,誯�,�o5Ч|tUy�� U���(��D����Lp�)�Wk���JK-������Z̆�E"+39<�؈��DT��Zkć
��4�Yj����R#�S9�6��p�/L�1w�d�4���(>����*j���)�+OA/�f43��g!�C�y��\��f���Bͽ��W,x3�����
B��M�	)@�� �9�K	�����ߥ胼�T��	Y���b�2b�U�}������jڣ�.U o:��RQ��T�-� �]-�L�-V޷P���T��$��ed�K�Ry&�Gm�.� ���PD>3�C���JA���B��XY�hM��O�!_j�i�fa�O�P��{=`if"uG �4Fs�@�]�Q���}h�j�C+(9���IҢ��X���d�Y	�^ec�Dfcn��p3��{��<h�VZo�4̓�E���mzQ	�/Q	�[Yx���ӻ�=��S{�e7a��N~��8���6�,�,�sVG�`�!8o����y�X��ݕE��h�l��P���y��=��6�"���H
�Đ0fz&oC����f�43�5�uqΓ��֩�O48���a�����L�cif28c�rq�w3Ē�m��[`RG0�����;��8�s&��'�Gx^��J�:h��鰪l��v(�s���$����4XԊ���3�6�K� ��bc���<f�_��t|FfP@���Pc3`��#!�斺J�53��m0��,�E��ha(,~�ć%�zyDbZ2uޡ��������?Z_G��4�G&ʠ^XГv��,����{��.������6/�&�Q�X�7���Xe�>��^[�6������Y�Cṅ�.�qgE�k@7��x.�(�R���0||p��, S^խ��$����ē��0����)ٟ��K͜7�7�oԉ��5����.΂��
ƌ��q�
z�����m�]��)����Rf�e4S�&~ehzc�"!������7�.�\.^��D�$�ұg�Ɗb���*D��BF��)5��F&��U%Yݐ��ַuZA6�����6�i�5�b��dB\�Ҫ �Z��l�T�nMKJ�Q�����E0�	�ahÏuh��{H\��3�'��͇a��{d�	�s׺31w@�����;?��O����",�]w�7dM�Q;�.�=�����i�i��C6��bfvװx��+z-�7�!���$�KD嬥Q&��n>��-�p�-֛S����~{��ď���ow�m�?}<��v���g)��W��Z]Y����J<�`������,Բs���a{�nd��q�]���ۣ����~�Mnt�'�t{���EF?�ier$o�)�g�&/�������d���A��7���r�ʘ*��G`t���E	�'sr��ia��Zl7��L~��?|� �]�rE��R]�S���a���_e��z�gd�&����x���~w�X�*�ʘ���gU6X�����wf�>��%����[�]?�>v�n?޺D(nښ��y٤��uv:54�n���)�%d=���%�����OI��}�L�1�w>�_գ*�"�Pۤ�V�Em��i2G�p��ֈmU�Ҥ ��í���o���t�����}G���O;*�$B�lIB�x�tX�Dt�������ϴn�8����=�����M�Z�OH4�9�'6%����D��x��8l/����n{��d^��z2_�?\]�İ��)2��:����E��� n�P�r�u� n��d�܋���ޜn¤��(6����jh��}(]d˶]��sΗ�_�\wE�Uz_��e�%}s�?��m�Ү*Ȝ�'�giVO5F�Ӻ�h����|�k��d�U�tb~�P4��V�T���o!F��UZVS��� �u� �
	g�{���V�T���)�q*���o�`ڸXBڝ�%�6���{��a�S��[�z���)������q�����Ѥ�)-�.�;��w�V>�jݚxu�n�me�����=�i��r=�G�'�~WF��41h࡙�|��YYs	��ʒ�!B�!���U4��5��1�p���*fm�U85�"�T�6�#�r	�v����L�c��T�f.G�r��8c�AEJU��<[�p_T���׽j9�A�g�5dUh�$��y���P����;��-Q��g����W�o��Jf�xQ�t�g��K w+��ljt�a��m�d�aW�ie��<�����5�J�jq�R���/���E� �dm����y���lS(.��h���]x�x菷�����Zw�G��j��oz���?�^e:�����E1���p�6mG�`�T��ْ�|�%�OU�d��lA��H��<ÃW6`% �7h���8������Y�"�X?�g9��|T�RT`�Ӫ�/"�R//XF�O	�U�t�@�Q��~�M߳7����q��:"TW���)SL�g�>YU@�S�|''][p� OK�|UUf�ȝ����1���]�Y�:z�N�a�R۫��&VCc4&Ys��M��j�c�1��b+��M��2�ɜ�T�a1�����6�m��"�`�Zq�"m���t;}���='���_�o=};>'6���t"aC�U�D愂���h�����6L���:l/ĥu����?Q��y�}N��P���@�nދ)G��
W��r�b�%^�_-�;S'kE��7~n���!� ��"pOܡa/��"�{ޯ��Gk{6-5~�U�$�s7hԐ�Z�vb�-){�mt���Q ����>G�*X��:��:��Th
pAYiaqz��l�8��R�����|�zfζB�����J}Ŷ��ڜ�ws��8��M�s����ZNbp�t��A[��.�ʮ.�wS��%�l�[Kե�"lzc�Z�-�2��&Z�1L�rPw������K?^�`�M��ZL�8EV�CR���k�&X�D�{����,��2��)�e2�X�sl� �x��_��Eb;�
QK���ZRA�XO�-�멺��ϓ��<]N�/ڛq��ӆ/W�    �I�[��s`֣�Y���V�%�Bg�'��*;U��/4�Ǘ����}v�~���o���`k��Ȭt �zO«L��E�Qh"�*���@H�H��7�O�=�ɮϛW�}m�yC ] -虪�-_;��#D�֎���:�ǳb5����u����g�o��"�'A��C��Z�Β��ƽ��&����X'������{P��hl��~�ֱ�3R��\ݻ�/D��M͍�X��uy>�1޺5�̭�%������A��L�8E���g6�=�2̀nR\�����#&��~�-�s"��>�_ǘ������BHFo�o��y1��wP�s�@���߇�+P��Ё_}����!�j�=J�ʾ�x���JY��
���*oD�>�f��z\����iU��\&6>D�̷��$~:	����_�E�� J߄�'��%�{�̲�gh�J'm�2���)�r����˻��ɉ����s���F,�ߠ��7���"K��9�<ZV�i��)�{$�q�ov��D׫=H�:'�{��%����%D��2��A��'��r�o6��~�vH��o��똉�Ǟ�V��M3@��|�L���»e����6����>��`���0�:�Gy,�d{��w(�~wD�M^�=LFo%�ߊO��9LL��O�Me9���]����8���w1�m��"^�Hg�SD�7�@\u�8�t� ��'�|������
~�Uf�X|�n�Ԃq����Q��|� <����1L�q��*�wi�zKM����d^�^{Kْ�x����v��4z/���7m?�y'd��ROuZ�fU�p�``޽���#���ы�*6�|���ޤ�{��F��A�����=Q�Oz���01�b�5�X��*��v�*��ӕ��餯bCE|��o�k��˾����W���6�R�kK%�<Ͻ)���co���� E�o����v�}��}+�f�[���v��
��QNH���u�<�~�:u_��uJh�Q��n�'����&���=�@�1��Z����f���Nm�Sd��G]S-!���`i��a�6:���Gw,�q�f�T�i�A��BUTw���C���]���MxϷY����`�����cJ���y9mf���`V�ހW�߷~FY?S�������D3��{�,�{R���VAy��Q�����yY`]�K˩����E�S%E�����L݄�ix�M7��O�~ۥ3�R��r7�%&(�U�i�{�]]���ǡ���Oa��M�I����_��m:H��>yF�W-m���U�s�Q��y,�]3�\�m�f�(-�g�<ߔ�Ôi�{���4�l��F�s�J���ҪR�G��{�y�J)�R�vh�UJi�t�V�R>N��c��T�l�E��2�\딭*�|�J��L�M���J�R)�(��F㍭J?Z��e�;ra�ܭ6"e1_�`�����V��g�Rwp�A��~��.#ݒs6�I�F����x�/N�U��G�{��Ȓ's������^F���(���}��9�g��PK�?�6��;N9 G���NBEy�m����HQ��y��H1W>MF��W��xE��c}���5�k��$�yu�*�J�h{)�"���͉H��{)��$�wS��,�Bm� ������U�˴1v��m��v֋���Zi�v�����}������W����	E��u���ӱ5wc�V�6�Un�c6k|�%�=XM�c7`	�FR�T���3����l��
��+{~O��H���Z �A�� ���A���#;Az?�*��(�-tn�l"��~���_����&EFzp�K���_��yy��.�B��N.�.�h�d��X�c�b]��\GC������#E���6�H�D�5�����05��d�)�Vb�g<ccP�#)gic�Gc�?L���3==r9@^J;��,O1c�2�?��V6�2�j=$�%��p�}ؒR��M�"��T��^��r&��طLD9�hif��W����X��LKC��!�F7yձ43���?���g9��^+��؏�=��N��+�*OJ�>��OA�o4隺�4��'N�P�k;��6Z�y�-��lf�h�;��5���)��}g��~��?���7 �9
40G#9FR�	j�g�$�E=u�Z���=�����t����a�F}$�h��p�%x���̸����PYϧܹ����׋����YOST��7��m$���l���i����"7liI�QW�g��[��8����]���%ą��Pf���7YfJ�*+�y;+�=��S[�A{(�}�H���TVϴE�"!e0���pw8��[O%�������r�n�vwr���������j�(m�n�M�)ki�,�
�9�!?<��D~���_C�f��~�������������}۬���;Y���m�%��Џ��1�q�����7�'-?b�Cȑ2��M�����	�[A��<�y�����B�`��eޱ��\yҵ|�N��*�b��]R���:�<\��<>�{���fX����A��H؏��Ο����=NۦG�V]?0���ɘ�����\и����������s�H?.�?{���ôڿ<]�~�;/���v�B:d�^��2/:��ݗ�O`5��+m5V\�x��g<ꨓ����`g����,�h�(W[6x^�a�-�����޷�[�N��_^~O�3"W:W[�����,i5��IJ`LC��ų�K�7�N�\�0�s?5yQ�F��! �{���k�۷.��zM/�0%�CI4��Yl��qC#lo��~�2S��S���!���������M�T��v�;��m8`#���A�D5�Q�L����B�2@��O&�tI�!-Aeؘ����*P��T �W�DkU�h�ӷi}?=��}���
[.�gx"�ɶ��;�*@�v#�]�Cf���A�W��^C :�� л�a����t<��$:�
}0��N��{��^�v��O�!S�B�y��x�*���N��
�)� l���3���M�WP9�)�i��5M���5.�����Ƞ-��S���J����^"YpW�]��t�	q�M�a��;�+	.��
��,��0��AsL8li,��������V[(�Ypխo螮��@�x�K �"5;AG�q>������I �J'q�B��=�4�/�2h6��6�l聮	.�q�De�y6��,|�]o{c?�Jd���t���>�$�A�6�_�HEo�Vv�g�ֿ9!Ľ�4��� ��N�����3��W6�b�:vQl�U������*�/��Ξ�٦�m'���-aD)�v�8Xtǀ\�zy_�$|����.a>9肈+�F��}��t}�l����{ �	o�)�}�tsټS�l�t�-c���=���>B�P�I���zϰ�_`t���<8�+�8��#�>������ڸ��k�<~��B�Z�䵫�-_-9����"y��iQ/E��?Db�p;�P$;�3,�2��Sq(�.��J%Bwd��W�է,?�����I��w����M���uUL������+ѪKF�u�k��-G��sN������������_Rvl�Uo`�1�������kBHE�����4M�'��N@
8�����@���P}R�.�c�K�F(\� (�@S�~<3j��<�:h _���u�2�$hr8ާN��(����R�~#��Zƀ���|y:�$��]�B��K%���Q��ղB?hw$�R�t) (�RL�X�E�'��+���R�nX(*�� �C1NWƨ� �{�qA ([/ƣ:Be��b�p�Cˇx�ԣw�6�!���ɨh!�D���=�tD��gX=>��@�)�����a�d)hTϰbz��\@߾���J�V���6�Vkz�%Qx� �����Ը^p'�f�dR���+�����~9qB)H	D����J����+��o��w�v�����a��j�+���0w�!��;̹8`�;ʆu7\����e*	��ӄ��;�$���� )���-#ay^������YH��{B    :@�PH��.k����<6��Vv�"���Bj-��@�3&�
;N�VT����\��~���-dz�L3�pY����b�oe�(�R�;P=r:t�)T�٩ұB�gX1=8)��k�'�B����k��V�3,��[+��b���>Q���%���M��z�*CSr��魇^�;rzL�e�Ыmb��+}$L���ia��kH{��(��Ц�6���+`��tsL�E�հ�J:�F���0�Q�ذ�ޔЬ�a= �C�d��#d�"�B�O�"����](Q�@�$ꊶ����dC�CԎc��E�E�����z�K���-��H�T�'�I��ԁe9�����=}��h����*G����_�-��~<�@�r��m(�6�	;�Wt|$��v ������G��q`��d���fDz�sڴV..7���J{��%�Sَ�<v�&4W=>4#�Vp�+�,� )�W���+�.IbHR ��֯N����)���Ĳ \�~7RY!+��[]�=@	��n�2�rlzK��O�`����<��uPj���L��X�8A[x��蝜⇼���{��I N���>N�6��+�����N�33-WAb=XT'>�x����S �@@)&��D��ĞaE4:0��Ѡ�|�)�6�H*�6�E�DC��S�i$5w�?���9�B��9W
0�
9���UG@�8_ҭ�~9��:q��@�����Pō�[��bn;He��)s��%m�7tX�٬�x�Y0��뵁��!�.&��~��������,p$Sfh7Z@pu����63��M5G\�i�Vi��z��Tf��8�>|�}Gf��Љs��*m���zVX]G	�/��ʃ�Y���	��:�s�Tr����νĴ�֭�	D��]��@Wdx�{u<��2��]��]de�ߟ_.�3�=9g��gXF_i�Jy�g�z���|����*��X������iU��[Q�)��zKN��H�����#��|;��Nj�B���˷_�ܝ���e�{�,�ˆ>�*#$�^~\˖;������oaH�ϟ�n�Π́K~�z)!P�/�|&+��>!i�BF��}5�Et}BL�k)���]�1n�n�4�H�b�
#�P��:b�b[ %J_L�D{q��|N�p���4���V�I�5�bY��"���F�u��l_��w��D�H�������L���d岅��oƽ�O@&�����N��O'�����|�oV������N~=N{�cX' V:� �|0���R�u�̀��k~���Ě3x�Ղ{�P�>_��1(i��knG�\�kej윋gXY���ϊe={P���R�0����{�}�}�j>��"�Q��!�{��B����%7��@��ä:6�.�i5=c�Z ���캞�i��:��{��r�q�����@�&��X��g8��gW�>���>D��D�c�"2�T��y��_��B�l���k��_�j�_��WZ1I8�s���"Y_�Uo}6�Q�o"�UM(f{z�ܮ�.���1_i�K[C�~��gv�N�+N�j��7O��g������Pmێ ��O�lt�P�"�{%C���ѳ4�,�PU%����7@�>�<�	�
i=-|�$��C��Dg��G
���P@խ�\#��EW����[�5� +T����G'�Q�7=]�Lt��=��V���ɺ5�ӟ�^��=M��W�K+h�Rv����*_�&q�4������Y�hV����ѽ	�݋ �&;���w��7��x��$�x�J,��<_�?{�ݨ���P Vq��`�r�풺�ZA!��~������H��jUF���+!;(�ί&�ې��ڷ���%�^�s����`ۧ^���J�i����P��VǭZ��:�#��=�
��i�f}#BO yW質��v���(V9A��Y�'ʠ-zRQ�G��T��++ւ�ذ�_�/�+a�q��в�V�-{
��}n��%�ڼ��Ie�m��R~dR�y�ƥs7�ʍb��<�
~e�/\�.�g�C$s'�e�!��{�L���v��+���"�UKz��I� >q?�*�ش�K������pG��ع�xM�����+��z�����V�O�Ȥ�	~M�o\W7w���)��J�Ê��Yy.�"��)�B��b��ۓ��"������_��I)����`[�:� XW��F�=�J����s����G�37\�&p\�.(��9��a%ٯjҤ$t�n\�dk�TQ��n*��Z";琰�Ծ���#�|b�f=U�z�HMUS�l'����(5���ߩ.*eյ.��_1ő�[���|@��"ו��}��:����Г�V����J+�y�+��S%e=¼�dN���( �U:oj3cT˂s�a���nb��D�_q���0���R�򐅘���ݱ�Q��!�
zds��_%4�NvK�vt0SK��Vk��֚}�h����/�(����;6�^ϟ����d���Ԋ���7�i�-.�V���ƴ��kmS#5N�r��֨2u�*5.�A[��
��L�m5�a`O����E�4y�D�?h��V�@�I=�İ����Y�b�K�҆z�3����ƕ�Ka&%�K���wʶF�:�빐�O���&�B���J~	}�!r���Tz���=���VSpHe�r���+��۝�8êoF�Gm;ϰ�����z��Rs��g(�yD�+b���Ƈ�,���Z�x<�40γ�V����&�z��4��y���p�;����y�&�*��VfL����[!���J���;�?,�g��0��t���>_}�kU�y��_O���
�X��7�-�"y��CC����n'?->��_��/7�nW�<�(u�6#{��u�b��#��'�G�=�CÉ��Ac�c3�{n�7�V��,H���sLO8��
$�_=�� �����f�3|䑬}��;E�b�|@=�k�%���mo7�`7	��no�
����KĦ9��BG;}��G�8~
���r���j��n������+w���'�C;0�mέ������Ul��wp�L 3��	�����K�aJ��s!�8�v\�x=��@��^�c:-����E�[AؚF�gM���`�f�\��Ι
����X]���(���|v-"�&�zX�3,��u���X�I寡H�y*I620�	��LJ�g!��B�E|XMB�%כǕ:�η�}3��$l�a�@�i %���ԝ���VӀ��;� ���i ��A���x���<[�w���'g2�+6���I�[��� �9�����K���u\]�f�x��{��0�x���pw��}��[z�n���]1h���ƽ�өvygѬ�}�`�Vyd\$�����3���S�Hm�T��k�84ʊK�2��WIe�,y����Ǌ���9��m5if���Ɋt�\�mᣉ����ތ��J`��l��?6����F�5gY�^���=(8�<�m�3���l�b����CðR���\K��{�WPȽ�>tv��>���b_+W±�"ϰ��뮇cV��^Β���5�����~+��VX�"^1K<N�o�����R۠��}��3߭.�7�_���y�O�r+�NO��ͭ;5/�;j�t=�3���|p)y
=�ro�[u�[e+
Tw�ܜ�,�l��`�j:��oH�s�q�h�HԬ]M�N	t]#�s(�$�g��Vg�xo�:�{@�شIm�pKO���=6,E~���C��k,��au#�T0����9=�76���i��a�ou{(�o�d_���Ś䝤�����	6}�����d����2@��L�ߑF�\���V*�q��#ts�
��q�A1�-���`��^nMm,(?����.�������6螷=�58���Xb_ܰ��� x�[1��nϓ�ou��T~n7�'�Cj�{����Ž�����m!���E^m������q�o)�#�K��&t�gk����&�ckJ��|j�~AJ`w}3�-�@o��e��uf\�L�g���F%#�.�>�O����    no>��y����|~�>�����������F���IUIf�f�<t;�z�п������������r�X�D>>>��WP���"�x%� �֌�V.L/��|)�z��x�U%%*k�}�tu#1`�3i>:cC;)>�C��\Pqi���D_�#��%a������j�=�|�>;Y;�n��5[`�-�d�+�8���.�R�� &�D6�?@����F_�z(�g�U>�]|��bR,�2�6]�.�z'+�c]��d�����eY*�ܠֳ��I�D&�g_/V|��5�=�qA��0�}�e(@iI�H�ʱYI{ =���X��є������r�����}�6�2��5��J]��+:������!ϋ����ɀ��Ǉ��7�Xw܅���/���X[�@F_����<��$�k�1�$�,X�*�3
���m	vz+�I=`E�<�
vq}�t�����h�YA���d�Őr�ae�֏H׈�t��H­+���wx�w^��-t�V���;��X��6��b��+�X��	p4��X�G��c�����S�@�A���
3=�aez�&u�*��S�m��"��&�g����>�hbϰR�p��(Gt.�P����%���k��+�5��1�9%_q��T��SȬ��?Gq��x�O��0pq�y�ʈL/wL�PFb�@�dX�����t�s�+ܯ-�Y1�G!��8��
l�K���Sd�)��kg�9��⽎(�ʘϥ���������/_�M>���ϗ��z�|~�Q�N�O�'U�H�x |���X�l8P�_�����"�N���־_�ߴ�"o�������t}������puQۖ��?o?W�_��bMDfO�iu�lϰ�f�w�ѯ�� ;��M�3�f+ ��I��̀�=�*RQ���f��!�&2�Y�C䖜����	�?�3��
�<kaKir�!RAε�<-��r�|<��R+Wukv��D��-��� �T�-#'E�m<�œ$��R�nՍmM�_f�$�8�oL����7d�@�޵@�g��/i�0b�%?�-qx������xY �Ă��l,d�Xe-@�#�S,J��_b�ĉK|+�Y�C-�Oy�y�jhC�I����ߜ��Q�����a�x��/���ꭆ2A��㚱��Y5jp)Wd����ܣz��<xw��I� ǟa�����x9&Dl�q�v�M�x���$�%� Y�9�x�&��Ǧ�h,p��G��/E��V>K�""
8��#eF��� �%�"W�8F��c@�q�,$�q�)w W�jj ���1�M����
/]��a�q�<��!c�I�w!��X����.�N����9��G�m�p@�S\�G�
�V�`�6|i���)��O�o{�YF�2>v��Uµ�ׯ�#���ǳ��ulXa?:�6|�rϖj�q��-꫺�4R�f!z��-r��j^(��@�ml��k~j�#@O,�������+��I�0����=���7����UZ���N��E��a�oj� =U2}x�0�+U��~q�w�źL��i���R75w��MV�*P>C�	@O,�/��M���gX�|����J뀏�-�=$o	}��Ǫ�y����y�m_�g
}MEo�Q+/���-Ģ��:@<���a���̆�@����d!=�-�eR�o<x��c���/�5��8�V&��)�>"��4x�U��~�����rc5��`���_@��J;��˟��1<Ê}3�xrg`_�C	'� �֊Ԩ<��	�Qă�+s�ȴ�*qM��0B�����w ����a���$�Z3P����em��p��{8ɟ����9��������f��jo������7-�u*8�������F���nS�!6D����n���t�����Ĺ)�O[ԧ�ǦC��\��
T��4b;��\3�ԣ�?X�ٚ���.��o���or���&l��o��)��MM�u�I�ƀ�v��= N�Hq�����a��zD���T�q�;�:��ʞ�ĵ�˘�����z׌�g�j-y���R���f���l�2�Ӓ �@oj��A�3@����2k��������b�J��Oğ��A>��Eү���P�O? ��tZ��4ܡ��()#�a_A���V&��o��W;�'�*X��X�%Lø���XS�W��:�=Eu�����(��@�����ً����{G���a��8��t� ��zw.7���#��h��5�ĵ����(��jQ)n,��(w�Q�3�_4,w��J�7��������X"�ΐ�_"7"�p�}��%r��� >+�� �݃{ ����ï7Q_�^�bГ�� 8E��#���Fn4��\�y�a/%s�9�%�2'�d@���LM�H�lDc����ډ2�b�a2Gj�a��f��ci���
�x��a8��v�4*�go]���c�A�|�xT�#�5�Ќ��O�k�w�/vYy����~8w�pn���Ŏ�·gX���I����w���BoC�}�Н�8�"��04���6����y������T�n�w�V��Y.3nϰ�G�S���+]��Ji�+�S ��>:���9�@L!ϰڍ>�W�[�`�S�6	�����GC�>ZE|�/�hW��I�7	�f}}������kC�^�A�Ve�7�Z͂�5VS��)lr��@{�tno��چ����mu1�R���[1-wߐ�p0��Z�?�;{�q��U��v�X�$�6V�8��Mν>N��/ݷ)'38w�7eH��l���D�3ya��ri�tiJ��f[4my�Np��iJ��h+�L��B�p��NG���V�1my������ʔ����drq�=��q����̔��݉)'[r]�<?�$�黟��OOs E���˷_�ܝ��K������������������4��3<M���� ����`���=�̷��M	vX0������������fz��?"�3�K�-p6c_���o��+���W+� ��~��o��Ֆ*�(C�?4��U2Կ~#�Q���~;����Uª�Ҩ�����_�*q:P��&N�ҿx]�t��7M(N�.�o�����#ޅ�����-I����VޠV�JE;�ѵ�3��/_kx�p�-$Yq8��۬0�e[Qh����3���b]��`m�d�%�ldy�t�o���mM����B���m�
v��'�� ml��}�6Ko�V�ZfЦ
^4R\��b�1��C��%�3�ܷZxK9\:5�?��R8���w�	�n:�o|e��o���p������U,&9-����H�׆�i� ����bҙ��"0�09�;�<�L�v�[-�b�P�� X�q�� �Q_�-��Z�eC�[�%��v�Ng��������YG
8����os8�33��NgĂ���_[]D����.c����`�&��n���`�:}��������?��vցŹ����i�z�n�h�`/?�l�ʧ���H��j��4� ��yd��ͮm�f�mC��q
`�Ԧ �:��J�8j�H��)	nm�5��қ��0ñ �a�qN��'��]ok ��qBe߶ %��������~����X�AO/W�ͥ��Z�\d���<}����ӷ?��pz��r����T6�4C�߾�x�C��?�!�4�6�����o��Ʒ�/�ط@%�PI���.Bh��׆J*B%IP{Ug�<�g��Oߐe�!�`���|A�R�����P���]W
��40��\,G�'u�1&+���k�i:S[@�|Wf�꼚��]�+C��t��޾�z_�(��I�@�n��-��/�g'��2i�A���3G��8������2��,��w�&;���;�P��/���!�Y��4�B� e��!���oOW}������߁�$�Wa��(^,]�O���!:��q��Q�q��]`f���Hm:�2�"�_��:��Y�a��hY����y<ݤ��'����Jy��a���%)׎@��㱓8{=�h���WֶY�6G$m���l���0YXz	�$�3���!�Eݓf�F�dS    ےl�YX��F��r�;�� �1W�fC� ��a3�姫f��X��ZG��J-�U}�m�������7��+Z����j��ĂJ����i�ˌ�-9^�5�F��R��7cVlA5�Πʛy�@�QL��_nC�\G�m���h�"�X�}����3�6i
���Bd���]E�G�{�d�Mut��=6�rzɺ�a�J���a���!�R�&-�mIw�[?�3�p�Y9� y�71����ss��铱�����&�� f�
�<Jy�ےo�'�|�>7��W�ݲc�]�R5.��3J5&,��?�K�����p(E���-?d_US�b]�#ʻ�А���4�����z��p�\<+F����	4A�{��@W�h���$Q�9�~��mz���gXA�ˈQܯ��/��E�r�K��r�2�lg�m�K�%���*�c`E�� @4RF'zR:3�![���O��d���Ib��DPQg��`E��tI4��5��wU���z;���a ��/��-@N,��C�{��� �}݂j�|x����P�rg(� ^��N�2kFĂě�CrY*��1<�{'�=��/��U���]C<I��!i-UK�"��ȉ%����{a'T�y#z��ك�X���!���<_y��{o��xH�A��>�H!g���J���rL��3	�II��<��\������
r������DRR�#O�.ea(�����>��n)�9�V�1��VJV�~M�%>@��"�2*a�m#,g}wϰ��y�p�����h,�A;�w�t}�+�h�g����Jy�B��+���FX��_ϰ���y�Z"O�#j%=��NHt6rE���-ʳF�+�d�T��h*� -��:AZ�=�Ş�_�x(��))���7;���
_�ZYR��C�!\=�)G4s6|����Hw�:��źL�R��sϰT*�+
}	��B� {b	=)z�.�a{@�Z�����:b�!ZK�K�5E�W�a�����Z�+���F��*�S	{Ҵ�Aϰbp
P�P��R�� �[r/��oR��3����V% ��Tao\R+K�f���gX�?4!�N8@s	�&�83�Z8�J;ҿ;]í��%4��8 i�~HF�I��C���j�eظg��Dg�)�����\;6��T{���!8_�+�>R�o�wϰ��֟��A�L��@{�����R�-wΠ������˚��rO����d�b�+��7"�t��	�x����hZ+e��H��Zxf�ѕ���hqf�S(�޲�a�C�6����L ?d��nQ���@&
�W��g�2�-���B�3���"~�&S�b�+�:ĵ�����*��iì�㒂�+�5�}+��|��]@�
ݲ_P� O�5�:�ы(G��x��h�<���3���d�р�Z]��ނ��4�'X���<��� ߵ�f_�`�7�F��*��P�)&�J���,d�W�= ZY_�/Pj��.+���~/� {>��~9kz�i`F�:���V�
'�O@Ȓt<%N {/�D/چX)J�A.�z4NA�T���~�u@
�ސ�P�������Y�m������#Z
*(���eO{(�{���gϛ��@�C�'�l5`�Tc�=W�zn��l���d�@�s-]ϰ���q�Ƭ���i�|\Cӝ�����)�M�����)(蛖6����@�)���X�k@�0dCv��c`�g��Vg� ����hcz��0�I��<���&�Ҟ�9l-`!>`���R �j�����Mә�UTי�i�63���o�iH3K�gX6�,�Hc�Z:_�nH�B�X���4T��H��j٢������?~�>%��fo��ͤ�-d�M�v��gz�|�Bd�n>N�� H��O�5�=�<�n�]��L�Ă]T�UP������'�D�c���i�3�3��j]��d�b��:��#���g�����>?5��kb2���R,���XfK�^o���G�tL�>6�e
u����3(i��R���5�2>޾�|>4�w�����	��y����ӏ�w��� �fx���z�%�U���\5�/V"^O@W�E?K��C,�I-�>4rnUu�˵��@�wm�\�U�(�^pCY�PP��#o�%{�X�L�)�h>��Z^��ej��O	!_��NV�}�j>mU���D��˅Y*�`I,�Ml
#"�s7z�g�1�}�Z�Z�U�(�B�6]�.�N��:q-�f��\���;���4AFSӅ���[I�&H.�o��eXZB�Fr#L�}抍����7����˱j$e���=Z�BNk�n��o�)��^fs�I��Y��&N�=Dz�>>��ƀ֯�+���Q�UE6�`s�8��h9�a(�K�KMQ�w���:�&R��m�vzw�IG�A�nUذ�}���7F�(m��1+̒�7�9���>�,���\L�,w9���	h�q��X��J����~���Od��DLC��ƯcV "���hlM�{�`�ʖ��C�Wy��@bz���<B����ƁK�.iM��1ry����%�Y�f���ê���J����گ��	{��L�p��m	w�~�Z���*~\3���syWn�2+���i��~54����2J(j����׶O����V41҃	��?����p3����AF	^x�3�&�f�$�	ɜ�:O�q=�;)�b�M+��������1�-&�]ﴘ�R���X��mU36�u�A��ذ
��φ������g�nZ���v*�E���z��g4�ȣz�D	���/U���Xpu� lX2/�����_��_еO:w����룼FN�������&	,G$G�kZ��ц�8�Ć�ܶ�61ŧaj�Ƨ�W۫Ʌj[�������/�[C�8��zԘ���X�m�Kd�LF�N��m��yn��p�0�ȨG'+��Uu!T�Lf(W��\���۸F��S&�"�P�u*��<�{j/Ѷ��/�%��ɈI�d|�͂&�G�8U�^G�)`Nl1��]3�]�&/8���8u���jH6��m�����N2�7�q��V�TBa���HZ��7L.x/w�[�{%��QO����HJ�NH� '%�ǆ���<�lT�Y��wNu���6^~�fV`$����@�N<�ʑ?8����a�_�0Jя�źH~�o��+��N�Fj�l�Q�="D��(����mC�Ev9����5˦&uD�� xK�Z�І#[:�a��4�j諉�qQ�|��6�9�V��Y�m,(�ʷA[}�[e�;�M��N�a�P?�j�J��c�2���݌MK�ǇU�瑛��W,$Iཚ�A��2��-��+}S?��j�J��s������������������FO��2*��jU��z��- Bx��Z</�_�>ɯ+����/��))�@ʈ�|����p�V����-�<c!��|H�z��5ьV�dvT<�J��\�}�E�8�Vr[��?#�x�U����V���
�������Û]��J�����ǂR=1>���V�珘,���VI��9F�s��6�z��|���ڝ��!C:lx�UԪ�q�}ݓ=)�N���[���?2N��ϰ2y�5���y���T~z8u{����a5U���������So:�L���B���m��?a?"Ӣn���G�h����m���^ �!
GZv��j��CJ�-���\���;��@Qw�I�;;>�N֏�֗���P���@����4��u���#����=�7Dy��r��K���iO�a��&�=�X��JDY^\���x��"�=�/�FXR����ˏ��o��B�k��{4}���"Lpt�lXM@�Pye�g���1���A� ��`�'A4�f�\��3�<������ K-3	�g�d��_>F'��_��94��Y
��Օ4̶���J��N�]o-l�^�Se��=`H��V�6;:�
�p�gX�,h�L�qf�^o?�'�<�ɜ��m3 ��nl@@%��i�\V-a��[vy����    2�`I০��&k}6ҡ��eA���PV-a�:�%������x�r�ߗ�����7}{~��>��nO����'�����\wy}����^_�/�����W�����/�R"�z�OD/�]>��'����O����������C�P�`DZ��Z:�(/�#�%�����۳������� L�g�]�d��\��g���w����$�."+a�Dx0�uޤ2�ϓf@J�Oþ����	fO��h��p%�8�#�L,ȩ��YC��fx�n��\j�̮�,mX�N�>:�2;]y ԭ(`�Ѫ%���Ɛ�O���(/�g'�h�>�=*Z��~֎�XK� ����J�4��Qy3����
v�_�����Bi�!WKZ�5*�>MÝ��a�J35j.�R�����@r����s$ozg��;:`35Ar�+}�e` kIl\%v�5@{2�F��)?BT���,��F��)��6d�jϰ2�X˪��,�~"����/�ǧcŪ��
�a��U�4�H�~���hY9��I�"[_�a��Y�z�1єH���4�{��-�N/�.���Ȑ-�~����.`f|3fEr�S]�Z�kzh��U�7��i��~��J,�ye{y3vk��8��'Z}@ !��zT�1+��[V}2А<ϰ��j�U�0�`�u-�!�u�L�@�U/Ps���i-R<�t�S �X"�U<��@�y��ƨ��z@�t�X��m�p�FB�a��8�x:�Q*���cVL"�x�u��č���׶1�|���1��mIwJit�@��Ƈ���C
�C����Ǭ�EA�����V�e�8�%�!����Q
|��/�5rK��IY��lX�3�g�̈,�!�8�VD��<�,"�<72�*��_8��D�<*:� �*%�e�L��7�&��J����1⬽ƹ��z����$�ė��M���<S�q;w\��=�I,�Ʌ�	j�u@	���H&�P��8��1��Uf+��y�Z������BW�ƹd�* ��I��J�eW8'�{HJ_��S��VT����@��h��7gk�g:"L\����+eE1GwB\�b�XW��Xz�4�Zg~� �TyA q��gvs�68$��<M��#�[*���f%�#n�x�z��!"N`>Fę��e��j�GH�hd�"Tb]m{$[�1�:��mud�$�*�C��I�x��I��>���V�υL�z�����a�i����c���!�Z��'��ʠ��=�
|��������1"��j����,g`�;�H��g��l�֪?>-�H!ϰ�F�y��c�x�u��U��;�R����UƷR��/��B��C�긦:zu,tn�s(�P�\������\�y�a/%Z�V������3���'e����{BG�q���W̀�+<�*����W����5��GH�b}u���{�����L�S��
�����ӱ��p�T V���]}����B?t�|Ţ�a�n71���b^����`�na��N��UP��6������� }���͇�+��_8��Go\����M ϰJA(���;�U
�G�ug�na�/���S�cCo����C ��ʅ�e�	9��VfM���Za�@��[X�o��^���������7RX|�!��,k{S�M�`�_di��c?iy��fOa� ��!d0��> ��_蓹�<܂�R����X��a�גpW��+��H��i"�Q���T`L20���\�\>�t�c�ZT�ےÍ^�?�\���[�z� �
��{4m�_��!�(~F��X��oe���d݌�%�2�+�M=B�XFK��ީ��2������2XP�=�n+���|����"VJ=Z��GTzzK��Я�$���f�ÞB���C5?�I��7���$�k��YĪ���>V�q��M"��k7�]=Z�g�V~����2gM�t�Pھ���ڑv��@�,\fo(٘t���c�(<|s����chk���#�1��:������}�����������Ǘ����^��}��}8M"������puy﹈�S�8�6Ո��q�P ��`�7��;z#��=5��hi\�T�S:�^2CC����ʁ6�Z2��\{D5ӟ�K��]�#@_����G�r/�I�m͊:?��L�I�j��Y�'��zz��+�<z/#B��Vy�xD���5��y��<�ZHK��y`h�$ϰ���a��<��8��*�1� W�*����R<���V
�~�L� ��f��sЃ9 �R5z+14��3�6��'��^R{+�L�)��z+�� �����a�^i�ދ6|�{�S�}���H���>�|=����?�����Hu�����[���7�������r���𢿀�#H~�b� [�\���氏�Y�e9'��+���͢���߈#��F/K�/1\�fD.V�4Zf�Kd2Z���n��V�0l�.?�M�_ �Ĺɇ?6�]y��7�ś�v�����G"�"�`bXsO5g�M�O���:���S�|4�e��u-��I�ah*��-)p��γ���Mv�o+"�Ļ���r&\�R�43_�K0W��3�GW������iQ�^�vA<W�S�Pm0`%�J��@��zX)�����N
b���^ �n^ �W��j3�����|�ܞ�����_bf�mzd't��a�_J���р�8�4d.w?���

'8��H�ɷ|������Ǘ��s�H-ݫ�G4haGe��c��Lӎ��"94=VҼ;V+,��$Yv����Џ:$�K����pW�%Q���uH
Cұ}i��;�T<�nRQBr����,_>w����@�u
{���F��MkS�� ��x�c	o0�6�g�m�P�.��e*D��"��W�'8i雾l�RL�A��}~G����/Ҥ(B2��@X| ��%o��e���]��]yBqȁ���Yr�Ȓ� �%'�-e������A�\���RB �=�)eēj����SZ	;=�%%�%]팷�����f����.��#0��~S�N!tW��Vr1�>4i�	�Go������[�@Եs��Ɂ��O��,�cC�Dn���D���E�����X"��>
=7詃�{�+�=�h�`r<(��%�k���p��$MD��$�k���*�}ߴ�ɹzr�J#<����@�rGq���s43G_/�d���^Cm�o��� ;q��9g�]4�
�p�A�$�==��Q{��ԑ�]=t;q�W�ծ!���yM�� xG޽Gpc�O�|I������m�����|��'��o��󝟾|������7��+��{m7�OK%�~џF|����Ʃ��X.�����������r3�|�,��>>�'��8���m�?[{W.��kS�g��'�} ��M�}��q~��KW�sf��|��0ڬ��d�^��݄PJ����A$n��I�<�6�Z��@4N��HA^�+�>n��m�4�gXB�a�=���=�;�Mҵ���}p27��YdA��fѣ�݄��Lx��(E�Ċ(ŊR�0�J%h[�n�cն{1~���gx2�"��V�� N:��v��{�2�B�.��ʳ&ڮ�t�b芦Ebs�ai�v��8�/��K;`v����ꠄx\ ?�����OKı��nd-�1��:2�����yrQ�;Q+��.5�S������tM 뻩�ړ�|��%�g�D��t�����K�	]-�9���S�
��yZ]�ÓqA�\Cо�6�������j�ػ��=%�g��.0�Ǜ:���-�:,���ɕ�eK���½8p%�=�n ,n���;bp�:ڭ�e�[�il���!�ƸgX��m��hX�pE1\��2ᾗZ�m��r��������ߓ�>YE{GO�bM�a��CIːEE�(�����H���������f6,m]to6fw`�qCJy�'��,��D��nˇ�U҄�i3E��R��~�$D��K��*j{��Z�4˿���:s�[k.f��=��!'�=ÓjǼ �2��_9���n�j�,h�^�hb';=�3d��ۅ��W    ���!�����w����<9���?�_.O��q�ٶ��zyx	Sn�E3�w�����Ly����e�_W���Ό����b�񐼑y�������t}�����Mݺ��͝�	��y��O�'�>^������������ӷ�@�ԯ��}4���I�}zE�:L�]=^_8꽦޷;Я_��/O7��<���<���4���Y�_�����n_�5\��R.��]�n0=j@��z�'�1��c��Xbf!�����H�6"p�l�+S�â�l��C#�����g����H���U��h�9��l�k�	�!�7C��{��Ҩ$�'��d���[�1C������V��n�ذ�uM�5���H�����a!;N��m��֑��1w�N�j�c�ǘj�s(>��"̴л��Vg4�_��-�+��0~����`�����w��V�e��������y�M�W7�E�-=��Ne���������g��O:���� ��FG����!_=��U�kyE<�c�?�k�"5��,d���|��h�*E��&Eo�յ����8�,���{���8	·�>��������x���������|�ӷ�����1�.����\����އ�$D$��o�,��1��J�.���ު�p�����9���;����e�u`�������/�5J�^�M5����tu%Χ���.�y�}�a�Y�9�"�,|ovE �_�������ۃ.����??_�Nr(� a�޼ݟc\�x����;[o�s-A���i_�IZ�jz�Ղr�3��g"�y��E��-�pƟT�s��� �gX�>�q.g=$������x-��~�[�/�_C��א5���p֌���:�����ZY�4�zS8���K�����Vl���l�.�r�˥C���J�u��]��7������˷��sz�>?�n�O/;��d��t��z�}���S����`w��gE��k��1��\��>4�^�^n��Y��{�c)Ax`w �$�ث}���������`��<�$���>��O���{i�d�'��z�i�������]�?�P�di�5���E���I@3|[(UB�uAY����\���y�,�p�=�&jǨ'̀uIŇ�O�ҁюp�� ��lh����Y�-���nnv���?�����k��5R��3������`'��D~�l�.7�sh����޶3�E�3����h�`�>�"�3�C<n�N,�����xS���N��v\ıaE;h�Eǚ"�$�o��� 70G$�u�����̺��=}�(˹�����?��C{0�ٞp/��A���̙���� a�w���mm����}�>vV�~X�֤�5&ؑ��V��!������ЉA��FXe6��V|X�fi��
V�����*9����y�_B�u�{���۽"��)Ȩ��)�?!?>��O"�y�>M�o�><pˡ���.>,��6k��y�2u������S�_����(ݫ��hhV�7mW��BH�َQN~ɤ`��B�L��*��ld��J/T�[��B�Y��!aV�1q�<#�wܞ��^�fW����.J�$}+B	�q���%�'A��p�uN�\������W]�$Hy ����C8�x��\s�)	b�f_0i�(�X	����=|'
�^��x
��g�z�j^���)��ß�v�P�#����~�Сw��-�1�����ٳ4�@���ݳ���L��*�j�u�hI[I�ԕ��+O�ޞ_ԟA�T4�ښ_N����;J��
�/�
�4��Z� כ�9�!ѥ�_6&8���3n�Aq��VáNSh�{@8�e�b��b�Ê�a��r�1[=����8����$��<��^n�?��L���q��]���L�w�:�ށ&����/ѪY��ν��� π��-♵,yyZ�!�����f����O�y
)���9ɟNN�Ov8���Ƥ��y��z̅j��y�׳;8za�u�0�_vy�	ް?5Gݸ���* �I@}@5ϻ˷�'94lbA�7v&GwX��ճ\o$��8?K����h��T�:���<�L*���j����8GB�
�l!����B�m�!��ٸ��s�������H۬H�F퉯:�B���0��� �mP�F����:+�m�4bul�"�HH�a�'��r�e��;{A[���6�Ar�=Òf��<�z>�ۭ.w�KB�����(+�TkҼ�Ҿabe�Lb���A���(�t֢I���� ���)i�Xgrϰr�d릠.IuP�'��i�}[Ot)i(�C�3,��O:�|��5��^ʎ�@f-J�3��9�
�.d�^�K9��Ⱦ<��#;���7֯O�7WJ<�.�6v��҄�W�{�\+Z�m%�p��;���#*!*ok���)H��a�&0��*ק	�ը��+�}��k(�S�Vd�NX���G)�sO὇?��k5��G�NG�9U�3���d����Aun���[�)��-�)��N�nI9F�պT��]���B�B�;�z���!\�V�益�`<�u�f�O

�LO1xk�NH�Kޟ*�Y'@B�k�u"!�/�|��m�I��>�b
~��_�5���]��x��ힹ�{��s��g7��t=a@A��]ˢ�%�r`�<W�;���+з��y��6j�D�@�E�����ֱ<���88�#�=<�J��d��<�E	0���NT���G<�g8r~�3���I}I{�+�O: �I���v���S����i�>�a��`7��6�1�9��c6�9�Ε�\��ؔ�iDEN�}�}�j�~���$EsB �=۳`��Z;y)�z�o�5*�7=���϶η�W?
�/~�9i�ᆪ��ŏ~���}L>Ѐ��d6�9=�q�4'����9nY�������9#B�W���n� &k�6ܾc��N��v%�c/`  �|���r���f�c�J3֩��t�_T�#����D�B���^y'~���M�x?�3�W��;W�{��4 �!6�F�f��>�ۙ�aI�+����_���g����d��b�Q���X?��F'��.�VX��8�)�;X#Rtzb�����3�9B�+�e�%�"� M�	!���{�S&9x�4j~�7�aɒ�YNȡ�#e3�B���}���a�<�
cY��&m�h��d+�y�&	(ĮE��U��v�N=�e>Q�jL:A�c�^m8w��Y�9Q�A7K@�R��x� O����Å�i���5�>��a�,�'�)�%��n���.*��qx��q�<�
oa�G���,%x����H��_�:��,H���ݗ��y�)�pF,���4���R����}�{Ŏjv��1|=zRC�T�CA>>L�����������ˉ���w�\<M˭bcm�V�
'����s��Bs~��W�����m���D�v�ţ^�]����厯��;���	d�:�aZf�/��B���]3o�	D�C��%
���C������|�ߘdx&�{�H�pj߱��N�����.���wO���޽���;u�������	����O�_�N���d$�{�p;l��|��w�󾝋Td���M�_�&��.�����o��	ʯ?�_��Jm��S��*���[�խ<��"s{����vZWO��>��{�~Ħl�l��qC�ԭ��t���L��KT�4�7�!�����9��� �GV�y�_�Gu����VWR(��E6������FVF��t-�3�sU ���B�W���QHu���޾>6��~��HDG�����Lz��\�
���������~z��Xy�"�����y�Ƞ�GNHk���TICp��pӶEe�M��[~�Q��%��Jz��_����b2�����.}}�,5=*��l�s�B����iv�=�VU��@��9�nl�q�"����x�M&�u�ʀd���_�ީ��^n>|x<=�������^��8tq��?���-ʹ��|����%�n�7�G�_�N�1�O/���8�����t���./�.O�>���������;�4S�r/i���i�|��}��O�	�m2�    -��u[���է����n��t~8�t#�k������q��k;?��������������r��p�M<�J2՗���m�ӹ��eg�m��u�y8}x<?���I}�z�ͥ��!�3b|:&BY�ߓf�Wl�FL����Z&5�w!l�!6�Z
� ؞-l2Rw�q����<̧����:���4C苘�p�]��� ¥���p�g[.Q�-�A㣈�Q\�xCzhN������n~����r��!�ðRG��p41	�!�� f������%U}� ���Hv��bG���ѡ\�����V'2��w�,�o�+���O�'Ci�WRD;C�FҀ4�go��XsI�ա/Q1v�(.��5�8��{��fI������j��\�Jdle�r�������a��'+��y�z"):�:���,���L�8�ETM|t��xr�Ү'�a=�i����~�`�UH7k�jr4#�(Qt��1* :� �F�M5���7�i.�g�JB7�0���4݅du/�g�����^*L+&F6���i+��#�=e�z#/���R�U��-oM~ÆM�}'��d��Ŗo�$xm�%��% �g��Zv�����ǳ�!J� ��w��Ed�6^�%����o'��p�V:�u���-�S�����!���"q������Q�jD =��8�k��T4�FX�(��e�u����Q�����t���K9F�I`I�G�kcl�6����݅��\jr=�hE��B���V�)��d'+cjQkJ���&�mZ����_��WG�e��_"|��:Th��Ve��s�_�k<�<G{�co�"��:�ž%>���DFG�pˑ^�b���<��i�K=� �B2�c?��osw%��?4�4Kh�)S��;`
�a�����"��-v�z|xyz��{U3�� ���VxE��Td�0��Y�a7�v�\��nǠ��+����;����,2�����B��m� Y��z�pd�(������ϟ寖�c�dŞ�^���e"wζ�صc:���A����.|�v��!��kV�����8�Ĥ%�������%�¶AW7�^;6�hۅ֋�D��F&^��i���n�qni)�(L"�nE�<�Q���F����j�_/Z���'��/?
\�غ9�j���#;��׳�5�qҟkxճ/6��c�.���H�7����_��+���(�����|3�0�|�Q��l�_�쥻������XAR}��Oy���h���3��e������@/�+Y��+�3��Z�f�h�B����b�}A^���5
�-e�V�MV~������?�ߪ��L���]�M��������� ,�e�/_�l�: �-C�ͮ�݂���~~�;?��`~�u����N������-���������ۗ{�P�=6�6_����~7�Q�&���(���Xd/It�y�Ʉ���O~4,�l�������V��Щ���N;���Nzmor�w��RwG��M�&~sI���7����6���ϤU37�9���s��6P�qϧ�?=˓u�n���堌�1��Z/�y]׌��o���D(3P"��s� $��q\�n��[V����o7//_��zq��t<�������I}!��oFrB�dD7��~�n;c1�T�9T:&[|o5��o~}��8�7GV��zr2���c6e�׋߲W���o?�;�
v��~����ww�7���+��!�����$+�,��k(yo�y":=Q��8|�t���{z�t>ɷ��ۛ������<-�OV�1Z�~z���a򞨧a��ɲ��������o���r�}����t}y���{U7=�H��n/p(�'J���=�ߩ�N�5���w���{:�����Z*���Mݝ�5=���g6vW�k�yY�r}x�,y�Kf�p�n���I&m��5��"�[{�����:NS?�槛�O�˃��?���n���,a¯��=s���]}��xDT��?!0�~��q}�����������$����$�:f�!çw2�8}������������0<�����9�=�t�МVV��������4A���bi������н'����dX^�P6��2r���t��F:�(�wX �_B���O�N6��k�u��d��>a��v�P�e�$����~�P�{�_�T?}��M��"�ʛwY�K*��0���
�.U�ϒ��9Q=���j�P��P���Ґ���,]��C!ZJbLU�6��>2j��v'W���A���
���t��K22'�y,����w��^>>].5p~��B����4]����|+��s�����O��5[F���U�J�Ő�������1�1�V��1_.�l%p%EOz����=�E6�O���/+|��'ٞ��O%1�9�g�#C^I�x~~��dH���";����$���o����_�X��B	\���I�k���a�F�A��j�~.�N%�Uh�d����}5�)�P�Z�|��aDC�~H=ف�H� �*�䉐z"_0��^S�~Jt�\�V0(��BiZ%�Iy(�)х!�E	��A�I��'��o8p��{��QK��	�`�䪊(3D?y�f��L�L�!�i�X:�� 8�����7��GA�.�^��E����p/V$=�C5��nC�XA����:���k��g?z,�n4�v�Lnc[���C^yZh|uUHO���Ѹ]���=�������d����kVg���H����r��^_�^��OCCn;�ǩ�>}>]n�O�]N�g�Z��7;i�Mn�\V��˭�z�1Yt��"�nO_�&M_��ӻ�<�3}��vu���c��s��Lެ[Oj"�������eZ��,������L�uyzƿ�B����Z2Q���es����r�p�x����>��R�\���t����no��_A�}��ӣ1�G�&�mػ��C/�m����WxT{��B��z�N#�i����޻O�g^t`������Th>��^83��_%*��zZʯ^&�[֌D����^��]p��>=\n�/O�/�SA�tF�SAS�eMŧ�ݩ�L��ۻ+��t:=ۉ�,a__��3��	��%?l�b{fbK2����1/�7ZYS���N��SIcm�D^u�U�f`z3�/[��"�^[���O���� 3�g�ָK��� 3��������Ox��:�BS�Q���$�������~�<Iӥ�-5f",D:uC���zx7���9�n�Z(fȗ������b<h�>�>f�u�������Ы�=�%�A�A}�?���e%<�e�>����g���jWs����E}���N�=�d�]�C�m'�c$�5N��a����6�3e��d�k6�4� E�[�YR�w�Y�)~8K��p�Bp���,����s�A��0�����n��۳'7����=��ۿT޷�����R�[-�7�Ȼ�4�D�B������B�;�"�b��I%u�9O��a3E;~k��FX�[��G��xN�䕡�{=#�`���P�d̋��K(�S}^v��c����*�ΏO����d�sr���ל�]�V^ �x����r�A_��WM����JK&���`���-�.^�]1IwЊ�K��O|��c	���t�u:�n�
�������or}F=D&@o��l���oAJ��%���u>����_��
,��B�U��1��T�E�3��j�O"1�^n@ �0J=>�|~�w9��bo���̒���)���� X���X�c��>�Dd8T�@�� �#�{������/���[��g-µ�e.��wW�#���Cg�G,�^z��b]�#�d�/�pt�kς�s`����L������5����=/S e����֫��n����!�;YmhA�m�e�����7l ��UR����IX��7.�Qe���/C�]$f��zӛmhӻ�Q�w�}K���U��@?'�r�'���5��������Ol��Ѯ��Qz��gLՙ���i&�Wӓ�5����0�8�X��<�\�<E�&�s�5���� ��FXO��q�{F�+�Q���]���8�P���/c����N�D��    A[����[�g�h�ɢ��	����?K�����\��ܶ�n��o��g��+����Iy�����B�X�X��}��c�N��j�A���Jk	�eV��ya����twy~�+ɧǧ�ߧoy�?'C���~�������������ԣ�C)����Zb"6��Qj�k�5��Tk@[�5`MU�5 wV��e�d=��Ϛ�Tk`���k��ϱ��<FgGņQ�k�g�Q�50vf�b́�y"Nf� ��ל�k�U���@DT��V�5�C�o��<�B�l�m�h��Y"��}���.�&���2����_b
}��Jq-��Y�����1RM߷�������0J�8�z�J��Vzo���J{��Q&�#�ꘃC2&�|-��{'á�|P�<�X�= \O���.��t�ug렌���i���d�іޛ2�s�$*��sײ�d�?�s'QV-�F����?(b����6ȸgh���{��O�y��D����&p��g�iQQ���)	<1�gO��2��"7HG~��/��eRn.�����̎,�kM�[��A{��n���i^������Vi���M�0�L��;l��މ��?g=3K�RjN��A�=�N����5���@v�Y�m���-�iǄI!ÒsA��X�I9*�/����掯�4?u%�Dzqǿu�U(���y��������1�K�뚐��d��!�M����h~�+�ͩR��ݾm{�7�M�'�b����A��[!���o�4�(�{i��`:��^[a�s0}tc���^�:���{I�>�'�L�&�jݜ����@:eɡ����艈CzYӈ>�޷-א�Y�:���_��|Ԗ�� -���4��s��w�|b,�n�����W��h}�;z|�g�r��Ȗ5zy�zXY3����̌�s"q���u�Pq"�9C��6 �����e�LW�,������Q;��W@�#)�@N�3�Vc��hbK�@�Ŧ�Ƕ�E:�����M�+N��N#��,��`]���å��P���r�hnt��g<�\sc��@�0>(�ޅ����D{�Ӯ��]��5�v��j�G�R�:�D������N;��ķB弖4�u��>�\����s��v	l��y��b}���K�����C�v��` -S;�E�A��(�{h�D�d�q�r^�AB|�Y�%�(gN6���t$��б��MD�F �J"EQ�o0�D7��%�ؿ� ]7j����,�<�F8���I8*G�ɚF�N&������cst2_��p
m��6����
��2Y]���)��T��h+�^U���G~�&�-�0��[I$h
B4_oZO[���j���P�)e�k���6S)�%�,z����<J9qH_h)J�j�>��>6G)���� �A+��Σ�kCNUʫ�H6����DZ+��Q�b{�d�UƖ�YdH���Q�~	��/an�h�#l�)
/�̰�]�i~*������&�M�+�����07��o;q�4m�Ҡ�A|�nN�Z(�G�hk��Q�s��5h�Hs#��w��|��ٳ�ǜ����Ǽ��e�g�dh�zT�hP_�I�+��=���|����nd,Z��v���,y�`&�7	:[-wK��F� ���r}�ij��5�K�t�^�H?��I5b�ӗ3��W�i\5�z��7����Tԃ�
���Ge��P,d�O�/��4Ӑ}����3�~10�7 ��4⡈��5נ}ύit=w��q��ϯLUʫ7(���ȵ7Ff� �pT��ZB���X��X��O���ǚ�S����ۘ�Xio�5g;�<]�F�����5O(J��t�o[j�6�E�͜3=%���5#����KQ3Z��ل�[P35+�"��[����rp�n-�yo��=]������t���ץ�u�O]�l��jcK[��ȜWZ��M���u*i��(�t���@�Y�6;�����F��`�fr��R�JU�n
O�k(��Or�u���O�%(	�ȉ�������vɲ��W|%��%;�Ƒ拥�MƧ�O��z��x�B�bA�,��q�x�^j�1�� �����C�����׿I�c^����������ׯO3��uYBx�\�~y�,ɛ�����T�N��iy�մ�������׏���o���y"B��
yǼ�Ι��'*���E3��W,{R�l�M�ۿ��j�O^/%?|����<�������<�x�K{��ϙ�OP_�x���W�g�Gx���w�����������߀��)�w��~���w��>9ݎfп�y�)���|�u��
�/�I߬����|�t��4��\V���ϓ�N���������?����=9�������r����%:����v)(`�����#�1/��� ���?>��/��������h(˻��/3��]�f��WXɂ�!XY�Kّ�O������e`���*��:yok�P�P�
����s���K�1h�'7��&OTL5�"�c�}�ϲ�k�U�\A���z�pg���W�/>���� ʖ�,럳��*�?��X�b�UWe���zD������W�v��5��˂5�K�_�}�C�ٳ�,�2n�R,_�r ַ5�&�����فz9�vA�-=5Ɓrv"�H������tW'd��%t=�1.s�Y��M����M�����u���f�����,��8\&�2��D�{Ë��lDܟ�>5�?�����,Q��D1��'u�����.1V&�����g���o+�0o����7z���Nm�qY���QFI���p��v+h��������~��;�ר�"�`	~E�_�O�+���Ж�N�aA?B�Żp[�K��yS퍥m`��[E"!��>�ٻ�zn����	-;� r�˚�z}u��3�l������e!�*zf	��\�)�P��B�a��8���Ur�"_5N|O�DQ�t�~u���JR�a�[ �ڝ/�'&�߬KA޷��Q�~1y"n�KEUΊ�W���-ޓ�ou$�3��Oi���%_+���uzeiA�V5�(��臖]#��M`uI����v�iIWJ֧\�r^�(A������������*�y�D�=Q&�i����ǿ�w���ߝ~U]�eI{��\{�m�/�Y?e�V��G|���fbs�/7WϘ��TɴOb�����+H͌�Hzi�X����+����=�C��:�N?&��-3˾�����af��]�����x�W��8��G�EW��:p�ЁȰ�P��M�}6r�o o�-�}F�V��ow����~E�פ��PO�Ij�D�N��IY_��r���v��чd x��(��pϷ��ЩӰK�U�����Uõ���\]�f t�%�#ݣ����u�3E���"��+��p��#K�E�X��ɷ�H&2�=�G��a��F�0x��r�I�8�%�]ڽ�`�v�B�o�HA�{��՛�덐��k��M�cS�)݄ ��>�p���U�`'E��^v�!�����7��*۽��v)c���~���gvW���# �ER1��_[1^H����;��=��򔗭�6QLD[�(f�Yh��VT�Q�]�=}�c뼻g86.��p͒�z�Gq������E�6T��=)�%O�d�#�/���w.ˑ��^�<������w Yl�XU����Î�phb���h!K��@o��B^z��������w $�=2��Hw�_�<�̓�����|ܜn�Ǉ#�wǫ�ur|:��;�#q���. jby{�q�:%0�(��L]i�s ;��7�G�qC��g��N���G[P�Ņ.���S�Q��pr�)ao���n�K>��S�{�|�Y�-O��.)�o��B��B5W(�h�y��&
-�4tvXJI�p��S8Vo��y��P�),��H��	}�3�����S�3�2j���'�P*�㿎*��z���;�C�ͳ[g#�T�����g�*8?��t���1/�t��ŃO�cO�\��Ny6����-m�e�R�&�-�Y�J��cK�z�k�Y�턆G�С]w
6��,��s�f�c����v e2����f���    ����f:z������G��T]wf��Z�if�o�x���6H:���M��ͥ�����-N���i�I��qlm�s���nθR����y�oG�o`G���RL���i����)�M�&o�PnϚ{���{��Bz�RH�A�i�]��W�~�o�kw��:>	D��,4���(�[������zk�ߣߍ�۹P������m����8�R��v��5�r�c[�ç@��f;[3�^5�C�����L_	_/vqG;^���4�,@�S����$�i̓�nցT�ڧഁB���c���
���K}?K0J�9�W3 mCړߙ�@�'���W�����1	��v�jvm-nx�om'8rk���گ��-��91J�1�����u����z�����ur��������<�^=:�j�D笠ν��R>ewxդ}��OR��%��v�p�`� ��j��8���=[!W�ܒ2�a�3�s�Uɕ���\�ܼW��R8{�r%g�r��r(��>-L���Az�N�i�g�^�#_j��f�'�9�E��R��)c��T���wz"��w�6#�'�m��*^���t> @� �M
���N�k�)�r��T����aj�y�O�v��ZLC>rs��6Py����VuϤ����-��{^�U��t�> �B�k��T�0�>�DL��};��
� d�d��sX�l�,�����T��>�2��=Z�0b"b�9�OC�ڷ9�W:�mt�r��G�6�#�f�UV�8�ݍ�=���v,��`o���ֺ=�D�%����<��b���#����=�6��o�����R)	��u�i�t`����z4�卒S��\�"d
'kS9Ef议�1��[' d_D�?P�{�ҖY�WD�ճhޕx�>���P�T8j-ޔ�S��B�|�ꛏ^�n�u��i�\k��Dݙ2F����+�#�|�����a�`���'��J��I�-��
]4
0U�[
t����]�͡��������Z����Z��h�6}�N�Gj���P��n�`o@B��0o(���u�p���I���ha����%���;���@�`vw}�	�SI�Zc|1�kYv2.[�>j#�N��rsuT�ٮ�&Q��ҥ9U��@i��^�v\��R�>���u� 3%�F��"�Lއp=:p?�\�F@!�W��f�['A$j��!��d��Bӳ
�d���<�%hO����r��̋|�˻��{
���d�λ���wb8��qܔ&��4� �Ö[HF�>C19��e�����<@�ܫ�<�t�z����E�_���4���+�W=^�L4w�T�8"<�2��EO�N���Bl�8x
��^6샫�2�d�-���t����k�8�͗���ڰ�Z�5PsV���\�m���&�Xj�l�������?7���N�9R���r-��B̸���#���E�`-�>�qӠ�æ���j3֣�3�[���ͺ�aɚYެ�6�r�Y܆��ڟA��j�%J��P���ߌ*տ���`������mh�T�ɨ�mg(g�ѻH������������0���p[;�:n�t֤��'��D9C���O���|`� �2�_����_ie�+�=�ʓ��+���B�&"0����oZy�8��	��oy1�K-7ʹ���;-Լ ӵ�P��	$T�Ϫl�u(��j��wVh����t���ٽ����3�|��L�
ۺa�k#���Y���K>OC~��KF�#�t@�9�F���L>/y&�=~*�$�C�*s�|^�D�lB�,D'�C��D��S���]`��݌���N,E9�Ə����Ҟ|�;zT�}Jy��dV�iH>�[�'��6�t$��NE*4{5�=cԜ4�r����OIg�]�W�c����^��qg rI-/�-َ@̸���Y{��D%B	$B��̫��]�p*��$�IH"4k�=�H����_�Dh��yđ%c�9�ۉ�Y�F
sk�.�����|f����I`�B>�LS��<s�9T���4���N�4p�l��^ִ@��U�њ���ݲ��-M�}�� 䩬�dfǋ�#~]S坏�3�_>r����4��	����G�MC+��2���%�DO7���1��й(����G.y"T�>~��S�ƃ�|$��G���I˙�=��C)�o6�$�6ȳ�$��\�J�z�i�I�h;�s�E�9r�$*����P�͝�$��$�Bjά@A��6G#T�ӝ�����&�6���&����\^	@���G��5�&g\���ɢ� �&� ��Mfp�6�N��3�����bH��Y�P��)�c�ˆ�!hφ���������b�Ce(�\�, ���8�LA��R�H����/��)0{U�
)���[��D?S�
�J��j�,TkB���m*HKɩ�G�wXn~#m��,B�2I3�x�LRQ*0�2IaM����6(�"�%�D�H,I�~Y�7�lЁ�Gd��9��G�� ��g<���N0^��gw�����W�b�h�����Ƭ�����*r���$��t�����53e�u�**��$e�������ӌv�?�D�`ʞu��2)�����ǐ�]<�\�$>٤qh�lR��;�LP���A�5Kd �\r�oٔ0���!4��� A�c��_~{�|z��[5�:ژ�tQ�����:DD�5��Ҩ�������E,��!��\w���/N!�X��Z�4�Y-����5K�r��֓��{,-*YP2����^>��ׂ97F��SD��v�w�֡��SV����~V�6L����`	>w�	+�v�w
��J�%��=k�R���1��|X5j��:�Z{�L����UT�S�r'@�&�r`/�hĵ��VRs-���ck%j���g�&4|�^ø�a*OIC ż����"�h=�G(�L.���!'<@¶�� �>"U.x���e�ұ�R�)��	H:���Z:sG�iOq�9�no�׎�Nx�X�0�^:v;ݽce� �f�t�#H]ދ�YH��J���L&��wT����F��ir��=��d��89�����氢�l����:R��
�t�
�	�z�?����韱�F���ܱ�^�?ÇCH֙�G�
�?��h4�ܮ�N��K����{�]��`�Þol?����=����j�E��+�J�s͠�Զ:�6w+���9|�
�Jh����b<4�Y�!�0'hZ:I��������@296b$�����9aJ�s,i��P��:��"T�ki�����en�|Q�[��q_�T�W���Z��y5�7
�^`����F��%���q�.�mE�,�Jݞ��e�蜦�C:T��ꞺTw	}��K��@�3H�!=�rGU�#��ծR4[���F 1�Ӫ:��O�uF��(ihĪa�e�s$
X��wE����]B��7�׆(��$�;Lĸv	{�׹m��P��~س�l`���l9�a�].���|\��	{[�������U�q	7��따�_��(�@$��o���\:��7	{{�s'L�u����ۮگ�w[2v�rzN^�����<�e��o��moX1��7�1���Q���yqQ(�*� �T�C�p��~�:c���iT)RϿ�l��/V��3�Qa��k:�k:$�Fx�w��-��݆��\bq�y�+�������Nog�Y�<a� Vt�^~[��_ֿ�]C[ult�s�����d���',���_?��[��ڷ����O;��褑s�4an�K61T��W����g"�gT����*����������ޭ{���
w��a��+��o�&<��mu`	��V���f>��Ӣ�?>��?��?������ԓ��5�L�����z8mvĤ�7Z�&D�D"9����Qm�I�3��BgP����9�����Y�����;:Oj:��s2��:���V�%��*uL����Dd���]݈�jI	����@����T��Mo<������p���]S�bGGtX����)����ᘗR\=��x�xw�C�ȡ��i�=�q7bW�.+��7�Su���:?T4ZvNZZ��'��q#�*U|-~|^A��    POj���Q�زs*�����������٭軄���� b(b�:�����kP���$4����Y㧌���"z�����x�_oW�S(��S�PtV'��ݶ�Qߕ:�_�o�z8���O������)p��ɱz�m�6g�S'�4$;�����C\V}�1D"�x�oH�]r�޾�UJ�!|�D|�0�?�����n��F$�8��A;���8�E(�l���:Q�<>�y�����"<Y��w�������jhuV{Urሜ�;�YmW�5�ZdsP6ԋ�T�h�L��U�':q'e��j?���L���q��Ļ3U&G�)c}xب>%�-���߈����H��7R���
9�AO���p=�n��d�o�o�h��x��X�����1ao�~d��+ه�og#�����?2�}<�]A\prw������C+ۡ���~l/�4��qĻ�Ӆ�>�[��~�����w��%����h7�g>�BVg��yK��m�g����1ܜx�#-��������t�����'qDO��V�Bt��|����-P��a�sv�͇������W�'Y�@99i<���C�J�C�*����I��y" \����>m�[���7����(#ҟ;\���]9p�]�s�<�
�N����a��X�c�g���gg��8�Vm7��־g{��s2��[�x�cu�c���[�p��`�*�*�'TE�N}0Zt��f�/a�Ӄ�B�==��(��;=g���!���O�i��fO�L�U�܃��4�==3�Wr߹��͞�������y��gf�*B��0���_e��D ��:b�*Mjތ<��p�#��ԝT➞Y�u�n���b//�o��$��S� 1�{s��y��T��.l~i��5d�� ��fs{���;��y���S�B�A�ȍq���nE���S�wW��-k���)�x6��Ͽ�Ͽ��N%�Y���Uo�@���~�NNs��������~wl���� �%�}�a��o�[s;p,�/`D#�/Ǘ��YO�Q4��7������IW�/����P���:E��!˩��ض�q1���[.5�j�� ��d��R�j�b�#����y����>0�����bߋ��?S&ز�r�૿o*u������͆�is���Iu?���8��
h��r�]��F�-2�[�1���5;tYϿ�>��q�����F���Q��ϥN��'�_�.��n�!����&�������+VW�$�[���A�q�J�=��]�{�ݒ�qԝ���s�V���ꤜ�(�' it��9����Ǐ>ٗL�6k��f�<\P�xF)l��v�x�ws���) ~/��NB;9�C�DG�-k���H� s��P��f'����̲�ڎI"|,���jW�;��}�ޭ��Ǐ+�jP�ѡ�-�L���A[�O�M�F� ~E}Ϭd�	3h�~[�v�����E�!��?�"�=��~����@?�S2�l���^�`����F�!�x���z�Ͽ� r�� �bi�S}*��:�������<X�P���f�S����e�m�D|X�������_>nm#̼F�YD�m�����/y��(�&^����M�`���- ��zE��(�7�x���mub�[�ѐ�/3�6P��PQ�� �y�t�ѡMw��]>w�ۿ�4ɗ�^��3U��6��O+�"S?�F�}��z�~�9���'��_������A�����{�cM����*,�gˁǃ�,�Zz|����Jwx<>�R�Уa�'_9�|a��W�����/<��;vD�ȼ�$P�R"��ה5�^���NQ���X7�6��L%x0�@Ys���#�@�`��A��~x��Ƃ��)T�B7T|x�ޣ�5�7g�{8\�HKN����n��(�ٌ���^��W*�t*/H�� b����/P�x;b�����d��W�ˁG��'�vݲ�

���c8J��*�hɅ�l��4^���4Y;� �^^��!��F�I�N�-��Su�	_���QƑ��\��5���@7��f��(G�z�T?�ȡ]�W��ĖD�2��a@�[���&Uo3�2H��V=������I����C&b���@�P�ļ�d�$V����0#1���@a(aL��y��R�u��'^�,pI�Á�t�\AN�F�yW� L1�_W&a@��h�֡O+@��k�L�)OK'\�ˀ���Oue�4�22M���L��T��O
���F
�c߅p�G8���[��qO���������+�k��TW�N�-��=�E�MiF
�1S(Z�).�L�w����
�gxY�ı����
=��@���Y�l1h�^��.T�BD@ ��<s�� ���53��!�50(~(@��(���2ذ~ë�T�u_X(����㷔�d�]�����^���@�Q�[J�_�doa[��l|Z�$|�G�̖��g�y�m����u��oi|��糌j}��諠ǟ�%�Ґ!��@�q���#�^'	�C��p�N���$O��-&Z+��Hcl�e�Y�2��N�I�N�-�Y.;�a#�0�'�����W��c�qsPZ`��#ۑ���!����j����(j�i��`N�]v򂳨_E�j�mc�dF&|h&�fB�	���R^�s���� �ClP½����_�?<lׇd���'<Bc���蜑�|z2��<UQ�(c��x�6�D�D�F)2��a��JR���;I�A2&w�C��Q(��G}��Q�[��IT���d�w��(5ɽD�S+Ȉ�*�
G�@y�}��ґ�c��*���x���Ł��T''Y��Y@���p��\�y�7��٦�`��P�,j�}�=���_ዒK �J2�v��Q*���E	%|�	e�P�aΩg�㓢}��Y�@�Έd��.R��Q"�o�o.�(ss��B8"-C_����3i&�3�5� �A����D�>�:�^��ژ�(`	-#W�F��E�&���y#�V.���2�9l蛼)DH�n��o�����F�hD��?͔������L$Xr����'s�3�F�'��' |@e���"�I�$r�gT,G�ԙ���2%���hFɥK�j��͇C�s�4w�i)J�$yo�{H)W<͔07J�,EX��Y>��'~=�4�Y�,�4^a֏4!N�c����O%�":��@w��z���S�^���7D��w/��Su���jD1э����_�����W�
ң�=��]�wg`ʟ[���L��O����ޱ�X�[|���9����#8��VK��z�E	h0Q[O�+�s@�nHv����dw�)%�J���+F8-�'�+��gGG�J��O�[tlPÆ�� M��P2�I������a#������R~�,:�������8e�D\5¥��$.�pGN<�(k�4ػ�sMG(C��(aSEe�!��}
�4���0�CvMh�7V���"{�1d7)jTk}|��@SӀ�T&R%��k	�-$���W8�#�!�rB��wH�;�o|-E���1�� �'���F�9�)��D���
�7���k6�FV�hSOe���� ֝TN�y�%ǫ+�����%������3���C�����,+���ވ.���]u��P 	��L%��jB><��!�Fwu�$��^јI/����44��;�UZQ#|��Li�������T"ϲ5-�^���A�J�A�;;���`촁J�i�|B��WҞpA��q�[��U0v�P�}=���V�7���ո�q]KR)�iKp����!щM�Cr�<6Fc ���Q����F��G����9�AF��KA>��\o�vi�*B�*eYk7D(-RZ���7\��1�Af*H��l?�*7I�2�����ԑF�f[�z�v����]��}Nj9�$6�1(�y{���?����(�B!eu����Ɓ�|Jӏ.|��HWsr^�=�Z�L|IT���D���3�]*q�(�P��sinR�:��X��Γ�&Y���q]0؈�1���u0+�֥i��)��O�\�`4��P��H��8��Œ    (� ���n�>���S�Hچ+�+�<��Aʊ�K
�9_�'���#�&i�`�Е$e^.����Mn ��>@� ��N��4*I�xPwjz$x�ъ+��N�ÌBYD&���1*c�s�Z��|�{�0�0f�52ڐ^J��f ���|�
N�&�bJ�;����\w�vy+|^��	q�T(��%=9��v�$
I����&�{�"0�1�9�-GW>�Cs
�^,��ƮA�����@��PX�H�O�F�)��m ���&ܨ�^.���,.5r5Q.@�B��?B*%�pf��p�O��_��0�0�8m̔Pp2+`?P�~�J���c斳:n`75p��8P��S�՝϶Xg��?�m�I�`���I����Y�p�86{�������.陡��� ]��1��]X+:�p�'w�
��rͭ@)��2WY"=Kbd�)ߖ�)��ng���tV�ȯѠ�T���ZPz��H���5oTJ=-�5�QAeZP�O��\{�Լ�7ЀC|���U��r-�<��d��5ow�<�_cA�!:@�TU�A��}��Aق�w�I���hPNe���K�7�W#��H-6��agY{�Pa���2geP9%e칰7ce-�X��GL>�GҢ�sQ�?:�=�υS+����, Vp��.7���Eq��O�;^.ZċV�в�^U���Ei��T�{_Z��堕+����������,�]0-�'[�B��9i�0Jkf���sЪ�0-�в�bnZg�Қ77�h�i������8���ߢ���q�j|+.���<\.72��{k��!s�?P�����iX1��"�R���%c8.��bQ��dr�4�]�fT��wSs����ze`9�&��z@�:�)�x��ì-D���P]�eW �ţ,н�Q������<�nfr�/Ӗ�l�}�Ud1S*R^��F��<mb����"���1���S���.M[����"-��M^Dl���t�[��u[r�Ő�2fG��*<d���/�>\�����>��թ���¢BŅM�|S�P��e�k)�}7.wv�� ������;�EGwh�)28Ci�1���-�t�FRկY�6 �nA�Aר�ڭ>-� T��3+d��/-d�`6�|�8�HP�d��Z	�T%�{�)�eWծ�y��%8el�A/��/�;�`�!��q��~faKp�x�!�0��`3^;A�$�3jTe�/R�"��oJY�ʚn ��}�Z0:�@t E
ЫA���w���^���z���&��Wl%�h��en➛�n��x:v�X�=��;��a-��"EN��I�L[��Mpk�����V�5 ;q5�8��@3B /r��˵����d��<Oc����^�� �CV�#w�L[%'ԋ�
��q9� �K3X��n�J�9��He{/�3|�H�)Y�eCr�D�õ��R��5�r ��P����J �ݏZ�ޚ��[*u�v�j�tcמ�y�IF�ⶲ�F��3k���KAfj�4aZ�]� � 2�4Cb\t�wk@{b<S����8 ��HQٷ̦���5�͝sɄ�~��y��P��s �
B���od2�����F1l%r|6�flt��3���a�� e�?��T�	F�/H�!I��M�����2���~e븱d��X�Y����t�lc�FA�<R�9,���\�R�=��ԧ[@ڲ��������f���4c��S㙇A����Q��G�3�<?�*�2sd��x��qti���%Gp��]�I��{O�V�6��>�|>V�����/ԡp��T��B.eVP$Q7x�~��[��O�uBݛ�����i����f�����)������zK�����￝�۝xs��?�������zO�]rS�6	�Kj��ڹ�<[�����H�w����7��>��q��zC�����?���~��������?�?����������?}����x��Өs��BM�Jτ����!y8����9���'�y*m��=������[�o��\��wS!���wl�f��	���fk=�c_R�MJyt�tf�f�"�}[RV*Мuh��JtY��Ͽ���k3j�*̜�h�6�rtY�[������mw�A�̳"���_q���VqΌ[�4gw߉*����n���m��	��^;#�cD
F�ʳǙ�~�b|��}���F9b;F�`�+?�1
�㫔����=�噂ѯ��8�;S��}~g�;p�C�s�[�>�����,F��y�Ҳ �)��4��Wmكg�vLX
nѵcABM�yX<���D)��c�����0k���g��x�u�\��x����?��d%�e��� ���V/�P"�2�G��/�i��󔂅��r̺B�[�
%��{��׃)�I�O��8�#a�D4%a����0��:;&V�a�	%��+G�p�?fB�㵣���<�P�J@c��w)D�=�ˬ K�Z vuH+��Z�nZ��})����6t��u@�B	[�_�&�m��ҋ��(�
`&^�aڈ)������°)�Rb�n�W�5���8mȔ��Q���W�/�ퟦ�����ôƵ��r���xخ��1� ѱC̑�ÒƧZ�#9��LUͬ|��E͏�5�]"�G�Qt(O*������*e|�uz�j�J:���{�5Jqӳ�+�&�9p��������k�V���eH%�B*��FI��U(�]'�2_�$_ �L�$j�Hb��U"هGd���8�;;C�1�O}�=p{�����<g ɗG�#yk�s���2Z(��P��=@*�E��o�;('0ދ�b��=�Qƛ�,�b9�x/J,��P���S�xH�2��W)� �?�f�ƻL�V�c�Q�v��9�����0��v�usZq[���[������Ȳ�ۗώ]�"c�t�јM��Ѧ���ǽ�6{�ư�˚��-T��)��e��|�؎�@��؊ 讖�;��?��D�m�V�(��g�[a�UՇm���9s+/���eՓg��[��#�!D�K���8z�C����SU�+���n�r�`qv��0�w���͆=�8�����=?��w|����`�Q�����]��������|+�{|Ev�K~��ǿ�÷�����(���`H�_�D��!	���4�vܽiGP�s��D�;u�w���w�(������%_*��Ӷ��O�ͨ]���gs���>^����,Aئ����������ސ�M�_���iEImH��3��̢���ͤhi՝��Iq/�֪OIg��R3s�+2��Y�z�N&z�59�ͯ�s������~�����|����d���sͱa�Zf�Tg�&���`q�`��`c⒩�xs���߾�Ϗt��������X�Z�<�@��5{s�˹L����sgf#��G����^=�g�����z�8V{g��{�U,�I*��G��d��2e�����әp�����_�w:9�۷?N0��Ca�ߛ�D��D��C�5 B�$@� K�����-�/C(��R�ۅ�8�,)�AU1��/T�O卜�fR�;�P��F���RU˶P3	E�:�T)�LB��;�����JUĤҿ8u n�l�{���3�Fu���pm@�ArUm�lc��`V���T^n��|���
*� Ɣ��Pm�Ф3�L�c�;��ܡ���0�g?S���m���L2��L�_����|�mu��Ϋ��K��F�.q�́�3s^��t����\I⷟O�:^�,��y�Jq% �y?y�{D�GX�^7 �3�HT�7��x=S���$�P�q�Yx���qPRd�����>��s��u�}r�`)	X��=��-d���>�t<��L��tf6"ܹ9H����SϷ��;1p��������
F��Ȥ�h?TF]�Os1�y�5ux�iډ��E�T@e�OԽ"�Aa�)�d��n�:mFޙ\����nD��j2���:h�&cђd5��hجFW4"���j���Pՠ�Vc(A�1�y[5�xԟ����j�v��_�j5^{O�r�F���D�_���kΦٍ� ^  �Z�B��,d4���;Il3]Ɉ1�臉T�F�G�O��� C��	�5����RP�'��F�`)%M@�Q�ڕ�/�h���h�N�q�3�4��H�qc��%D�_���JB���.3����F����y#Π�b6���lLm6�"�m6��&&��i쬿׹4�#�i{�Y�q��!n� ��-����)������1!��l_�t�+Ms�t>ѣ_�a� t�p2lN^�\a8�}K�b��ؽ��N�P(�w��)��l�bK1�YyE��~���r&
E�F_7E��g�Bq���&�4�CQ��b�Pto�tS��G���X���f��Җ���2�=`2Q���cl�h=�Q�6�����}\l�~
>��N|2s���/���eL��i˘.|P��U�t_X%˖��o���c+B^��������+���W��Y���}i�(�&�����/���'3YY�x�4p=3|M���'��k��פn��u��TS6�� �+��˖�ʈG�w(oI�$c�q�(;��9�ji-�(�,B����	{7�Nal�/����G�;�`����:���jE����N/p9������c+���O���?=�ݣ      d   A   x���,��8�!��5�3�3���w�v��J����o ��ǣ�<#=�=�
b���� `��      f      x��}ˮ�:����W��RJ�����e\�ը	%R�v�@��r�����x���2c-fn�Hʭ�)ej��ݼY�dJ��RDp���?���O��**oMY+��(�[���U�תH_��K�o�7��/T����1�h~h�.�0��:T�*�J�}�*S��+S)�:�7�Z�Z�m�+_�PնV�n����Fۢ�8}�����8,##����2-?�ڕ��N[_��=Zə"9�Cn7���٣��`�A�����c���2�����/5c����_����-G���j?+�F��>c������G.���p��[��Wb��X��s��pf�S���G3bC{-�7��=�յS߸��N��`-���NfG���6��g��y"m:��ݗ�
x|˻�K}coy�7�wno�'O?|��(�x����b{�HO����0n���DJ��jU�ٿх��AE��jB��j��ܾ��Xu��t)UЍ���1,tǳV��32��kJ3�k��^u�z���k1^�� V�/5�tbu#v��Ɗ��X�~�D+`Z�,�����b��)F7݊�.��M!V60E�q�}�0��d|�y�WvDpa�%�k��p�	^���;��E;p�[���1�Iً�N�c�t^̔b��1�FZ��b'#�e�e+�Xm��J�s�ǎ����(�j�X|�6ë�#8d��:���?7��9o좰b|Z�.���ۊ�VcOx<~���Vbid�Ou��_Ȝ�Z�jT��q�W�S�zY�!+�}�̶�톖ceb�*Z���%�8�}�62�2��V��r���O��	>�е�:���^ԯ���Xx@��_� Y[2>Wǿ�Vl���.���^�zH�Xw�q�|rNF����|�o��F�;�����o@щ���Tbwlpa��.���Sg��+�v���#�wk����c�����l$l�l@o�_��[��P�Dz1��1^M�6ڮ��ʿ�x��!2��4`Y�@n�hF�Oc�^�j #���R!E��%xB��Ȳ\:����o���<A�v����ꎾ!�k��+�����w,�!���_��W�Vė�h���3��Ŏ����9M����G@���x�p��̣� n�q���Ķof�=���c�9��SJ�n3�Ľ,k��P�b��?������G��`�v˖�[���l��|��}`XX5��N�!��J]���R�����Mm��í}�G�ůe��KeT�-#��Ҡ�r��Ư8���-݂!7�������s�9�Zn�
����^�	n瓬�+<������Z}�cRwZ������aGx1�B����&<̯�fR�e$�,*��ѽX��ۀ�+<�ZyEKf_L� ��+$�m�����~pѭ��Z�9*�l̪x��Rձm�E�d~uH�Q
m�Uő��8y}�/.+���ī�
9��sO,�+���a�_!9�՝����+洴��<
v9�b��>��̯� ���G�=W�_o��y"�[���ؖ-��_���.�e�S�qX_�_����Ӛ��ǉ�{ۏ�<4$�m:�_9���Y���ş��|���uxcY�3�����w��py�_%\�W�#��/��Rσ5~Ո��s7�D~��[�[�R.�zg�����j�+�O5�[�Gw6�Bl>�nς{-�JyD+>+Չ9+��FMy�g�WdVpE$�D�W@͕��\�v����QE(3�:��#�ui�_���kV�U9:o��3�Z������~��Ư�Ww�&�¯�)M˶V@/��3�E��j�K��7I+�n���8g!���/������&W)WtnQ�y�³�+���5�^����X�Q�6&\����~e��C�W�eY�v̯�	�2�ZG�W�0~���^{�q��`_��6C�Wspe����$�3��2�y>� � ���kH�ܠ��~���o1XN���/ȯ��]�6<�H��a6����\+�!��/��3M�HD�deM�i����[5G�WspƜ�V𙱿՟a��d<�׮���O���o�n������2\�;��(���|��lU�W�W}!�w��6	f�움��U�W�k,�����+86<�Y�W0������Wȸ>n���:e�'c�;��X�V�&��ҵS���?9�3�C��o��9��7bk+pq�����l�������8�N:w U���-oG�W�_���7Q�s��3hn����l�k$!�����|j7�-���g�W̨��$�Tf��X�$i�2�}���T	�6V�WH!��W��r�<H�p�����TW��v|?�_����W����7C�_��?���[��2�Z3��3Y�r_ѓ��z1s#������G�q_|^~�*�Ww�&V���w�,�и�Lc|p����l���ur7O��
؋_Q�".>�(u�U��՚��HW��S\	i��w��P��FS�(�-5�b��=R��g�^ѩ�n�w�G�>���Jd4dLƊb�^5�v>n'�WLvd�zR��c0 O'i�~v��_q5�n`Ǎ�ذ��D������+�PYΉd���s��g�iĞ2�"�U�QqGM�̯��������6ת>'�buڪ��~L+:����oڲ�}1�W5���.1�
ŕ�)��>�T_o����ӳ���g����d����&����+��ݰvs��5~{�~��a|z�m}�����K�*�l�������R�q�_}�?g�W�\U������bu�w�n��Ӄ��Ta��
x�_Qa ]��Mβ�����^�&��F�q|��e���T��L�o�߅qY��$>�\�o�Ư�g����T�i��_���.���v��mk2b.���ml�O.�i����z/y(]�0+w�g웾�9�T�ғ|x�%76����_�_�F8��#����L��m�ʯj+Zw�s;�ƯXO����u��cB�sg~Ż�C�
�b��a3Ы�k�#���� ��ʯJF�R�FeC��}�qf
�(���������ە�cV����x�pu�=�M^�۸��{尅�v����^w��Ş4��!��ٟ��E�2�U9X�cAs<����XO��ּl��|^~��,|F=il�����x�Z~;�뗻�E�4������QR;�)�NǯN���k���㾡v������t'��0�Jr'߃��^����W���'�e�qU���o�x$?�һ�� ��t��tq�7<�i9���E7I`I>�K6QJ�m�~�\<�~,N7bV�J���
Y:�Ɖ��6�k�N9d�p�X�O�Z�C\!c��,h���6�eFk�"�\qΩ���	M�K�c�p���}3W����m-v�����W)���X�W�n�����O9�)��ae���^��j�sb�<O�2�:�Q�a�_��zJ,�3���W])�zO͟~9��_�����3_+�b��m��#����<!�bh"'��;T.�#���h�x��6�����[B�>jUt�k=¯F��Ar��a_�s�M���M��ߚ�ö�K9akT�jW�P���)����/��m_�!TCU�x�u�s��CS����4�^e򰝍_e�������
�[{�}��!�5p!��~D�V��Ws�+�'k�<��a��+��ۿ�����D�����j2��*�1[j})>T\d2=�<�udpURQf;�.�4���K�D�<W�!O�yH-�k��+0%F'ͨ?誮c�Ro�v�=����ŧ���ԡ.�����#�X�FK��*��7g�f~�~x}Q"�ā8��S��b����_��'ޕw��M)6�� Htj~��q��fd��{/�b�������Z矝_�A���#y遄�[A>�^U��q)۪BL�7Gr�D�W,���$�Տ��cjT^S�@�����2N�ʯy��#�a�=���:�	ψM�G��3�[�L��	�����:%��$�8�%�_=�̯���h���Jj��9G+�5,�� �p;ץ&�p�x>��N�2�T�ۿ�ίR�C�Ԓݮ��1|%~Ep�    -kF̷��)�_�����=⃑�l"]�ڄ�l��f_�UH1;5H�KI��3�H|P��v"ic+䣽��SS��Q����]��<� d{��P�ζ�q�k��+\?�N�t>n���J����d�l��*��)�,�?�O̯�;��3��xfA�=����5P�"�5�Alr?B��'*��j�cߖvx-�5�n�^o���¯�s,R9�g5���W.Ւ:Zk��g��Jȳ�����\q]Ǜ������q�%��8#yB��>�+s��4�o?X��lSu���^x��yB>�F�*R�x�񝠻xD�b�*Vu]�"�`�铿�1G?j�����!^6�SVҖ�أ>���x'X_�}u�i�����p���̯�B�_���Ƞ���S.��i*
aI��R"n���*�B|���n�p�k�P���o�@y��WK~�X�v I'���5�-[X�W�#M1��� �B�<���U��i�+lV��&�c�����K,���{M�Ko��/��]�rƿ�Q��p}�w!w��V��*��ϯ�Ӯt�l�0�hma�rY�ZӛH�*qUQ�!�ʀ��N|,�6�+>��>Rֆ9Z��JI���*�{Z�%i%������Eޢ�K��F|��EMA��\��g�g���{���_�/��j�J\��W*H�%&�JjA�Ї��Mz�P�nz+,t�_����7�-08���;�;ݲ�9k%X�`�H���d������\�n�_���ڕ��'Ə���s�\���@r����Re�,ZCu�*V�iA#�(]���f �2��2�H��~5U͂n'�d}b���<W)+�� �o�"�@aޤ���j|��M՘m���N����m/�yJ�Ց��q$�X���~��B�^����W�gs��:�bߕ�D�*������˯�n�>�珰���:�՞?�_%`.K�8��k��~�ĴD��T�������tZFl�ԅ�9g�t����\n�_1:��e;_-�T�D�W
�%������*C�+���ǖ��c���(���8\k�����>s~�ʀ����-O�����U��pc��a��u�G�q��A������y�G�|��56'�o���d"��i��/��ҫ/�f��b�(� k6\|�mU�{Q`E�hD�Z�˯޲��GV8�e���A�G��k����|�wa~��i���Я���E/g��C0��v���3���c�A��>�W���"��b�_�]<g��Vl��2����^�"�e�{yj`Vej��P>A�A )m���4�86YӚ>�ِ�S�G���5l�!�I��ف����[���q��Ϸ��1md���-
FY�*�m�;�՘9H��Ͻ������r��ul�wC����wD��+��U�7CN{�u���Zh�x:ڤ���?�|>��"��h��O�W��2`�U�f6���159r�X�0աNմ_Ư��^}{z)�[�ƿ��c�1���Ucx����䂢��9��͟�s�M�B����Z�!rf��r��zu���� ��v�;��{@�<�Þ|m;��.�fWݚ>���c�|�$�Ǜ�3�(̏n{.��[����g���J/ � ךkt|Wp�⯿�-t��f�,�$�(��N4"B|��I�R��{���LƁ�F'eMj(kWAV�^t�P��8��;%��A$B*Ϻ����}�/�w�J�X;I__�hi�*�+>��8o��\y��gj�q=W���*p�`}[��)a�*'�n�!c�1��оxl�#�3~�		��WU�>�D��O5���O���e����k G��ްS��9�+^(��;�V�؟,��>B�j/�-γ̃��n����x�c/���W�h�� �Sk|cT�^r> �}8��zCo���⃬�~��lW��*?��q/��|�5�x�^,��?�f�j���E����R7ǫĠ�mu��1�r�����5�dp5�G5�i�H�����]����u����IK�*9At!\Rw�����-��zįXI�jT����ss�:S�J:���X=�ʤ�^\ǡ��y��_edddddd�[�*��2ylL�	Cd���x��.�����sCS���i�X��*Ef���f��PQZ�I]��Nj���e0#K�t��}�U�&��k��W��Mu�o�*�ރ��J�A>{�D_�|Y��m]�U䢥�,d釫2�%:��������q�áJ*���:�W�՝{n���XJD��O��.�b)۴C���g��Ka��%�(������Z�>�Sz�3�5�'��EoK)�G~�������6�B��+�X�U�I���&�d�I��܎��#-��o�wC��~Ld�E��Qxt�R�
��-㒯ο������8v�� %���\}��CL5k�\4����ݫ�Q<p!�U�K���'���h!^�ҕ�wU�_T�Ѣ������u�����h���J�Ey6�gz����\��Jd���m�� �S�hV��W35���\�Uɤ0�*U�^�ϐ�����q���~=+�jM?�⃒�,*���m��]�����/};-j���Q������BdD���۾�\�%�Ն�M[���tR~R��6����*�
oyb�Bo۾E��j��~B�E*���=�,��Pl`n|�_edddd|% |�_�^ݹ�a���k�۠�_�I:}�W�uEIbz(��e�adY��5���e��PZIU/��Їf0eW��i���K6���@�-��W��`���C~(Cd{�u�ƿ��vw������qr�v�� p��C�
�El�.���`FFFF�����(�	����������~E���,��&2��z�JU��H��ょ�Evd/�OW��"�f���H�k��m�PGf%�j0؎�0��������%����`K]� e5��-�n�fck�&�"��ȵ���Qt���C(�Br��k�>e���`FFFF�WU�F���k�}�ɯ�kTˆF����^��|7�`���4���I�.�H�]<W����o����ѐ.��j=+M�B��5�
x��f~5�gP�NUu�R��7׶�ܺ��|���*�R����uS�!���R�!~'�ث�}�����322222�,>į��J�ҵhi^�)w����6�A�vm�*J�Bs�N��TU��l��`��KU#���Б�Y�1��Ng|���_��۩�.#"4� ��u�����!��E��K��v�����`oC��W-����t�z=Bm�K3Q��B�A}��C��{lB�OWe�E��L�5����R�MjXc�� k
�E���������k�hڪ�{��ⱠΠ�l|d�uW%|?K~�#�zn~{]���	����)C��^v�Y���b��C��{|'U'VR2�kYA�����f�g��H��p�q_,���j,�_s�a�K�N8j��{t(Q���S�k�Hy��;+v�9�5Y3��3Y%��G�<##�������4�<��[�N2�lc�:q�F{U
:�C��kyO�]�DD�fP&?πx"��H��u��Qo*�mҍ�|���P���Q�Q��a\��մ�\ߙ���2����/XA�[�I5+VJ���b]���k/�L�(^�J`��X���
)M!��#XU�;�+����aSŐ���υ��׶I+���|/^�T����^�T���V��a��{��O����\�=�cṺ�)5�������+�l!(�U÷V���@U�![,x��pex�^�>5��X��,�*�}��โ�BoS������d���k�[�g�.�ɡҩ��o扆j�k��Eɶ{>QRrAo01g��gG������T}F����������N~5]E���a�.>9����|��o!4��˛�h��%j*T!ed�p�:ɋ��^O��H�;�*�ǉ�nG�?R���%jIΆ-�����rh�(ߎ�]�����+��/0�Lx\8z�J���%4�rՈ����Rl2�:�T��ӫc�����b�������c!�ɏ�3�˷ T  b�:}�ѥcLŃ�����*#�������b�O�`�%�󩛞]7�=zzѹ�w�*TU�x/�[��cЯ���2��ɺ�*>�\���TP��J�����L0�����Hr²,�޹�߻�YѯЪo���t'�Q��D�P���z&��lZl>cr6?b��b���uf~u���sA_Ж(���l�0T� �_ed�h؉_���:](��������9'���t3�:Q�2j|�V����(��F��k���`,��N'~���o�y[�HetUU��Eb4HR�m]�P���#�+L�kOȦF�jL(�(���Ǥ��U�k1$�L�|��nh�����IO���'��j+��_��s
E>f���K_�����Bd.������_ed�h؝_5�b\3��m|�5��)^�0������n�@R�0Y�� �]�9��3֋�v�yM�!n�Z�p�I/�h����PkG��u��~���k"��J�CvV~U����3t�|Ɯ��g���f�z���3�ڂΊ��� ��m�W�_ed�h؝_Ց�4��T�	M��jo}��<(�!2���ȧ�%YI�*�%�:}f�[��BFӀ������%)n����������W`��o����m0R��^ƣ��
Z�/ɿ����?���%�R���j�B��)�S���̯2����Ѱ��
u��p||zb��5Ep��jh#�(��wCoZ#ʜ9W�(����DK�Kup���]V�1JH�I�º��ٲ-$e68�KK�t�t�D��PK.����՝m���m��
�&^4��&D�W&�7B��	�3��&�<��j�$��5"�]�k���7�-�z�~�����f~��UFƏ�]��Eu��[�M^Y��0b�z7u�\�:a����<ʠ�`��Rl�_3xۗU�;d�i/Y�v�G�fԓ�[���	MWE�V.r,�w��W�3ި�,�����W�+ N���S*K�#�w,R�r�_2��;p���*Ŏ��'�W\hЋ���@�no&�̯22~4��ƙQ�R�H_)�	��|@}Y�׌�?/��S�0��է�T�c=j/�h+Zuұ��A�Ǿ-BQ��0ڱfPo�Jq�Z�&��������|� ���|�m-v��z��𫧫>����{S3JĂ���~%��$z�R��+J�J��{u�222��a�j���E�t��{�������E!qLx�Щ��KTF�u'�r���:��
H�S,d2u>��W���9���w_���+�/%Q��3!!��U���җ�S,�w�Q����㱏k�
;Hzk��x��i؆��Y	�V"xN222�����WmG>7��:�EdYJ��J}T��U�Pۑ����;�{0�j2�b])�׮�:�q���XM�����{�rt�{N�5~Ub�RKYp�)/>34��Π1,��t��8|�ߌ�v�9FVx���p�vl$�\ X����G#�Y�����D Y�<�E��+d�}�<�z+F��,�ڸi�x@.�J��Y!�Ãa����_��%`G�j�_��v���/��5bǝS�yLpHB�!�V32~d~�ckR�_�v�����_�X�Z�;��|��Y^�|rF�X'e�c��f7��ߘ�+=6)�t V�r�R^�s���BY�e=L[�W�#���J����q��Ϋu���}�W����:�o�A�W/m����2�Tȹ��{7���;�XX�i���� [X�wa���m��`)�E��?Θx���	�B��ifh(�Xn?���v����<��ƆՎ]+vD����������7yM���5I_��edd|Bd~���m �|a�@�;�Z]�I���ݝ��8w���,���)Ef�Ø�3��9)Gz'l�o:�X*�ɸa@����_�����[+z�5�_%���Z��KFF����*�-����Km�X��(5�[GG�;oĊFl��~��f�B���k�I�� �4j��-����^���<��[�J����X����q4���̯2��.��k)0~t��i��L�!��2ؽ��l��'0cMs�4���}>3�"�6�4�۲��ʯ\cVphݱ
�Q`��/������c�����e3�z"��k�W�j��N���$�4C,� N"*�5 �ɸ�|_i��ݳ��I0��ca�qp������[f}�-[�z�����{>���~WM޾pC�b`�6##�Ĉ�<���hr�8�R[D~����K6K�
�'�V�P�aJ�pfU�kٴR#h!��5������+9+��5�F��W���;��S�+8V2�"�϶ʬ����0b��6bG��ddd�8��T���U�M�DI �{�U�pMu�8!�_������eѴ�qN�	�����/���D^ӈ���O���,e��0�����j��>�m�1ˢJ؝�۫�
K����� W��k�ٲ�U��q�W�7bs��t�#�p�=r	���*�1xJЦ����E�mp���F~�\53_�F�^K]� f��Z+/:<&���W��K<-|J���<��r!뛲�Xq�Յs�Vl�>�|�f����_��)��^]?���'@!V}2�k߶lga� Ҍ���^ mY[xHqΑ�4�������0#�0Mm="�_1n�Vs�QK�s��}��+�2��#.�N2�C�Q:��J9�|��Q{:�iu�"3��.�ݎ�J������`�M-�Ɔ�"��:}�q��yӣ�5��4�]���8����B0��q�v�1&C��]�9��kGzVG�� ׮4V��v}�{1##� �]o���J"��_��K�V�K��t�s{���S�Q:�=r�6r��z�e0.o剟ԟ��C?��90Z[7�^ �Z���<�AD~���{|/ۺ��ˢ�Ú�H�Nu�V ��~M��<`���Ķ�̫����)�YͫD(��>�Ìb�)�²������'AzS�����#���mC]hx����k�Pno�Mje��ѓ��c(̪S}����E�5�����a5�p>��(�#��Ě�⽸��º6������ �~��	D#Br��@Eq�`g =��!i.|l��z�W��9`�[2�U��Ο��4Wͅ�>+B�{���m>�����~��ƨ:^K-�V
y�x�����ֶ�C(���
����ҕ��y��TeL�a��烕G����w����C��^\!F�K�`�H���Y�8�/�����'�ǅ�!�a�8 ��>�� �T�b����|�^{\���3�"��gŬ�ɕ�s���q�KG�������f��_�ό�B�|r�ﺲ��T��ۛ7�qJ�!��Zv�%8U)+|Q��E6��=�<΂?�:����x|�Ϲym��q�s4�b��3�/? ������?�����w����o��O������B��J[�T����۟~}���?��]�Um���o��_~v�օ�������?�����_����>�~��q둔�����~���/?9����ߚ�*ʶ���o��������������������(�.�]�[�0�t�?��������~���'�ֺ����7��Z����+��ZY�{�w���RK���7��7����� �B      h      x������ � �      j      x������ � �      l      x������ � �      n   .  x��Y�r�:}&��_0%���gq�:��J�R5/�+(Q���~zwR~E[���B!�r�]��T�K^�e2�Io�~ӅCO�]�K��p�7ZA��K���N{�km�O��ҧ����4���D� ��6��v�j��n$���TVk'�!C7
�Pw��Em���xϺ��i��r"7��]nU�F#�4��p���y���v6�0�w��д��������P0�m��8p�RI�w��ʔ��ݫ�׹�wNJP�t�5�L�#W(L!�p}?t�1�9!B�!.V�B��n�頜�:�z�۷���ʃ��Ԉ�Em#w��̛���h>n�gQ�`�/5j����w�d�[���y|�d_�NRvf?����U�Y�I���@�T� (�:�d|7���fg��/�5'{�2V8��ǚ�� 6nq?tq4ei�����VCϼ>;�ީ�.���̏�ɜJ��]g��~Z��7��IfQ�9�l��V[x�4��z6�%��wu��y \��CJ7��������W�N�CR�П�OW�{w[��D䦣� �K���L��$�ӊF�������ۥs
': ��eJ�-x7`��Oը;�#ve�a?K]@�V���d��v��"�\)��ֻRj^:t���S�[����Vs2v�xi��w�rr��1���@jJMF��қV��6cN_8�,�8j��o�l�LL�����<i=�Ӆ?������̝�� �Z��::߿�l�^m��g}|�3�83��ר�����z��MIdDK؎�h����'���&|5o��d�;U:�Z���ԟ��<�I�7�S�-�fzz���h*����\�:w��㓖��������/��v �٨c��r~^�3��+4t�X��t����s��dB�]�s���z�����q��K�C)��8�`,�8i�h�9��=C�	��*UX�HV��MM�>�;��Ec���BVLnq\�s~Q,-��pۏQ�����p�7y��ކ"��a��=ӥ:���ځk�	��y̶uc���(��Z��s�$��,W$
lE�#P�}vFI���f���D0����ؽ�"7M\5 \ �H - "� �;� V��:�H����:�H	�&�>� #C�!�r	"	�ɢk�{�Fa:�9�A)@���4#�>m�lǆK$�/��2�A�BY���G��3d�m�+uQ�s���Hҍ�"v��8�#�@Y��\���q���V2�r6���h��U���.�ى"d���M�!7�������I�kſN�����: Τ��,�.#>M�(��bzRdI�eʁ�}��5&�
�_�,�8�f�RH�'�ꋈb��I��~���<E{@i:�N��Չ>�k^�7��~LBM�>��e������|Rgpq�޻�$��~�� �E�$�FF	�gɼ�u/a�F��^�i3հM7�t�i���/�G����h��O���&D�O������5����U2�ݾP��.�z�飆p���f�݂|����Z��:��2���2�a�ӹ�P� �W"�C���I����fx�+�8y7�qj���M��l����"�~���
R�k���<r}|�P��o�lRdW�(ҏ�\@�����7pH,���F����1u!��9�=�̚�#�-���&?��$�,���'gavF�3ƃ2���<�{w��aV/����{Z���Zn�I�.nvj�w�fϽ��2�6j����30e���=�A2D��w�8�!�:�n�F���h5�=�c�5��H!��7pp�d�,��	��hQi@���zƒR�%�A���k��d'��w�x����0Y��$�*Z��V�c��x	���r�#��R��%�/d��s�a�V9_5y��jL�v���ȋbJ��~��[)�`���}�K<�(��s��>�&�J[|L︖��Z����p%sA)�q�zA�\���7%h����_5�W� 3���&���d2HFmĿ�`�ak�_LqTc◡��������_�Q~���~��A�����g����%C \)y�s��	f's��P���ECX?��(:��qF�h"F� ����.'oA:�#F�X����ߠ1�M�d��抧�ק��<��J���	g$����<��y��鑃��G��m��T��>�[u`^�D�W��ÑEK�ޫ�X7��$��U�wSbM���"��� ;'T�!����|���>4�����[¤}(�{UZ8�0�P��N�$���,��xf����'�CkJA�%��U<�<����+)��
���� ��Q��q����⩥-*	� n=|��X��&���ºQ3:4���te�Ib}
�9a������rOw���tNR�5��PR�݇0��
����u�b�~�H��1�+�����~��v�#È�]?���%[f��@x�R	i?�Ѕ�qL2��F�m¯� c1�g:�m�e��SL��I9L+�+(�x��R�a5f�t�Ğ4.�sb���t�f��B9��J�]�͹���������ӥ0�b��w��y�\R��8٥%���{7'�����4�M:֙?T������b8��~�no�`��Ŗ[ۛ,�a�����|�u��oǕr�D]�:�hrF�l��&���%5�u��q'�p�]S����{k�t�76a��Ǵ�D��w��)��1� �,/w���}��ğ�C��L"�.��tYX���=c�,o��L+ᐻ�f�es���0�*I?��d�@��8ot�g'>e
I�!º������,O��      p   �   x�5NK
�0]'���� �Tэ Tp#�،vH��|���VW3����FDQ�N�4��tlETO�u�:��*�o�r�Qn�1:g��`$��i�˼��(r=T.�E�F��.:�;��,F��Z�/���ɡ��R�F8'�j�;�%/�5X+M�I�ye�c)��6�GQ      r   E   x�3�,�9��(���T�� .# �5/='�8C�Տ��uI--)N�Ppq�2r݊�S܂�b���� �[�      s   o  x��TKn�0]sN���8ɒ�h��D
� @7N�:�'��E{�ޢ�^�� ��XN?RG�1�7����Ȟ���,v�Tjbʻ�N��x(H�G<�)p������{N���q����.�#"����6���(�yY�t����e�o�=u�SA�|�W��d���`Di�h������.��WT�|��B��T�UN�p��z��H"�Q��UE�z����2��D�q��*����Ě0U)�t*����'��Y��8���H:	��X�8�8��`�ԙ`���5�YU���l�5���V��߆�vG͗�,�u�|�#�I���dYmW����&��v��y�%�v��P��+k�Dh�eS��~wwOC���D�x�O��7e�=�3��E^��	(�0G�~Y�ɛ@Ū��.�y�Ew�[8��(�F����c���v=4�L�
��N"1��g=�W�km9�B�N��ş`�y�KI�����1�Up�����q:F��fꮅ����ŏ�\�����W�%(1L��/����g��H�پ�򉹒6�"�ź�:#��O�LMf����1��G*uV8u%��N���f,�$A�M?�{�F���:��� �q�T      u      x��]Ko9�>�{�0�m�zTY^`1(Ie[#Y�He�z0������Y�˥���4_h�,�����$���ʔ3mee2��$��`D��쥽���xv�����p)��k�f�����B�F?�������u覆��i��I>��Qx��F�N�.T���Z�~:?Ez�D�w�\(�����ʀ*Չ��P~�߿�0�?|%�;F�����h>�B=���B�#�P�����CyM�*�����>v��V�8���jaٌ��f_zx|��m$s��ʻ���0g�����g*N"��=�y/�%�Ox?A��\Y�������'X9ٛ(V�J�7���o���/�h�V�j�R[�[����i^��Ofb�0�ӴX�	E��=PY�Ln��ȋ���T���ZA����J�g��T|�O��;:� �O��}��I��Z��8�a�\�=x�S%/�[��ś8��쥀��[T>�d,sY��(Z����Y�p�Y}oQi�P7������� � �ש�JZ�1�"��&"^��.O��T.�Ɂ��Y���S=?H��2N���k Cq��5����I	|S%�����ń����D\��fP�JépE��`Ae��z���(phвA��JǚM�U���������l�F�jd��D�i������
�����&nr�*?�^?;������M�� ި�M�	�ϴd�z�v��5�F*
�i��)�/��s,��$�*J�[�t�"��*w;/�/ُ´R�����O߹C�A��u�@��2h��(�&�[9� [���)����ô{G٢����k�ݡʩ	��Ca3>�"Z&���J���x~��/�N�|"�#�����2P�5�׷+���}<e`D�_'��h?�s�2D�Rt�	�)���,���=Z�' ɹ��I���5"��
��������������C�P�7�eױ��Jb5�Ii��q�}0S8
���]��D����Q�17���i��d��xX~���g}j�����'�����̖�N{GÏ�c1::��")X|xp �G����8U3��f�{��l<<�ŉFq���'�#Oi�3��(Q���p�}`���^x>�6��4��ï.H{������M[��z|>��8iМ��x<:�i{��z��!o���%���/E��b*���������K҆������S/���e]cu��Lq$���q\�3�^��p���񇸒:�b�h��;��(Nt�h��B/R5��T3���R&FQ�ʘ��h��mPvB�6��_@���s�	�7��}��>���]`˥��؛x9u9"�m�`6L�I�-��*0~�?��砓	�.5Y��k���>����+@J�O������b=|�3w��K�Z���!���L&�mOE� q�C��(�����$�ptT:�V*�Y8�b7WK%��j��Z����W`�N\� &��t8�r�}���<+���T�O/�[�8}�I9�����4�RW%��ç�������)j�w����F:�=~�R�����Jż�U�����G�1J�o~��6����;l
鳾���*�.���Hmm�橒�b8���U$%o�6��R���EюS��;�qSs%�,�&�r9S���t35���L];L
l_��a)jL�6=>��h4_�R)��蒺5�PμX��PS��.��W�o����[�����r)$�Q�T���v{�jpe�V�j �;5�����$V*�=��\���({��A�rM��+>3�82:<�Jaw���7j23lN�+%uߙy-}�T��q4���bE���jf*sY��q�<��A3-�xC�K�@���F
h�X��;U�Zj^����>�<`�s���9��3h�;x{l}�#tLq�YdV���MZ��xo�|�2P�1��+AA��Ρ�����1�}�2�|���jչ�c��j��Y��/�=�O����rƠCçLsX�P�'��7зzY�M23@�|�b8��P�fG�x'å8�n���ߢ�3w���ȵ
4 1���;�5N�S.t
`�7~������o豺6C�2CJ���ۡ�����@V�(y�_hPS~CX�Ǡ�c�~�4P=�z3���>��o��+������(����� �,�ACy�~8�c�Q�uxyy��R;�X�TO�P�BOqbd���ËR�-�����R����"6:C����>��V�4)LT5˻*��D���}�P����DsW\�[h�^��U
IE�g�6~�,�B�Jv��*�z��`��#v *U.e(���b��/��l��W�2��\���:������R	B'��zˇ�&�U����e�ǣw]�>:w�ο1����l��o��_�H�8���W������o:�Q�2|Kpr�+M�,5M{����C�EǕw<婸83Ÿ�`�Y�0�##B�`�#�2�Q%�rG�T� P|4�dV��7��}�}�K�qt�+O|�濫�6�fڗ&tmLk�ݕ�0,:9���*���/_��Z�<�o���f�������a��&�J�Ԯ��R�0c9�K��:�S�Cgp*��봎C�õ�S$2`s���!�)
m����T��[:ǩx#J���$�D}R�ڄPѺi����c;@G�-@0ӥ�j;T�Atl@X��R���Ff?u,n�C�y���)���\�:J>w�_FA�g==�:�eKr:Y9��v���� ��
�>�౞�|cm�0,i ��T����\�@3
�}���J�T"1Rd�Mdi���Drij� ۫�G�w�@��mK�w����ޟ2�P#� hX��1��ܪ��Q�t���&jt��w���iCO��a`Z��14��2)�l
�[�
W�n�G͇w�}W3�����s^��i0Vq��XԈ@; &�Cnq�r���55��0�V>�
wh'��v�Bj&#��������k2ۤ@I�˨['��T���uh5���2-
�X�m��?=ۤ����"զ�KD�p���d�{,��=PCŋΜrA�9V���G��Ό2B���)��@��O�7���J<���*��7�?�q��J��XT"�F�RѷVQ�g��K4ڷ��J����*�<]�Qml �w�ǵp���HE�%I�|�Ң�丼�����Y�8��=�z&�/Z���*X�5�'�D��ſDs4�K`Nl�{E��B\��9Ԇ�  �t����8H��Q˞��<
�����E��UV-TV�"O���#OW�h���В�P�k�A6U�Β��ȣ}�E�w��y>��D\��y-͎M$�����m�lCy��(^
����|�Lؤ�<|m�C{�uE
M~���ro���	U`����dUA�6!�hO��P0*���1�6����+����3�e(g+x������3�@V��@������O�P�*uNUAk?������֛�t���0iP�Y���L��ר%lj(=�^h�ol�`ԫ�&+*׳������1�:?�Ӧ~�'�0��O�d��[rm�O�hx1;�$^�G'^$��݊�i�B�`�Ãnh4�т�?��6��An?iB�E�}�ը�E��>�yq<��p:6/"���0����a�� �W��(����׺`�_7��0_c�t���G�w:�V�}P��/���tb�&0E�-���)ޝ[�.�,�n`O��|�O��|��Wk�Ƈ鷼Z4>H���X&�ʖN�t�_�Z^u���$��4��v��4�:Ƅ��Fc3;�9"�Qa8��p��t�iI��-���Lkw�t�Z�踣�Rl LE����s�.�s�T8[w�/���=�n��FZN�� #�W�2��Ṯc`�1���K��i��JC	�f,��xdYە*��=6\J���	���FN��X6{��p�%�T�-7L:I3	�ǩ�"�3��˳�DE�U`�nu��fP�c�lܱ�ճ    ���Ԙ%;Y4#�M?<��{Z4����A\�5~YP���2gm|�#�����n�����AV�fj��_�v�h�l�9/�m%�A��!>L�bmr#��_5�+��_8gJ#��g5�V�^��Fh_�b�IӶ+k�ӽ80�ӄ�V&��i��F}I�7&7QQ/sz-���TANј��B��l�u�4�{��.I�c�eik�����E����V�+�x���nc�1ԋXW�՜խ�����lϦ ��a�2s�ۀ��An�Ӝ����9	y-�,� kҐ��3�ܐ�����[��
�������� x�U�o�ӈ�Mc�<c�G[Kv�faQ|����8�Q�)3[������ '&8��m@$sO����頡K� Xٙ ��&�D\�t�̤^�T?̀T�F��̭�E&��(I�p�D��O�eC7\ɂ5��&�3K�fW,�tP���3}޲\mu��b\m��#)7��P��M�'�����	fv$i�'�em�t�#��'�\�Y74�w,od<�;��e3t�^ٵ��B.�m�[V �~a��]ނW�*E��[jR��D��ˋh&g�ǩ�T�&����\�Ƣ��vv:�X������ν�F*�e�;��U�]�����ۈfY��`T�S����f� �e�;�W��_���
�b��fY��fF�����O`��c�������@a�B>�ڌ��c0�:D5j��w�����~Gd�?�H����N�[�x�������SPI��6^Z��|涸|I��ĕ�Ǖ�����@?��������n��f=)��t^Kr�H���ڀh�W�ٲ�J��
�2�n�,�#o�iKH�1���"W�%4O�4Cp��P�[TRzZ"�ɞl���Z'�'�ހ���Y���u1ɪ��<��'����.Ko������\����¨���'��ؗ�ݧ��Щ����UZ�R�t��~���!���j����nj�p]мɓ�����ųņө���&��	c+�*�	�С�0�I]�x�X=�M.j�eл���
0:��g���:@2��j�a���4e��eA��I!�f����^�c�S�a,uy6�	�d"R���dd+m$V�
_��o��%�	�d�(_\0
*BgQ��򺿕`:�cn�:����İ}��l��,�����NO׭���-3$̖�n7Ja���������Ty�xj�)?�,�X�7���C5�w��jkcs�������x.�h"��(I�zs�����&I��<F�2/��-[�Y�I�ѸQ���u,�+� �1\7����V�r!�9(�<�;pNU(`0Rt�xW��l� �������4�;���d��V�����B�4��uu��g`:�������l�<i�o��g����R�L�����{����k�ߓFB}�)�R�@Ln@��D�j�q��Ĝ&���c�Ќ����)nS�#h���+T븍_b�Lv�{qYb�d��ٱ��
x��>��l�;�~>�G�U�-�=/�fL&5y]�����w-j���~c�f�؊����	?b0x�v����n�n-���3[`�nS�b~�l�{�Yh7�o�yAG����˻Y|r�k|�x����ܮ�,����а�'[�~�D�3ʄI{�J%Kp�����9�"or�g�����xVO��Oj�=�������)r%�4��1�r�|�i�,���a�耦7�#���J���<d�dJwdB?˛P��	��R*�U#?U�]V�*^}��E^e�P�fxO�kB�r\+���|��+�p͢��,W��b�e��J�L�����J���|��b����x`�&hb�#��@p-��ޞ���^�\���U���Џ}��T�G:�|�p������T�!?5U	��h�����f�˙$!ݡ/�QV~0J�����Ƈs����{JM�4�`p���t�Vcu7��P�l�m{.I��W3�`t1_^>��ʳ(��gS�%9)N�����_V��ƹ�G�
Ir'���&"u��/Fˏ�1�/�-���89��N�)�׌n�Ay��"�i���ם�G˯=(��um�<Z~�Qy��S�(ժ����Q"*���hi"�;Z��(=��Z�h�9����D'zntY�rY��ͼ�-MqsPW�(icW������;�k�&m� �1�P#������U�<M��s�n�xV8�;U^��Y�!=��EI�UKƒ�e�8�fv%��?b����婃�,^��Q0;L*�Z�Ԧr%EꂙH�Ɯ�xČ���#w�|q�}���L-�;�8^�Nł������S���������Bw���Lj��Y�{*��>�淛���Z9Rix7Mb̋M��ت�|��*F��&�S�V6�ƃ����q���Ha$�8�c�~�q������my^3��c�t"d(�}\y���X7�Nŕ����*0�h0�gĚC�f`o��
�>�`�I`���1S{� 7���>#Ǹm@�,��g�Ab�kh�nY�.Rm���-�W=��lqf
势�ȿ�JO�󺧵|n��=O�����g,.T����ʃ�8���;�Yqo
�G	�K��9j�sgj]f�#����m$�êr2tMqk~���K�#(�u���Z�K<���.dp#Ss^_N�"�e�*�Gl��NN��1��3a�fK!"�T��磩N1�O=C��)Rz� 2;,1��΋Q��xU�AT�E<��L�e��toy�ޗ<���*�/�q�
�e7uq�.����s�jaγC/��͇�F�K�N�IVz��)�.4�́�� �����Q@Mh�	�p���Dص*�E�6�),џ����N� �}>���{Qp��Y��4�Z�s8�(�&����S�C�tl��S�:4��9E�r'���@As�(���i�9����èʫGtr��	�)��L%9�?�vt-;ޯ����Pn�����G�]���Q�V�M��52��#�hTbj�u0<u\s�<;�����ãP�?��֏y0w��Ւdx����dv�b�����P|'V��.��\������H��#nv;��v���gn$x`�j	T�xbq��0Y)�1��W��e-䪴��w� ���2��]c&4��(}z���8��e
bz���2���M&fȉF�`�0���� ˦������k�c9���Z^���ҒX��u����#��
���M�<P�3�)����a���q�֩Z���f���*0���f^f�0������X��.�V���W�N��vt�KJe�j(�����B�}kV� �׋��[�,?��*��2q��!��/�t��O=T��2�!`�X�����jf�]�Ү^��P�վ��;���@n�{�ICH4ԁ*(�k9���ё�lN�'�����]���h��J�~6��)M��;�&Kj>�f��`kG�L�a�����]D�S����E|K�#���|��xMQ�s~Np����
ux�s��K�E�k ��@ei2��2g�[�K)pv�!N�I��N����/��ܰ����UJ3�$K��i^}�e��ޤ�x=DD���匢_MSd�}�w�RT�:���}�y�~L-Ap���\f0�"Y(��e����{�����ߌNʱ��yU�1�[����Ǉ���q�U���0aP�f�Y��x���2�t��"4��<�},F�|U�]>�����^Cļ��c$�M�c0�
��D��K�~׵ �h@ʬ����1�D��,�W� ���Ը�UF�a�U����2�]T���0	�@4��� Z��WW
-	!ڔe�:��v*�Y 039*ו���$��V3v��/j�P��x*B�a��=��֧�������ƭ�T1�0J2�p�҇M��;���y���s_��7F�#�*�U�Y3|�;����0�w������1��^�Ēe���1�4_V�n�F��;�&����_�3�f���D�t~��Ƃ=�u�����[;^^�l��!��e�2K�ziJ
�#h_ئ�	�l���G���_k� �  ��=���ƣ�B���:�i���~7�����q�m����Cs�]��m�<Z��n��`p�Ľ��@�q�\�g�0��?oBF3_�l�7 7���P���4V�D�g�p+�����D��b-��ze�c�9���^lzʚ�uN�F�Ô�- u#�D�90��&��3��X��>R�b��_N�schR��Wn�R����z 87rE)��~@79�A݂��S�f�v��%�O��9ۨ���?��U%�9�{0E��Ts�����u��u��#�u�� �nZ�Rn�V���c��&Y�,��b�Y����A��<��f���/k�߻��3��EwkE��KY�i�������YRԃ`���&�̔,fj2-+��a�14EZL�̻c�p��j�3(��Y�G��ZU��kƫrk���.�gx�:�)}81;�0j�`N>�3��<v��1���A�l�<���-u�r3�����l<�3�TL�sY��B��O�ߎx�-�:�zM�N?������lѓ�]�+܆y�PCܭF��D	�WL����|hȝM�6�CW�٦�7{�&��D�a���H��#�"2��hTa�M�
?ny�U�� ٖz�u�ud�sgqbk�M���ySY��h���:q�y�d�,a��*F�4���`�5�x��S���jjS���+�h��.�<J�fؚ�h�oh:��|�S)y
��L�2 �$ӄOV���_^\+y����/&��!(%����9������;��w�٥7}ፊ��̄�BV��}�b����W�q��j��4m�[?�w�.���lv��o9�t��ot���ۭwL��5f��ٽ�@��c0�����0���l�:`�'�"���jg���n�AR��1��"0�@�� ns�u�����*{C3���d`畟d:�v���
�4�I�.�h��Ѿ��9���K���,��M�.�j&L=�I�0Pz��M|���`������l��NU��>?z����<)F���f�v�ˠ��$叄r+>��4���$�`�ƿ\/G�Ո'&X��/�]NX��4�T��:��:-�J�^6���A��OA����2�۱d~��F��k�}G��#����́��%iIX*�ćY�KR�����,=oFb���%s�RW��{]#�j�Ro�7o�R�}��fj��ك�����/Ϟ=�R $      x   �   x�]���0�g�~D�+�$��(�����TV��f��')� ��;�N�t����,\3�=��BL��҂�5��B�:���0��E\�{]8�'*�@%53�����<�V\� ���ٛ��a;R-�-�͝8XF''c��/֠Fr_�T��k�<�#.��pD�ڊ��j�<F�^�ɏ>�! | �X	      z   �   x�EP�m1|SU��@�&N��"���� ���e���נ,���ȃ 1����h�BB��Irs�lc,<~���7���OeP�6� }�x� 4CG>���0�X�a#��]�g�O$�8�K-ź�Uo8�|����1�1��*�m�5���yb��]�S�������s���*k	�o�z��3��<�kϞ�z�vKg��r$q�Na���]y�?��l�n/J�?��V      {   K   x�3�,�t9���<� .# ����Շ��r�t�q�2�݂}]�����̀� נ`�2c '8�ߛ+F��� b�      ~   C   x�3�,���N�J-S0�3�71�w�,�2�$%*8ee�f��u�@�&8$��9Ӹb���� �v
      �   _   x�3�,�ts�p�42Ӏ�����\� 9�������LL�LM���8�R�2K*3sR2�2s--��s3s���s9�����!W� $ �      �   A   x�3�,�4bts�p�2	`�Cd,1eL�2�X���e��Ș�e��ȘC�`q[� ��(:      �   &   x�3�,�ts�p�4�4�34��32�31����� a��      �   K   x�3�,�	�9<'��ȆHWNCKsN��"�4.#���+��k���_$T&%(c�q"G�`G�DHK� ��       �   ]   x�3�,�tw�q�S8<'��?7� oO.�����]��l�Vq�Upq=2��.C�L���k����vO_ϣ󸌀b��� �c�b���� � $     