import 'package:flutter/material.dart';

class SubjectView extends StatefulWidget {
  final String bookName;
  final String writerName;
  final VoidCallback ontap;
  final String image;
  final String fileUrl;
  final VoidCallback downLoadUrl;
  final String createdDate;

  const SubjectView(
      {Key? key,
        required this.bookName,
        required this.writerName,
        required this.image,
        required this.ontap,
        required this.fileUrl, required this.downLoadUrl, required this.createdDate})
      : super(key: key);


  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: InkWell(
            onTap: widget.ontap,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff069e79)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 2)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 7),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: widget.image.isEmpty ? Image.asset('assets/images/Soccer.jpg'):Image.network(widget.image),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.bookName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                      Text(
                        widget.writerName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                      IconButton(
                          onPressed: widget.downLoadUrl,
                          icon: Icon(
                            Icons.download_outlined,
                            size: 30,
                            color: Color(0xff069e79),
                          )),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
                        child: Text(widget.createdDate),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}