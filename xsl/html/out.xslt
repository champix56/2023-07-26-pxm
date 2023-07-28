<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title></title>
			</head>
			<body>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture">
		<div class="facture" id="facture-{@numfacture}">facture N°<xsl:value-of select="@numfacture"/></div>
	</xsl:template>
</xsl:stylesheet>
