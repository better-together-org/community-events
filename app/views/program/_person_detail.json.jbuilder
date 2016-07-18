
json.id         person.id    
json.name       person.getFullPublicationNameSansPrefix
json.prefix     person.prefix    
json.bio        person.bio ? person.bio : ''
json.company    person.company
json.job_title  person.job_title
if person.edited_bio
    json.links do
        json.url        person.edited_bio.website_url if person.edited_bio.website && person.edited_bio.website.strip.length > 0
        json.twitter    person.edited_bio.twitterid if person.edited_bio.twitterinfo && person.edited_bio.twitterinfo.strip.length > 0
        json.fb         person.edited_bio.facebook if person.edited_bio.facebook && person.edited_bio.facebook.strip.length > 0
    end
end
if person.bio_image && @partition_val
    listImage = person.bio_image
    listImage.scale = @scale
    json.list_image     listImage.bio_picture.list.url.partition(@partition_val)[2] if listImage.bio_picture.list.url
    json.detail_image   listImage.bio_picture.detail.url.partition(@partition_val)[2] if listImage.bio_picture.detail.url
    json.full_image     listImage.bio_picture.standard.url.partition(@partition_val)[2] if listImage.bio_picture.standard.url

    json.image_256_url (get_base_image_url + listImage.bio_picture.square256.url.partition(@partition_val)[2]) if listImage.bio_picture.square256.url
#    json.list_image_url     (get_base_image_url + listImage.bio_picture.list.url.partition(@partition_val)[2]) if listImage.bio_picture.list.url
#    json.detail_image_url   (get_base_image_url + listImage.bio_picture.detail.url.partition(@partition_val)[2]) if listImage.bio_picture.detail.url
#    json.full_image_url     (get_base_image_url + listImage.bio_picture.standard.url.partition(@partition_val)[2]) if listImage.bio_picture.standard.url
end
json.prog       person.published_programme_items.collect{|i| i.id}
