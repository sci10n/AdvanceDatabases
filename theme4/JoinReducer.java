// cc JoinReducer Reducer for join

//package org.myorg;

import java.io.IOException;
import java.util.Iterator;
import java.util.*;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

// vv JoinReducer
public class JoinReducer extends Reducer<TextPair, Text, Text, Text> {

  @Override
  protected void reduce(TextPair key, Iterable<Text> values, Context context)
      throws IOException, InterruptedException {

      /* here comes the reducer code */
	Vector<Text> buffer = new Vector<Text>();
      	
	boolean addIt = false;
	for(Text text : values){
	  if(text.toString().contains("#1")){
	      addIt = true;
	      //String avalue = text.toString();
	      //avalue = avalue.substring(0, avalue.length()-2);
	  }
	  else if(text.toString().contains("#2")){
	      String avalue = text.toString();
	      avalue = avalue.substring(0, avalue.length()-2);
	      buffer.add(new Text(avalue)); 
	}
      }
       if(!addIt){
	return;
      }
	
      for(Text text: buffer){
	context.write(new Text(key.getFirst().toString()),text);
     } 
      
  }
}
// ^^ JoinReduce
