locals {
    homes_path_aws = {
        home_music_home_path = {
            public_path = "/workspace/terraform-beginner-bootcamp-2023/public/music_home"
        content_version = 1
        }
        home_video_home_path = {
            public_path = "/workspace/terraform-beginner-bootcamp-2023/public/video_home"
        content_version = 1
        }
    }
    homes = {
        home_music_home = {
            name = "Glory for Ukraine"
	        description = <<DESCRIPTION
	        There is no comments needed...
	        DESCRIPTION
            domain_name = module.terrahome_aws["home_music_home_path"].cloudfront_url
	        town = "melomaniac-mansion"
	        content_version = 1 
        } 
         home_video_home = {
            name = "Four rooms"
	        description = <<DESCRIPTION
	        One of the best movies by Kventin Tarantino
	        DESCRIPTION
            domain_name = module.terrahome_aws["home_video_home_path"].cloudfront_url
	        town = "video-valley"
	        content_version = 2 
        } 
    }
}
