import json as JS
import xmltodict
import xml.etree.ElementTree as ET
from xml.dom import minidom

def rxkfs(xml_string, new_key):
  root = ET.fromstring(xml_string)
    for element in root:
      element.tag = new_key
    return minidom.parseString(ET.tostring(root, encoding='utf-8').decode('utf-8')).toprettyxml(indent="  ")

with open("/home/jd/.local/tmp/es_systems.json", "r") as jsonf:
  data = JS.load(jsonf)
    for key in list(data.keys()):
      for k3 in list(data[key].keys()):
            if k3 == "extension":
              data[key][k3] = ' '.join(data[key][k3])
      for k2 in list(data[key]['command'].keys()):
            if k2 == "label":
              data[key]['command']['@label'] = data[key]['command'].pop(k2)
            elif k2 == "text":
              data[key]['command']['#text'] = data[key]['command'].pop(k2)
              xmd = xmltodict.unparse({'systemList': data})
              xmdd = rxkfs(xmd, "system")


    with open("/home/jd/.emulationstation/custom_systems/es_systems.xml", "w") as xmlf:
      xmlf.write(xmdd)
