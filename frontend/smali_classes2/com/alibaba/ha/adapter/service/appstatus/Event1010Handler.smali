.class public Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;
.super Ljava/lang/Object;
.source "Event1010Handler.java"

# interfaces
.implements Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$SingleTon;
    }
.end annotation


# static fields
.field public static final HISTORY_FILE_NAME:Ljava/lang/String; = "aliha-appstatus1010.adt"

.field public static final LAUNCH_INTERVAL:J = 0x7530L

.field public static final MAX_HISTORY_EVENT_CNT:I = 0x258

.field public static final MAX_HISTORY_FILE_SIZE:I = 0xa000

.field public static TAG:Ljava/lang/String; = "AliHaAdapter.Event1010Handler"


# instance fields
.field public asyncTaskThread:Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;

.field public mApplication:Landroid/app/Application;

.field public mExtMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public mHistoryEvents:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field public mLockObj:Ljava/lang/Object;

.field public mToBackgroundTimestamp:J


# direct methods
.method public static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mToBackgroundTimestamp:J

    .line 39
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mLockObj:Ljava/lang/Object;

    .line 40
    new-instance v0, Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;

    invoke-direct {v0}, Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->asyncTaskThread:Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;

    return-void
.end method

.method public synthetic constructor <init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;)V
    .locals 0

    .line 27
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;-><init>()V

    return-void
.end method

