<script src="jquery.min.js"></script>
<script src="FileSaver.js"></script>
<script src="tableexport.js"></script>

<script>
function export1()
{
$(".exporttable").tableExport();
}
/* Defaults */
$(".exporttable").tableExport({
    headings: true,                    // (Boolean), display table headings (th/td elements) in the <thead>
    footers: true,  				// (Boolean), display table footers (th/td elements) in the <tfoot>
    //type:"xls",
    formats: ["xls"],// "csv", "txt"],    // (String[]), filetypes for the export
    fileName: "id",                    // (id, String), filename for the downloaded file
    bootstrap:true,                   // (Boolean), style buttons using bootstrap
    position: "bottom"    ,             // (top, bottom), position of the caption element relative to table
    ignoreRows: null,                  // (Number, Number[]), row indices to exclude from the exported file
    ignoreCols: null  ,                 // (Number, Number[]), column indices to exclude from the exported file
    ignoreCSS: ".tableexport-ignore"   // (selector, selector[]), selector(s) to exclude from the exported file
});
</script>
