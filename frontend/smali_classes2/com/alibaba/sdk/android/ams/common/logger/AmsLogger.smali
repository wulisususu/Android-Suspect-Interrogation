.class public Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;
.super Ljava/lang/Object;


# static fields
.field public static final DEBUG:I = 0x2

.field public static final ERROR:I = 0x0

.field private static final IMPORTANT_LOG_TAG:Ljava/lang/String; = "[MPS]"

.field public static final INFO:I = 0x1

.field private static final importantLogger:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

.field static listener:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;",
            ">;"
        }
    .end annotation
.end field

.field public static volatile log_level:I = 0x3


# instance fields
.field TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    const-string v0, "[MPS]"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->importantLogger:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addListener(Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;)V
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;-><init>(Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;)V

    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->addILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public static clearListeners()V
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    return-void
.end method

.method public static getImportantLogger()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->importantLogger:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-object v0
.end method

.method public static getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;
    .locals 1

    new-instance v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;-><init>()V

    iput-object p0, v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public d(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/Throwable;I)V
    .locals 3

    sget v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->log_level:I

    const/4 v1, 0x2

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    if-nez p2, :cond_0

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_0
    invoke-static {v0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_0
    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    iget-object v2, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    invoke-interface {v1, v2, p1, p2, p3}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/Throwable;I)V
    .locals 3

    sget v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->log_level:I

    if-ltz v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    if-nez p2, :cond_0

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_0
    invoke-static {v0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_0
    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    iget-object v2, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    invoke-interface {v1, v2, p1, p2, p3}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->i(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->i(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/Throwable;I)V
    .locals 3

    sget v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->log_level:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    if-nez p2, :cond_0

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_0
    invoke-static {v0, p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_0
    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    iget-object v2, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    invoke-interface {v1, v2, p1, p2, p3}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method public w(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->w(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->w(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/Throwable;I)V
    .locals 3

    sget v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->log_level:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_2

    iget-object v0, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    if-nez p2, :cond_0

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_0
    if-nez p1, :cond_1

    invoke-static {v0, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    :cond_1
    invoke-static {v0, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_2
    :goto_0
    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->listener:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    iget-object v2, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->TAG:Ljava/lang/String;

    invoke-interface {v1, v2, p1, p2, p3}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_1

    :cond_3
    return-void
.end method

.method public w(Ljava/lang/Throwable;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->w(Ljava/lang/String;Ljava/lang/Throwable;I)V

    return-void
.end method
