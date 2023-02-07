package com.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MainDao {

	public static List<Integer> getIdlist(SearchModel sm) {

		List<Integer> idList=new ArrayList<Integer>();
		try{
			Connection con=DbConnection.getConnection();
			String sql="select id from product_details where category='"+sm.getSearchCategory()+"' and search_name='"+sm.getSearchName()+"'";
			PreparedStatement pst=con.prepareStatement(sql);
			ResultSet rs=pst.executeQuery();
			while(rs.next()){
				int id=rs.getInt(1);
				idList.add(id);
			}
		}catch(Exception e){
			System.out.println(e);
		}
		return idList;
	}

}
