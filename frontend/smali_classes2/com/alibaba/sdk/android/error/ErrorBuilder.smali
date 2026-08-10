.class public Lcom/alibaba/sdk/android/error/ErrorBuilder;
.super Ljava/lang/Object;


# instance fields
.field private code:Lcom/alibaba/sdk/android/error/Code;

.field private detail:Ljava/lang/String;

.field private msg:Ljava/lang/String;

.field private solutions:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Lcom/alibaba/sdk/android/error/Code;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->code:Lcom/alibaba/sdk/android/error/Code;

    iput-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail:Ljava/lang/String;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions:Ljava/util/ArrayList;

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->code:Lcom/alibaba/sdk/android/error/Code;

    return-void
.end method

.method public static builder(Lcom/alibaba/sdk/android/error/Code;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 1

    new-instance v0, Lcom/alibaba/sdk/android/error/ErrorBuilder;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;-><init>(Lcom/alibaba/sdk/android/error/Code;)V

    return-object v0
.end method


# virtual methods
.method public build()Lcom/alibaba/sdk/android/error/ErrorCode;
    .locals 3

    new-instance v0, Lcom/alibaba/sdk/android/error/ErrorCode;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorCode;-><init>(Lcom/alibaba/sdk/android/error/Code;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg:Ljava/lang/String;

    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->setMsg(Ljava/lang/String;)V

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail:Ljava/lang/String;

    if-eqz v1, :cond_1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->setDetail(Ljava/lang/String;)V

    :cond_1
    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_2

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions:Ljava/util/ArrayList;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->setSolutions([Ljava/lang/String;)V

    :cond_2
    return-object v0
.end method

.method public detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail:Ljava/lang/String;

    return-object p0
.end method

.method public msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg:Ljava/lang/String;

    return-object p0
.end method

.method public solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public solutions([Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 4

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    iget-object v3, p0, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object p0
.end method
