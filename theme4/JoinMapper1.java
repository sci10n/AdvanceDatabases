// cc JoinMapper1 Mapper for a reduce-side join

//package org.myorg;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.log4j.Logger;

//vv JoinMapper1
public class JoinMapper1
    extends Mapper<LongWritable, Text, TextPair, Text> {

/* here define the variables */
  @Override
  protected void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {
/* here the code for retrieving the triples from file01 and send the prefix of the dewey_pid as key */
      StringTokenizer itr = new StringTokenizer(value.toString());
      while(itr.hasMoreTokens()){
	  String id = itr.nextToken();
	  String dewid = id;
	  String aname = itr.nextToken();
	  String avalue = itr.nextToken("");
	  try{
	      dewid = dewid.substring(0,dewid.lastIndexOf('.'));
	      dewid = dewid.substring(0,dewid.lastIndexOf('.'));
	  }catch(StringIndexOutOfBoundsException e){
	      dewid = "Malformed id";
	  }
	  if(aname.equals("species") && avalue.contains("P_KK"))
	      context.write(new TextPair(dewid, dewid ),new Text(avalue+"#1")); 
      }
  }
}
//^^ JoinMapper1
