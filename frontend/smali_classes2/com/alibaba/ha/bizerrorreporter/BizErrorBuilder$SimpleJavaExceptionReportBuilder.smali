.class Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;
.super Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$ReportBuilder;
.source "BizErrorBuilder.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SimpleJavaExceptionReportBuilder"
.end annotation


# instance fields
.field mExceptionContent:Ljava/lang/String;

.field mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

.field mThread:Ljava/lang/Thread;

.field mThrowable:Ljava/lang/Throwable;

.field final synthetic this$0:Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;


# direct methods
.method constructor <init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x0,
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "this$0",
            "exceptionModule",
            "context",
            "reportName",
            "timestamp",
            "type"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->this$0:Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;

    .line 342
    invoke-direct {p0, p1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$ReportBuilder;-><init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;)V

    iput-object p2, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExceptionModule:Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    .line 345
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->throwable:Ljava/lang/Throwable;

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThrowable:Ljava/lang/Throwable;

    .line 346
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->thread:Ljava/lang/Thread;

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThread:Ljava/lang/Thread;

    .line 347
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionDetail:Ljava/lang/String;

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExceptionContent:Ljava/lang/String;

    .line 348
    iget-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    if-nez p1, :cond_0

    .line 349
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    .line 351
    :cond_0
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionId:Ljava/lang/String;

    if-eqz p1, :cond_1

    .line 353
    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v1, "exceptionId"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 355
    :cond_1
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionCode:Ljava/lang/String;

    if-eqz p1, :cond_2

    .line 357
    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v1, "exceptionCode"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 359
    :cond_2
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionVersion:Ljava/lang/String;

    if-eqz p1, :cond_3

    .line 361
    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v1, "exceptionVersion"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 363
    :cond_3
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg1:Ljava/lang/String;

    if-eqz p1, :cond_4

    .line 365
    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v1, "exceptionArg1"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 367
    :cond_4
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg2:Ljava/lang/String;

    if-eqz p1, :cond_5

    .line 369
    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v1, "exceptionArg2"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 371
    :cond_5
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg3:Ljava/lang/String;

    if-eqz p1, :cond_6

    .line 373
    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v1, "exceptionArg3"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    iget-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThrowable:Ljava/lang/Throwable;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExceptionContent:Ljava/lang/String;

    if-eqz p1, :cond_7

    .line 377
    iget-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    const-string v0, "exceptionDetail"

    iget-object v1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExceptionContent:Ljava/lang/String;

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 379
    :cond_7
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArgs:Ljava/util/Map;

    if-eqz p1, :cond_8

    .line 380
    invoke-interface {p1}, Ljava/util/Map;->size()I

    move-result p2

    if-lez p2, :cond_8

    .line 381
    iget-object p2, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExtraInfo:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 384
    :cond_8
    iput-object p3, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mContext:Landroid/content/Context;

    .line 385
    iput-object p4, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mReportName:Ljava/lang/String;

    .line 386
    iput-wide p5, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mTimestamp:J

    .line 387
    iput-object p7, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mReportType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected buildContent()Ljava/lang/String;
    .locals 2

    .line 392
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 394
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->buildThrowable()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 395
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->buildExtraInfo()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 397
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected buildThread(Ljava/lang/Thread;)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "thread"
        }
    .end annotation

    .line 454
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    :try_start_0
    const-string v1, "Thread Name: \'%s\'\n"

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/Object;

    .line 456
    invoke-virtual {p1}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-static {v1, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\"%s\" prio=%d tid=%d %s\n"

    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Object;

    .line 457
    invoke-virtual {p1}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {p1}, Ljava/lang/Thread;->getPriority()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v2

    .line 458
    invoke-virtual {p1}, Ljava/lang/Thread;->getId()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const/4 v6, 0x2

    aput-object v4, v3, v6

    invoke-virtual {p1}, Ljava/lang/Thread;->getState()Ljava/lang/Thread$State;

    move-result-object v4

    const/4 v6, 0x3

    aput-object v4, v3, v6

    .line 457
    invoke-static {v1, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 459
    invoke-virtual {p1}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object p1

    .line 460
    array-length v1, p1

    move v3, v5

    :goto_0
    if-ge v3, v1, :cond_0

    aget-object v4, p1, v3

    const-string v6, "\tat %s\n"

    new-array v7, v2, [Ljava/lang/Object;

    .line 461
    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v7, v5

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_0
    move-exception p1

    const-string v1, "MotuCrashAdapter"

    const-string v2, "dumpThread"

    .line 464
    invoke-static {v1, v2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 466
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected buildThrowable()Ljava/lang/String;
    .locals 7

    const-string v0, "MotuCrashAdapter"

    .line 401
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 404
    :try_start_0
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getProcessName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "Process Name: \'%s\' \n"

    .line 405
    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThread:Ljava/lang/Thread;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    const/4 v3, 0x0

    const/4 v4, 0x1

    const-string v5, "Thread Name: \'%s\' \n"

    if-eqz v2, :cond_0

    :try_start_1
    new-array v4, v4, [Ljava/lang/Object;

    .line 407
    invoke-virtual {v2}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v4, v3

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    new-array v2, v4, [Ljava/lang/Object;

    const-string v4, "adapter no thread name"

    aput-object v4, v2, v3

    .line 409
    invoke-static {v5, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    const-string v2, "Back traces starts.\n"

    .line 411
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    const/4 v2, 0x0

    :try_start_2
    iget-object v3, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThrowable:Ljava/lang/Throwable;

    if-eqz v3, :cond_1

    .line 415
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    iget-object v2, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThrowable:Ljava/lang/Throwable;

    .line 416
    new-instance v4, Ljava/io/PrintStream;

    invoke-direct {v4, v3}, Ljava/io/PrintStream;-><init>(Ljava/io/OutputStream;)V

    invoke-virtual {v2, v4}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintStream;)V

    .line 417
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-object v2, v3

    goto :goto_1

    :catch_0
    move-exception v2

    goto :goto_2

    :cond_1
    :try_start_4
    iget-object v3, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mExceptionContent:Ljava/lang/String;

    if-eqz v3, :cond_2

    .line 419
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "\n"

    .line 420
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_2
    const-string/jumbo v3, "\u65e0\u5185\u5bb9"

    .line 422
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 427
    :goto_1
    :try_start_5
    invoke-static {v2}, Lcom/alibaba/sdk/android/tbrest/utils/AppUtils;->closeQuietly(Ljava/io/Closeable;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_3

    :catchall_0
    move-exception v3

    move-object v6, v3

    move-object v3, v2

    move-object v2, v6

    goto :goto_4

    :catch_1
    move-exception v3

    move-object v6, v3

    move-object v3, v2

    move-object v2, v6

    :goto_2
    :try_start_6
    const-string v4, "print throwable"

    .line 425
    invoke-static {v0, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 427
    :try_start_7
    invoke-static {v3}, Lcom/alibaba/sdk/android/tbrest/utils/AppUtils;->closeQuietly(Ljava/io/Closeable;)V

    :goto_3
    const-string v2, "Back traces end.\n"

    .line 429
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 430
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->buildEnd()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_5

    :catchall_1
    move-exception v2

    .line 427
    :goto_4
    invoke-static {v3}, Lcom/alibaba/sdk/android/tbrest/utils/AppUtils;->closeQuietly(Ljava/io/Closeable;)V

    .line 428
    throw v2
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    :catch_2
    move-exception v2

    const-string v3, "write throwable"

    .line 432
    invoke-static {v0, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_5
    iget-object v2, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->mThread:Ljava/lang/Thread;

    if-eqz v2, :cond_3

    .line 437
    :try_start_8
    invoke-virtual {p0, v2}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->buildThread(Ljava/lang/Thread;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_3

    goto :goto_6

    :catch_3
    move-exception v2

    const-string v3, "write thread"

    .line 439
    invoke-static {v0, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 443
    :cond_3
    :goto_6
    invoke-virtual {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;->buildEnd()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 444
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
