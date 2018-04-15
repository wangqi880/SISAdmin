package com.sis.service;

import java.util.List;

import com.sis.model.MajorDetail;

/**
 * @author luchenxi
 *
 */
public interface MajorInterface {
	/**
	 */
	List<MajorDetail> getMajorDetailInfo(String majorName);
}
