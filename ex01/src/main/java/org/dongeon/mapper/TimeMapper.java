package org.dongeon.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

    @Select("SELECT NOW()")
    public String getTime();

    public String getTime2();
}

