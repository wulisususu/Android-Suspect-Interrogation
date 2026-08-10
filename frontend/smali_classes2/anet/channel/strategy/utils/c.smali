.class public Lanet/channel/strategy/utils/c;
.super Ljava/lang/Object;
.source "Taobao"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(J)Ljava/lang/String;
    .locals 5

    .line 133
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-wide/32 v1, 0x3b9aca00

    .line 136
    :cond_0
    div-long v3, p0, v1

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const/16 v3, 0x2e

    .line 137
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 138
    rem-long/2addr p0, v1

    const-wide/16 v3, 0x3e8

    .line 139
    div-long/2addr v1, v3

    const-wide/16 v3, 0x0

    cmp-long v3, v1, v3

    if-gtz v3, :cond_0

    .line 141
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result p0

    add-int/lit8 p0, p0, -0x1

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->setLength(I)V

    .line 142
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    if-eqz p0, :cond_3

    .line 150
    invoke-interface {p0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_2

    .line 154
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 156
    :try_start_0
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 157
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_1

    goto :goto_0

    .line 160
    :cond_1
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2, p1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "="

    .line 161
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 162
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lanet/channel/strategy/utils/c;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, p1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "+"

    const-string v4, "%20"

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "&"

    .line 163
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 165
    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result p0

    add-int/lit8 p0, p0, -0x1

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->deleteCharAt(I)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p0

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Object;

    const-string v1, "Request"

    const-string v2, "format params failed"

    const/4 v3, 0x0

    .line 167
    invoke-static {v1, v2, v3, p0, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 169
    :goto_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_3
    :goto_2
    const-string p0, ""

    return-object p0
.end method

.method public static a(Ljava/lang/String;)Z
    .locals 7

    .line 19
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 22
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object p0

    .line 23
    array-length v0, p0

    const/4 v2, 0x7

    if-lt v0, v2, :cond_7

    array-length v0, p0

    const/16 v2, 0xf

    if-le v0, v2, :cond_1

    goto :goto_1

    :cond_1
    move v0, v1

    move v2, v0

    move v3, v2

    .line 29
    :goto_0
    array-length v4, p0

    if-ge v0, v4, :cond_6

    .line 30
    aget-char v4, p0, v0

    const/16 v5, 0x30

    if-lt v4, v5, :cond_2

    const/16 v6, 0x39

    if-gt v4, v6, :cond_2

    mul-int/lit8 v3, v3, 0xa

    add-int/2addr v3, v4

    sub-int/2addr v3, v5

    const/16 v4, 0xff

    if-le v3, v4, :cond_4

    return v1

    :cond_2
    const/16 v3, 0x2e

    if-ne v4, v3, :cond_5

    add-int/lit8 v2, v2, 0x1

    const/4 v3, 0x3

    if-le v2, v3, :cond_3

    return v1

    :cond_3
    move v3, v1

    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_5
    return v1

    :cond_6
    const/4 p0, 0x1

    return p0

    :cond_7
    :goto_1
    return v1
.end method

.method public static b(Ljava/lang/String;)Z
    .locals 12

    .line 49
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 52
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object p0

    .line 54
    array-length v0, p0

    const/4 v2, 0x2

    if-ge v0, v2, :cond_1

    return v1

    .line 65
    :cond_1
    aget-char v0, p0, v1

    const/16 v2, 0x3a

    const/4 v3, 0x1

    if-ne v0, v2, :cond_3

    .line 67
    aget-char v0, p0, v3

    if-eq v0, v2, :cond_2

    return v1

    :cond_2
    move v4, v1

    move v6, v4

    move v0, v3

    move v5, v0

    move v7, v5

    goto :goto_0

    :cond_3
    move v0, v1

    move v4, v0

    move v5, v4

    move v6, v5

    move v7, v3

    .line 71
    :goto_0
    array-length v8, p0

    const/4 v9, 0x7

    if-ge v0, v8, :cond_a

    .line 72
    aget-char v8, p0, v0

    const/16 v10, 0x10

    .line 73
    invoke-static {v8, v10}, Ljava/lang/Character;->digit(CI)I

    move-result v10

    const/4 v11, -0x1

    if-eq v10, v11, :cond_5

    shl-int/lit8 v6, v6, 0x4

    add-int/2addr v6, v10

    const v7, 0xffff

    if-le v6, v7, :cond_4

    return v1

    :cond_4
    move v7, v1

    goto :goto_1

    :cond_5
    if-ne v8, v2, :cond_9

    add-int/lit8 v5, v5, 0x1

    if-le v5, v9, :cond_6

    return v1

    :cond_6
    if-eqz v7, :cond_8

    if-eqz v4, :cond_7

    return v1

    :cond_7
    move v4, v3

    goto :goto_1

    :cond_8
    move v6, v1

    move v7, v3

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_9
    return v1

    :cond_a
    if-nez v4, :cond_b

    if-ge v5, v9, :cond_b

    return v1

    :cond_b
    return v3
.end method

.method public static c(Ljava/lang/String;)Z
    .locals 5

    .line 108
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 111
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object p0

    .line 112
    array-length v0, p0

    if-lez v0, :cond_9

    array-length v0, p0

    const/16 v2, 0xff

    if-le v0, v2, :cond_1

    goto :goto_2

    :cond_1
    move v0, v1

    move v2, v0

    .line 116
    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_8

    .line 117
    aget-char v3, p0, v0

    const/16 v4, 0x41

    if-lt v3, v4, :cond_2

    const/16 v4, 0x5a

    if-le v3, v4, :cond_4

    :cond_2
    const/16 v4, 0x61

    if-lt v3, v4, :cond_3

    const/16 v4, 0x7a

    if-le v3, v4, :cond_4

    :cond_3
    const/16 v4, 0x2a

    if-ne v3, v4, :cond_5

    :cond_4
    const/4 v2, 0x1

    goto :goto_1

    :cond_5
    const/16 v4, 0x30

    if-lt v3, v4, :cond_6

    const/16 v4, 0x39

    if-le v3, v4, :cond_7

    :cond_6
    const/16 v4, 0x2e

    if-eq v3, v4, :cond_7

    const/16 v4, 0x2d

    if-eq v3, v4, :cond_7

    return v1

    :cond_7
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_8
    return v2

    :cond_9
    :goto_2
    return v1
.end method

.method public static d(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    if-nez p0, :cond_0

    const-string p0, ""

    :cond_0
    return-object p0
.end method
