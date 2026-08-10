.class public Lcom/alibaba/sdk/android/push/common/util/a/b;
.super Ljava/lang/Object;


# instance fields
.field public a:Ljava/lang/String;

.field public b:I

.field public c:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public d:Lcom/alibaba/sdk/android/push/common/util/a/d;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v0, ""

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->a:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->b:I

    sget-object v0, Lcom/alibaba/sdk/android/push/common/util/a/d;->a:Lcom/alibaba/sdk/android/push/common/util/a/d;

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->d:Lcom/alibaba/sdk/android/push/common/util/a/d;

    return-void
.end method

.method public constructor <init>(I)V
    .locals 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-static {}, Lcom/alibaba/sdk/android/push/common/util/a/d;->values()[Lcom/alibaba/sdk/android/push/common/util/a/d;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v5

    if-ne v5, p1, :cond_0

    iput-object v4, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->d:Lcom/alibaba/sdk/android/push/common/util/a/d;

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    const-string p1, ""

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->a:Ljava/lang/String;

    iput v2, p0, Lcom/alibaba/sdk/android/push/common/util/a/b;->b:I

    return-void
.end method
