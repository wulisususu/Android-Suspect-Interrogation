.class public Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;
.super Ljava/lang/Object;
.source "LogConfigRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public appenders:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;",
            ">;"
        }
    .end annotation
.end field

.field public destroy:Ljava/lang/Boolean;

.field public enable:Ljava/lang/Boolean;

.field public level:Ljava/lang/String;

.field public loggers:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/android/tlog/protocol/model/request/base/Logger;",
            ">;"
        }
    .end annotation
.end field

.field public module:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.Protocol.LogConfigRequest"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->TAG:Ljava/lang/String;

    return-void
.end method

.method private appendersParse(Lcom/alibaba/fastjson/JSONObject;)Ljava/util/Map;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/fastjson/JSONObject;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;",
            ">;"
        }
    .end annotation

    .line 120
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 121
    invoke-virtual {p1}, Lcom/alibaba/fastjson/JSONObject;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_9

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 122
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 123
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/fastjson/JSONObject;

    .line 125
    new-instance v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;

    invoke-direct {v3}, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;-><init>()V

    if-eqz v1, :cond_0

    const-string v4, "fileName"

    .line 127
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 128
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;->fileName:Ljava/lang/String;

    :cond_1
    const-string v4, "filePattern"

    .line 131
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 132
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;->filePattern:Ljava/lang/String;

    :cond_2
    const-string v4, "level"

    .line 135
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 136
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;->level:Ljava/lang/String;

    :cond_3
    const-string v4, "name"

    .line 139
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 140
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;->name:Ljava/lang/String;

    :cond_4
    const-string v4, "pattern"

    .line 143
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 144
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;->pattern:Ljava/lang/String;

    :cond_5
    const-string v4, "rollingPolicy"

    .line 147
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_8

    .line 148
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getJSONObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v1

    .line 149
    new-instance v4, Lcom/taobao/android/tlog/protocol/model/request/base/RollingPolicy;

    invoke-direct {v4}, Lcom/taobao/android/tlog/protocol/model/request/base/RollingPolicy;-><init>()V

    const-string v5, "maxHistory"

    .line 150
    invoke-virtual {v1, v5}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 151
    invoke-virtual {v1, v5}, Lcom/alibaba/fastjson/JSONObject;->getInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    iput v5, v4, Lcom/taobao/android/tlog/protocol/model/request/base/RollingPolicy;->maxHistory:I

    :cond_6
    const-string v5, "totalSizeCap"

    .line 154
    invoke-virtual {v1, v5}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 155
    invoke-virtual {v1, v5}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v4, Lcom/taobao/android/tlog/protocol/model/request/base/RollingPolicy;->totalSizeCap:Ljava/lang/String;

    .line 158
    :cond_7
    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;->rollingPolicy:Lcom/taobao/android/tlog/protocol/model/request/base/RollingPolicy;

    .line 161
    :cond_8
    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    :cond_9
    return-object v0
.end method

.method private loggerParse(Lcom/alibaba/fastjson/JSONObject;)Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/fastjson/JSONObject;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/android/tlog/protocol/model/request/base/Logger;",
            ">;"
        }
    .end annotation

    .line 82
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 84
    invoke-virtual {p1}, Lcom/alibaba/fastjson/JSONObject;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 85
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 86
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/fastjson/JSONObject;

    .line 88
    new-instance v3, Lcom/taobao/android/tlog/protocol/model/request/base/Logger;

    invoke-direct {v3}, Lcom/taobao/android/tlog/protocol/model/request/base/Logger;-><init>()V

    if-eqz v1, :cond_3

    const-string v4, "appender"

    .line 90
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 91
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/Logger;->appender:Ljava/lang/String;

    :cond_0
    const-string v4, "level"

    .line 94
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 95
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/Logger;->level:Ljava/lang/String;

    :cond_1
    const-string v4, "module"

    .line 98
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 99
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/Logger;->module:Ljava/lang/String;

    :cond_2
    const-string v4, "tag"

    .line 102
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 103
    invoke-virtual {v1, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v3, Lcom/taobao/android/tlog/protocol/model/request/base/Logger;->tag:Ljava/lang/String;

    .line 107
    :cond_3
    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_4
    return-object v0
.end method


# virtual methods
.method public parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 47
    check-cast p1, Lcom/alibaba/fastjson/JSONObject;

    const-string p2, "enable"

    .line 49
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 50
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getBoolean(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->enable:Ljava/lang/Boolean;

    :cond_0
    const-string p2, "destroy"

    .line 53
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 54
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getBoolean(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->destroy:Ljava/lang/Boolean;

    :cond_1
    const-string p2, "level"

    .line 57
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 58
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->level:Ljava/lang/String;

    :cond_2
    const-string p2, "module"

    .line 61
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 62
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->module:Ljava/lang/String;

    :cond_3
    const-string p2, "appenders"

    .line 65
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 66
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getJSONObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object p2

    .line 67
    invoke-direct {p0, p2}, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->appendersParse(Lcom/alibaba/fastjson/JSONObject;)Ljava/util/Map;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->appenders:Ljava/util/Map;

    :cond_4
    const-string p2, "loggers"

    .line 69
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 70
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getJSONObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object p1

    .line 71
    invoke-direct {p0, p1}, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->loggerParse(Lcom/alibaba/fastjson/JSONObject;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/model/request/LogConfigRequest;->loggers:Ljava/util/Map;

    :cond_5
    return-void
.end method