.method private _send1010Hit()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->asyncTaskThread:Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;

    .line 63
    new-instance v1, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;

    invoke-direct {v1, p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;-><init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V

    invoke-virtual {v0, v1}, Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;->start(Ljava/lang/Runnable;)V

    return-void
.end method

.method public static synthetic access$100(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/util/List;
    .locals 0

    .line 27
    iget-object p0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    return-object p0
.end method

.method public static synthetic access$102(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .line 27
    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    return-object p1
.end method

.method public static synthetic access$200(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/util/List;
    .locals 0

    .line 27
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->readFileData()Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic access$300(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V
    .locals 0

    .line 27
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->_send1010Hit()V

    return-void
.end method

.method public static synthetic access$400(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/lang/Object;
    .locals 0

    .line 27
    iget-object p0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mLockObj:Ljava/lang/Object;

    return-object p0
.end method

.method public static synthetic access$500(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Long;)Ljava/util/Map;
    .locals 0

    .line 27
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->makeTimestampExtData(Ljava/lang/Long;)Ljava/util/Map;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic access$600(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Object;Ljava/util/Map;)Z
    .locals 0

    .line 27
    invoke-direct {p0, p1, p2}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->sendEvent(Ljava/lang/Object;Ljava/util/Map;)Z

    move-result p0

    return p0
.end method

.method public static synthetic access$700()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static synthetic access$800(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V
    .locals 0

    .line 27
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->clearHistory()V

    return-void
.end method

.method public static synthetic access$900(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Long;)V
    .locals 0

    .line 27
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->addHistory(Ljava/lang/Long;)V

    return-void
.end method

.method private addHistory(Ljava/lang/Long;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    if-nez v0, :cond_1

    .line 119
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    .line 122
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x258

    if-lt v0, v1, :cond_2

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    const/4 v1, 0x0

    .line 123
    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_2
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    .line 126
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 128
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->write2File()V

    return-void
.end method

.method private clearHistory()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    .line 110
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->write2File()V

    return-void
.end method

.method public static getInstance()Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;
    .locals 1

    .line 45
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$SingleTon;->access$000()Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    move-result-object v0

    return-object v0
.end method

.method private makeTimestampExtData(Ljava/lang/Long;)Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Long;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 83
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    if-eqz v1, :cond_1

    .line 86
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    .line 87
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    .line 88
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Long;

    .line 89
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, "_"

    .line 90
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 92
    :cond_0
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_1
    const-string v1, ""

    :goto_1
    if-eqz p1, :cond_2

    .line 95
    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-lez v2, :cond_2

    .line 96
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 98
    :cond_2
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p1

    const/4 v2, 0x1

    if-le p1, v2, :cond_3

    .line 99
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p1

    sub-int/2addr p1, v2

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    :cond_3
    :goto_2
    const-string p1, "_timestamps"

    .line 103
    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method

.method private readFileData()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mApplication:Landroid/app/Application;

    const-string v2, "aliha-appstatus1010.adt"

    .line 246
    invoke-virtual {v1, v2}, Landroid/app/Application;->openFileInput(Ljava/lang/String;)Ljava/io/FileInputStream;

    move-result-object v1

    .line 247
    invoke-virtual {v1}, Ljava/io/FileInputStream;->available()I

    move-result v2

    if-eqz v2, :cond_2

    const v3, 0xa000

    if-le v2, v3, :cond_0

    goto :goto_1

    .line 252
    :cond_0
    new-instance v2, Ljava/io/ObjectInputStream;

    invoke-direct {v2, v1}, Ljava/io/ObjectInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 253
    :try_start_1
    invoke-virtual {v2}, Ljava/io/ObjectInputStream;->readObject()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Long;

    if-eqz v1, :cond_1

    .line 254
    array-length v3, v1

    if-lez v3, :cond_1

    .line 255
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 256
    :try_start_2
    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v3, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v0, v3

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_3

    .line 263
    :cond_1
    :goto_0
    :try_start_3
    invoke-virtual {v2}, Ljava/io/ObjectInputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_5

    :catch_0
    move-exception v1

    goto :goto_4

    :catchall_1
    move-exception v1

    move-object v3, v0

    goto :goto_2

    :cond_2
    :goto_1
    return-object v0

    :catchall_2
    move-exception v1

    move-object v2, v0

    move-object v3, v2

    :goto_2
    move-object v0, v1

    :goto_3
    :try_start_4
    sget-object v1, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    .line 259
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    if-eqz v2, :cond_3

    .line 263
    :try_start_5
    invoke-virtual {v2}, Ljava/io/ObjectInputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    move-object v0, v3

    goto :goto_5

    :catch_1
    move-exception v1

    move-object v0, v3

    :goto_4
    sget-object v2, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    .line 265
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_5
    move-object v3, v0

    :cond_3
    return-object v3

    :catchall_3
    move-exception v0

    if-eqz v2, :cond_4

    .line 263
    :try_start_6
    invoke-virtual {v2}, Ljava/io/ObjectInputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_6

    :catch_2
    move-exception v1

    sget-object v2, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    .line 265
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 268
    :cond_4
    :goto_6
    throw v0
.end method

.method private sendEvent(Ljava/lang/Object;Ljava/util/Map;)Z
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    .line 132
    new-instance v9, Ljava/util/HashMap;

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mExtMap:Ljava/util/Map;

    invoke-direct {v9, v0}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    if-eqz p2, :cond_0

    .line 134
    invoke-interface {v9, p2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 138
    :cond_0
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const/4 v1, 0x0

    const-string v4, "-"

    const/16 v5, 0x3f2

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v6, p1

    invoke-virtual/range {v0 .. v9}, Lcom/alibaba/sdk/android/tbrest/SendService;->sendRequest(Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1
.end method

.method private write2File()V
    .locals 5

    const-string v0, "/aliha-appstatus1010.adt"

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    if-eqz v2, :cond_1

    .line 211
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mApplication:Landroid/app/Application;

    const-string v2, "aliha-appstatus1010.adt"

    const/4 v3, 0x0

    .line 220
    invoke-virtual {v0, v2, v3}, Landroid/app/Application;->openFileOutput(Ljava/lang/String;I)Ljava/io/FileOutputStream;

    move-result-object v0

    .line 221
    new-instance v2, Ljava/io/ObjectOutputStream;

    invoke-direct {v2, v0}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    .line 222
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/Long;

    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    .line 223
    invoke-interface {v1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 224
    invoke-virtual {v2, v0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    .line 225
    invoke-virtual {v2}, Ljava/io/ObjectOutputStream;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 232
    :try_start_2
    invoke-virtual {v2}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    :catchall_0
    move-exception v0

    move-object v1, v2

    goto :goto_1

    .line 212
    :cond_1
    :goto_0
    :try_start_3
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mApplication:Landroid/app/Application;

    invoke-virtual {v4}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 213
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 214
    invoke-virtual {v2}, Ljava/io/File;->delete()Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :cond_2
    return-void

    :catchall_1
    move-exception v0

    :goto_1
    :try_start_4
    sget-object v2, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    .line 228
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    if-eqz v1, :cond_3

    .line 232
    :try_start_5
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    sget-object v1, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    .line 235
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    :goto_2
    return-void

    :catchall_2
    move-exception v0

    if-eqz v1, :cond_4

    .line 232
    :try_start_6
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_3

    :catch_1
    move-exception v1

    sget-object v2, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->TAG:Ljava/lang/String;

    .line 235
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 238
    :cond_4
    :goto_3
    throw v0
.end method


# virtual methods
.method public init(Landroid/app/Application;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mApplication:Landroid/app/Application;

    iput-object p2, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mExtMap:Ljava/util/Map;

    iget-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->asyncTaskThread:Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;

    .line 53
    new-instance p2, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;

    invoke-direct {p2, p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;-><init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V

    invoke-virtual {p1, p2}, Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;->start(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 0

    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 0

    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 0

    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 0

    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 0

    return-void
.end method

.method public onSwitchBackground()V
    .locals 2

    .line 143
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mToBackgroundTimestamp:J

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mHistoryEvents:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 146
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->asyncTaskThread:Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;

    .line 147
    new-instance v1, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;

    invoke-direct {v1, p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;-><init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V

    invoke-virtual {v0, v1}, Lcom/alibaba/ha/adapter/service/appstatus/AsyncThreadPool;->start(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public onSwitchForeground()V
    .locals 4

    iget-wide v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mToBackgroundTimestamp:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 168
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->mToBackgroundTimestamp:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x7530

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    .line 170
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->_send1010Hit()V

    :cond_0
    return-void
.end method
