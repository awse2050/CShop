package com.cs.domain.category;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReplyPageDTO<R> {

	private List<R> list;
	private int replyCnt;
}
