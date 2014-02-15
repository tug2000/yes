<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.util.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.FileItemIterator" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.BufferedOutputStream" %>
<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="com.ruijie.mcp.util.FileUploadUtil" %>
<%

if(ServletFileUpload.isMultipartContent(request)){

    DiskFileItemFactory dff = new DiskFileItemFactory();
    dff.setSizeThreshold(1024000);
    ServletFileUpload sfu = new ServletFileUpload(dff);
    FileItemIterator fii = sfu.getItemIterator(request);
    String title = "";   //图片标题
    String url = "";    //图片地址
    String fileName = "";
    String relativePath = "";
    while(fii.hasNext()){
        FileItemStream fis = fii.next();
        try{
            if(!fis.isFormField() && fis.getName().length()>0){
                fileName = fis.getName();
                BufferedInputStream in = new BufferedInputStream(fis.openStream());
                relativePath = FileUploadUtil.doSave(in, fis.getName());
            }else{
                String fname = fis.getFieldName();
                if(fname.indexOf("pictitle")!=-1){
                    BufferedInputStream in = new BufferedInputStream(fis.openStream());
                    byte c [] = new byte[10];
                    int n = 0;
                    while((n=in.read(c))!=-1){
                        title = new String(c,0,n);
                        break;
                    }
                }
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    response.getWriter().print("{'original':'"+fileName+"','url':'"+relativePath+"','title':'"+fileName+"','state':'SUCCESS'}");

}
%>
