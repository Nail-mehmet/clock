
import 'package:flutter/material.dart';


class Politikamiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              '''
Gizlilik Politikası

Bu gizlilik politikası, uygulamamızın kullanıcılarının kişisel bilgilerini nasıl topladığını, kullandığını ve koruduğunu açıklamaktadır.

1. Bilgi Toplama
Uygulamamızı kullandığınızda, size daha iyi hizmet verebilmek için kişisel bilgiler toplayabiliriz. Bu bilgiler, adınız, e-posta adresiniz ve telefon numaranız gibi kimliğinizi tanımlayan bilgileri içerebilir.

2. Bilgi Kullanımı
Topladığımız bilgiler, size daha iyi hizmet sunmak, müşteri desteği sağlamak ve uygulamamızı geliştirmek için kullanılacaktır.

3. Bilgi Paylaşımı
Kişisel bilgilerinizi, yasalar gerektirmedikçe veya sizin izniniz olmadan üçüncü taraflarla paylaşmayacağız.

4. Güvenlik
Kişisel bilgilerinizin güvenliğini sağlamak için çeşitli güvenlik önlemleri kullanıyoruz. Ancak, internet üzerinden yapılan hiçbir veri aktarımının tamamen güvenli olduğunu garanti edemeyiz.

5. Değişiklikler
Bu gizlilik politikası, zaman zaman güncellenebilir. Herhangi bir değişiklik yapıldığında, yeni gizlilik politikası burada yayınlanacaktır.

6. İletişim
Bu gizlilik politikası ile ilgili herhangi bir sorunuz varsa, lütfen bizimle iletişime geçin.

Tarih: 20 Haziran 2024
          ''',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}