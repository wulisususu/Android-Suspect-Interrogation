.class public Lcom/taobao/android/tlog/protocol/model/reply/ParseHelper;
.super Ljava/lang/Object;
.source "ParseHelper.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static jointPointParse(Ljava/lang/String;Lcom/alibaba/fastjson/JSONObject;)Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;
    .locals 2

    const-string v0, "background"

    .line 88
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 89
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/BackgroundJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/BackgroundJointPoint;-><init>()V

    return-object p0

    :cond_0
    const-string v0, "event"

    .line 90
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 91
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;-><init>()V

    return-object p0

    :cond_1
    const-string v0, "foreground"

    .line 92
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 93
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/ForegroundJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/ForegroundJointPoint;-><init>()V

    return-object p0

    :cond_2
    const-string v0, "lifecycle"

    .line 94
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 95
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;-><init>()V

    return-object p0

    :cond_3
    const-string v0, "notification"

    .line 96
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 97
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;-><init>()V

    const-string v0, "action"

    .line 98
    invoke-virtual {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 99
    invoke-virtual {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;->action:Ljava/lang/String;

    :cond_4
    const-string v0, "uri"

    .line 102
    invoke-virtual {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 103
    invoke-virtual {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;->uri:Ljava/lang/String;

    :cond_5
    return-object p0

    :cond_6
    const-string v0, "startup"

    .line 106
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 107
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/StartupJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/StartupJointPoint;-><init>()V

    return-object p0

    :cond_7
    const-string v0, "timer"

    .line 108
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_9

    .line 109
    new-instance p0, Lcom/taobao/android/tlog/protocol/model/joint/point/TimerJointPoint;

    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/joint/point/TimerJointPoint;-><init>()V

    const-string v0, "waitMilliseconds"

    .line 110
    invoke-virtual {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 111
    invoke-virtual {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->getInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Lcom/taobao/android/tlog/protocol/model/joint/point/TimerJointPoint;->waitMilliseconds:I

    :cond_8
    return-object p0

    :cond_9
    const/4 p0, 0x0

    return-object p0
.end method

.method public static parseUploadInfos(Lcom/alibaba/fastjson/JSONArray;)[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;
    .locals 8

    .line 33
    invoke-virtual {p0}, Lcom/alibaba/fastjson/JSONArray;->size()I

    move-result v0

    new-array v0, v0, [Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    const/4 v1, 0x0

    .line 34
    :goto_0
    invoke-virtual {p0}, Lcom/alibaba/fastjson/JSONArray;->size()I

    move-result v2

    if-ge v1, v2, :cond_a

    .line 35
    invoke-virtual {p0, v1}, Lcom/alibaba/fastjson/JSONArray;->getJSONObject(I)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v2

    .line 36
    new-instance v3, Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    invoke-direct {v3}, Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;-><init>()V

    const-string v4, "fileInfo"

    .line 38
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 39
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->getJSONObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v4

    .line 41
    new-instance v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

    invoke-direct {v5}, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;-><init>()V

    const-string v6, "fileName"

    .line 42
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 43
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->fileName:Ljava/lang/String;

    :cond_0
    const-string v6, "absolutePath"

    .line 45
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 46
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->absolutePath:Ljava/lang/String;

    :cond_1
    const-string v6, "lastModified"

    .line 48
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 49
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getDate(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v6

    iput-object v6, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->lastModified:Ljava/util/Date;

    :cond_2
    const-string v6, "contentLength"

    .line 51
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 52
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v6

    iput-object v6, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->contentLength:Ljava/lang/Long;

    :cond_3
    const-string v6, "contentType"

    .line 54
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 55
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->contentType:Ljava/lang/String;

    :cond_4
    const-string v6, "contentMD5"

    .line 57
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_5

    .line 58
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->contentMD5:Ljava/lang/String;

    :cond_5
    const-string v6, "contentEncoding"

    .line 60
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_6

    .line 61
    invoke-virtual {v4, v6}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v5, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->contentEncoding:Ljava/lang/String;

    .line 65
    :cond_6
    iput-object v5, v3, Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;->fileInfo:Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

    .line 68
    :cond_7
    invoke-virtual {v2}, Lcom/alibaba/fastjson/JSONObject;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_8
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_9

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .line 69
    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 70
    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    .line 71
    instance-of v6, v4, Ljava/lang/String;

    if-eqz v6, :cond_8

    .line 72
    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v5, v4}, Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 75
    :cond_9
    aput-object v3, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_a
    return-object v0
.end method
