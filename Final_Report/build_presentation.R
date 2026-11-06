# ==============================================================================
# Script: Final_Report/build_presentation.R
# Purpose: Build Presentation Deck (PPTX & PDF) for Capstone Defense
# Strictly NO Python dependencies. Uses Node.js / pptxgenjs & LibreOffice CLI.
# ==============================================================================

cat("[1/3] Checking environment dependencies...\n")

# Check Node.js
node_path <- Sys.which("node")
if (node_path == "") {
  stop("Node.js is required to generate the presentation deck.")
}
cat(sprintf("  -> Node.js binary found: %s\n", node_path))

# Check LibreOffice
soffice_path <- Sys.which("libreoffice")
if (soffice_path == "") {
  soffice_path <- Sys.which("soffice")
}
if (soffice_path != "") {
  cat(sprintf("  -> LibreOffice binary found: %s\n", soffice_path))
} else {
  cat("  -> Note: LibreOffice not found in PATH; PDF conversion will be skipped.\n")
}

root_dir <- getwd()
if (!file.exists(file.path(root_dir, "generate_presentation.js"))) {
  if (file.exists(file.path(root_dir, "..", "generate_presentation.js"))) {
    root_dir <- normalizePath(file.path(root_dir, ".."))
  }
}

cat(sprintf("[2/3] Generating 14-slide PPTX deck via generate_presentation.js...\n"))
script_file <- file.path(root_dir, "generate_presentation.js")
node_cmd <- sprintf("NODE_PATH=/tmp/node_modules node %s", shQuote(script_file))
res_node <- system(node_cmd)
if (res_node != 0) {
  stop("Failed to generate PPTX presentation deck.")
}
cat("  -> PPTX presentation generated successfully.\n")

pptx_file <- file.path(root_dir, "Final_Report", "Stock_Market_Breakout_Presentation.pptx")
out_dir <- file.path(root_dir, "Final_Report")

if (soffice_path != "" && file.exists(pptx_file)) {
  cat("[3/3] Converting PPTX to presentation PDF via headless LibreOffice...\n")
  lo_cmd <- sprintf("%s --headless --convert-to pdf %s --outdir %s",
                    shQuote(soffice_path), shQuote(pptx_file), shQuote(out_dir))
  res_lo <- system(lo_cmd)
  if (res_lo == 0) {
    cat(sprintf("  -> PDF export generated: %s\n", file.path(out_dir, "Stock_Market_Breakout_Presentation.pdf")))
  } else {
    warning("LibreOffice PDF conversion exited with a non-zero status.")
  }
} else {
  cat("[3/3] Skipping PDF conversion.\n")
}

cat("\n==============================================================================\n")
cat("Presentation Build Complete!\n")
cat(sprintf("PPTX: %s\n", pptx_file))
cat(sprintf("PDF : %s\n", file.path(out_dir, "Stock_Market_Breakout_Presentation.pdf")))
cat("==============================================================================\n")
