<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--def. des formats de  papier-->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4Portrait" page-height="297mm" page-width="21cm">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--fin de definition des formats-->
			<!--sequences de chapitres-->
			<fo:page-sequence master-reference="A4Portrait">
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<xsl:for-each select="//page">
							<fo:block break-after="page">
								<fo:table>
									<fo:table-body>
										<xsl:apply-templates select="image"/>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</xsl:for-each>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
			<!--fin d'un chapitre-->
		</fo:root>
	</xsl:template>
	<xsl:template match="page/image">
		<fo:table-row>
			<fo:table-cell>
				<fo:block>image</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="@href"/>
					<fo:block/>
					<xsl:value-of select="."/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
</xsl:stylesheet>
