#!/usr/bin/env python3
"""
report_typography.py
Typography and layout helpers for the 20-25 page B.Tech Data Science academic report.
"""

import os
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml import parse_xml
from docx.oxml.ns import nsdecls

BASE_DIR = "/home/saurabh/Stock_Project"
OUTPUT_DIR = os.path.join(BASE_DIR, "Final_Report")
DOCX_PATH = os.path.join(OUTPUT_DIR, "Final_Academic_Report.docx")
PDF_PATH = os.path.join(OUTPUT_DIR, "Final_Academic_Report.pdf")

# Palette
COLOR_PRIMARY = RGBColor(15, 44, 89)      # Deep Navy (#0F2C59)
COLOR_SECONDARY = RGBColor(33, 102, 172)  # Medium Blue (#2166AC)
COLOR_TEXT = RGBColor(35, 35, 35)         # Charcoal text
COLOR_MUTED = RGBColor(95, 95, 95)        # Muted grey
HEX_PRIMARY = "0F2C59"
HEX_LIGHT_BG = "F4F6F8"
HEX_BORDER = "CCCCCC"
HEX_ACCENT = "E2E8F0"

def set_cell_background(cell, hex_color):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{hex_color}"/>')
    tcPr.append(shd)

def set_cell_margins(cell, top=45, bottom=45, left=90, right=90):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = parse_xml(f'<w:tcMar {nsdecls("w")}><w:top w:w="{top}" w:type="dxa"/><w:bottom w:w="{bottom}" w:type="dxa"/><w:left w:w="{left}" w:type="dxa"/><w:right w:w="{right}" w:type="dxa"/></w:tcMar>')
    tcPr.append(tcMar)

def style_paragraph(p, space_before=0, space_after=2.5, line_spacing=1.10):
    p.paragraph_format.space_before = Pt(space_before)
    p.paragraph_format.space_after = Pt(space_after)
    p.paragraph_format.line_spacing = line_spacing

def add_h1(doc, text):
    h = doc.add_paragraph()
    style_paragraph(h, space_before=9, space_after=3, line_spacing=1.10)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(16)
    run.font.bold = True
    run.font.color.rgb = COLOR_PRIMARY
    return h

def add_h2(doc, text):
    h = doc.add_paragraph()
    style_paragraph(h, space_before=6, space_after=2, line_spacing=1.10)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(13)
    run.font.bold = True
    run.font.color.rgb = COLOR_SECONDARY
    return h

def add_h3(doc, text):
    h = doc.add_paragraph()
    style_paragraph(h, space_before=5, space_after=2, line_spacing=1.12)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(11)
    run.font.bold = True
    run.font.color.rgb = COLOR_PRIMARY
    return h

def add_p(doc, text, bold_prefix="", italic=False):
    p = doc.add_paragraph()
    style_paragraph(p, space_before=0, space_after=2.5, line_spacing=1.10)
    if bold_prefix:
        r_b = p.add_run(bold_prefix)
        r_b.font.name = "Calibri"
        r_b.font.size = Pt(10)
        r_b.font.bold = True
        r_b.font.color.rgb = COLOR_TEXT
    run = p.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(10)
    run.font.italic = italic
    run.font.color.rgb = COLOR_TEXT
    return p

def add_bullet(doc, text, bold_prefix=""):
    p = doc.add_paragraph(style='List Bullet')
    style_paragraph(p, space_before=1, space_after=2, line_spacing=1.12)
    if bold_prefix:
        r_b = p.add_run(bold_prefix)
        r_b.font.name = "Calibri"
        r_b.font.size = Pt(10)
        r_b.font.bold = True
        r_b.font.color.rgb = COLOR_TEXT
    run = p.add_run(text)
    run.font.name = "Calibri"
    run.font.size = Pt(10)
    run.font.color.rgb = COLOR_TEXT
    return p

