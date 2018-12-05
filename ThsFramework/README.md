# Ths Erp Framework

Bu proje uygulama geliştirme framework olarak oluşturuldu. Sistem Delphi baz bileşenleri ile çalışıyor. Ayrıca bir bileşen eklemenize gerek yok. Veri tabanı olacak PostgreSQL veri tabanını kullanıyor.

Şu anda geliştirme ortamı versiyon olarak PostgreSQL 9.5 ile devam etmektedir.

## Getting started

Proje klasörü içindeki sql_script.sql dosyasını pg_restore komutu ile yükleme yaparak başlayabilirsiniz. Yükleme işlemi aşağıdaki gibi yapılacaktır.

Önce bir veri tabanı oluştur.

Komut satırından bu kodları çalıştırabilirsiniz. Eğer çalışmaz ise sizin PostgreSQL veri tabanının kurulu olduğu dizinin içindeki bin klasör yolunu Sistem ortam değişkenleri içindeki Path e ekli değildir. Buraya o path eklenirse cmd ekranında istediğiniz zaman bin klasörü içindeki komutları çalıştırabilirsiniz.

Bu ekleme işlemini yapmadan çalışmak isterseniz. CMD ile konsol ekranını açın
c:\Program Files\PostgreSQL\verxx\Bin\
dizinine gidin. Aşağıdaki komutları burada çalıştırın. Bu şekilde de çalışabilirsiniz.

createdb -U postgres -h 127.0.0.1 ths_erp2018		//bu işlemi arayüzden de veri tabanı oluşturma/ekleme ile yapabilirsiniz.
pg_restore -U <username> -h <host> -d <dbname> <db_yedek_file_name>
	<username>				postgresql server için kullanıcı adı örnek: postgres
	<host>					postgresql sunucu ip adresi örnek: 192.168.1.100 (Eğer localhost yani veri tabanı sunucusu komutu çalıştırdığınız bilgisayar üzerinde kurulu -h ile başlayan parametreyi girmenize gerek yok)
	<dbname>				geri yükleme işlemini yapmadan önce CREATEDB xxx ile oluşturduğunuz xxx veri tabanı adı
	<db_yedek_file_name>	geri yukleme yapılacak yedek dosyasının adı ve yolu

	createdb -U postgres ths_erp2018
	pg_restore -U postgres -d ths_erp2018 d:\Projects\_GITHUB\Delphi\ThsFramework\sql_script.sql