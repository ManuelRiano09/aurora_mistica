import 'dart:async';

import 'package:aurora_candle/domain/entities/candle_template_entity.dart';
import 'package:aurora_candle/presentation/providers/firestore_service.dart';
import 'package:flutter/material.dart';

// This provider is used to manage the candle templates
// It is used to get the candle templates from Firebase, add a new candle template, delete a candle template and get the color from a string
// It is used in the MainScreen, CreateCandleTemplateScreen, EditCandleTemplateScreen, CandleTemplateInfoScreen, EditQuantityAlertDialog and ColorSelectorCircleWidget
// This class uses a local list for to minimize calls to Firebase, the Firebase get is only called when the list is empty or there is no fetch in process.
class CandleTemplateProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<CandleTemplateEntity> _candleTemplateEntityList = [];
  StreamSubscription? _candleSubscription;
  bool _isFetching = false;

  List<CandleTemplateEntity> get candleTemplateEntityList {
    if (_candleTemplateEntityList.isEmpty && !_isFetching) {
      fetchCandleTemplates();
    }
    return _candleTemplateEntityList;
  }

  /// get data from Firebase only if is necessary
  Future<void> fetchCandleTemplates() async {
    if (_isFetching) return; // Si ya se está ejecutando, no hacemos otra llamada
    _isFetching = true;

    try {
      _candleSubscription?.cancel(); // 🔹 Cancelamos la suscripción previa si existe
      _candleSubscription = _firestoreService.getCandles().listen((candles) {
        _candleTemplateEntityList = candles;
        notifyListeners();
      });
    } catch (e) {
      debugPrint("Error fetching candles: $e");
    } finally {
      _isFetching = false;
    }
  }

  /// Add candle 
  Future<void> addCandleTemplate(CandleTemplateEntity candleTemplateEntity) async {
    try {
      await _firestoreService.addCandle(candleTemplateEntity);
    } catch (e) {
      debugPrint("Error adding candle: $e");
    }
  }

  /// Update candle
  Future<void> updateCandleTemplate(String id, CandleTemplateEntity updatedCandle) async {
    try {
      await _firestoreService.updateCandle(id, updatedCandle);
    } catch (e) {
      debugPrint("Error updating candle: $e");
    }
  }

  /// Update candle quantity
  Future<void> updateCandleQuantity(String id, int newQuantity) async {
    try {
      await _firestoreService.updateCandleQuantity(id, newQuantity);
    } catch (e) {
      debugPrint("Error updating candle quantity: $e");
    }
  }

  /// Delete candle 
  Future<void> deleteCandleTemplate(String id) async {
    try {
      await _firestoreService.deleteCandle(id);
    } catch (e) {
      debugPrint("Error deleting candle: $e");
    }
  }

  @override
  void dispose() {
    _candleSubscription?.cancel();
    super.dispose();
  }


  CandleTemplateColors getEnumFromString(String colorString) {
    return CandleTemplateColors.values.firstWhere(
      (e) => e.name == colorString,
      orElse: () => CandleTemplateColors
          .white, // white by defect
    );
  }

  void orderCandles(String sort, bool isAscending) {
  if (_candleTemplateEntityList.isEmpty) return; // Evita ordenar si no hay datos

  // Crear una nueva lista con los mismos elementos
  List<CandleTemplateEntity> sortedList = List.from(_candleTemplateEntityList);

  switch (sort) {
    case "nombre":
      sortedList.sort((a, b) => isAscending ? a.title.compareTo(b.title) : b.title.compareTo(a.title));
      break;
    case "color":
      sortedList.sort((a, b) => isAscending ? a.color.name.compareTo(b.color.name) : b.color.name.compareTo(a.color.name));
      break;
    case "esencia":
      sortedList.sort((a, b) => isAscending ? a.scent.compareTo(b.scent) : b.scent.compareTo(a.scent));
      break;
    case "cantidad":
      sortedList.sort((a, b) => isAscending ? a.quantity.compareTo(b.quantity) : b.quantity.compareTo(a.quantity));
      break;
  }

  if (_candleTemplateEntityList != sortedList) {
    _candleTemplateEntityList = sortedList;
    notifyListeners(); // Notificar cambios en la UI
  }
}
}