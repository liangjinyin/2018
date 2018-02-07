package com.tospur.common.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.sort.SortOrder;


public class SearchIndex {
	
	public final static String CLUSTERNAME = "xdata-elk-cluster";
	private String indexName = "elasticsearch-bigdata*";
	private String esAddress = "172.18.84.49";
	private int esPort = 9300;
	private int pageSize = 100;
	private int pageNo = 1;
	
	public DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SortOrder sortOrder = SortOrder.DESC;
	
	public static Client client = null;

	public SearchIndex(){
	}
	
	public SearchIndex(String esAddress){
		this.esAddress = esAddress;
	}
	
	public SearchIndex(String esAddress, int esPort){
		this.esAddress = esAddress;
		this.esPort = esPort;
	}
	
	public SearchIndex(String esAddress, int esPort, int pageSize, int pageNo){
	    this.esAddress = esAddress;
	    this.esPort = esPort;
	    if(pageSize > 0){
	        this.pageSize = pageSize;	        
	    }
	    if(pageNo > 0){
	        this.pageNo = pageNo;	        
	    }
	}
	
	

	
	public static void main(String[] args) throws Exception {
		

	}
	
	/* slow */
	public void buildClientByTransport() throws UnknownHostException {
        String[] ipStr = esAddress.split("\\.");
        byte[] ipBuf = new byte[4];
        for(int i = 0; i < 4; i++){
            ipBuf[i] = (byte)(Integer.parseInt(ipStr[i])&0xff);
        }
		
		Settings settings = Settings.settingsBuilder()
		        .put("cluster.name", CLUSTERNAME).build();
		client = TransportClient.builder().settings(settings).build()
			//	.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName("centos1"), 9300));
				.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByAddress(ipBuf), esPort));
	}
	
	
	
	public void close(){
	    if(client != null){
	        client.close();
	    }
	}

}