.class final Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/logger/ILogger;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->addListener(Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;->a:Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public print(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    sget-object v0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$2;->a:[I

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/logger/LogLevel;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eq p1, v0, :cond_3

    const/4 v0, 0x2

    if-eq p1, v0, :cond_2

    const/4 v0, 0x3

    if-eq p1, v0, :cond_1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;->a:Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    invoke-interface {p1, p2, p3, v2, v1}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;->a:Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    invoke-interface {p1, p2, p3, v2, v1}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;->a:Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    invoke-interface {p1, p2, p3, v2, v1}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger$1;->a:Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;

    invoke-interface {p1, p2, p3, v2, v1}, Lcom/alibaba/sdk/android/ams/common/logger/LoggerListener;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;I)V

    :goto_0
    return-void
.end method
