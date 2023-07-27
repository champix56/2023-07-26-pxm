<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">Facture en date du <xsl:value-of select="/factures/@dateeditionXML"/>
		<xsl:text>
type;num;date;idclient;total</xsl:text>
	<xsl:for-each select="/factures/facture">
		<xsl:text>
un facture</xsl:text>
</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
