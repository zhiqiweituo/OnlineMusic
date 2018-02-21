package com.zhi.service;

import java.util.List;

import com.zhi.entity.PageBean;
import com.zhi.entity.Song;

public interface SongService {
	public List<Song> songList(PageBean pageBean,Song s_song);
	public long songCount(Song s_song);
	public void saveSong(Song song);
	public void deleteSong(Song song);
	public Song findObjectById(int songId);
}