def add_callout(doc, text, title="NOTE"):
    tbl = doc.add_table(rows=1, cols=1)
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    cell = tbl.cell(0, 0)
    cell.width = Inches(6.5)
    set_cell_background(cell, "F0F4F8")
    set_cell_margins(cell, top=80, bottom=80, left=140, right=140)
    
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(f'<w:tcBorders {nsdecls("w")}><w:left w:val="single" w:sz="18" w:space="0" w:color="0F2C59"/><w:top w:val="none"/><w:right w:val="none"/><w:bottom w:val="none"/></w:tcBorders>')
    tcPr.append(borders)
    
    p = cell.paragraphs[0]
    style_paragraph(p, space_before=0, space_after=0, line_spacing=1.1)
    r_t = p.add_run(f"[{title}] ")
    r_t.font.name = "Calibri"
    r_t.font.size = Pt(9.5)
    r_t.font.bold = True
    r_t.font.color.rgb = COLOR_PRIMARY
    
    r_txt = p.add_run(text)
    r_txt.font.name = "Calibri"
    r_txt.font.size = Pt(9.5)
    r_txt.font.color.rgb = COLOR_TEXT
    
    

def add_code_block(doc, code_text):
    tbl = doc.add_table(rows=1, cols=1)
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    cell = tbl.cell(0, 0)
    cell.width = Inches(6.5)
    set_cell_background(cell, "F8F9FA")
    set_cell_margins(cell, top=60, bottom=60, left=100, right=100)
    
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(f'<w:tcBorders {nsdecls("w")}><w:left w:val="single" w:sz="12" w:space="0" w:color="CBD5E1"/><w:top w:val="single" w:sz="4" w:space="0" w:color="E2E8F0"/><w:right w:val="single" w:sz="4" w:space="0" w:color="E2E8F0"/><w:bottom w:val="single" w:sz="4" w:space="0" w:color="E2E8F0"/></w:tcBorders>')
    tcPr.append(borders)
    
    p = cell.paragraphs[0]
    style_paragraph(p, space_before=0, space_after=0, line_spacing=1.0)
    run = p.add_run(code_text.strip())
    run.font.name = "Courier New"
    run.font.size = Pt(8.0)
    run.font.color.rgb = RGBColor(30, 41, 59)
    
    


def add_figure(doc, img_rel_path, fig_num, caption, note=""):
    img_full_path = os.path.join(BASE_DIR, img_rel_path)
    if os.path.exists(img_full_path):
        p_img = doc.add_paragraph()
        p_img.alignment = WD_ALIGN_PARAGRAPH.CENTER
        style_paragraph(p_img, space_before=4, space_after=2)
        p_img.add_run().add_picture(img_full_path, width=Inches(4.2))
        p_cap = doc.add_paragraph()
        p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
        style_paragraph(p_cap, space_before=1, space_after=3)
        p_cap.paragraph_format.keep_with_next = True
        r = p_cap.add_run(f"Figure {fig_num}: ")
        r.font.name = "Calibri"; r.font.size = Pt(8.5); r.font.bold = True; r.font.color.rgb = COLOR_PRIMARY
        r2 = p_cap.add_run(caption)
        r2.font.name = "Calibri"; r2.font.size = Pt(8.5); r2.font.italic = True

