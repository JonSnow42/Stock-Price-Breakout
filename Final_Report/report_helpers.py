#!/usr/bin/env python3
"""
Final Academic Report Generator:
Title: Machine Learning-Based Stock Market Trend Analysis and Momentum Breakout Prediction
Target: 20-25 pages professional B.Tech Data Science project report.
Generates: Final_Report/Final_Academic_Report.docx and Final_Report/Final_Academic_Report.pdf
"""

import os
import sys
import docx
from docx import Document
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT, WD_ALIGN_VERTICAL
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import qn, nsdecls

def create_element(name):
    return OxmlElement(name)

def set_cell_background(cell, hex_color):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{hex_color}"/>')
    tcPr.append(shd)

def set_cell_margins(cell, top=100, bottom=100, left=150, right=150):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = parse_xml(f'<w:tcMar {nsdecls("w")}><w:top w:w="{top}" w:type="dxa"/><w:bottom w:w="{bottom}" w:type="dxa"/><w:left w:w="{left}" w:type="dxa"/><w:right w:w="{right}" w:type="dxa"/></w:tcMar>')
    tcPr.append(tcMar)

def add_header_footer(doc):
    for s_idx, section in enumerate(doc.sections):
        # Unlink header/footer for section 1 (title page) vs rest
        if s_idx == 0:
            section.different_first_page_header_footer = True
            header = section.first_page_header
            footer = section.first_page_footer
            # empty for cover page
            continue
        
        # Header
        header = section.header
        hp = header.paragraphs[0]
        hp.alignment = WD_ALIGN_PARAGRAPH.RIGHT
        hrun = hp.add_run("B.Tech Data Science Project Report | Stock Market Momentum Breakout Prediction")
        hrun.font.name = "Calibri"
        hrun.font.size = Pt(8.5)
        hrun.font.italic = True
        hrun.font.color.rgb = RGBColor(120, 120, 120)

        # Footer
        footer = section.footer
        fp = footer.paragraphs[0]
        fp.alignment = WD_ALIGN_PARAGRAPH.RIGHT
        
        # Left part of footer
        frun_left = fp.add_run("Machine Learning-Based Trend Analysis & Momentum Breakout Prediction        ")
        frun_left.font.name = "Calibri"
        frun_left.font.size = Pt(8.5)
        frun_left.font.color.rgb = RGBColor(120, 120, 120)

        frun_p = fp.add_run("Page ")
        frun_p.font.name = "Calibri"
        frun_p.font.size = Pt(8.5)
        frun_p.font.color.rgb = RGBColor(100, 100, 100)

        # Add PAGE field
        fldChar1 = parse_xml(r'<w:fldChar %s w:fldCharType="begin"/>' % nsdecls('w'))
        instrText = parse_xml(r'<w:instrText %s xml:space="preserve"> PAGE </w:instrText>' % nsdecls('w'))
        fldChar2 = parse_xml(r'<w:fldChar %s w:fldCharType="separate"/>' % nsdecls('w'))
        fldChar3 = parse_xml(r'<w:fldChar %s w:fldCharType="end"/>' % nsdecls('w'))
        fp._p.append(fldChar1)
        fp._p.append(instrText)
        fp._p.append(fldChar2)
        fp._p.append(fldChar3)

        frun_of = fp.add_run(" of ")
        frun_of.font.name = "Calibri"
        frun_of.font.size = Pt(8.5)
        frun_of.font.color.rgb = RGBColor(100, 100, 100)

        # Add NUMPAGES field
        fldChar4 = parse_xml(r'<w:fldChar %s w:fldCharType="begin"/>' % nsdecls('w'))
        instrText2 = parse_xml(r'<w:instrText %s xml:space="preserve"> NUMPAGES </w:instrText>' % nsdecls('w'))
        fldChar5 = parse_xml(r'<w:fldChar %s w:fldCharType="separate"/>' % nsdecls('w'))
        fldChar6 = parse_xml(r'<w:fldChar %s w:fldCharType="end"/>' % nsdecls('w'))
        fp._p.append(fldChar4)
        fp._p.append(instrText2)
        fp._p.append(fldChar5)
        fp._p.append(fldChar6)

print("Helper functions defined successfully")
