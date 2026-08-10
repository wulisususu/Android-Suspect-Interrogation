.class public Lcom/alibaba/sdk/android/error/ErrorCode;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private final code:Lcom/alibaba/sdk/android/error/Code;

.field private detail:Ljava/lang/String;

.field private msg:Ljava/lang/String;

.field private solutions:[Ljava/lang/String;


# direct methods
.method protected constructor <init>(Lcom/alibaba/sdk/android/error/Code;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Z)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p5, Lcom/alibaba/sdk/android/error/Code;

    const/4 v0, 0x0

    invoke-direct {p5, p1, v0}, Lcom/alibaba/sdk/android/error/Code;-><init>(Ljava/lang/String;Ljava/lang/Integer;)V

    iput-object p5, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    iput-object p2, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    iput-object p3, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    iput-object p4, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    return-void
.end method

.method public static docContent([Lcom/alibaba/sdk/android/error/ErrorCode;)Ljava/lang/String;
    .locals 9

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v1, p0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_2

    aget-object v4, p0, v3

    const-string/jumbo v5, "|"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v4, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v4, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, v4, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    if-eqz v5, :cond_1

    move v5, v2

    :goto_1
    iget-object v6, v4, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    array-length v6, v6

    if-ge v5, v6, :cond_1

    if-eqz v5, :cond_0

    const-string v6, "<br />"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    add-int/lit8 v6, v5, 0x1

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ". "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, v4, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    aget-object v5, v8, v5

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move v5, v6

    goto :goto_1

    :cond_1
    const-string/jumbo v4, "|\n"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static docTitle()Ljava/lang/String;
    .locals 1

    const-string v0, "\n| \u9519\u8bef\u7801 | \u9519\u8bef\u63cf\u8ff0 | \u5907\u6ce8            |\n| ------ | -------- | ------------------- |\n"

    return-object v0
.end method

.method private static toStringWithAllInfo(Lcom/alibaba/sdk/android/error/ErrorCode;)Ljava/lang/String;
    .locals 5

    new-instance v0, Ljava/lang/StringBuilder;

    const-string/jumbo v1, "\u9519\u8bef\u7801\uff1a"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", \u9519\u8bef\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "), "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    if-eqz v1, :cond_1

    array-length v1, v1

    if-lez v1, :cond_1

    const-string/jumbo v1, "\u8bf7\u68c0\u67e5\u4e00\u4e0b\u51e0\u70b9\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p0, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p0, v2

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "; "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-static {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->builder(Lcom/alibaba/sdk/android/error/Code;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    if-eqz v1, :cond_1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    :cond_1
    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    if-eqz v1, :cond_2

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solutions([Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    :cond_2
    return-object v0
.end method

.method public create(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorCode;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->create(Ljava/lang/String;Z)Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    return-object p1
.end method

.method protected create(Ljava/lang/String;Z)Lcom/alibaba/sdk/android/error/ErrorCode;
    .locals 7
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    new-instance v6, Lcom/alibaba/sdk/android/error/ErrorCode;

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/Code;->getCodeStr()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    iget-object v4, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    move-object v0, v6

    move-object v3, p1

    move v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/alibaba/sdk/android/error/ErrorCode;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Z)V

    return-object v6
.end method

.method public getCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/Code;->getCodeStr()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getCodeInt()I
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/Code;->getCodeInt()I

    move-result v0

    return v0
.end method

.method public getMsg()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected setDetail(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    return-void
.end method

.method protected setMsg(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    return-void
.end method

.method protected setSolutions([Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->solutions:[Ljava/lang/String;

    return-void
.end method

.method public toShortString()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "("

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->code:Lcom/alibaba/sdk/android/error/Code;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->msg:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/error/ErrorCode;->detail:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    invoke-static {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->toStringWithAllInfo(Lcom/alibaba/sdk/android/error/ErrorCode;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
