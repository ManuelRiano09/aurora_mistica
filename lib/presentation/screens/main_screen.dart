import 'package:aurora_candle/presentation/screens/create_candle_template_screen.dart';
import 'package:aurora_candle/presentation/widgets/candle_template_widget.dart';
import 'package:aurora_candle/presentation/providers/candle_template_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Aurora Candle',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.bold),
        ),
        leadingWidth: 10.0,
        backgroundColor: const Color.fromARGB(255, 111, 93, 159),
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Altura de la línea
          child: Container(
            color:
                const Color.fromARGB(255, 200, 162, 206), // Color de la línea
            height: 0, // Grosor de la línea
          ),
        ),
      ),
/*       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LargeTextActionButton(
              text: 'Crear plantilla',
            ),
            SizedBox(
              height: 40,
            ),
            LargeTextActionButton(
              text: 'Ver plantillas',
            ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ), */
      body: Column(
        children: [
          SortingContainer(),
          Expanded(child: _CandleTemplatesBodyWidget()),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 232, 249),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 153, 0, 254),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateCandleTemplateScreen()),
          );
        },
      ),
    );
  }
}

class _CandleTemplatesBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final candleTemplateProvider = context.watch<CandleTemplateProvider>();

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Mismo número de columnas
        crossAxisSpacing: 10, // Mismo espaciado horizontal
        mainAxisSpacing: 10, // Mismo espaciado vertical
        childAspectRatio:
            1, // Relación de aspecto cuadrada para mantener estética
      ),
      itemCount: candleTemplateProvider.candleTemplateEntityList.length,
      itemBuilder: (context, index) {
        final candleTemplateEntity =
            candleTemplateProvider.candleTemplateEntityList[index];
        return CandleTemplateWidget(
          candleTemplateEntity: candleTemplateEntity,
        );
      },
    );
  }
}


class SortingContainer extends StatefulWidget {
  const SortingContainer({super.key});

  @override
  _SortingContainerState createState() => _SortingContainerState();
}

class _SortingContainerState extends State<SortingContainer> {
  String selectedSort = "nombre"; // Orden activo
  bool isAscending = true; // Estado de orden (ascendente/descendente)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.95),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Botones de ordenamiento
              ToggleButtons(
                isSelected: ["nombre", "color", "cantidad"]
                    .map((option) => option == selectedSort)
                    .toList(),
                borderRadius: BorderRadius.circular(10),
                onPressed: (index) {
                  setState(() {
                    selectedSort = ["nombre", "color", "cantidad"][index];
                  });

                  final provider = context.read<CandleTemplateProvider>();
                  provider.orderCandles(selectedSort, isAscending);
                },
                children: [
                  _buildSortButton("Nombre", Icons.sort_by_alpha, "nombre"),
                  _buildSortButton("Color", Icons.color_lens, "color"),
                  _buildSortButton("Cantidad", Icons.format_list_numbered, "cantidad"),
                ],
              ),

              // Botón de orden ascendente/descendente
              IconButton(
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: isAscending
                      ? Icon(Icons.arrow_upward, key: ValueKey("asc"), color: Colors.deepPurple)
                      : Icon(Icons.arrow_downward, key: ValueKey("desc"), color: Colors.deepPurple),
                ),
                onPressed: () {
                  setState(() {
                    isAscending = !isAscending;
                  });

                  // Obtener el Provider desde el contexto
                  final provider = context.read<CandleTemplateProvider>();
                  provider.orderCandles(selectedSort, isAscending);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para botones de ordenamiento
  Widget _buildSortButton(String label, IconData icon, String type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: selectedSort == type ? Colors.deepPurple : Colors.grey),
          SizedBox(width: 5),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
