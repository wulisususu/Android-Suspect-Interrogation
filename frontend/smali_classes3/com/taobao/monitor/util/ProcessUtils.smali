.class public final Lcom/taobao/monitor/util/ProcessUtils;
.super Ljava/lang/Object;
.source "ProcessUtils.java"


# static fields
.field private static sProcessName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getCurrProcessName()Ljava/lang/String;
    .locals 3

    .line 31
    invoke-static {}, Lcom/taobao/monitor/ProcedureGlobal;->instance()Lcom/taobao/monitor/ProcedureGlobal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/ProcedureGlobal;->context()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lcom/taobao/monitor/util/ProcessUtils;->sProcessName:Ljava/lang/String;

    .line 32
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 33
    invoke-static {}, Lcom/taobao/monitor/util/ProcessUtils;->getCurrentProcessNameViaLinuxFile()Ljava/lang/String;

    move-result-object v1

    .line 35
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    if-eqz v0, :cond_0

    .line 36
    invoke-static {v0}, Lcom/taobao/monitor/util/ProcessUtils;->getCurrentProcessNameViaActivityManager(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    :cond_0
    sput-object v1, Lcom/taobao/monitor/util/ProcessUtils;->sProcessName:Ljava/lang/String;

    :cond_1
    sget-object v0, Lcom/taobao/monitor/util/ProcessUtils;->sProcessName:Ljava/lang/String;

    return-object v0
.end method

.method private static getCurrentProcessNameViaActivityManager(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "context"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    sget-object v1, Lcom/taobao/monitor/util/ProcessUtils;->sProcessName:Ljava/lang/String;

    if-eqz v1, :cond_1

    return-object v1

    .line 79
    :cond_1
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    const-string v2, "activity"

    .line 80
    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/ActivityManager;

    if-nez p0, :cond_2

    return-object v0

    .line 84
    :cond_2
    invoke-virtual {p0}, Landroid/app/ActivityManager;->getRunningAppProcesses()Ljava/util/List;

    move-result-object p0

    if-nez p0, :cond_3

    return-object v0

    .line 88
    :cond_3
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_4
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningAppProcessInfo;

    if-eqz v0, :cond_4

    .line 89
    iget v2, v0, Landroid/app/ActivityManager$RunningAppProcessInfo;->pid:I

    if-ne v2, v1, :cond_4

    .line 90
    iget-object p0, v0, Landroid/app/ActivityManager$RunningAppProcessInfo;->processName:Ljava/lang/String;

    sput-object p0, Lcom/taobao/monitor/util/ProcessUtils;->sProcessName:Ljava/lang/String;

    :cond_5
    sget-object p0, Lcom/taobao/monitor/util/ProcessUtils;->sProcessName:Ljava/lang/String;

    return-object p0
.end method

.method private static getCurrentProcessNameViaLinuxFile()Ljava/lang/String;
    .locals 5

    .line 44
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    .line 45
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "/proc/"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/cmdline"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x400

    new-array v1, v1, [B

    const/4 v2, 0x0

    const/4 v3, 0x0

    .line 52
    :try_start_0
    new-instance v4, Ljava/io/FileInputStream;

    invoke-direct {v4, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 53
    :try_start_1
    invoke-virtual {v4, v1}, Ljava/io/FileInputStream;->read([B)I

    move-result v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 58
    :try_start_2
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4

    goto :goto_1

    :catchall_0
    move-exception v0

    move-object v2, v4

    goto :goto_0

    :catchall_1
    move-exception v0

    :goto_0
    if-eqz v2, :cond_0

    :try_start_3
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 62
    :catch_0
    :cond_0
    throw v0

    :catch_1
    move-object v4, v2

    :catch_2
    if-eqz v4, :cond_1

    .line 58
    :try_start_4
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    :cond_1
    move v0, v3

    :catch_4
    :goto_1
    if-lez v0, :cond_2

    .line 65
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v1, v3, v0}, Ljava/lang/String;-><init>([BII)V

    .line 66
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    :cond_2
    return-object v2
.end method
