//package CS246.Project1;

import java.io.*;
import java.net.*;

public class GetWebpage {
  public static void main(String args[]) throws Exception {
      URL url;
      InputStream inputstream = null;
      BufferedReader br;
      String htmltext;

      try {
          url = new URL(args[0]);
          inputstream = url.openStream(); 
          br = new BufferedReader(new InputStreamReader(inputstream));

          while ((htmltext = br.readLine()) != null)
          {
              System.out.println(htmltext);
          }
      } 
      catch (MalformedURLException mue)
      {
           mue.printStackTrace();
      } 
      catch (IOException ioe)
      {
           ioe.printStackTrace();
      } 
      finally 
      {
    	  try {if (inputstream != null) inputstream.close();}
    	  catch (IOException ioe){}
      }
    }
}
