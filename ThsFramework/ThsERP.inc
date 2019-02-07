{---Info---
  Unit Name     : ThsERP.inc
  Descriptions  : Geliþtirici uygulamanýn nasýl kullanýlmasý gerektiði ile ilgili derleyici direktiflerini burada belirtecek
  Created By    : Ferhat YILDIRIM
  Modified By   : -
}

{$DEFINE MIGRATE}
{$DEFINE THSERP}

//Geliþtirici demo bilgilerini kullanmak istediðinde bu direktifi kullanacak.
//The developer will use this directive when he wants to use the demo data.
{$DEFINE DUMMY_VALUE}

//Geliþtiricinin Select, Insert, Update, Delete iþlemlerini hangi metod ile gerçekleþtireceðini burada belirliyoruz.
//Here, we determine which method the developer will perform Select, Insert, Update, Delete operations.
{$DEFINE CRUD_MODE_PURE_SQL}  //CRUD_MODE_SP - CRUD_MODE_PURE_SQL
