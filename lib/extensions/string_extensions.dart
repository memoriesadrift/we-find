import 'package:xml/xml.dart';

extension Desearializer on String {
  XmlElement toXmlElement() => XmlDocument.parse(this).rootElement;
}