import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/booking.dart';

class BookingSource {
  static Future<Booking?> checkIsBooked(String userId, String hotelId) async {
    var result = await FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection("Booking")
        .where('id_hotel', isEqualTo: hotelId)
        .where('is_done', isEqualTo: false)
        .get();

    if (result.size > 0) {
      return Booking.fromJson(result.docs.first.data());
    }

    return null;
  }

// Fungsi statis yang mengembalikan Future<bool> dan menerima dua parameter: userId dan booking
  static Future<bool> addBooking(String userId, Booking booking) async {
    // Mendapatkan referensi ke koleksi 'Booking' dalam dokumen 'User' yang spesifik berdasarkan userId
    var ref = FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .collection('Booking');

    // Menambahkan data booking lagi ke dalam sub-koleksi 'Booking' dan menunggu hingga selesai, menyimpan referensi dokumen yang dihasilkan
    var docRef = await ref.add(booking.toJson());

    // Memperbarui dokumen yang baru ditambahkan dengan menambahkan field 'id' yang nilainya adalah id dokumen itu sendiri
    docRef.update({'id' : docRef.id});

    // Mengembalikan nilai true menandakan bahwa fungsi telah selesai dengan sukses
    return true;

    // -- Mendapatkan referensi ke tabel 'Booking' dalam tabel 'User' berdasarkan userId
    // -- Dalam SQL, kita tidak perlu referensi ini, tetapi kita anggap kita bekerja pada tabel tertentu

    //
    // -- Menambahkan data booking ke dalam tabel 'Booking' dan mendapatkan id dari record yang baru ditambahkan
    // INSERT INTO Booking (column1, column2, ...) VALUES (value1, value2, ...);
    // -- Asumsi kita mendapatkan id dari record yang baru ditambahkan
    // -- Di Firestore, ini dilakukan dengan var docRef = await ref.add(booking.toJson());
    // -- Dalam SQL, kita menggunakan sesuatu seperti LAST_INSERT_ID()
    // SELECT LAST_INSERT_ID() INTO @docId;
    //
    // -- Memperbarui record yang baru ditambahkan dengan menambahkan/memperbarui kolom 'id'
    // UPDATE Booking SET id = @docId WHERE id = @docId;
    //
    // -- Mengembalikan nilai true menandakan bahwa fungsi telah selesai dengan sukses
    // -- Dalam SQL, ini tidak relevan karena kita tidak mengembalikan nilai dari query, tetapi dalam konteks aplikasi kita dapat menganggap operasi selesai sukses.
  }

}
