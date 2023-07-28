<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<style type="text/css">
					.facture{
						height:287mm;
						width:200mm; 
						border: 1px solid black;
						page-break-before:always;
					}
					.numfact{
						width:60%;
						margin-left:20%;
						text-align:center;
						margin-top:2cm;
						border: 1px solid black;
					}
				</style>
			</head>
			<body>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture">
		<div class="facture" id="facture-{@numfacture}">
			<div class="numfact">
				facture N°<xsl:value-of select="@numfacture"/>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>