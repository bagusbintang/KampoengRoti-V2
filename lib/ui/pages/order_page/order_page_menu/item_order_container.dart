import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/cart_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class ItemOrderContainer extends StatefulWidget {
  final CartModel cart;
  final Function() increment;
  final Function() decrement;
  final Function() notes;
  final Function() remove;
  const ItemOrderContainer({
    Key? key,
    required this.cart,
    required this.increment,
    required this.decrement,
    required this.notes,
    required this.remove,
  }) : super(key: key);

  @override
  State<ItemOrderContainer> createState() => _ItemOrderContainerState();
}

class _ItemOrderContainerState extends State<ItemOrderContainer> {
  TextEditingController? notesController;
  @override
  Widget build(BuildContext context) {
    notesController = TextEditingController(text: widget.cart.notes);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.cart.prodUrlPhoto!,
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Text('Image not Found !');
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.cart.prodTitle!,
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: bold),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(
                                widget.cart.prodPrice! * widget.cart.quantity!),
                            // "Rp ${currencyFormatter.format(widget.cart.prodPrice! * widget.cart.quantity!)}",
                            style: primaryTextStyle.copyWith(
                                fontSize: 12, fontWeight: medium),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(widget.cart.prodPrice) +
                            " / pcs",
                        // "Rp ${currencyFormatter.format(widget.cart.prodPrice)} / biji",
                        style: primaryTextStyle.copyWith(
                            fontSize: 10, fontWeight: semiBold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.cart.notes ?? '',
                        // "Rp ${currencyFormatter.format(widget.cart.prodPrice)} / biji",
                        style: primaryTextStyle.copyWith(
                            fontSize: 10, fontWeight: semiBold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // CartCounterShop(),
                          Container(
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.remove,
                                    size: 20,
                                  ),
                                  onPressed: widget.decrement,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    widget.cart.quantity
                                        .toString()
                                        .padLeft(2, "0"),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                  onPressed: widget.increment,
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: widget.notes,
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/icon_writing.png",
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                                InkWell(
                                  onTap: widget.remove,
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/icon_bin.png",
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
        ),
      ],
    );
  }
}
