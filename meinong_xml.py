# coding: utf-8

import xml.etree.ElementTree as ET
import urllib.request
url='http://opendata.cwb.gov.tw/opendataapi?dataid=O-A0001-001&authorizationkey=CWB-386E7312-1884-4672-84A0-FDD0C4FD7927'
tree = ET.parse(urllib.request.urlopen(url))
root=tree.getroot()

def extract_namespace(root_tag):
    namespace_list=root_tag.split('}')
    namespace=namespace_list[0]+"}"
    return(namespace)
namespace=extract_namespace(root.tag)


def byctxt(txt):
    
    name=[]
    value=[]
    for x in root.findall(".//*[{urn:cwb:gov:tw:cwbcommon:0.1}locationName='"+txt+"']"):
    
        for c in x.findall(namespace+"weatherElement"):
        
            ev = c.find(namespace+"elementValue")
            name.append(c.find(namespace+'elementName').text)
            value.append(ev.find(namespace+'value').text)
    return(name,value)

xml_data=byctxt("美濃")
col=(xml_data[0])
value=(xml_data[1])
exit(list(value[3:]))
