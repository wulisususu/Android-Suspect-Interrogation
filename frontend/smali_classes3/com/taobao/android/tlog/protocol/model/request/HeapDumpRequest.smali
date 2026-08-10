.class public Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;
.super Ljava/lang/Object;
.source "HeapDumpRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public allowForeground:Ljava/lang/Boolean;

.field public heapSizeThreshold:Ljava/lang/Integer;

.field public start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

.field public uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.Protocol.LogUploadRequest"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 33
    check-cast p1, Lcom/alibaba/fastjson/JSONObject;

    const-string p2, "allowForeground"

    .line 35
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 36
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getBoolean(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->allowForeground:Ljava/lang/Boolean;

    :cond_0
    const-string p2, "heapSizeThreshold"

    .line 39
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 40
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->heapSizeThreshold:Ljava/lang/Integer;

    :cond_1
    const-string p2, "uploadId"

    .line 43
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 44
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->uploadId:Ljava/lang/String;

    .line 47
    :cond_2
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 48
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->uploadId:Ljava/lang/String;

    :cond_3
    const-string p2, "start"

    .line 51
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 52
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getJSONObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object p1

    if-eqz p1, :cond_4

    const-string p2, "type"

    .line 56
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 57
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_4
    const/4 p2, 0x0

    :goto_0
    if-eqz p2, :cond_5

    .line 62
    invoke-static {p2, p1}, Lcom/taobao/android/tlog/protocol/model/reply/ParseHelper;->jointPointParse(Ljava/lang/String;Lcom/alibaba/fastjson/JSONObject;)Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    move-result-object p1

    if-eqz p1, :cond_5

    .line 64
    iput-object p2, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    :cond_5
    return-void
.end method
