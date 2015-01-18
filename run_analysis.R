#marklittle
#20150115

#setwd("D:\\RÑ§Ï°±Ê¼Ç\\G&C data\\Project\\UCI HAR Dataset")


features<-read.table("features.txt",stringsAsFactors =FALSE)
colf<-c("subject_id","activity",features[[2]])
wanted<-grep("std|mean",features[[2]])
#features[wanted,]$V2
activity_info<-read.table("activity_labels.txt",stringsAsFactors =FALSE)
subject_test<-read.table("./test/subject_test.txt",stringsAsFactors =FALSE)
data_test<-read.table("./test/X_test.txt",stringsAsFactors =FALSE)
activity_test<-read.table("./test/Y_test.txt",stringsAsFactors =FALSE)
activity_test<-merge(activity_test,activity_info,by.x="V1",by.y="V1")
#data_test2<-cbind(subject_test,activity_test$V1,data_test,stringsAsFactors =FALSE)
data_test<-cbind(subject_test,activity_test$V2,data_test,stringsAsFactors =FALSE)


colnames(data_test)<-colf
#colnames(data_test2)<-colf

subject_train<-read.table("./train/subject_train.txt",stringsAsFactors =FALSE)
data_train<-read.table("./train/X_train.txt",stringsAsFactors =FALSE)
activity_train<-read.table("./train/Y_train.txt",stringsAsFactors =FALSE)
activity_train<-merge(activity_train,activity_info,by.x="V1",by.y="V1")
#data_train2<-cbind(subject_train,activity_train$V1,data_train,stringsAsFactors =FALSE)
data_train<-cbind(subject_train,activity_train$V2,data_train,stringsAsFactors =FALSE)

colnames(data_train)<-colf
#colnames(data_train2)<-colf
total<-rbind(data_train,data_test)
print("Merges the training and the test sets to total")
selected<-subset(total,select=c("subject_id","activity",features[wanted,]$V2))
print("Extracts only the measurements on the mean and standard deviation for each measurement:selected")
print("Uses descriptive activity names to name the activities in the data set:summary(total$activity)")
print(summary(total$activity))

print("Appropriately labels the data set with descriptive variable names")
print(names(total))
print("From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:\n")

tidydata<-aggregate(x=selected, by=list(subject_id=selected[["subject_id"]],activity=selected[["activity"]]), FUN=mean)
write.table(tidydata,file="tidydata.csv",row.names=FALSE)

#7352+2947




#tidydata<-xtabs(mean~subject_id+activity,data=selected)


#total2<-rbind(data_train2,data_test2)
#selected2<-subset(total2,select=c("subject_id","activity",features[wanted,]$V2))
#rm(c(total2,data_train2,data_test2))

#selected2[[1]]<-as.numeric(selected2[[1]])
#selected2[[2]]<-as.numeric(selected2[[2]])
#tmp<-as.matrix(selected2)
#tidydata<-xtabs(mean~subject_id+activity,data=tmp)
#tidydata<-xtabs(~subject_id+activity,data=selected)
#tidydata<-dcast(selected,c("subject_id","activity"),mean)


#selected$test<-paste(selected[[1]],selected[[2]])
#write.csv(selected$test,file="test.csv",row.names=FALSE)