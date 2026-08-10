.class public Lanet/channel/util/ALog;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/util/ALog$Logcat;,
        Lanet/channel/util/ALog$Level;,
        Lanet/channel/util/ALog$ILog;
    }
.end annotation


# static fields
.field private static LOG_BREAK:Ljava/lang/Object;

.field private static canUseTlog:Z

.field private static isPrintLog:Z

.field private static volatile log:Lanet/channel/util/ALog$ILog;

.field public static logcat:Lanet/channel/util/ALog$Logcat;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 83
    new-instance v0, Lanet/channel/util/ALog$Logcat;

    invoke-direct {v0}, Lanet/channel/util/ALog$Logcat;-><init>()V

    sput-object v0, Lanet/channel/util/ALog;->logcat:Lanet/channel/util/ALog$Logcat;

    sput-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    const-string/jumbo v0, "|"

    sput-object v0, Lanet/channel/util/ALog;->LOG_BREAK:Ljava/lang/Object;

    const/4 v0, 0x1

    sput-boolean v0, Lanet/channel/util/ALog;->isPrintLog:Z

    sput-boolean v0, Lanet/channel/util/ALog;->canUseTlog:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static varargs buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    const-string v0, ""

    if-nez p0, :cond_0

    if-nez p1, :cond_0

    if-nez p2, :cond_0

    return-object v0

    .line 199
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const/16 v2, 0x40

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 200
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    sget-object v2, Lanet/channel/util/ALog;->LOG_BREAK:Ljava/lang/Object;

    .line 201
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "[seq:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, "]"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    const-string p1, " "

    if-eqz p0, :cond_2

    .line 205
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    if-eqz p2, :cond_6

    const/4 p0, 0x0

    :goto_0
    add-int/lit8 v2, p0, 0x1

    .line 210
    array-length v3, p2

    if-ge v2, v3, :cond_5

    .line 211
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, p2, p0

    if-eqz v4, :cond_3

    goto :goto_1

    :cond_3
    move-object v4, v0

    .line 212
    :goto_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ":"

    .line 213
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v2, p2, v2

    if-eqz v2, :cond_4

    goto :goto_2

    :cond_4
    move-object v2, v0

    .line 214
    :goto_2
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    add-int/lit8 p0, p0, 0x2

    goto :goto_0

    .line 216
    :cond_5
    array-length v0, p2

    if-ge p0, v0, :cond_6

    .line 217
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 218
    aget-object p0, p2, p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 221
    :cond_6
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static buildLogTag(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    return-object p0
.end method

.method public static varargs d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x1

    .line 138
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 140
    invoke-static {p0}, Lanet/channel/util/ALog;->buildLogTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p2, p3}, Lanet/channel/util/ALog;->buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p0, p1}, Lanet/channel/util/ALog$ILog;->d(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public static varargs e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x4

    .line 183
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 185
    invoke-static {p0}, Lanet/channel/util/ALog;->buildLogTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p2, p4}, Lanet/channel/util/ALog;->buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p0, p1, p3}, Lanet/channel/util/ALog$ILog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    return-void
.end method

.method public static varargs e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x4

    .line 175
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 177
    invoke-static {p0}, Lanet/channel/util/ALog;->buildLogTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p2, p3}, Lanet/channel/util/ALog;->buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p0, p1}, Lanet/channel/util/ALog$ILog;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public static getLog()Lanet/channel/util/ALog$ILog;
    .locals 1

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    return-object v0
.end method

.method public static varargs i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x2

    .line 151
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 153
    invoke-static {p0}, Lanet/channel/util/ALog;->buildLogTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p2, p3}, Lanet/channel/util/ALog;->buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p0, p1}, Lanet/channel/util/ALog$ILog;->i(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public static isPrintLog(I)Z
    .locals 2

    sget-boolean v0, Lanet/channel/util/ALog;->isPrintLog:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_1

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 128
    invoke-interface {v0, p0}, Lanet/channel/util/ALog$ILog;->isPrintLog(I)Z

    move-result p0

    return p0

    :cond_1
    return v1
.end method

.method public static setLevel(I)V
    .locals 1

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 118
    invoke-interface {v0, p0}, Lanet/channel/util/ALog$ILog;->setLogLevel(I)V

    :cond_0
    return-void
.end method

.method public static setLog(Lanet/channel/util/ALog$ILog;)V
    .locals 2

    if-nez p0, :cond_0

    return-void

    :cond_0
    sget-boolean v0, Lanet/channel/util/ALog;->canUseTlog:Z

    if-nez v0, :cond_1

    .line 97
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "tlog"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    .line 101
    :cond_1
    invoke-interface {p0}, Lanet/channel/util/ALog$ILog;->isValid()Z

    move-result v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    sput-object p0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    return-void
.end method

.method public static setPrintLog(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/util/ALog;->isPrintLog:Z

    return-void
.end method

.method public static setUseTlog(Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    if-nez p0, :cond_0

    const/4 p0, 0x0

    sput-boolean p0, Lanet/channel/util/ALog;->canUseTlog:Z

    sget-object p0, Lanet/channel/util/ALog;->logcat:Lanet/channel/util/ALog$Logcat;

    sput-object p0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    goto :goto_0

    :cond_0
    const/4 p0, 0x1

    sput-boolean p0, Lanet/channel/util/ALog;->canUseTlog:Z

    :goto_0
    return-void
.end method

.method public static varargs w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x3

    .line 167
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 169
    invoke-static {p0}, Lanet/channel/util/ALog;->buildLogTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p2, p4}, Lanet/channel/util/ALog;->buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p0, p1, p3}, Lanet/channel/util/ALog$ILog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    return-void
.end method

.method public static varargs w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x3

    .line 159
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/util/ALog;->log:Lanet/channel/util/ALog$ILog;

    .line 161
    invoke-static {p0}, Lanet/channel/util/ALog;->buildLogTag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p2, p3}, Lanet/channel/util/ALog;->buildLogMsg(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p0, p1}, Lanet/channel/util/ALog$ILog;->w(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
