import 'package:aurora_candle/domain/entities/candle_template_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final CollectionReference candlesCollection =
      FirebaseFirestore.instance.collection('candles');

  // Agregar una vela
  // Agregar vela y devolver el ID generado por Firestore
  Future<String> addCandle(CandleTemplateEntity candle) async {
    final docRef = await candlesCollection.add(candle.toJson());
    return docRef.id; // 🔥 Retorna el ID generado por Firestore
  }

  // Obtener todas las velas en tiempo real
  Stream<List<CandleTemplateEntity>> getCandles() {
    return candlesCollection.orderBy('title').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CandleTemplateEntity.fromJson(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Obtener todas las velas solo una vez (sin suscripción en tiempo real)
  Future<List<CandleTemplateEntity>> getCandlesOnce() async {
    try {
      final snapshot = await candlesCollection.get();
      return snapshot.docs.map((doc) {
        return CandleTemplateEntity.fromJson(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching candles once: $e');
      return []; // Retornar una lista vacía en caso de error
    }
  }

  // Actualizar una vela existente
  Future<void> updateCandle(
      String id, CandleTemplateEntity updatedCandle) async {
    try {
      await candlesCollection.doc(id).update(updatedCandle.toJson());
    } catch (e) {
      debugPrint('Error updating candle: $e');
    }
  }

  // Actualizar solo la cantidad de una vela
  Future<void> updateCandleQuantity(String id, int newQuantity) async {
    try {
      await candlesCollection.doc(id).update({'quantity': newQuantity});
    } catch (e) {
      debugPrint('Error updating candle quantity: $e');
    }
  }

  // Eliminar una vela
  Future<void> deleteCandle(String id) async {
    await candlesCollection.doc(id).delete();
  }
}
