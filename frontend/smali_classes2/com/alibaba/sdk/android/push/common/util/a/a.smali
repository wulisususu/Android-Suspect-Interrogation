.class public Lcom/alibaba/sdk/android/push/common/util/a/a;
.super Ljava/lang/Exception;


# instance fields
.field private final a:Lcom/alibaba/sdk/android/error/ErrorCode;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/error/ErrorCode;)V
    .locals 1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->toShortString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/common/util/a/a;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-void
.end method


# virtual methods
.method public a()Lcom/alibaba/sdk/android/error/ErrorCode;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/common/util/a/a;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object v0
.end method
