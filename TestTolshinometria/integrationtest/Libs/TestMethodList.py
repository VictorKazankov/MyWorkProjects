import sys
import os.path
sys.path.append(
    os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir)))
from lxml import etree


class TestMethodList(object):

    def __init__(self):
        self.attributes = []

    @staticmethod
    def get_body_text(result):
        body_text = result.content.decode("utf-8")
        return body_text




    @staticmethod
    def assert_elements_count(body_text):

        xml_root = etree.XML(body_text)
        find_text = etree.XPath("//CNAME/text()")
        print find_text
        values = find_text(xml_root)
        assert len(values) == 747, "AssertionError: Element count isn't correct"



    @staticmethod
    def assert_is_object(body_text):

       xml_root = etree.XML(body_text)
       find_text = etree.XPath("R")
       count_object = find_text(xml_root)
       print len(count_object)
       assert (len(count_object) > 0), "Count of devices  = 0"
       return len(count_object)


    @staticmethod
    def get_count_measurement(body_text):
        xml_root = etree.XML(body_text)
        find_text = etree.XPath("R")
        count_object = find_text(xml_root)
        print len(count_object)
        return len(count_object)


    @staticmethod
    def get_number_measurement(body_text):
        xml_root = etree.XML(body_text)
        find_text = etree.XPath("//res/text()")
        print find_text
        values_arr = find_text(xml_root)
        values_num = ' '.join(values_arr)
        return values_num