def add_figure_pair(doc, img1_rel, fig1_num, cap1, img2_rel, fig2_num, cap2):
    """Embeds two related figures side-by-side with separate captions in a balanced academic table."""
    p1 = os.path.join(BASE_DIR, img1_rel)
    p2 = os.path.join(BASE_DIR, img2_rel)
    
    tbl = doc.add_table(rows=1, cols=2)
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    for c in tbl.rows[0].cells:
        tcPr = c._tc.get_or_add_tcPr()
        borders = parse_xml(f'<w:tcBorders {nsdecls("w")}><w:left w:val="none"/><w:top w:val="none"/><w:right w:val="none"/><w:bottom w:val="none"/></w:tcBorders>')
        tcPr.append(borders)
        set_cell_margins(c, top=20, bottom=20, left=40, right=40)
    
    cell1 = tbl.cell(0, 0)
    cell1.width = Inches(3.2)
    p_img1 = cell1.paragraphs[0]
    p_img1.alignment = WD_ALIGN_PARAGRAPH.CENTER
    style_paragraph(p_img1, space_before=2, space_after=2)
    if os.path.exists(p1):
        p_img1.add_run().add_picture(p1, width=Inches(3.1))
    p_cap1 = cell1.add_paragraph()
    p_cap1.alignment = WD_ALIGN_PARAGRAPH.CENTER
    style_paragraph(p_cap1, space_before=1, space_after=3)
    r1 = p_cap1.add_run(f"Figure {fig1_num}: ")
    r1.font.name = "Calibri"
    r1.font.size = Pt(8.5)
    r1.font.bold = True
    r1.font.color.rgb = COLOR_PRIMARY
    r1_t = p_cap1.add_run(cap1)
    r1_t.font.name = "Calibri"
    r1_t.font.size = Pt(8.5)
    r1_t.font.italic = True
    
    cell2 = tbl.cell(0, 1)
    cell2.width = Inches(3.2)
    p_img2 = cell2.paragraphs[0]
    p_img2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    style_paragraph(p_img2, space_before=2, space_after=2)
    if os.path.exists(p2):
        p_img2.add_run().add_picture(p2, width=Inches(3.1))
    p_cap2 = cell2.add_paragraph()
    p_cap2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    style_paragraph(p_cap2, space_before=1, space_after=3)
    r2 = p_cap2.add_run(f"Figure {fig2_num}: ")
    r2.font.name = "Calibri"
    r2.font.size = Pt(8.5)
    r2.font.bold = True
    r2.font.color.rgb = COLOR_PRIMARY
    r2_t = p_cap2.add_run(cap2)
    r2_t.font.name = "Calibri"
    r2_t.font.size = Pt(8.5)
    r2_t.font.italic = True

    

def add_styled_table(doc, headers, data, col_widths=None, table_num=1, caption=""):
    p_cap = doc.add_paragraph()
    style_paragraph(p_cap, space_before=5, space_after=2)
    p_cap.paragraph_format.keep_with_next = True
    r_num = p_cap.add_run(f"Table {table_num}: ")
    r_num.font.name = "Calibri"
    r_num.font.size = Pt(9.5)
    r_num.font.bold = True
    r_num.font.color.rgb = COLOR_PRIMARY
    
    r_txt = p_cap.add_run(caption)
    r_txt.font.name = "Calibri"
    r_txt.font.size = Pt(9.5)
    r_txt.font.italic = True
    r_txt.font.color.rgb = COLOR_TEXT

    tbl = doc.add_table(rows=len(data) + 1, cols=len(headers))
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    # Header row
    hdr_cells = tbl.rows[0].cells
    for i, title in enumerate(headers):
        hdr_cells[i].text = title
        set_cell_background(hdr_cells[i], HEX_PRIMARY)
        set_cell_margins(hdr_cells[i], top=50, bottom=50, left=80, right=80)
        p = hdr_cells[i].paragraphs[0]
        style_paragraph(p, space_before=0, space_after=0)
        p.runs[0].font.name = "Calibri"
        p.runs[0].font.size = Pt(9.0)
        p.runs[0].font.bold = True
        p.runs[0].font.color.rgb = RGBColor(255, 255, 255)
        
    # Data rows
    for r_idx, row in enumerate(data):
        row_cells = tbl.rows[r_idx + 1].cells
        bg_color = "FFFFFF" if r_idx % 2 == 0 else "F8FAFC"
        for c_idx, val in enumerate(row):
            row_cells[c_idx].text = str(val)
            set_cell_background(row_cells[c_idx], bg_color)
            set_cell_margins(row_cells[c_idx], top=35, bottom=35, left=80, right=80)
            p = row_cells[c_idx].paragraphs[0]
            style_paragraph(p, space_before=0, space_after=0)
            if p.runs:
                p.runs[0].font.name = "Calibri"
                p.runs[0].font.size = Pt(8.5)
                p.runs[0].font.color.rgb = COLOR_TEXT

    # Apply column widths
    if col_widths:
        for r in tbl.rows:
            for i, w in enumerate(col_widths):
                r.cells[i].width = Inches(w)
                
    p_after = doc.add_paragraph()
    style_paragraph(p_after, space_before=0, space_after=4)
    return tbl

print("Optimized report_typography loaded successfully")
