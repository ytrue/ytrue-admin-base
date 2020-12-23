package com.ytrue.mall.sys.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 更新密码参数
 */
@Data
public class UpdatePasswordDto {

	/**
	 * 旧密码
	 */
	@NotBlank(message="旧密码不能为空")
	@Size(max = 50)
	private String password;

	/**
	 * 新密码
	 */
	@NotBlank(message="新密码不能为空")
	@Size(max = 50)
	private String newPassword;
}
