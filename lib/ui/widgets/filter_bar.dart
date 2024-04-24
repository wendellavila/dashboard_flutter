import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'card_item.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    required this.onChanged,
  });

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return CardItem(
      child: SelectionContainer.disabled(
        child: TextField(
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            labelText: 'Filtrar',
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 12),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.0,
              ),
            ),
            suffixIconColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.focused) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface),
            suffixIcon: const Icon(
              Symbols.search_sharp,
              weight: 650,
            ),
          ),
          onChanged: (value) => onChanged(value),
        ),
      ),
    );
  }
}
