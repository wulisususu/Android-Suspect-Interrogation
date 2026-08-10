.class public Lcom/taobao/tao/log/TLogNative;
.super Ljava/lang/Object;
.source "TLogNative.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/TLogNative$XLoggerInfo;
    }
.end annotation


# static fields
.field public static final AppednerModeAsync:I = 0x0

.field public static final AppednerModeSync:I = 0x1

.field private static final MAX_CACHE_CAPACITY:I = 0x64

.field private static TAG:Ljava/lang/String; = "TLOG.TLogNative"

.field private static final sInitCache:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/tao/log/TLogNative$XLoggerInfo;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile sOpenSoSuccess:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 23
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/taobao/tao/log/TLogNative;->sInitCache:Ljava/util/List;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/taobao/tao/log/TLogNative;->sOpenSoSuccess:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static native addModuleFilter(Ljava/lang/String;I)V
.end method

.method public static native appenderClose()V
.end method

.method public static native appenderFlush(Z)V
.end method

.method public static appenderFlushData(Z)V
    .locals 2

    const-string v0, "TLogNative"

    .line 62
    :try_start_0
    invoke-static {p0}, Lcom/taobao/tao/log/TLogNative;->appenderFlush(Z)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    const-string v1, "appenderFlushData failure"

    .line 66
    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    :catch_1
    move-exception p0

    const-string v1, "appenderFlushData failure, unsatisfied link error"

    .line 64
    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method public static appenderOpen(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 9

    :try_start_0
    const-string v0, "c++_shared"

    .line 48
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    const-string v0, "tbmarsxlog"

    .line 49
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    const/4 v2, 0x0

    move v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move-wide v7, p5

    .line 50
    invoke-static/range {v1 .. v8}, Lcom/taobao/tao/log/TLogNative;->appenderOpen(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)Z

    move-result p0

    sput-boolean p0, Lcom/taobao/tao/log/TLogNative;->sOpenSoSuccess:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    sget-object p1, Lcom/taobao/tao/log/TLogNative;->TAG:Ljava/lang/String;

    const-string p2, "appenderOpen"

    .line 52
    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method public static native appenderOpen(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)Z
.end method

.method public static native cleanModuleFilter()V
.end method

.method static dispatch(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9

    .line 131
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getInitState()I

    move-result v0

    const/4 v1, 0x2

    const-string v2, "tlog"

    if-ne v0, v1, :cond_2

    sget-object v0, Lcom/taobao/tao/log/TLogNative;->sInitCache:Ljava/util/List;

    .line 132
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    const-string v1, "flush log in asyncInit Mode"

    .line 133
    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;

    .line 135
    iget v2, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->level:I

    iget-object v3, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->module:Ljava/lang/String;

    iget-object v4, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->tag:Ljava/lang/String;

    iget-object v5, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->type:Ljava/lang/String;

    iget-object v6, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->clientID:Ljava/lang/String;

    iget-object v7, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->serverID:Ljava/lang/String;

    iget-object v8, v1, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->log:Ljava/lang/String;

    invoke-static/range {v2 .. v8}, Lcom/taobao/tao/log/TLogNative;->logWrite(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/taobao/tao/log/TLogNative;->sInitCache:Ljava/util/List;

    .line 137
    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 139
    :cond_1
    invoke-static/range {p0 .. p6}, Lcom/taobao/tao/log/TLogNative;->logWrite(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 143
    :cond_2
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->isInitSync()Z

    move-result v0

    if-eqz v0, :cond_3

    const-string p0, "tlog isn\'t init,please call init() ,or initSync(bool) method !"

    .line 144
    invoke-static {v2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    :cond_3
    sget-object v0, Lcom/taobao/tao/log/TLogNative;->sInitCache:Ljava/util/List;

    .line 146
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0x64

    if-lt v1, v2, :cond_4

    const/4 v1, 0x0

    .line 148
    :try_start_0
    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 150
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 153
    :cond_4
    :goto_1
    new-instance v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;

    invoke-direct {v0}, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;-><init>()V

    .line 154
    iput p0, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->level:I

    .line 155
    iput-object p1, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->module:Ljava/lang/String;

    .line 156
    iput-object p2, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->tag:Ljava/lang/String;

    .line 157
    iput-object p3, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->type:Ljava/lang/String;

    .line 158
    iput-object p4, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->clientID:Ljava/lang/String;

    .line 159
    iput-object p5, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->serverID:Ljava/lang/String;

    .line 160
    iput-object p6, v0, Lcom/taobao/tao/log/TLogNative$XLoggerInfo;->log:Ljava/lang/String;

    sget-object p0, Lcom/taobao/tao/log/TLogNative;->sInitCache:Ljava/util/List;

    .line 161
    invoke-interface {p0, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_2
    return-void
.end method

.method public static native getLogLevel()I
.end method

.method public static getRc4EncryptSecretyKeyValue()Ljava/lang/String;
    .locals 3

    .line 95
    :try_start_0
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object v0

    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->getSecurityKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRc4EncryptSecretValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    sget-object v1, Lcom/taobao/tao/log/TLogNative;->TAG:Ljava/lang/String;

    const-string v2, "please check rsa key"

    .line 97
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v0, 0x0

    return-object v0
.end method

.method public static getRsaPublicKeyMd5Value()Ljava/lang/String;
    .locals 1

    .line 107
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRsaMd5Value()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSecurityKey()Ljava/lang/String;
    .locals 2

    .line 79
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getSecurityKey()Ljava/lang/String;

    move-result-object v0

    .line 80
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "t_remote_debugger"

    .line 83
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->isDebugable()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "SecurityKey"

    .line 84
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    return-object v0
.end method

.method static isSoOpen()Z
    .locals 1

    sget-boolean v0, Lcom/taobao/tao/log/TLogNative;->sOpenSoSuccess:Z

    return v0
.end method

.method private static logWrite(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    sget-boolean v0, Lcom/taobao/tao/log/TLogNative;->sOpenSoSuccess:Z

    if-nez v0, :cond_0

    return-void

    .line 115
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "."

    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 p1, 0x0

    .line 116
    invoke-virtual {p2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p2, p1, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    .line 117
    invoke-virtual {p2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p2, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p2

    .line 119
    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string p1, "module"

    :cond_2
    move-object v1, p1

    .line 120
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_3

    const-string p2, "tag"

    :cond_3
    move-object v2, p2

    move v0, p0

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    .line 122
    :try_start_0
    invoke-static/range {v0 .. v6}, Lcom/taobao/tao/log/TLogNative;->logWrite2(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    .line 124
    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    return-void
.end method

.method private static native logWrite(Lcom/taobao/tao/log/TLogNative$XLoggerInfo;Ljava/lang/String;)V
.end method

.method private static native logWrite2(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public static native setAppenderMode(I)V
.end method

.method public static native setConsoleLogOpen(Z)V
.end method

.method public static native setLogLevel(I)V
.end method
