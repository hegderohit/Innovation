<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <xsl:template match="/">

        <xsl:variable name="attributes_body"> 
            <xsl:attribute name="chapter"><xsl:value-of select="1234"/></xsl:attribute> 
            <xsl:attribute name="id"><xsl:value-of select="12"/></xsl:attribute> 
        </xsl:variable>
        <xsl:message>
            Chapter : <xsl:value-of select="$attributes_body/@chapter"></xsl:value-of>
        </xsl:message>
        
      <xsl:variable name="componentProperties2">
          <containerModelProperties namespace="http://www.innovation3g.com/gsf/model"  xpath-default-namespace="http://www.innovation3g.com/gsf/model">
              <x namespace="http://www.innovation3g.com/gsf/model">
                    <xsl:value-of select="100"/>
                </x>
              <y namespace="http://www.innovation3g.com/gsf/model">
                    <xsl:value-of
                        select="300"
                    />
                </y>
              
            </containerModelProperties>
        </xsl:variable>
        
        <xsl:message>
            x Value is : <xsl:value-of select="$componentProperties2/containerModelProperties/x"></xsl:value-of>
        </xsl:message>
        
        
       
        
    </xsl:template>
    
    
</xsl:stylesheet>