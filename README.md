# taskmanager

https://icalendar.org/ ICalendar TaskManager ve tekrarlayan eventler için yani sonu belli olmayan işler için örneğin telefonumuzda oluşturduğumuz alarm (Her gün beni 10 da uyandır) kullanılır bu formatının kullanılmasındaki asıl amaç çoğul verikaydedilmesini yani 1 iş için atıyorum 365 task   oluşturup database kaydetmektense tek bir kayıtta bu standart yapıya çözüm bulabiliriz. Ayrıca verilerin başka platformlara senkronizasyonu atıyorum uygulamayı google takvim, microsoft takvim gibi spesifik uygulamar için en optime çözümü sunduğu için bu yapıyı kullanmak oldukça mantıklıdır. Database kayıt ederken de enum keyler ve standart formattaki tarih zamanlar ile kayıt edilmek doğru bir yaklaşımdır. 

Ben şuanlık bu yapıyı kullanmadım çünkü implementasyonu biraz uzun ve zaman maliyetini göz önünde bulundurmam gerekliydi. Daha önce Reminder ile alakalı bir app yaptığımda bu yapıyı kullanmıştım o yüzden zamanım olsa yine bu yapıyı kullanırdım.

## Getting Started

Uygulamanın özellikleri : 

  - Task Oluşturma, Güncelleme, Silme
  - Oluşturulan Taskları Takvimde Event Olarak Görme,
  - Taskları tamamlandı yada tamamlanmadı şeklinde işaretlenmesi (Tamamlanan taskler yeşil olur),

Yapılması Gerekenler:
 
  -Biraz refactor gerekli  : Business Logic Component (BLoC) pattern kullanarak iş yükümü dağıttım ama vakit olsaydı daha optime olarak çalışmasını sağlamayabilirdim. Widgetları da biraz daha ekranlara bölerek class' lar rahatlatılabilir ve tabikide test kodu yazılmalı.
  
Kullandığım Paketler:
  -BLOC -> Business Logic Component (BLoC) pattern,
  -uuid -> Id için kullandığım paket,
  -lottie -> 60 fps animasyon için kullandığım paket,
  -flutter_screenutil -> ekran çözünürlükleri için kullandığım paket,
  -shared_preferences -> verilerimi kaydetmek için kullandığım paket,
  -takvim
