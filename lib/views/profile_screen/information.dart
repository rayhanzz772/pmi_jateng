import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
            onPressed: () {
              Get.toNamed('/profile');
            },
          ),
          title: Text(
            'Informasi',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: kPrimaryWhite),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circle with icon

                SizedBox(height: 16),
                // Card with content
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.red[900],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentang Kami',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Selamat datang di Graha Diklat PMI Jawa Tengah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'PMI Jawa Tengah berkomitmen untuk memberikan pelayanan kemanusiaan yang terbaik kepada masyarakat. Kami bekerja dengan dedikasi tinggi, memastikan bahwa setiap kegiatan kemanusiaan dilaksanakan secara profesional dan penuh tanggung jawab. PMI Jateng terus berinovasi untuk memenuhi kebutuhan masyarakat, baik dalam tanggap darurat, donor darah, maupun pelatihan kebencanaan. Kami hadir dengan tujuan memberikan bantuan kepada mereka yang membutuhkan, serta berperan aktif dalam menjaga kesehatan dan keselamatan publik. Dengan semangat gotong royong, PMI Jateng siap melayani kapanpun dan dimanapun.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.red[200],
                            radius: 20,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.red[900],
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
